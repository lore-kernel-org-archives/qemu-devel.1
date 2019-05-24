Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B73EC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:01:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42F5221848
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 19:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42F5221848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUFR8-0002Ys-M2
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 15:01:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaro.koskinen@iki.fi>) id 1hUFPi-0001h2-W2
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaro.koskinen@iki.fi>) id 1hUFPh-0006wm-Hs
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:59:34 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:39100)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aaro.koskinen@iki.fi>)
	id 1hUFPh-0006rj-As
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:59:33 -0400
Received: from t60.musicnaut.iki.fi (85-76-86-221-nat.elisa-mobile.fi
	[85.76.86.221])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id C12E020014;
	Fri, 24 May 2019 21:59:22 +0300 (EEST)
Date: Fri, 24 May 2019 21:59:22 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Peter Maydell <peter.maydell@linaro.org>,
	Thomas Huth <thuth@redhat.com>
Message-ID: <20190524185922.GA4597@t60.musicnaut.iki.fi>
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
	<20190522093341.GA32154@Red>
	<20190522181904.GE3621@darkstar.musicnaut.iki.fi>
	<8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
	<c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
	<20190523183623.GB5234@darkstar.musicnaut.iki.fi>
	<CAFEAcA8C0WN5FwaW2kfWiRm1T8wML_fWXDKqRXP-Lv_P7ysy8A@mail.gmail.com>
	<20190524150018.GA3156@t60.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524150018.GA3156@t60.musicnaut.iki.fi>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 62.142.5.107
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
Cc: Tony Lindgren <tony@atomide.com>, QEMU Developers <qemu-devel@nongnu.org>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Fri, May 24, 2019 at 06:00:18PM +0300, Aaro Koskinen wrote:
> Please don't delete OMAP boards quite yet :) In the mainline kernel
> they are not orphaned, they frequently get tested using actual hardware,
> and QEMU would help in additional testing. I'll try to get N8x0 boot to
> work with the minimal kernel I use on real HW.

So it was only a matter of attaching the serial console at the QEMU side
(a hackish patch at the end of the mail).

$ qemu-system-arm --version
QEMU emulator version 4.0.0 (v4.0.0-dirty)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
$ qemu-system-arm -M n810 -kernel zImage -nographic
Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.1.0-n8x0_tiny-los_b1ac4+-00007-g7435e73d8ac4 (aaro@amd-fx-6350) (gcc version 8.3.0 (GCC)) #1 Fri May 24 20:43:02 EEST 2019
[    0.000000] CPU: ARMv6-compatible processor [4107b362] revision 2 (ARMv6TEJ), cr=00c5387d
[    0.000000] CPU: VIPT aliasing data cache, unknown instruction cache
[    0.000000] OF: fdt: Machine model: Nokia N810
[    0.000000] printk: bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writeback
[    0.000000] OMAP2420
[...]

However there are plenty of WARNs that are not present on real hardware.
Anyway, it's a start.

A.

...

diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index 906b7ca22d43..52ff83ec5147 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -792,6 +792,7 @@ static void n8x0_uart_setup(struct n800_s *s)
     qdev_connect_gpio_out(s->mpu->gpio, N8X0_BT_WKUP_GPIO,
                     csrhci_pins_get(radio)[csrhci_pin_wakeup]);
 
+    omap_uart_attach(s->mpu->uart[2], serial_hd(0));
     omap_uart_attach(s->mpu->uart[BT_UART], radio);
 }
 

