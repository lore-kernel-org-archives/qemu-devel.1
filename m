Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9855C2BBD1
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8542D20897
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEtmmovl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8542D20897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48368 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI1P8-0001tm-KX
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 23:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O4-0000Dc-SS
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:08 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:44467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1O1-0001ec-9x
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:08 -0400
Received: by mail-pf1-x42a.google.com with SMTP id o20so1089437pfp.11
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 20:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c/EzHGppV6gl8rO8Vhy6nIp4rvkUxVOnTcgtSMu43es=;
 b=bEtmmovl3hTJh0CqzLmiUHX7ywamblJDobmYYRuAtUFfPDBTH7qQiX5m6OqFuZdF0Z
 esHQmFt95HYAwAK1tE/YZFLWj1sB9CeJZykFAeRYGhvouH9sdOLUhJ/OOuvD8y001wWP
 cykDvroHTVCe57eeb8DSXCEU91/cKzYgqCDVTdUCpodlNSLwlrJqKIzlOo3TjrnkFLXi
 Oe+utEYFBu/87QXj4R+4AdfQU70y0b2InMPemBWpxZ5Di8y5jvtZH8sImVk2QG4bcCue
 /zp23U9Z3yzKJup2si/X+7joALoGHDuL4jRiJLDhywGhADoABaavK2RGHBm78voQJ3nj
 dTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=c/EzHGppV6gl8rO8Vhy6nIp4rvkUxVOnTcgtSMu43es=;
 b=nZhtTO2dAnP0p++zbyXOJS5Qb9eJbsg7me60ZZ3KIl/QdMW6hPnsePawmKXWzxVjIU
 /n5+SEVaRR2D/oyL1+IzYIOSd3P7ApXtKpmyATtkPh99YCAMu5nN5a0LCzE5g752iyBP
 g+8hMOnln4eGmuKcNV3b6Q5O7rhxFcLW3aNDaOgBHV2av9tuXBm/2ZWkDNpZTj5E281d
 OWtYQJr1rs//xrbS9ju1Xda4y55G8PnEpAV4g3fFaT0wCZTRNqFPRkRBCfJzG1D5NMbd
 uDEgGwmpIeis9fAn9I6cS7EPLAXcKBOKMML3d6FwfbWBWIaIb8wgcxfVbZgIo6VSQpUr
 38Yw==
X-Gm-Message-State: AOAM531GMUyc5bwhpZzm5LUNAOUKhyUvQtq8Ms+yrH+d3f/MnVTYA75W
 SrVMtSiwvfWW/ibozYu0sgKz
X-Google-Smtp-Source: ABdhPJx6beHyptaYMKzOlTpMMW0BrRMZdev6amwTklDFhgNmg3Nr9AWBeIG4sFCkPxter8yY0Gs3sg==
X-Received: by 2002:a63:fe49:: with SMTP id x9mr12976163pgj.446.1600139523347; 
 Mon, 14 Sep 2020 20:12:03 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id g23sm11551776pfh.133.2020.09.14.20.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:12:02 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v3 00/12] target/arm: Add vSPE support to KVM guest
Date: Tue, 15 Sep 2020 03:11:36 +0000
Message-Id: <cover.1600135462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=haibo.xu@linaro.org; helo=mail-pf1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3:
  - Moved the patch 11 kernel header change to patch 01
  - Removed doc for vSPE
  - Moved the assignment of has_spe into aarch64_add_spe_properties
  - Only enable spe properties in KVM mode
  - Only trigger the kvm_arm_spe_init with in-kernel irqchip support
    to avoid breaking bisection
  - Set the PMSVER bit in ID register if spe was enabled by usespace

Again, many thanks to Andrew, Richard, Philippe and Auger for their comments. 

This series add support for SPE(Statistical Profiling Extension)[1]
in KVM guest. It's based on Andrew Murray's kernel KVM patches V2[2],
and has been tested to ensure that guest can use SPE with valid data.
E.g.

In host:
$ ./qemu-system-aarch64 \
        -cpu host -M virt,accel=kvm,gic-version=3 -nographic -m 2048M \
        -kernel ./Image-new \
        -initrd /boot/initrd.img-5.6.0-rc2+ \
        -append "root=/dev/vda rw console=ttyAMA0" -nodefaults -serial stdio\
        -drive if=none,file=./xenial.rootfs.ext4,id=hd0,format=raw \
        -device virtio-blk-device,drive=hd0  \

In guest:
$ perf record -e arm_spe/ts_enable=1,pa_enable=1,pct_enable=1/ \
        dd if=/dev/zero of=/dev/null count=1000
$ perf report --dump-raw-trace > spe_buf.txt

The spe_buf.txt should contain similar data as below:

