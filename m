Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4CDC8300A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E973820787
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 10:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XpIXhx4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E973820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU6Mj-0006yR-3G
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 06:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jU6L6-0004QT-5O
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <zltjiangshi@gmail.com>) id 1jU6L4-0004Se-D7
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:22:43 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zltjiangshi@gmail.com>)
 id 1jU6L3-0004KA-Vd
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 06:22:42 -0400
Received: by mail-pg1-x542.google.com with SMTP id x26so2538029pgc.10
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 03:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ycV03Qb2e/TJ4HXNBuZlVu4R7xxQNf7srsAUMZ0wHq8=;
 b=XpIXhx4mPxU5+1qJMS/MVh0/f/M4jKEk4LZRQ3JG3xNDraH+HqnwGiR1hwtv3EnpZw
 4zjZs544+0QWx/O3UHd9JVmNAs0Db/bq5TToGlW+cLlcnepj1uJw/e7nmhvmpB/z2SvC
 NyYqqzPkIeqO36Pv7mOIZdeKyCqYDVsGGWD67/7F5xtOdLann+Z7QzxSWDGxUTAYX/Dq
 0GoiAFPJOw+rmdd4VC4kA2juAuRF25PwMS2q6sCIuPbf9ges+ACp2Hm9cJwKE9R3zDYC
 JnYhbxW7bOLsm4lYilm3Yq8LY/Mo+nWwVP+HrdV4YY/rX6SchHVbYQ3//nUhmEh0KYeB
 ClkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ycV03Qb2e/TJ4HXNBuZlVu4R7xxQNf7srsAUMZ0wHq8=;
 b=KIQ5w2kdOpb9zNoHkDlrTJH9/Ef/KA19rkTuHh3oolXlae1H4WQAnSscaYz5ESABig
 J8jQu4KiihgNzgv0AGaCwraypIWzPYBrM5akjfJY0pNBIe2AIq+/LeXG3cvgRYViLsLn
 F+NBZq+E9cVVk7gd2Djk5VQ/Sd9RvrTK7uyZ2f79ElN8a0raPeiNJDXQL6v4BYDjLkfl
 5O8YXr11tn3a9esSFQ6xEZ5dO33tj8z4Z71Yh3n227wa9V6/mc4cqoH8fOSEkwiiPp6A
 lmgZMRWmkPGlzdry5m62POopgtJ34AQ0QbtozXAMLcstg2wiaL4rQc3OkLVfgsWlBaOL
 BPvQ==
X-Gm-Message-State: AGi0PubY8rOC1Pn2VxpfihqQ0+oZ1CU/qZAd92+ExGFNHErJJMv1vbsa
 CLNLBEaM7qR/anYWo73rnQg=
X-Google-Smtp-Source: APiQypIbIawzw27CxRXIxX9jCHF/aaOIs7jZeeJ8/SaHQRFV4fA7JZHcNC9M6fw4dO2zh1N4r4T4NA==
X-Received: by 2002:a63:af51:: with SMTP id s17mr2743031pgo.305.1588242159646; 
 Thu, 30 Apr 2020 03:22:39 -0700 (PDT)
Received: from software.domain.org (28.144.92.34.bc.googleusercontent.com.
 [34.92.144.28])
 by smtp.gmail.com with ESMTPSA id a15sm1397872pju.3.2020.04.30.03.22.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 30 Apr 2020 03:22:38 -0700 (PDT)
From: Huacai Chen <zltjiangshi@gmail.com>
X-Google-Original-From: Huacai Chen <chenhc@lemote.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH for-5.1 V2 0/7] mips: Add Loongson-3 machine support (with KVM)
Date: Thu, 30 Apr 2020 18:22:28 +0800
Message-Id: <1588242155-23924-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=zltjiangshi@gmail.com; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::542
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

Huacai Chen(7):
 configure: Add KVM target support for MIPS64
 hw/mips: Implement the kvm_type() hook in MachineClass
 hw/mips: Add CPU IRQ3 delivery for KVM
 target/mips: Add Loongson-3 CPU definition
 target/mips: Add more CP0 register for save/restor
 hw/mips: Add Loongson-3 machine support (with KVM)
 MAINTAINERS: Add myself as Loongson-3 maintainer

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 MAINTAINERS                          |   5 +
 configure                            |   2 +-
 default-configs/mips64el-softmmu.mak |   1 +
 hw/core/Makefile.objs                |   2 +-
 hw/core/null-machine.c               |   4 +
 hw/mips/Kconfig                      |  10 +
 hw/mips/Makefile.objs                |   3 +-
 hw/mips/common.c                     |  29 ++
 hw/mips/mips_int.c                   |   6 +-
 hw/mips/mips_loongson3.c             | 886 +++++++++++++++++++++++++++++++++++
 include/hw/mips/mips.h               |   3 +
 target/mips/cpu.h                    |  28 ++
 target/mips/internal.h               |   2 +
 target/mips/kvm.c                    | 212 +++++++++
 target/mips/machine.c                |   6 +-
 target/mips/mips-defs.h              |   7 +-
 target/mips/translate.c              |   2 +
 target/mips/translate_init.inc.c     |  84 ++++
 18 files changed, 1281 insertions(+), 11 deletions(-)
 create mode 100644 hw/mips/common.c
 create mode 100644 hw/mips/mips_loongson3.c
--
2.7.0

