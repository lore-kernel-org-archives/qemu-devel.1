Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83261C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC4C320679
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 04:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5W4qpTs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC4C320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1katFp-0000sE-Hc
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 23:21:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1katEx-00008Q-A5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:20:43 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37135)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1katEv-0006qW-1t
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 23:20:42 -0500
Received: by mail-pf1-x444.google.com with SMTP id 13so145845pfy.4
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 20:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NBxD1QBn+pw0WASVh7pOY7WZo3hcOko6Rk/3uawMKQQ=;
 b=n5W4qpTsqM0TZ1JPpOUiFapkgOG2ttV0t9J0X8P/QIqBlKl8Quqqr9uTSYOV7673FF
 O8yZGjT8/MoYXwa0cjWmolbz/S+cD4lZZrVzvcBsjTqOWVamEUncIFoUBxeCfvNwU51C
 5EvmjQTeWmWoSqc0lZdtviSsXIoHWGoG/kTKuCjsYfQv1sWnrreDBGmOqLNG4yj2R8Ug
 exQ30BFXjYcwuRRHsHf4ryWWnx3YFokWVB3uDJVR8Cwle0evPatYKTBdAATAK+D9tEBJ
 sbVcEdqmXlU0PwEGlccZ/znsqMh2STJG1e/Uusz2KCe20IUaVx7f5TXhnJD29ocs/MWq
 jStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NBxD1QBn+pw0WASVh7pOY7WZo3hcOko6Rk/3uawMKQQ=;
 b=RvZSZCBSAA2jClNyec7dUjM7gCVvbH0gFT4HaUItZ2QxcaSEW449xutLLZ8ZTeC8ll
 Lf9lTeCMAETtGqozVsGlMikGW4ToUDoOCLKTO9sCf7Vs9bh1+5u0uIuUCMHbIztLM0Jd
 XqCABHCHBltRXR2+ftmpiwOwvUbMMe1HTlcKxBW8Sstq12qLTdGyxFmFfMCWy6oz66+O
 9GSXCPau27b3bt2ZznKnGjgL7BsPg+mizwZz+VZnHvGR01jjOv+On5KyX5BGA6UDapkd
 Z4QHoJhCXyeUf4aDgAcsMWwb1gXr3M+eL/ssndra9PnsvxfchgF3Go/3ErfhMFc8pu8B
 FU6w==
X-Gm-Message-State: AOAM533UFRRSkJGCsKZaBQZLrX1Cs2PE4PyS8N7aHkEBFPITaY/i2FXx
 E5auB4n6Ox/l9QNKAUfTcMA=
X-Google-Smtp-Source: ABdhPJy5mpoKKJ5QCWmnlEqzDDKs8/ERtkgrLHmGDARlrpfg/74XU8BfvgdQ/9yvGTmKhbEFnhtS+g==
X-Received: by 2002:a17:90a:74c5:: with SMTP id
 p5mr308259pjl.167.1604636439029; 
 Thu, 05 Nov 2020 20:20:39 -0800 (PST)
Received: from software.domain.org (111-252-196-15.dynamic-ip.hinet.net.
 [111.252.196.15])
 by smtp.gmail.com with ESMTPSA id y1sm262235pjl.12.2020.11.05.20.20.35
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Nov 2020 20:20:38 -0800 (PST)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH V17 0/6] mips: Add Loongson-3 machine support
Date: Fri,  6 Nov 2020 12:21:44 +0800
Message-Id: <1604636510-8347-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
Loongson-3A R4 is the newest and its ISA is almost the superset of all
others. To reduce complexity, in QEMU we just define two CPU types:

1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
   suitable for TCG because Loongson-3A R1 has fewest ASE.
2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
   suitable for KVM because Loongson-3A R4 has the VZ ASE.

Loongson-3 lacks English documents. I've tried to translated them with
translate.google.com, and the machine translated documents (together
with their original Chinese versions) are available here.

Loongson-3A R1 (Loongson-3A1000)
User Manual Part 1:
http://ftp.godson.ac.cn/lemote/3A1000_p1.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P1.pdf (Chinese Version)
User Manual Part 2:
http://ftp.godson.ac.cn/lemote/3A1000_p2.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A1000_processor_user_manual_P2.pdf (Chinese Version)

Loongson-3A R2 (Loongson-3A2000)
User Manual Part 1:
http://ftp.godson.ac.cn/lemote/3A2000_p1.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A2000_user1.pdf (Chinese Version)
User Manual Part 2:
http://ftp.godson.ac.cn/lemote/3A2000_p2.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A2000_user2.pdf (Chinese Version)

Loongson-3A R3 (Loongson-3A3000)
User Manual Part 1:
http://ftp.godson.ac.cn/lemote/3A3000_p1.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual1.pdf (Chinese Version)
User Manual Part 2:
http://ftp.godson.ac.cn/lemote/3A3000_p2.pdf
http://ftp.godson.ac.cn/lemote/Loongson3A3000_3B3000usermanual2.pdf (Chinese Version)

Loongson-3A R4 (Loongson-3A4000)
User Manual Part 1:
http://ftp.godson.ac.cn/lemote/3A4000_p1.pdf
http://ftp.godson.ac.cn/lemote/3A4000user.pdf (Chinese Version)
User Manual Part 2:
I'm sorry that it is unavailable now.