. ... ARM SPE data: size 135944 bytes
.  00000000:  b0 f4 d3 29 10 00 80 ff a0                      PC 0xff80001029d3f4 el1 ns=1
.  00000009:  99 0b 00                                        LAT 11 ISSUE
.  0000000c:  98 0d 00                                        LAT 13 TOT 
.  0000000f:  52 16 00                                        EV RETIRED L1D-ACCESS TLB-ACCESS
.  00000012:  49 00                                           LD  
.  00000014:  b2 d0 40 d8 70 00 00 ff 00                      VA 0xff000070d840d0
.  0000001d:  9a 01 00                                        LAT 1 XLAT
.  00000020:  00 00 00                                        PAD 
.  00000023:  71 a5 1f b3 20 14 00 00 00                      TS 86447955877
.  0000002c:  b0 7c f9 29 10 00 80 ff a0                      PC 0xff80001029f97c el1 ns=1
.  00000035:  99 02 00                                        LAT 2 ISSUE
.  00000038:  98 03 00                                        LAT 3 TOT 
.  0000003b:  52 02 00                                        EV RETIRED
.  0000003e:  48 00                                           INSN-OTHER
.  00000040:  00 00 00                                        PAD
.  00000043:  71 ef 1f b3 20 14 00 00 00                      TS 86447955951
.  0000004c:  b0 f0 e9 29 10 00 80 ff a0                      PC 0xff80001029e9f0 el1 ns=1
.  00000055:  99 02 00                                        LAT 2 ISSUE
.  00000058:  98 03 00                                        LAT 3 TOT
.  0000005b:  52 02 00                                        EV RETIRED

If you want to disable the vSPE support, you can use the 'spe=off' cpu
property:

./qemu-system-aarch64 \
        -cpu host,spe=off -M virt,accel=kvm,gic-version=3 -nographic -m 2048M \
        -kernel ./Image-new \
        -initrd /boot/initrd.img-5.6.0-rc2+ \
        -append "root=/dev/vda rw console=ttyAMA0" -nodefaults -serial stdio\
        -drive if=none,file=./xenial.rootfs.ext4,id=hd0,format=raw \
        -device virtio-blk-device,drive=hd0  \

Note:
(1) Since the kernel patches are still under review, some of the macros
    in the header files may be changed after merging. We may need to
    update them accordingly. To be specific, if you want to have a try
    on this patch series, you needs to replace on the kernel 5.5-rc2 based
    series, and do minor changes:

    -#define KVM_CAP_ARM_SPE_V1 179
    +#define KVM_CAP_ARM_SPE_V1 184

(2) These patches only add vSPE support in KVM mode, for TCG mode, I'm
    not sure whether we need to support it.
(3) Just followed the 'sve' property, we only allow this feature to be
    removed from CPUs which enable it by default when the host cpu support it.

[1]https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/
   posts/statistical-profiling-extension-for-armv8-a
[2]https://www.spinics.net/lists/arm-kernel/msg776228.html
[3]https://www.mail-archive.com/qemu-devel@nongnu.org/msg727588.html

Haibo Xu (12):
  update Linux headers with new vSPE macros
  target/arm/kvm: spe: Add helper to detect SPE when using KVM
  target/arm/cpu: spe: Add an option to turn on/off vSPE support
  target/arm: spe: Only enable SPE from 5.2 compat machines.
  target/arm/kvm: spe: Unify device attr operation helper
  target/arm/kvm: spe: Add device init and set_irq operations
  hw/arm/virt: Move post cpu realize check into its own function
  hw/arm/virt: Move kvm pmu setup to virt_cpu_post_init
  hw/arm/virt: spe: Add vSPE device and corresponding interrupt support
  target/arm/cpu: spe: Enable spe to work with host cpu
  target/arm/kvm: spe: Enable userspace irqchip support.
  target/arm: spe: Add corresponding test.

 hw/arm/virt-acpi-build.c       |   3 +
 hw/arm/virt.c                  | 116 ++++++++++++++++++++++++---------
 include/hw/acpi/acpi-defs.h    |   3 +
 include/hw/arm/virt.h          |   2 +
 linux-headers/asm-arm64/kvm.h  |   4 ++
 linux-headers/linux/kvm.h      |   2 +
 target/arm/cpu.c               |   9 +++
 target/arm/cpu.h               |  17 +++++
 target/arm/cpu64.c             |  56 ++++++++++++++++
 target/arm/kvm.c               |  10 +++
 target/arm/kvm64.c             |  56 ++++++++++++++--
 target/arm/kvm_arm.h           |  18 +++++
 target/arm/monitor.c           |   2 +-
 tests/qtest/arm-cpu-features.c |   9 +++
 14 files changed, 271 insertions(+), 36 deletions(-)

-- 
2.17.1


