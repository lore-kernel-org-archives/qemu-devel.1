Received: from eggs.gnu.org ([2001:4830:134:3::10]:48121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eMoQz-0008G8-82
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eMoQw-0001Wk-3B
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:09:21 -0500
Received: from chuckie.co.uk ([82.165.15.123]:43351
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eMoQv-0001WS-Rq
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 00:09:18 -0500
References: <20171205081744.6563-1-mark.cave-ayland@ilande.co.uk>
	<20171205081744.6563-3-mark.cave-ayland@ilande.co.uk>
	<6e01fbfb-f7b3-952b-435b-d1e3daa3131c@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7349c202-3e2a-5c57-78af-f1ed8d9d2f35@ilande.co.uk>
Date: Thu, 7 Dec 2017 05:09:09 +0000
MIME-Version: 1.0
In-Reply-To: <6e01fbfb-f7b3-952b-435b-d1e3daa3131c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 2/5] net: introduce net_crc32_le()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, jasowang@redhat.com, sw@weilnetz.de

On 05/12/17 14:31, Eric Blake wrote:

> On 12/05/2017 02:17 AM, Mark Cave-Ayland wrote:
>> This provides a standard ethernet CRC32 little-endian implementation.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>   include/net/net.h |  2 ++
>>   net/net.c         | 22 ++++++++++++++++++++++
>>   2 files changed, 24 insertions(+)
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
>> +            if (carry) {
>> +                crc = crc ^ POLYNOMIAL_LE;
>> +            }
> 
> Worth writing as 'crc ^= POLYNOMIAL_LE;'?

Yes, works for me.


ATB,

Mark.
