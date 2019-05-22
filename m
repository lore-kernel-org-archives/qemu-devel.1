Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A095C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6595920863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6595920863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTVqd-0004cI-Jz
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 14:20:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaro.koskinen@iki.fi>) id 1hTVpi-0004JZ-Ou
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaro.koskinen@iki.fi>) id 1hTVpf-0003Ri-AL
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:19:21 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:46640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aaro.koskinen@iki.fi>)
	id 1hTVpd-0003J7-Sz
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:19:18 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-4-80-nat.elisa-mobile.fi
	[85.76.4.80])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 939AB200A2;
	Wed, 22 May 2019 21:19:04 +0300 (EEST)
Date: Wed, 22 May 2019 21:19:04 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Corentin Labbe <clabbe.montjoie@gmail.com>
Message-ID: <20190522181904.GE3621@darkstar.musicnaut.iki.fi>
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
	<20190522093341.GA32154@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522093341.GA32154@Red>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 62.142.5.108
Subject: Re: [Qemu-devel] Running linux on qemu omap
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
	qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Wed, May 22, 2019 at 11:33:41AM +0200, Corentin Labbe wrote:
> qemu-system-arm -M help |grep OMAP
> cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
> n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
> n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
> sx1                  Siemens SX1 (OMAP310) V2
> sx1-v1               Siemens SX1 (OMAP310) V1
> 
> > > The maximum I can get with omap1_defconfig is
> > > qemu-system-arm -kernel zImage -nographic -machine cheetah -append 'root=/dev/ram0 console=ttyO0'
> > > Uncompressing Linux... done, booting the kernel.
> > > then nothing more.

With N800/N810 omap2plus_defconfig should be used instead. However,
I don't think that works either (but haven't tried recently). Also with
N800/N810 you need to append the DTB file to the kernel image.

> thanks, with your config I was able to boot both sx1 and cheetah
> (by adding CONFIG_MACH_OMAP_PALMTE=y)

Great!

> Now I need to find what is missing (or in excess) in omap1_defconfig
> to made it boot

A simple (but slow) way would be to start adding config options from
omap1_defconfig one by one to the working config, and see which one
makes it fail.

> Another obstacle is the disabling of the initrd, perhaps by using
> sdcard as an "initrd" will do the trick, but the sdcard is ignored for
> the moment.

Using CONFIG_INITRAMFS_SOURCE it's possible to include a file system
inside the kernel image.

Based on your boot log, I think the kernel probably panics before the
MMC/sdcard is found (asynchronous probe). You could try adding rootwait
to the kernel command line. (My config has CONFIG_CMDLINE_FORCE=y, so
you need to add it to CONFIG_CMDLINE, as QEMU -append gets ignored). Also
the sdcard will appear as /dev/mmcblk0 instead of /dev/sda.

The sdcard is working fine for me, and it can be used to run a full-blown
distro rootfs; I don't know what is the capacity limit in the MMC driver
but at least 16 GB image is working fine:

[    2.011012] mmc0: new SDHC card at address 4567
[    2.016419] mmcblk0: mmc0:4567 QEMU! 16.0 GiB

A.

