Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F307C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69ACA221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 08:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaeH9aZC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69ACA221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3xUD-0000pX-K7
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 04:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k3xSf-0006yx-8l
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:45 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32]:35916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1k3xSc-0001gw-3J
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 04:10:44 -0400
Received: by mail-io1-xd32.google.com with SMTP id t15so1077886iob.3
 for <qemu-devel@nongnu.org>; Fri, 07 Aug 2020 01:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CoQS0jn/1hwXwTcHIYOL0+48OLeXmrMVmHENtEgtvUM=;
 b=GaeH9aZChBHRdPq0u5V59OslWHYdLl8rOY5wAxWLOQ1MI3tky7nzgwhYYq58khBl+q
 n9rXoc7MxJ83wRraLE+j8G3eS/huYIt45mz7bmtQ8kZYet3YPpm+kZeIVK/aWM7dwaEE
 a/cAZlh8fgeuD89keyLfLwxvhrq0i4MUeTYlZWGU0KWzZG1/Bwbog30RGEUfYO7SRpAk
 9k5z+tWpyXsTMfDkv/1iVxl4aCfnbUVpxseMoxWAFyirwJrVb8nFdrMKCUyLBwYBUb5l
 4s0a69+jgoxSoeXkx9tZHXXgob990NhU53lhIZBUV7Fm9JON9aaOuHMeofxBEmZ/KWFv
 VhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CoQS0jn/1hwXwTcHIYOL0+48OLeXmrMVmHENtEgtvUM=;
 b=XVtrhzt3m05o8Sp5N2iWetk5+GqlCoxHTPhtG06ZFuhSnMZekPSJZjxfPdVuso/7GF
 Q63v5XgGBdEEAvDXbT3EuRroPw0MheV1nJLEOzhycZYjZ3IDB+D6KAsFSTMJqtfg3GQI
 bXZF9K4wQN1KX+t6WewO5lNwYORM0l/V8k1QXH8Q0JUPfI0vV9hdFXHwtnxk9yeqK45s
 R1LRQ/kW5UFvx9MYJ1DZKT4pjvrqbRHL6IKhtrCOLrMgIJ4XWn1sYRcSXUbFYmOolncz
 mFJAN/VIKTQV5ibMpJ6OVy3DMRkm2jQcCuEbmvXXidDW788e2myrqh0RRrEaJwg74JNy
 l9ug==
X-Gm-Message-State: AOAM530QujrsFKCojcer7JlBxTRvl3OEZZYpgasoZeSyIZCGkPNhMdxK
 vaqZsKeZB9ABdtJxvpcGQHAQ
X-Google-Smtp-Source: ABdhPJx+dd+FZEUPthxbS13wXm3KiIOfFKLr+PCSmYr+TKpBmX3qa+qS+trdTYj6ltMw5vUKB951qA==
X-Received: by 2002:a05:6602:2409:: with SMTP id
 s9mr3032017ioa.98.1596787840232; 
 Fri, 07 Aug 2020 01:10:40 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id l144sm6233546ill.6.2020.08.07.01.10.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2020 01:10:39 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: peter.maydell@linaro.org
Subject: [PATCH 0/7] target/arm: Add vSPE support to KVM guest
Date: Fri,  7 Aug 2020 08:10:30 +0000
Message-Id: <cover.1596768588.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d32;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd32.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: drjones@redhat.com, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
    update them accordingly.
(2) These patches only add vSPE support in KVM mode, for TCG mode, I'm
    not sure whether we need to support it.
(3) Just followed the 'pmu' property, we only allow this feature to be
    removed from CPUs which enable it by default. But since the SPE is
    an optional feature extension for Armv8.2, I think a better way may
    be to disable it by default, and only enable it when the host cpu
    do have the feature.

[1]https://community.arm.com/developer/ip-products/processors/b/processors-ip-blog/
   posts/statistical-profiling-extension-for-armv8-a
[2]https://www.spinics.net/lists/arm-kernel/msg776228.html

Haibo Xu (7):
  update Linux headers with new vSPE macros
  target/arm/kvm: spe: Add helper to detect SPE when using KVM
  target/arm/cpu: spe: Add an option to turn on/off vSPE support
  target/arm/kvm: spe: Unify device attr operatioin helper
  target/arm/kvm: spe: Add device init and set_irq operations
  hw/arm/virt: spe: Add SPE fdt binding for virt machine
  target/arm/cpu: spe: Enable spe to work with host cpu

 hw/arm/virt-acpi-build.c      |  3 +++
 hw/arm/virt.c                 | 42 ++++++++++++++++++++++++++++++
 include/hw/acpi/acpi-defs.h   |  1 +
 include/hw/arm/virt.h         |  1 +
 linux-headers/asm-arm64/kvm.h |  4 +++
 linux-headers/linux/kvm.h     |  2 ++
 target/arm/cpu.c              | 34 +++++++++++++++++++++++++
 target/arm/cpu.h              |  5 ++++
 target/arm/kvm.c              | 11 ++++++++
 target/arm/kvm64.c            | 48 ++++++++++++++++++++++++++++++++---
 target/arm/kvm_arm.h          | 18 +++++++++++++
 11 files changed, 166 insertions(+), 3 deletions(-)

-- 
2.17.1


