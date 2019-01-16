Received: from eggs.gnu.org ([209.51.188.92]:49027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjtmq-0001rT-DL
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:35:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjtmp-0007gf-4p
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:35:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjtmo-0007WW-S1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 17:35:51 -0500
References: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
	<20190107091618.GD27089@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <e2e14237-32be-8e3d-242c-c19e98d04d60@redhat.com>
Date: Wed, 16 Jan 2019 17:35:40 -0500
MIME-Version: 1.0
In-Reply-To: <20190107091618.GD27089@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Emulation of TCG OPAL self-encrypting drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Kozub <zub@linux.fjfi.cvut.cz>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, kwolf@redhat.com



On 1/7/19 4:16 AM, Stefan Hajnoczi wrote:
> On Sat, Jan 05, 2019 at 07:27:03PM +0100, David Kozub wrote:
>> Hi,
>>
>> Can QEMU emulate an OPAL disk? The only relevant thing I found is a post
>> from 2017 about TPM that mentions OPAL:
>> https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg04586.html
> 
> CCing John Snow (IDE/ATA) and Kevin Wolf (QEMU block layer).
> 
>> specifically this bit:
>>
>>> Well, at some point somebody's going to want us to implement this,
>>> but... they can do that when they do that.
>>
>> So I assume it is not implemented. (?)
> 
> Right.
> 
>> I agree with the sentiment expressed in the mail linked above w.r.t. OPAL
>> security. I'm interested in this from SW development/debugging/fiddling
>> perspective. A sufficient solution for me would not add any real encryption
> 
> QEMU supports LUKS encrypted disk images so no new code is needed for
> the actual encryption.
> 
>> but would respond to the various OPAL commands send via ATA TRUSTED
>> SEND/RECEIVE commands.
>>
>> In fact, a more generic solution would work for me: If it was possible to
>> send ATA commands from QEMU to a separate process which could then handle
>> them as it liked and reply back to QEMU. This could be useful for other
>> fiddling/debugging situations too.
> 
> Might as well implement it in QEMU so users can easily take advantage of
> it without setting up external software.
> 
>> Or, just a pass-through to a block device in the host - but a pass-through
>> that would allow OPAL commands.
> 
> You can pass through a storage controller using PCI passthrough or you
> can pass through a SCSI LUN, but there is no ATA passthrough.
> 
>> I'm grateful for any hints/ideas. Perhaps something like this is already
>> possible with QEMU?
>>
>> Best regards,
>> David
>>

I can answer some questions about the ATA layer, but I'm not well read
on OPAL or the interrelationship between the two.

We don't have an ATA-style passthrough in QEMU right now and nobody has
ever asked! Would you mind elaborating for me what kind of setup you're
looking to accomplish and maybe I can give you some better hints?

--js
