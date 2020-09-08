Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C96C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:16:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C7F21D20
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 08:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mOXtCU3s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1C7F21D20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFYnY-0002Ik-SP
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 04:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYl9-0005ZT-0h
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:47 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:43632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFYl6-0000Q8-Mk
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 04:13:46 -0400
Received: by mail-pg1-x52b.google.com with SMTP id t14so4057304pgl.10
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 01:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dme5wOJZvNDhKpDBEi74Ima5Rw3hvZ52vtZKHURP4rY=;
 b=mOXtCU3sfQYCyaYDEF3467iwanb/BnVVUkjRgJ2724aFN2GTTwczcMKw67aiTpzQ5/
 UI9Zu7/cn5g/T3L2mfmcXHDtUG/PxYN0b5ZBq7lnY525LRfVnNNDV2KZK4mWrXcY2bZT
 w2pzcBAxnL3OQIai+9TnuGN7CPNx6BkKHW1/0oqanZrxnkOyLReCyvoEtan2NYyfxPiV
 WiMsjPiRsnRrfH6+q7KxYQ/TED3CDomAXsmWt3twbjY9LrCJTmBe8EwCskedRmMtD7TE
 vKFH90buBGcoZ3Bl2NvCnbyhVIF3WGo+NrmnGXijgPMrXRk6U7S1pRujWt/DDlbLeqYB
 lqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Dme5wOJZvNDhKpDBEi74Ima5Rw3hvZ52vtZKHURP4rY=;
 b=CMrj/TvKwO9GtqbcrBFxefe0bWTaHK4lZ6E6sKlDxkS3AUf9CnTo+Ow/qI9thiKo4g
 gPXB9T+ir/ewjiAJFn65r+mEh0pZ5GSJPJdn4i20gwTONGbnic9IafNrW89zfTZ3ytK+
 uxmD+abtIBVhzAZQMa8zwh81CmlRV3Fb5lmHQXtyL+8XyB36PolmtfxwvTn5BR1UF6Tb
 Qr+jgbJZCGwYbo1+3Q8trhukOirZlrn3fo0FiLM0fBzPDOBN1iHWq0CZOfVXVj1fxl+z
 uA50v/s2NTEKTNdDNiCRO0wBRWWMEpGWK3PfLlBAYv66VELa5gXmuxso0XzPw752t+KN
 KWvg==
X-Gm-Message-State: AOAM530yQiNdoukoZgSaiPX1/L06XpvFqr9FHn8Q4dT0Bjp70kJvaTf1
 wMikccFe6HPFD9ZhCQgbmATe
X-Google-Smtp-Source: ABdhPJxYZmOfnfKjnuKddGmh9o43gJ69MZCZy6GnJIG0MbRVsrBPIY49ISgpgB2O/MUcvf3gRggxqA==
X-Received: by 2002:a17:902:b108:b029:d0:cbe1:e770 with SMTP id
 q8-20020a170902b108b02900d0cbe1e770mr102286plr.23.1599552822378; 
 Tue, 08 Sep 2020 01:13:42 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id m190sm16934788pfm.184.2020.09.08.01.13.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 01:13:41 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v2 00/12] target/arm: Add vSPE support to KVM guest
Date: Tue,  8 Sep 2020 08:13:18 +0000
Message-Id: <cover.1599549462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=haibo.xu@linaro.org; helo=mail-pg1-x52b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

v2:
  - Rebased on Andrew's patches[3]
  - Added compat codes to enable vSPE only for the 5.2 and 
    later machine types [Andrew]
  - Changed to use the ID register bit to identify the spe
    feature [Andrew/Richard]
  - Added the missing field in AcpiMadtGenericCpuInterface
    definition [Auger]
  - Split the un-tested userspace irqchip support for vSPE
    into a separate patch [Andrew]
  - Added doc and qtest for vSPE [Andrew]

Many thanks to Andrew, Richard, Philippe and Auger for their comments. 

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
  hw/arm/virt: spe: Add SPE fdt binding for virt machine
  target/arm/cpu: spe: Enable spe to work with host cpu
  target/arm/kvm: spe: Enable userspace irqchip support.
  target/arm: spe: Add corresponding doc and test.

 docs/system/arm/cpu-features.rst |  20 ++++++
 hw/arm/virt-acpi-build.c         |   3 +
 hw/arm/virt.c                    | 116 +++++++++++++++++++++++--------
 include/hw/acpi/acpi-defs.h      |   3 +
 include/hw/arm/virt.h            |   2 +
 linux-headers/asm-arm64/kvm.h    |   4 ++
 linux-headers/linux/kvm.h        |   2 +
 target/arm/cpu.c                 |  11 +++
 target/arm/cpu.h                 |  17 +++++
 target/arm/cpu64.c               |  57 +++++++++++++++
 target/arm/kvm.c                 |  10 +++
 target/arm/kvm64.c               |  56 +++++++++++++--
 target/arm/kvm_arm.h             |  18 +++++
 target/arm/monitor.c             |   2 +-
 tests/qtest/arm-cpu-features.c   |   9 +++
 15 files changed, 294 insertions(+), 36 deletions(-)

-- 
2.17.1


