Return-Path: <SRS0=HB7V=X6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7372CC4740A
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 15:52:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30AF42133F
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2019 15:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RmoppEl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AF42133F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGmLm-00041r-D7
	for qemu-devel@archiver.kernel.org; Sat, 05 Oct 2019 11:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGmHl-0008Jx-NP
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGmHj-0007y4-N9
 for qemu-devel@nongnu.org; Sat, 05 Oct 2019 11:47:57 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34349)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iGmHj-0007wB-FS; Sat, 05 Oct 2019 11:47:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id j11so4697888wrp.1;
 Sat, 05 Oct 2019 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ORpZrfjKnIUmuyqyANwDX4Q5AcwXrPMAGidRqNo+o7U=;
 b=RmoppEl7JNk1COfGBKgUmdTHS9PEh8t7ea+X1wyUNpc9xt0tqVa4lsbEQM5434JRKy
 NZ2NtRz2d4jzpv/VGPAKujLGEt2l1tnayTckP3b+hpi+c5cwomnS5HoJfpvlFRnHPnlG
 FsH8K5kuzhq/jC1H09GD6opyeLALoRgSCZDxPE1iZ/WQxPcp3pCGB+w9B3JbXZlGJ/w9
 feB5s/GeKic1VAt2Upp7CkUUF5ugPjnercwJMFzvYTHv/NhTTpkdXPjP2eCSQEnjBwhf
 9KzuFO9X6dOny4Afksaf5+2YTr94oHOtetCWF+3XlFoGeai5QpvMCPFEVcj4OeoK0YaJ
 PVdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=ORpZrfjKnIUmuyqyANwDX4Q5AcwXrPMAGidRqNo+o7U=;
 b=E5F4lm3xnyqqE4EFGe22PC95TEb3MjQpZqI+q5pKZHrjMlQkMoRqbpstoAyormQiC/
 p/u61jLRRq+JP9ne+7ShJpg/bq5F0eMRDYM4kIxCnTQYBy4/iW5vLCDsV6BLFSCt+8Mt
 4gwYe176x6+z8zXXUgJ58n//vpD2/oJ3lOEEPt0CabQhPXJ5/MQwU4tRxQWdDNoyqzHn
 nQOcth6ko5AuVhzgUVVdWDnRT2SK57AnM8vVeUiHIYcaY83rZqS04Z98rCeBMNwZycbV
 yZucPgVDhfg17d9f5qjimxS4NdrsY5nippYEGgVbK2fFcR5gcgakyEEkzkoN+QGs3wg0
 NMPw==
X-Gm-Message-State: APjAAAXXiyzvUvnSN9/FW74II6gReMwTKK3Fwz4EX9EhtnTAa9o6sBAV
 9apCxfnhLUZZFUKee5I8cErPmui3cGo=
X-Google-Smtp-Source: APXvYqy4ZT/CTaYNixI30JDDxWWz9HhA4kc1AnS0NBgeh9UH5F8aVvdcs+itGToM1hmHUldg09x+bg==
X-Received: by 2002:adf:ff8b:: with SMTP id j11mr7286784wrr.65.1570290473013; 
 Sat, 05 Oct 2019 08:47:53 -0700 (PDT)
Received: from localhost.localdomain (46.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.46])
 by smtp.gmail.com with ESMTPSA id o22sm24542294wra.96.2019.10.05.08.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2019 08:47:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/5] tests/boot_linux_console: Add initrd test for the
 Exynos4210
Date: Sat,  5 Oct 2019 17:47:44 +0200
Message-Id: <20191005154748.21718-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191005154748.21718-1-f4bug@amsat.org>
References: <20191005154748.21718-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Basse?= <contact@fredericb.info>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Cleber Rosa <crosa@redhat.com>,
 Maksim Kozlov <m.kozlov@samsung.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test boots a Linux kernel on a smdkc210 board and verify
the serial output is working.

The cpio image used comes from the linux-build-test project:
https://github.com/groeck/linux-build-test

If ARM is a target being built, "make check-acceptance" will
automatically include this test by the use of the "arch:arm" tags.