And human-translated documents (W.I.P) are available here now:
https://github.com/loongson-community/docs/tree/master/English-translation-of-Loongson-manual

Both KVM and TCG are available now!

We now already have a full functional Linux kernel (based on Linux-5.4.x
LTS) here:

https://github.com/chenhuacai/linux

Of course the upstream kernel is also usable (the kvm host side and
guest side have both been upstream in Linux-5.9):

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

How to use QEMU/Loongson-3?
1, Download kernel source from the above URL;
2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
4, Build QEMU-master with this patchset;
5, modprobe kvm (only necessary for KVM mode);
6, Use QEMU with TCG:
       qemu-system-mips64el -M loongson3-virt,accel=tcg -cpu Loongson-3A1000 -kernel <path_to_kernel> -append ...
   Use QEMU with KVM:
       qemu-system-mips64el -M loongson3-virt,accel=kvm -cpu Loongson-3A4000 -kernel <path_to_kernel> -append ...

   The "-cpu" parameter is optional here and QEMU will use the correct type for TCG/KVM automatically.

V1 -> V2:
1, Add a cover letter;
2, Improve CPU definitions;
3, Remove LS7A-related things (Use GPEX instead);
4, Add a description of how to run QEMU/Loongson-3.

V2 -> V3:
1, Fix all possible checkpatch.pl errors and warnings.

V3 -> V4:
1, Sync code with upstream;
2, Remove merged patches;
3, Fix build failure without CONFIG_KVM;
4, Add Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>.

V4 -> V5:
1, Improve coding style;
2, Remove merged patches;
3, Rename machine name from "loongson3" to "loongson3-virt";
4, Rework the "loongson3-virt" machine to drop any ISA things;
5, Rework "hw/mips: Implement the kvm_type() hook in MachineClass";
6, Add Jiaxun Yang as a reviewer of Loongson-3.

V5 -> V6:
1, Fix license preamble;
2, Improve commit messages;
3, Add hw/intc/loongson_liointc.c to MAINTAINERS;
4, Fix all possible checkpatch.pl errors and warnings.

V7 and V8 have only one patch (machine definition) with some minor improvements.

V8 -> V9:
1, Update KVM type definition from kernel;
2, Fix PageMask with variable page size for TCG;
3, Add TCG support (add Loongson-EXT instructions).

V9 -> V10:
1, Split fw_cfg to a separate patch;
2, Split boot parameters definition to a local header;
3, Update MIPS machine documentation;
4, Many other improvements suggested by Philippe Mathieu-Daudé.

V10 -> V11:
1, Fix some typos;
2, Add Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>.

V11 -> V12:
1, Split boot parameter helpers to loongson3_bootp.c;
2, Support both BE and LE host (Loongson guests are always LE).

V12 -> V13:
1, Sync code with upstream;
2, Re-enable KVM support for MIPS in meson;

V13 -> V14:
1, Remove merged patches;
2, Split boot parameter helpers to a separate patch;
3, Many other improvements suggested by Philippe Mathieu-Daudé.

V14 -> V15:
1, Remove merged patches;
2, Fix malta breakage caused by variable page size;
3, Add unaligned access support for Loongson-3's TCG mode;
4, Many other improvements suggested by Philippe Mathieu-Daudé.

V15 -> V16:
1, Remove some unused code;
2, Add Reviewed-by: Richard Henderson <richard.henderson@linaro.org>.

V16 -> V17:
1, Remove merged patches;
2, Rework Loongson LIOINTC;
3, Fix update_pagemask() for MIPS R6; 
4, Add Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>.

Huacai Chen and Jiaxun Yang (6):
 target/mips: Fix PageMask with variable page size
 hw/intc: Rework Loongson LIOINTC
 hw/mips: Implement fw_cfg_arch_key_name()
 hw/mips: Add Loongson-3 boot parameter helpers
 hw/mips: Add Loongson-3 machine support
 docs/system: Update MIPS machine documentation

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 default-configs/devices/mips64el-softmmu.mak |   1 +
 docs/system/target-mips.rst                  |  10 +
 hw/intc/loongson_liointc.c                   |  49 +--
 hw/mips/Kconfig                              |  12 +
 hw/mips/fw_cfg.c                             |  35 ++
 hw/mips/fw_cfg.h                             |  19 +
 hw/mips/loongson3_bootp.c                    | 165 +++++++
 hw/mips/loongson3_bootp.h                    | 241 +++++++++++
 hw/mips/loongson3_virt.c                     | 614 +++++++++++++++++++++++++++
 hw/mips/meson.build                          |   3 +-
 include/hw/intc/loongson_liointc.h           |  39 ++
 target/mips/cp0_helper.c                     |  27 +-
 target/mips/cpu.h                            |   1 +
 13 files changed, 1174 insertions(+), 42 deletions(-)
 create mode 100644 hw/mips/fw_cfg.c
 create mode 100644 hw/mips/fw_cfg.h
 create mode 100644 hw/mips/loongson3_bootp.c
 create mode 100644 hw/mips/loongson3_bootp.h
 create mode 100644 hw/mips/loongson3_virt.c
 create mode 100644 include/hw/intc/loongson_liointc.h
--
2.7.0

