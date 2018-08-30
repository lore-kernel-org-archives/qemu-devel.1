Received: from eggs.gnu.org ([2001:4830:134:3::10]:42894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1fvIMO-0008C4-Jy
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:31:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1fvIMN-00011M-OK
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:31:24 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:39716)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
	id 1fvIMM-0000xz-Rm
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:31:23 -0400
Received: by mail-wm0-x244.google.com with SMTP id q8-v6so1082150wmq.4
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 01:31:21 -0700 (PDT)
Date: Thu, 30 Aug 2018 09:31:18 +0100
From: Leif Lindholm <leif.lindholm@linaro.org>
Message-ID: <20180830083117.iekobw7l3arkt24m@bivouac.eciton.net>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9hivJzqksiSZbco4+EysYj=_y0t3k_L7TobxNPS8T2dQ@mail.gmail.com>
	<CAHmQWvC4Kp1CAeCe8ZTGtSeG7fnT=Xen4GFKfnhTBWUCJdQV+g@mail.gmail.com>
	<20180829134219.cmyqipnvukk6k2rp@kamzik.brq.redhat.com>
	<CAHmQWvA5t7zbbDDM0UvuKSL_Z8ey+x+vOGZumYjwsq0FC5AHGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmQWvA5t7zbbDDM0UvuKSL_Z8ey+x+vOGZumYjwsq0FC5AHGA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, Aug 30, 2018 at 03:07:29PM +0800, Hongbo Zhang wrote:
> >> Yes, I am working on the v3, with main changes:
> >>  - machine name "sbsa-ref" (good name?)
> >>  - a separate file sbsa-ref.c
> >>  - don't touch the acpi c file, acpi will be supplied by uefi
> >
> > I agree with the above three bullets.
> >
> >>  - only necessary dt node, no other peripheral dt nodes
> >
> > I'm not sure what DT nodes are necessary. After discussing the
> > ACPI tables, and that firmware would supply them, I thought we
> > also agreed firmware would supply the DTB.
>
> Yes, firmware supply ACPI to load OS.
> But for DT, It is said that UEFI still needs some DT nodes, at least
> for memory size. I am trying to figure out which DT nodes are
> mandatory too, it is better we don't have any DT nodes left.
> 
> @Ard, @Leif, is there any possibility to remove all the DT nodes?
> On real hardware, how does UEFI find the memory size and CPU number?

Usually by asking some form of SCP/PMU.
So until we have rock-solid multi-cpu-instance (making terms up here,
there may be a proper name already?) support upstream, we need to take
shortcuts.

Using DT in the same way as we do for mach-virt when booting the OS
with ACPI seems the most logical choice to me.

The best alternative I can think of would be extending fw_cfg, but
that would then be lost effort once (if) we get to the abovementioned
situation, whereas the DT route comes for free.

/
    Leif