This test can be run using:

  $ avocado --show=app,console run -t machine:smdkc210 tests/acceptance/boot_linux_console.py
  console: Booting Linux on physical CPU 0x900
  console: Linux version 4.19.0-6-armmp (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Debian 4.19.67-2+deb10u1 (2019-09-20)
  console: CPU: ARMv7 Processor [410fc090] revision 0 (ARMv7), cr=10c5387d
  console: CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
  console: OF: fdt: Machine model: Samsung smdkv310 evaluation board based on Exynos4210
  [...]
  console: Samsung CPU ID: 0x43210211
  console: random: get_random_bytes called from start_kernel+0xa0/0x504 with crng_init=0
  console: percpu: Embedded 17 pages/cpu s39756 r8192 d21684 u69632
  console: Built 1 zonelists, mobility grouping on.  Total pages: 249152
  console: Kernel command line: printk.time=0 console=ttySAC0,115200n8 earlyprintk random.trust_cpu=off cryptomgr.notests cpuidle.off=1 panic=-1 noreboot
  [...]
  console: L2C: platform modifies aux control register: 0x02020000 -> 0x3e420001
  console: L2C: platform provided aux values permit register corruption.
  console: L2C: DT/platform modifies aux control register: 0x02020000 -> 0x3e420001
  console: L2C-310 erratum 769419 enabled
  console: L2C-310 enabling early BRESP for Cortex-A9
  console: L2C-310: enabling full line of zeros but not enabled in Cortex-A9
  console: L2C-310 ID prefetch enabled, offset 1 lines
  console: L2C-310 dynamic clock gating disabled, standby mode disabled
  console: L2C-310 cache controller enabled, 8 ways, 128 kB
  console: L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x7e420001
  console: Exynos4210 clocks: sclk_apll = 12000000, sclk_mpll = 12000000
  console: sclk_epll = 12000000, sclk_vpll = 12000000, arm_clk = 12000000
  [...]
  console: s3c-i2c 13860000.i2c: slave address 0x00
  console: s3c-i2c 13860000.i2c: bus frequency set to 93 KHz
  console: s3c-i2c 13860000.i2c: i2c-0: S3C I2C adapter
  [...]
  console: dma-pl330 12680000.pdma: Loaded driver for PL330 DMAC-241330
  console: dma-pl330 12680000.pdma:       DBUFF-256x8bytes Num_Chans-8 Num_Peri-32 Num_Events-16
  console: dma-pl330 12690000.pdma: Loaded driver for PL330 DMAC-241330
  console: dma-pl330 12690000.pdma:       DBUFF-256x8bytes Num_Chans-8 Num_Peri-32 Num_Events-16
  console: dma-pl330 12850000.mdma: Loaded driver for PL330 DMAC-241330
  console: dma-pl330 12850000.mdma:       DBUFF-256x8bytes Num_Chans-8 Num_Peri-1 Num_Events-16
  console: dma-pl330 12850000.mdma: PM domain LCD0 will not be powered off
  console: Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
  console: Serial: AMBA driver
  console: 13800000.serial: ttySAC0 at MMIO 0x13800000 (irq = 40, base_baud = 0) is a S3C6400/10
  console: console [ttySAC0] enabled
  console: 13810000.serial: ttySAC1 at MMIO 0x13810000 (irq = 41, base_baud = 0) is a S3C6400/10
  console: 13820000.serial: ttySAC2 at MMIO 0x13820000 (irq = 42, base_baud = 0) is a S3C6400/10
  console: 13830000.serial: ttySAC3 at MMIO 0x13830000 (irq = 43, base_baud = 0) is a S3C6400/10
  [...]
  console: Freeing unused kernel memory: 2048K
  console: Run /init as init process
  console: mount: mounting devtmpfs on /dev failed: Device or resource busy
  console: Starting logging: OK
  console: Initializing random number generator... random: dd: uninitialized urandom read (512 bytes read)
  console: done.
  console: Starting network: OK
  console: Found console ttySAC0
  console: Linux version 4.19.0-6-armmp (debian-kernel@lists.debian.org) (gcc version 8.3.0 (Debian 8.3.0-6)) #1 SMP Debian 4.19.67-2+deb10u1 (2019-09-20)
  console: Boot successful.
  PASS (37.98 s)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
serial input is not working :(

I sometime get (not always):

Starting network: OK
[   70.403690] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   70.423212] rcu:     0-...!: (36 GPs behind) idle=c7a/1/0x40000000 softirq=287/288 fqs=1
[   70.428209] rcu:     (detected by 1, t=2602 jiffies, g=-443, q=2209)
[   70.432826] Sending NMI from CPU 1 to CPUs 0:
[   70.473866] NMI backtrace for cpu 0
[   70.476621] CPU: 0 PID: 112 Comm: cat Not tainted 4.19.0 #1
[   70.476711] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   70.476916] PC is at mntput_no_expire+0x88/0x464
[   70.476996] LR is at rcu_is_watching+0x24/0x78
[   70.477074] pc : [<c02b256c>]    lr : [<c01a2fb4>]    psr: a0000013
[   70.477150] sp : ee2afdb0  ip : 9dff9a2f  fp : ee2aff70
[   70.477225] r10: 00000142  r9 : ee219dc0  r8 : ee2afec0
[   70.477302] r7 : ee2afec0  r6 : c0298d6c  r5 : ef02c400  r4 : ef018200
[   70.477385] r3 : c0f99274  r2 : 00000031  r1 : 2e87c000  r0 : a0000013
[   70.477461] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   70.477537] Control: 10c5387d  Table: 6e30806a  DAC: 00000051
[   70.477613] CPU: 0 PID: 112 Comm: cat Not tainted 4.19.0 #1
[   70.477688] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[   70.477765] [<c01128f4>] (unwind_backtrace) from [<c010e5b4>] (show_stack+0x10/0x14)
[   70.477847] [<c010e5b4>] (show_stack) from [<c0a36160>] (dump_stack+0x98/0xc4)
[   70.477925] [<c0a36160>] (dump_stack) from [<c0a3cc90>] (nmi_cpu_backtrace+0x6c/0xb4)
[   70.478000] [<c0a3cc90>] (nmi_cpu_backtrace) from [<c0111530>] (handle_IPI+0x108/0x420)
[   70.478076] [<c0111530>] (handle_IPI) from [<c04950a8>] (gic_handle_irq+0x98/0x9c)
[   70.478151] [<c04950a8>] (gic_handle_irq) from [<c01019f0>] (__irq_svc+0x70/0xb0)
[   70.478226] Exception stack(0xee2afd60 to 0xee2afda8)
[   70.478303] fd60: a0000013 2e87c000 00000031 c0f99274 ef018200 ef02c400 c0298d6c ee2afec0
[   70.478378] fd80: ee2afec0 ee219dc0 00000142 ee2aff70 9dff9a2f ee2afdb0 c01a2fb4 c02b256c
[   70.478453] fda0: a0000013 ffffffff
[   70.478529] [<c01019f0>] (__irq_svc) from [<c02b256c>] (mntput_no_expire+0x88/0x464)
[   70.478605] [<c02b256c>] (mntput_no_expire) from [<c0298d6c>] (terminate_walk+0x154/0x160)
[   70.478681] [<c0298d6c>] (terminate_walk) from [<c029ce3c>] (path_openat+0x324/0xfe4)
[   70.478759] [<c029ce3c>] (path_openat) from [<c029ea9c>] (do_filp_open+0x70/0xdc)
[   70.478835] [<c029ea9c>] (do_filp_open) from [<c028b36c>] (do_sys_open+0x134/0x1e4)
[   70.478911] [<c028b36c>] (do_sys_open) from [<c0101000>] (ret_fast_syscall+0x0/0x28)
[   70.478989] Exception stack(0xee2affa8 to 0xee2afff0)
[   70.479064] ffa0:                   b6fc7d6c 0000000a ffffff9c bebbf268 000a0000 00000000
[   70.479139] ffc0: b6fc7d6c 0000000a 00000050 00000142 bebbf268 b6fc6970 b6fc6b28 bebbf254
[   70.479214] ffe0: b6fc6970 bebbf1e0 b6f9dd94 b6fb0c0c
[   70.484892] rcu: rcu_preempt kthread starved for 2600 jiffies! g-443 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
[   70.514943] rcu: RCU grace-period kthread stack dump:
[   70.516687] rcu_preempt     I    0    10      2 0x00000000
[   70.523711] [<c0a4caac>] (__schedule) from [<c0a4d28c>] (schedule+0x4c/0xac)
[   70.525103] [<c0a4d28c>] (schedule) from [<c0a52c34>] (schedule_timeout+0x230/0x564)
[   70.526472] [<c0a52c34>] (schedule_timeout) from [<c01a7818>] (rcu_gp_kthread+0x6e4/0xbf0)
[   70.527784] [<c01a7818>] (rcu_gp_kthread) from [<c014d7f0>] (kthread+0x138/0x168)
[   70.528989] [<c014d7f0>] (kthread) from [<c01010b4>] (ret_from_fork+0x14/0x20)
[   70.530387] Exception stack(0xef111fb0 to 0xef111ff8)
[   70.532556] 1fa0:                                     00000000 00000000 00000000 00000000
[   70.534904] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   70.536920] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Found console ttySAC0

