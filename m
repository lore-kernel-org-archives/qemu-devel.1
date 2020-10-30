Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB35C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CB3C20704
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZoDvCZO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CB3C20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYReb-0001vS-4U
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYRaW-0006Fr-Ld
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:24:53 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39472)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1kYRaR-0000Tx-Rn
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:24:52 -0400
Received: by mail-pf1-x443.google.com with SMTP id e15so4866466pfh.6
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IpA7w7W0dgZhtPLeP2kSj4B3/HrQPEptcjVS5YAz1VU=;
 b=gZoDvCZO7G+GDy4OZSI20sGHKgJWZ//VFvMyaC3Jm1EXlF1LHuIukenVnBMG0PDu0P
 19Ac4S6FIqoi4eC9v38eCyVV/Jr7tZFhgQo7EEkoORCrEfk3VNECrRhsTZCdXPak6b7n
 D7GupkwxYgmaGFh5pXsXrGemcBAu/fQPVm9+iUxu57VOh4it6NO62gvCL3EVcMvHcOCr
 oJu0qfaqmh6NnyXCOy0cPKobfDF6AWGR5Yp9rX9yyiOrvZ4X4IoWB9BUlpBuIhcJCwfb
 kcFEiCRXIhn0qUJtNC0fPeEJTYMlmsAmXNf3fQ51NGlXdRACARsQfJUaN+DrlIQepnfr
 aoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=IpA7w7W0dgZhtPLeP2kSj4B3/HrQPEptcjVS5YAz1VU=;
 b=EJq1PJGvAdpw0Fa92gQb31vnee1FZwaKWbPjtzwlLfyulrivBohAKvQE4KIIa13DeN
 UEUw/jy1oGgYshixb1xfMhU8YlaP6fbBondLuwpsgmnrH67MoX31jiSBk/Pg2/g/VvA5
 yho4CKuWYP3yGcszJ1rfSnPF8XkEju0FvtZE6Pp8Lo3OQXb72qwrtgYHUchvDnZ3Pmvo
 rs2DtysW7BUC6fVHIs2POZGHSpPJxigNLY2q3SHYBRF6bX4LyaUdrOUWZD+2/Jlr31kt
 G/bifkSsNILNvr95KftS/ISKc1MtxiWnd0CP8MEknE5e4pjSbZHVItcpSld6JuNtkHsK
 vEqw==
X-Gm-Message-State: AOAM531HYrR/md/b/+2bPaFQZCRyqN15x3ifu81Bf0pL+OnwClu9cl+U
 Fw58GJbFzIeUtEJpMKfoyqY=
X-Google-Smtp-Source: ABdhPJyvt2SLCauKuyuhoFQuyeAJfZ7DwtlRjqfVUoCnEBjiD3ajt3Wa1LqeV1FQPJMtJG2OMdEvhQ==
X-Received: by 2002:a17:90a:7006:: with SMTP id
 f6mr1977818pjk.97.1604053486174; 
 Fri, 30 Oct 2020 03:24:46 -0700 (PDT)
Received: from software.domain.org ([45.77.13.216])
 by smtp.gmail.com with ESMTPSA id v79sm6062146pfc.197.2020.10.30.03.24.42
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Oct 2020 03:24:45 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH V16 0/6] mips: Add Loongson-3 machine support
Date: Fri, 30 Oct 2020 18:25:35 +0800
Message-Id: <1604053541-27822-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x443.google.com
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
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
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

Huacai Chen and Jiaxun Yang (8):
 target/mips: Fix PageMask with variable page size
 target/mips: Add unaligned access support for MIPS64R6 and Loongson-3
 hw/mips: Implement fw_cfg_arch_key_name()
 hw/mips: Add Loongson-3 boot parameter helpers
 hw/mips: Add Loongson-3 machine support
 docs/system: Update MIPS machine documentation

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 default-configs/devices/mips64el-softmmu.mak |   1 +
 docs/system/target-mips.rst                  |  10 +
 hw/mips/Kconfig                              |  12 +
 hw/mips/fw_cfg.c                             |  35 ++
 hw/mips/fw_cfg.h                             |  19 +
 hw/mips/loongson3_bootp.c                    | 165 +++++++
 hw/mips/loongson3_bootp.h                    | 241 +++++++++++
 hw/mips/loongson3_virt.c                     | 614 +++++++++++++++++++++++++++
 hw/mips/meson.build                          |   3 +-
 target/mips/cp0_helper.c                     |  34 +-
 target/mips/cpu.h                            |   1 +
 target/mips/translate.c                      |   4 +-
 12 files changed, 1130 insertions(+), 9 deletions(-)
 create mode 100644 hw/mips/fw_cfg.c
 create mode 100644 hw/mips/fw_cfg.h
 create mode 100644 hw/mips/loongson3_bootp.c
 create mode 100644 hw/mips/loongson3_bootp.h
 create mode 100644 hw/mips/loongson3_virt.c
--
2.7.0

