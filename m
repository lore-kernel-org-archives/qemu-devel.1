Received: from eggs.gnu.org ([2001:4830:134:3::10]:39146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYSXr-0007Kl-ME
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:44:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYSXq-0001be-U5
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 04:44:51 -0400
Date: Thu, 28 Jun 2018 10:44:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180628084437.GA4833@localhost.localdomain>
References: <20180627232334.14142-1-laurent@vivier.eu>
	<20180627232334.14142-9-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627232334.14142-9-laurent@vivier.eu>
Subject: Re: [Qemu-devel] [C v2 08/10] hw/m68k: add a dummy SWIM floppy
 controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Reitz <mreitz@redhat.com>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>

Am 28.06.2018 um 01:23 hat Laurent Vivier geschrieben:
> Co-developed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

> +static Property swim_properties[] = {
> +    DEFINE_PROP_DRIVE("driveA", SWIMCtrl, drives[0].blk),
> +    DEFINE_PROP_DRIVE("driveB", SWIMCtrl, drives[1].blk),
> +    DEFINE_PROP_END_OF_LIST(),
> +};

This is not the right way to model things. The floppy controller needs
to expose a bus and floppy drives need to be created with a separate
-device option.

isa-fdc still has these options, but that's only for compatibility and
their implementation is basically a wrapper around the modern qdev way.

Kevin