Linux version 4.19.0 (root@591d0a36fd03) (gcc version 6.3.0 20170516 (Debian 6.3.0-18)) #1 SMP PREEMPT Fri Oct 4 19:53:43 UTC 2019
Boot successful.
/ #

Also:

[   73.000405] [<c01128f4>] (unwind_backtrace) from [<c010e5b4>] (show_stack+0x10/0x14)
[   73.000537] [<c010e5b4>] (show_stack) from [<c0a36160>] (dump_stack+0x98/0xc4)
[   73.000631] [<c0a36160>] (dump_stack) from [<c0a3cc90>] (nmi_cpu_backtrace+0x6c/0xb4)
[   73.000701] [<c0a3cc90>] (nmi_cpu_backtrace) from [<c0111530>] (handle_IPI+0x108/0x420)
[   73.000823] [<c0111530>] (handle_IPI) from [<c04950a8>] (gic_handle_irq+0x98/0x9c)
[   73.000924] [<c04950a8>] (gic_handle_irq) from [<c01019f0>] (__irq_svc+0x70/0xb0)
[   73.000990] Exception stack(0xef123f80 to 0xef123fc8)
[   73.001064] 3f80: 00000001 00000001 00000000 ef11b300 ef122000 c1007470 c10074b4 00000002
[   73.001131] 3fa0: 4000406a 410fc090 00000000 00000000 00000000 ef123fd0 c018759c c010a4c8
[   73.001196] 3fc0: 20000013 ffffffff
[   73.001262] [<c01019f0>] (__irq_svc) from [<c010a4c8>] (arch_cpu_idle+0x24/0x3c)
[   73.001328] [<c010a4c8>] (arch_cpu_idle) from [<c015f1f0>] (do_idle+0xcc/0x168)
[   73.001394] [<c015f1f0>] (do_idle) from [<c015f60c>] (cpu_startup_entry+0x18/0x1c)
[   73.001462] [<c015f60c>] (cpu_startup_entry) from [<4010276c>] (0x4010276c)

