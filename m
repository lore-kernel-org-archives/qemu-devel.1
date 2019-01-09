Received: from eggs.gnu.org ([209.51.188.92]:45134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zub@linux.fjfi.cvut.cz>) id 1ghMux-0002ut-1d
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 18:05:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zub@linux.fjfi.cvut.cz>) id 1ghMuw-0006YS-Cb
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 18:05:46 -0500
Received: from mailgw1.ipv6.fjfi.cvut.cz ([2001:718:2:1900::3]:45236
	helo=mailgw1.fjfi.cvut.cz)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zub@linux.fjfi.cvut.cz>)
	id 1ghMuv-0006Ve-TL
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 18:05:46 -0500
Date: Thu, 10 Jan 2019 00:05:32 +0100 (CET)
From: David Kozub <zub@linux.fjfi.cvut.cz>
In-Reply-To: <20190107091618.GD27089@stefanha-x1.localdomain>
Message-ID: <alpine.LRH.2.21.1901092339260.19055@linux.fjfi.cvut.cz>
References: <alpine.LRH.2.21.1901051827350.16856@linux.fjfi.cvut.cz>
	<20190107091618.GD27089@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] Emulation of TCG OPAL self-encrypting drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

On Mon, 7 Jan 2019, Stefan Hajnoczi wrote:

> QEMU supports LUKS encrypted disk images so no new code is needed for
> the actual encryption.

Thanks for the feedback, Stefan. I know very little about qemu internals 
(I looked around a bit). One issue is: OPAL needs some persistent data 
outside of the actual user-visible data. How does that fit in with storage 
in QEMU? Perhaps the implementation could just occupy a fixed size of the 
associated storage for the OPAL state.

>> Or, just a pass-through to a block device in the host - but a pass-through
>> that would allow OPAL commands.
>
> You can pass through a storage controller using PCI passthrough or you
> can pass through a SCSI LUN, but there is no ATA passthrough.

I currently don't have a usable box for PCI passthrough. I'm thinking 
that ATA passthrough could be generally usable for any fiddling and 
perhaps not too difficult to implement.

If I understand QEMU sources correctly, this needs to touch hw/ide/core.c 
(ide_exec_cmd), either adding a layer for OPAL, or just forwarding ATA 
commands for pass-through. Right?

Best regards,
David
