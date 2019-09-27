Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE71BC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 08:52:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4258217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 08:52:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4258217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDlyx-00039h-Qv
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 04:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDlxe-0001lU-HD
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 04:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDlxd-0002T5-AQ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 04:50:46 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iDlxZ-0002Bp-Tf; Fri, 27 Sep 2019 04:50:41 -0400
Received: by mail-yw1-f66.google.com with SMTP id x65so634913ywf.12;
 Fri, 27 Sep 2019 01:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NJ8Rg8Su0CjPii+ukETP0Glw88YzYNTSm39Og1Jt1/M=;
 b=tCRgul+SogcrKrj27rrVryXPkn2hT8/fT4N/FVMS9m/okiAhOjon3eBS1lZQkWpYWa
 LMznORb2h2FQ+phvAz65R4EW0ZtxUFYyFjh7wYnV0MgVUpMaARYHkh2XsEP5/+BPgnxU
 FnYJTKiJC/a4WFKWqGMlDa1OG+aVVn9fDOPuxpTxcatRYOP2h2b9zBzI24zm9aMpOynB
 jtQuMeAoGnZqHiH4cXz+xVhQ6IiXVjI+OGJXCRRv1EjAfkdJvcYEgyxUXxLfKQjomrRv
 ClN5jjbShE2auq2u4RuF3zaxNwJ+dc+bQNBgV5SX5aL3//3ONejptQ3FBKDdFAZElC7i
 eZ5g==
X-Gm-Message-State: APjAAAVAy6Xh6EY+lDFCoPpW90lDhOL795sh14o7pV0CE2yoteMrxxHz
 p4I1TsDxLj8ZilHqWi1+540E7rXulDLTe5sjoBE=
X-Google-Smtp-Source: APXvYqzBGc2Eas8uwSl7As0UrRrsr0ZShxu3LhPU47gYNAR8pBgQshFC7ayql6wVUkpbeOJ/ZoUEVlBS2KGc5qmajHU=
X-Received: by 2002:a0d:e6d3:: with SMTP id p202mr1850147ywe.368.1569574240454; 
 Fri, 27 Sep 2019 01:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190926173428.10713-1-f4bug@amsat.org>
 <alpine.BSF.2.21.9999.1909262221020.91838@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1909262221020.91838@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 27 Sep 2019 10:50:28 +0200
Message-ID: <CAAdtpL63edWaf1nEYznR4cjzqy6=1o5w69FFo70+vVSSmCy+qA@mail.gmail.com>
Subject: Re: [PATCH 00/19] hw/arm/raspi: Improve Raspberry Pi 2/3 reliability
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.66
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 26, 2019 at 10:32 PM BALATON Zoltan <balaton@eik.bme.hu> wrote:
> On Thu, 26 Sep 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> > and got it almost working (boots Linux kernel to userland, sadly
> > I'm still having timeout issues with the eMMC block).
> [...]
> > $ make aarch64-softmmu/all check-venv
> > $ ./tests/venv/bin/avocado --show=3Dapp,console run -t machine:raspi2 -=
t machine:raspi3 tests/acceptance
> > JOB ID     : 10bf6593659f0b191941265c19fe3dbf1652c3e7
> > JOB LOG    : /home/phil/avocado/job-results/job-2019-09-26T19.04-10bf65=
9/job.log
> > (1/4) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_=
raspi2_uart0: \console: [    0.000000] Booting Linux on physical CPU 0xf00
> > console: [    0.000000] Linux version 4.14.98-v7+ (dom@dom-XPS-13-9370)=
 (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200 S=
MP Tue Feb 12 20:27:48 GMT 2019
> > console: [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARM=
v7), cr=3D10c5387d
> > console: [    0.000000] CPU: div instructions available: patching divis=
ion code
> > console: [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT a=
liasing instruction cache
> > console: [    0.000000] OF: fdt: Machine model: Raspberry Pi 2 Model B
> > console: [    0.000000] earlycon: pl11 at MMIO 0x3f201000 (options '')
> > console: [    0.000000] bootconsole [pl11] enabled
> > console: [    0.000000] Memory policy: Data cache writealloc
> > console: [    0.000000] cma: Reserved 8 MiB at 0x3b800000
> > console: [    0.000000] percpu: Embedded 17 pages/cpu @baf2e000 s38720 =
r8192 d22720 u69632
> > console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total=
 pages: 243600
> > console: [    0.000000] Kernel command line: printk.time=3D0 earlycon=
=3Dpl011,0x3f201000 console=3DttyAMA0
>
> Not sure what timeouts you get related to eMMC but previously we've found
> that panic at boot due to mmcblk not ready is avoided with the "rootwait"
> kernel option which does not seem to be present in most of these tests.
> (It's also not present in images for real hardware so likely this only
> happens with QEMU but not on real hardware. Could it be that real hardwar=
e
> is slower so timing is different?)

The eMMC issue is on the raspi4.
Looking at my notes, I used "root=3D/dev/mmcblk0 rootwait", and it hangs wi=
th:

Waiting for root device /dev/mmcblk0...
[    0.898870] mmc-bcm2835 3f300000.mmc: mmc_debug:0 mmc_debug2:0
[    0.901397] mmc-bcm2835 3f300000.mmc: DMA channel allocated
[    0.930041] sdhost: log_buf @ (ptrval) (fac53000)
[    0.969910] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    0.973894] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.977753] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    0.981228] mmc0: sdhost-bcm2835 loaded - DMA enabled (>1)

So I guess now Linux improved and use new features not covered by our
hw/sd/bcm2835_sdhost.c model :(
(I have to use recent Linux kernels because older don't support the raspi4)=
.

I'll keep you informed, thanks for the hint!

Phil.