Based-on: 20190926173428.10713-16-f4bug@amsat.org
"tests/boot_linux_console: Extract the gunzip() helper"
---
 tests/acceptance/boot_linux_console.py | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
index 079590f0c8..197358a69c 100644
--- a/tests/acceptance/boot_linux_console.py
+++ b/tests/acceptance/boot_linux_console.py
@@ -318,6 +318,47 @@ class BootLinuxConsole(Test):
         self.vm.launch()
         self.wait_for_console_pattern('init started: BusyBox')
 
+    def test_arm_exynos4210_initrd(self):
+        """
+        :avocado: tags=arch:arm
+        :avocado: tags=machine:smdkc210
+        """
+        deb_url = ('https://snapshot.debian.org/archive/debian/'
+                   '20190928T224601Z/pool/main/l/linux/'
+                   'linux-image-4.19.0-6-armmp_4.19.67-2+deb10u1_armhf.deb')
+        deb_hash = 'fa9df4a0d38936cb50084838f2cb933f570d7d82'
+        deb_path = self.fetch_asset(deb_url, asset_hash=deb_hash)
+        kernel_path = self.extract_from_deb(deb_path,
+                                            '/boot/vmlinuz-4.19.0-6-armmp')
+        dtb_path = '/usr/lib/linux-image-4.19.0-6-armmp/exynos4210-smdkv310.dtb'
+        dtb_path = self.extract_from_deb(deb_path, dtb_path)
+
+        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
+                      '2eb0a73b5d5a28df3170c546ddaaa9757e1e0848/rootfs/'
+                      'arm/rootfs-armv5.cpio.gz')
+        initrd_hash = '2b50f1873e113523967806f4da2afe385462ff9b'
+        initrd_path_gz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        initrd_path = os.path.join(self.workdir, 'rootfs.cpio')
+        gunzip(initrd_path_gz, initrd_path)
+
+        self.vm.set_machine('smdkc210')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=exynos4210,0x13800000 earlyprintk ' +
+                               'console=ttySAC0,115200n8 ' +
+                               'random.trust_cpu=off cryptomgr.notests ' +
+                               'cpuidle.off=1 panic=-1 noreboot')
+
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+
+        self.wait_for_console_pattern('Boot successful.')
+        # TODO user command, for now the uart is stuck
+
     def test_s390x_s390_ccw_virtio(self):
         """
         :avocado: tags=arch:s390x
-- 
2.20.1


