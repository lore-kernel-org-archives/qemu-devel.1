Received: from eggs.gnu.org ([209.51.188.92]:44331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gpBmy-0001ct-Hy
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1gpBmx-0008Pm-Ao
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 07:49:52 -0500
MIME-Version: 1.0
References: <56F356E9-04E0-4419-91BD-55CC91C853E1@gmail.com>
In-Reply-To: <56F356E9-04E0-4419-91BD-55CC91C853E1@gmail.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 31 Jan 2019 13:49:12 +0100
Message-ID: <CABLmASGpih1TTWS4eCuckv12RvExs_UaQ=rPU+danJTSXR8grg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] qemu_vga.drv missing 256 colors support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Jan 31, 2019 at 12:12 PM Programmingkid <programmingkidx@gmail.com>
wrote:

> After testing a recent commit of QEMU I noticed that 256 color support is
> missing in Mac OS 9's color options. A lot of games refuse to run without
> being able to set the monitor to 256 colors. Could we have this option
> added?
>
> Thank you.
>

Hi,

An updated vga driver that supports 256 colours and reads edid info has
been committed to dgibson's ppc-for-4.0 branch:
https://github.com/dgibson/qemu/commit/4c693a81dbab9cecbf101c4c24e4b8af819df46c

Best,
Howard
