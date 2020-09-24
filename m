Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D0FC4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ABC62376F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrtGzUpw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ABC62376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLph-0007Qz-FV
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kLLnk-0004ud-JU
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:36:24 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36601)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kLLni-0000xC-FD
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 03:36:24 -0400
Received: by mail-pj1-x1042.google.com with SMTP id b17so1161058pji.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 00:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NdM00oKj6v1iUHina4J++nhhFOPrVkOktvMB8oCBsgA=;
 b=TrtGzUpwXTSyLVtGiFPO8KJXb7ACqnsvJfOlFCDo58QwBfVERoGetaEKb3W/JEU98i
 FaFjss8LEKTY50y6mRqRqxZJ79wN3Nuq+6H59wdzTn2O/nD1GbphHyrrTMMn83iXX4eO
 5xcfecRfXPHomoL06zOx7Som+4nqou0xviSeXTzRGGLWr7q8nDWJlzY2HJipnkbVlwBa
 60GFEFrFUPKGYzdKV7iC1tG/OL1qK23tLZvPIbWqvxGKMzlh/HWnOA5vhXHksUpaJQ22
 3XVCcj4xv20w+EBirSXYCffw8LiKd/6ExyJLnLFIbPtUw5sNeIWpJzqrRx07royV0jlA
 TIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NdM00oKj6v1iUHina4J++nhhFOPrVkOktvMB8oCBsgA=;
 b=lZS0kJinBWFdlXA0XzC9ErGjXSFYlCRMv7WusLHFfe1OiQgz/jtscNgdLI8/Bw8Hwy
 tYLpMFoYkfFO/x+JsVTny7v5v5mgaDbZAl+2qQl4TmHnWB4HwupKmNLSacHX6OfNnRm1
 DHZ+jx0ZJnWr7iaJupM3rpxZHoQuaum53guZR/9vL+Llyr6bqx5feQU0yoAeh3jbWh1G
 kdL1+8mNArpON4OepzRyadD/GYgfGljPAU9UY1iFIxKdIeGQV1O/y/4pOSdFYtOx8qMh
 JoUE+SLrkzVRs3AwniLRwSmaopLC5PPwKOqSTFKGeuB+RDc0Y2TEVNKUkrtfcLMmm1UX
 ApUQ==
X-Gm-Message-State: AOAM533YhlHr1UF7Xbf/Tk3UNALCcdYb2jkfm3iOVDqczjSLwrSr8vUD
 QrceArtOvtKgDb8TQMUcQ6U=
X-Google-Smtp-Source: ABdhPJzCsEaMrfisL9Lo/Tso2+fbMCBIbhyYuCbUwXURX1WrvTHggbTJIEy75Vjd97z7ZOjIbrEzNQ==
X-Received: by 2002:a17:90a:9f8e:: with SMTP id
 o14mr2793636pjp.103.1600932980455; 
 Thu, 24 Sep 2020 00:36:20 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id x13sm1777864pfj.199.2020.09.24.00.36.16
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Sep 2020 00:36:19 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V11 0/8] mips: Add Loongson-3 machine support
Date: Thu, 24 Sep 2020 15:35:48 +0800
Message-Id: <1600932956-11642-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pj1-x1042.google.com
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
LTS, the kvm host side and guest side have both been upstream for Linux-
5.9, but Linux-5.9 has not been released yet) here:

https://github.com/chenhuacai/linux

Of course the upstream kernel is also usable (though it is "unstable"
now):

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

Huacai Chen and Jiaxun Yang (8):
 linux-headers: Update MIPS KVM type defintition
 target/mips: Fix PageMask with variable page size
 target/mips: Add loongson-ext lswc2 group of instructions (Part 1)
 target/mips: Add loongson-ext lswc2 group of instructions (Part 2)
 target/mips: Add loongson-ext lsdc2 group of instructions
 hw/mips: Implement fw_cfg_arch_key_name()
 hw/mips: Add Loongson-3 machine support
 docs/system: Update MIPS machine documentation

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 default-configs/mips64el-softmmu.mak |   1 +
 docs/system/cpu-models-mips.rst.inc  |  10 +-
 docs/system/target-mips.rst          |  10 +
 hw/mips/Kconfig                      |  11 +
 hw/mips/fw_cfg.c                     |  35 ++
 hw/mips/fw_cfg.h                     |  19 +
 hw/mips/loongson3_virt.c             | 775 +++++++++++++++++++++++++++++++++++
 hw/mips/loongson_bootp.h             | 187 +++++++++
 hw/mips/meson.build                  |   3 +-
 linux-headers/linux/kvm.h            |   5 +-
 target/mips/cp0_helper.c             |  36 +-
 target/mips/cpu.h                    |   1 +
 target/mips/translate.c              | 443 ++++++++++++++++++++
 13 files changed, 1524 insertions(+), 12 deletions(-)
 create mode 100644 hw/mips/fw_cfg.c
 create mode 100644 hw/mips/fw_cfg.h
 create mode 100644 hw/mips/loongson3_virt.c
 create mode 100644 hw/mips/loongson_bootp.h
--
2.7.0

