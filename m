Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99716C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 02:39:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 658072068D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 02:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCJs6u7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 658072068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfwpm-0005bt-Kj
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 22:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jfwot-0004mO-Vy
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 22:38:32 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:41379)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jfwos-0005KJ-MB
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 22:38:27 -0400
Received: by mail-pf1-x443.google.com with SMTP id 64so4346991pfg.8
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 19:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=aGgFDTFQPYvKqjEcC1kdvs9lciiYvG5xsZOnEhZpU3c=;
 b=UCJs6u7ZPVgOzplRWTWt1LOrOedQUikIcFqeDcUPf6zjskKBAhrne/A8B5SFV/44TZ
 D76iW3FmzzNsUZejfkm/Jh7hil77hojPG4D61nkfNer/ERXzcxxzAT4NPpA/rUGuzsfY
 nDldItJT6hNp7uCzNcgX1ZnEYDViCBCdOfqlmw/WP9gm5PZjeuXl87D0lqnGlm/LVu5q
 ArCPeiXAfbRkYRBL+ipcNOJ4nfuylrDLXM7XAorJjc+VtgCPYxPloR89rN46RHaOIYkw
 XtMRB7Y8JcMwseIGP8i3aZF5oANKxKsE4YbIK+ngbBmSF89WUxaxpnGeZe05aCRrMxPA
 X0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=aGgFDTFQPYvKqjEcC1kdvs9lciiYvG5xsZOnEhZpU3c=;
 b=NNhj9eJVEJLLNiXnOYSZOhORTAVfcUb47XH6gbfM2mhyCSRkk6nKfogVwwqOhQwfrG
 MnwYb5A2nKJvE+yKCX5ZUjVOCvVI0Joo4AysitDPfI0PaVl4fUdCsPUXNKZtaxsawQsg
 5JGZD1PYxSkQrN3d7/1qlPIFEXlvNgKsy5sH7t9jlQal1mR3vCFAk/baNeR+iP4z1jYF
 oi6kMDmye3jHzOMA+kEbuGhu7kvkMUeCCrtUBAZLgl6qQzuxoa0BG/YGOX9bCJAuzAi6
 j6yYUbBcIzxCsUCl+Jtb9+knrXqEognlxagem15UyAcgJgAfHpdovT3qaJHZ/FzGbdt7
 kJgg==
X-Gm-Message-State: AOAM531HmCMbBlc51cXjO8k7+c7RzOv5WIsY7SdiZQjG2fZWcypF/NTw
 4bZ6GRl9xM6P1JsQtRsxefM=
X-Google-Smtp-Source: ABdhPJxNmBS19L7QX+dHVUPyjJBBIjb/nzSHsmDN0CFTZQ+vJhDLTudtyZkvcdeR9xXt3WcsB2zpUg==
X-Received: by 2002:a63:ad43:: with SMTP id y3mr21332620pgo.435.1591065504851; 
 Mon, 01 Jun 2020 19:38:24 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id j186sm630761pfb.220.2020.06.01.19.38.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 01 Jun 2020 19:38:24 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V4 0/7] mips: Add Loongson-3 machine support (with KVM)
Date: Tue,  2 Jun 2020 10:39:13 +0800
Message-Id: <1591065557-9174-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>, qemu-devel@nongnu.org,
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

We are preparing to add QEMU's Loongson-3 support. MIPS VZ extension is
fully supported in Loongson-3A R4+, so we at first add QEMU/KVM support
in this series. And the next series will add QEMU/TCG support (it will
emulate Loongson-3A R1).

We already have a full functional Linux kernel (based on Linux-5.4.x LTS
but not upstream yet) here:

https://github.com/chenhuacai/linux

How to use QEMU/Loongson-3?
1, Download kernel source from the above URL;
2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
3, Boot a Loongson-3A4000 host with this kernel;
4, Build QEMU-5.0.0 with this patchset;
5, modprobe kvm;
6, Use QEMU with TCG (available in future):
       qemu-system-mips64el -M loongson3,accel=tcg -cpu Loongson-3A1000 -kernel <path_to_kernel> -append ... 
   Use QEMU with KVM (available at present): 
       qemu-system-mips64el -M loongson3,accel=kvm -cpu Loongson-3A4000 -kernel <path_to_kernel> -append ... 

   The "-cpu" parameter can be omitted here and QEMU will use the correct type for TCG/KVM automatically.

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

Huacai Chen(4):
 hw/mips: Implement the kvm_type() hook in MachineClass
 target/mips: Add Loongson-3 CPU definition
 hw/mips: Add Loongson-3 machine support (with KVM)
 MAINTAINERS: Add myself as Loongson-3 maintainer

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 MAINTAINERS                          |   5 +
 default-configs/mips64el-softmmu.mak |   1 +
 hw/core/Makefile.objs                |   2 +-
 hw/core/null-machine.c               |   4 +
 hw/mips/Kconfig                      |  10 +
 hw/mips/Makefile.objs                |   3 +-
 hw/mips/common.c                     |  42 ++
 hw/mips/loongson3.c                  | 901 +++++++++++++++++++++++++++++++++++
 include/hw/mips/mips.h               |   3 +
 target/mips/cpu.h                    |  28 ++
 target/mips/internal.h               |   2 +
 target/mips/mips-defs.h              |   7 +-
 target/mips/translate.c              |   2 +
 target/mips/translate_init.inc.c     |  86 ++++
 14 files changed, 1092 insertions(+), 4 deletions(-)
 create mode 100644 hw/mips/common.c
 create mode 100644 hw/mips/loongson3.c
--
2.7.0

