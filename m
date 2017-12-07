Received: from eggs.gnu.org ([2001:4830:134:3::10]:48078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eMoQe-00087D-78
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:09:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eMoQb-0001Ol-22
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:09:00 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43346
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eMoQa-0001M3-QJ
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:08:56 -0500
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-5-mark.cave-ayland@ilande.co.uk>
	<73f0bc0d-dd3a-bb81-e56a-c3a38fc1cd71@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ab39086a-77f1-67d1-e276-e5880726de66@ilande.co.uk>
Date: Thu, 7 Dec 2017 05:08:32 +0000
MIME-Version: 1.0
In-Reply-To: <73f0bc0d-dd3a-bb81-e56a-c3a38fc1cd71@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 4/5] eepro100: switch
 e100_compute_mcast_idx() over to use net_crc32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

On 05/12/17 14:28, Eric Blake wrote:

> On 12/05/2017 02:17 AM, Mark Cave-Ayland wrote:
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   hw/net/eepro100.c | 19 +------------------
>>   1 file changed, 1 insertion(+), 18 deletions(-)
>>
> 
>> -            if (carry) {
>> -                crc = ((crc ^ POLYNOMIAL) | carry);
> 
> How does this compile after 1/5 renames POLYNOMIAL to POLYNOMIAL_BE in
> net.h?
> 
> /me looks
> 
> Oh, you have a redundant definition in the .c file, which is now a dead
> define.  Patch 1 should be updated to remove the duplicate definitions,
> and fix code to uniformly use POLYNOMIAL_BE.

Ah yes, I can fix that up on a v3.

> But overall, I like what the series is doing.

Great stuff, in that case I'll fix it up based upon all the comments and 
continue. It has been lying around in a local branch for months now...

BTW one thing I did notice is that sungem.c calls zlib's crc32 function 
directly which doesn't seem right, so I'll probably add that into the 
next version too. Once this has been done, switching the new 
net_crc32()/net_crc32_le() functions over to use a LUT or zlib or 
something else as the underlying implementation should be trivial.


ATB,

Mark.
