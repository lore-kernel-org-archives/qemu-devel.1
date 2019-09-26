Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3ADC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 20:33:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC435222C3
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 20:33:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC435222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDaSU-0003jw-60
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 16:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35447)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iDaRB-0002wd-JM
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 16:32:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iDaRA-0008H7-KW
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 16:32:29 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:50249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1iDaR6-00085U-JU; Thu, 26 Sep 2019 16:32:24 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6994574AAAC;
 Thu, 26 Sep 2019 22:32:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4CF1B749FDB; Thu, 26 Sep 2019 22:32:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4BB25749EDE;
 Thu, 26 Sep 2019 22:32:14 +0200 (CEST)
Date: Thu, 26 Sep 2019 22:32:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH 00/19] hw/arm/raspi: Improve Raspberry Pi 2/3 reliability
In-Reply-To: <20190926173428.10713-1-f4bug@amsat.org>
Message-ID: <alpine.BSF.2.21.9999.1909262221020.91838@zero.eik.bme.hu>
References: <20190926173428.10713-1-f4bug@amsat.org>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-895926101-1569529556=:91838"
Content-ID: <alpine.BSF.2.21.9999.1909262227160.91838@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-895926101-1569529556=:91838
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-ID: <alpine.BSF.2.21.9999.1909262227161.91838@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Sep 2019, Philippe Mathieu-Daud=E9 wrote:
> and got it almost working (boots Linux kernel to userland, sadly
> I'm still having timeout issues with the eMMC block).
[...]
> $ make aarch64-softmmu/all check-venv
> $ ./tests/venv/bin/avocado --show=3Dapp,console run -t machine:raspi2 -=
t machine:raspi3 tests/acceptance
> JOB ID     : 10bf6593659f0b191941265c19fe3dbf1652c3e7
> JOB LOG    : /home/phil/avocado/job-results/job-2019-09-26T19.04-10bf65=
9/job.log
> (1/4) tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_=
raspi2_uart0: \console: [    0.000000] Booting Linux on physical CPU 0xf0=
0
> console: [    0.000000] Linux version 4.14.98-v7+ (dom@dom-XPS-13-9370)=
 (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #1200=
 SMP Tue Feb 12 20:27:48 GMT 2019
> console: [    0.000000] CPU: ARMv7 Processor [410fc075] revision 5 (ARM=
v7), cr=3D10c5387d
> console: [    0.000000] CPU: div instructions available: patching divis=
ion code
> console: [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT a=
liasing instruction cache
> console: [    0.000000] OF: fdt: Machine model: Raspberry Pi 2 Model B
> console: [    0.000000] earlycon: pl11 at MMIO 0x3f201000 (options '')
> console: [    0.000000] bootconsole [pl11] enabled
> console: [    0.000000] Memory policy: Data cache writealloc
> console: [    0.000000] cma: Reserved 8 MiB at 0x3b800000
> console: [    0.000000] percpu: Embedded 17 pages/cpu @baf2e000 s38720 =
r8192 d22720 u69632
> console: [    0.000000] Built 1 zonelists, mobility grouping on.  Total=
 pages: 243600
> console: [    0.000000] Kernel command line: printk.time=3D0 earlycon=3D=
pl011,0x3f201000 console=3DttyAMA0

Not sure what timeouts you get related to eMMC but previously we've found=
=20
that panic at boot due to mmcblk not ready is avoided with the "rootwait"=
=20
kernel option which does not seem to be present in most of these tests.=20
(It's also not present in images for real hardware so likely this only=20
happens with QEMU but not on real hardware. Could it be that real hardwar=
e=20
is slower so timing is different?)

Regards,
BALATON Zoltan
--3866299591-895926101-1569529556=:91838--

