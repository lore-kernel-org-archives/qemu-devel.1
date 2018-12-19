Received: from eggs.gnu.org ([2001:4830:134:3::10]:35959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gZgi9-0003FZ-Mr
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:36:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gZgi6-00069v-K9
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:36:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1gZgi6-00069P-Ds
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 13:36:46 -0500
Received: by mail-wm1-f68.google.com with SMTP id d15so7077933wmb.3
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 10:36:46 -0800 (PST)
Date: Wed, 19 Dec 2018 19:36:42 +0100
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20181219193642.7cdbdf40@thl530>
In-Reply-To: <74b7c248-163e-f4a0-c889-59648801e023@ilande.co.uk>
References: <20181216215210.29088-1-huth@tuxfamily.org>
	<alpine.BSF.2.21.9999.1812171247380.61996@zero.eik.bme.hu>
	<20181218212614.385f4b5b@thl530>
	<74b7c248-163e-f4a0-c889-59648801e023@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/sparc64: Create VGA device only if it
 has really been requested
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org

Am Wed, 19 Dec 2018 12:23:31 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> On 18/12/2018 20:26, Thomas Huth wrote:
[...]
> > By the way, would it make sense to enable virtio-vga for the sun4u
> > machines, too?  
> 
> Hmmm that's one thing I haven't really tested - is there any reason
> to use this over the bochs_drm driver?

With virtio-vga, you'd get virtio-gpu features, too. See Gerd's talk
from KVM forum 2015 for details:

https://www.youtube.com/watch?v=4d-ObxgqZOs

 Thomas
