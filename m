Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A890C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF8122073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 18:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2cx9Glj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF8122073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUDgK-0004fJ-T3
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 14:13:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdp-0001Ni-Ip
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:11:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jUDdR-00009z-IR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:33 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jUDdQ-00008v-V5
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 14:10:09 -0400
Received: by mail-wr1-x42c.google.com with SMTP id j2so8179325wrs.9
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2020 11:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QSCkMIU3/qtFoswudN1xA9osD+mc7a0ztbpDr62YSng=;
 b=P2cx9GljKb7WlY7v2GyZq5xONoPFQ+DkCJFsmKiptJtgHjPaGg2lp2HdcahwjrHP0m
 wpn/0TYgF3eCiXJ/akUBHp5kqRp/IACA+ITpL/is9pRDPN5If0sILNhw9+YOur2Q2oBb
 kOWAYADpV7DIWB6WNZjuOJfQtZ69S4/N8Vz/FJgiaW7l0wrVLyYt1H5rJGwFN089kyUm
 uFp2vAJFN3XDwqH7XpU5cCaXLTwr2XZ9To1HfSfnWbNJ1LRhku2ouX5/15B+ix48JhZe
 KS4EkSU4pbBv91PKCuptoxSs5o01TRjZIrX3il2Ad4veHGdTU2j7Fj7rlOJniAJCD0dk
 ClZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=QSCkMIU3/qtFoswudN1xA9osD+mc7a0ztbpDr62YSng=;
 b=ALa5Uj3RA+6QmaIBWeTIkgYY/njl0WIfF3/8G+Z1ImP0x5sc93MGKPPfwrhvpwVIzv
 A4O2i8WOEOz2olhoVHzr0bSTPjvYDyavvKf9lhoXXNop+rxJ2Dk7SoirCa6yfcPObDgl
 tKRMgqy3Dixbj6BSSBUPWstGWuE2UtpJtNgvYbHoVJkswsEjCcRPcjJiZ6lqK6KeYTE1
 3dc9hVdeTD/sRUpWiq33pEb1J7zT9jCJHerRVZ9jeYxSBu+NlNk56HU2zN57gMmIa0/5
 9+GpvuCVl2SneauqFTU46hFYN8Nyox8UY4T9UOjUQd3Phb7i6JZ0KaXvujuCfnTyJ+px
 r5qA==
X-Gm-Message-State: AGi0PubX2TNBuLYRbsJFDbKQf09E4XF2dE7xd7APGUY60Z+0ZZGAd9Ss
 bMRWxXu/4UZMLcm01s3L1n5PaQ==
X-Google-Smtp-Source: APiQypJy5RxuoGbo3qB1jH3NyFXa8fz3LZvwwG0KSCdFRrbSA9vDZKgjGPyQh5AaxsZJcjuaLFUJTg==
X-Received: by 2002:a5d:61c5:: with SMTP id q5mr5384700wrv.260.1588270206625; 
 Thu, 30 Apr 2020 11:10:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t8sm652421wrq.88.2020.04.30.11.10.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2020 11:10:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/36] target/arm: Convert Neon to decodetree (part 1)
Date: Thu, 30 Apr 2020 19:09:27 +0100
Message-Id: <20200430181003.21682-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchseries starts in on the job of converting the Arm
Neon decoder to decodetree.

Neon insns come in three major parts:
 * the 'v8.0-and-later' extensions
 * the 'loads and stores' group
 * the 'data processing' group

This patchset converts all of the v8.0-and-later extensions
and the loads-and-stores, plus the "3-registers-same" subgroup
of the data-processing insns.

I'm working on the rest of the dp insns, but this seems like
a pretty large chunk of conversion patches to start with.

thanks
-- PMM

Peter Maydell (36):
  target/arm/translate-vfp.inc.c: Remove duplicate simd_r32 check
  target/arm: Don't allow Thumb Neon insns without FEATURE_NEON
  target/arm: Add stubs for AArch32 Neon decodetree
  target/arm: Convert VCMLA (vector) to decodetree
  target/arm: Convert VCADD (vector) to decodetree
  target/arm: Convert V[US]DOT (vector) to decodetree
  target/arm: Convert VFM[AS]L (vector) to decodetree
  target/arm: Convert VCMLA (scalar) to decodetree
  target/arm: Convert V[US]DOT (scalar) to decodetree
  target/arm: Convert VFM[AS]L (scalar) to decodetree
  target/arm: Convert Neon load/store multiple structures to decodetree
  target/arm: Convert Neon 'load single structure to all lanes' to
    decodetree
  target/arm: Convert Neon 'load/store single structure' to decodetree
  target/arm: Convert Neon 3-reg-same VADD/VSUB to decodetree
  target/arm: Convert Neon 3-reg-same logic ops to decodetree
  target/arm: Convert Neon 3-reg-same VMAX/VMIN to decodetree
  target/arm: Convert Neon 3-reg-same comparisons to decodetree
  target/arm: Convert Neon 3-reg-same VQADD/VQSUB to decodetree
  target/arm: Convert Neon 3-reg-same VMUL, VMLA, VMLS, VSHL to
    decodetree
  target/arm: Convert Neon 3-reg-same VQRDMLAH/VQRDMLSH to decodetree
  target/arm: Convert Neon 3-reg-same SHA to decodetree
  target/arm: Move gen_ function typedefs to translate.h
  target/arm: Convert Neon 64-bit element 3-reg-same insns
  target/arm: Convert Neon VHADD 3-reg-same insns
  target/arm: Convert Neon VRHADD, VHSUB, VABD 3-reg-same insns to
    decodetree
  target/arm: Convert Neon VQSHL, VRSHL, VQRSHL 3-reg-same insns to
    decodetree
  target/arm: Convert Neon VABA 3-reg-same to decodetree
  target/arm: Convert Neon VPMAX/VPMIN 3-reg-same insns to decodetree
  target/arm: Convert Neon VPADD 3-reg-same insns to decodetree
  target/arm: Convert Neon VQDMULH/VQRDMULH 3-reg-same to decodetree
  target/arm: Convert Neon VADD, VSUB, VABD 3-reg-same insns to
    decodetree
  target/arm: Convert Neon VPMIN/VPMAX/VPADD float 3-reg-same insns to
    decodetree
  target/arm: Convert Neon fp VMUL, VMLA, VMLS 3-reg-same insns to
    decodetree
  target/arm: Convert Neon 3-reg-same compare insns to decodetree
  target/arm: Convert Neon fp VMAX/VMIN/VMAXNM/VMINNM/VRECPS/VRSQRTS to
    decodetree
  target/arm: Convert NEON VFMA, VFMS 3-reg-same insns to decodetree

 target/arm/Makefile.objs        |   18 +
 target/arm/translate-a64.h      |    9 -
 target/arm/translate.h          |   26 +
 target/arm/translate-a64.c      |   17 -
 target/arm/translate-neon.inc.c | 1577 +++++++++++++++++++++++++++++++
 target/arm/translate-vfp.inc.c  |    6 -
 target/arm/translate.c          | 1200 +----------------------
 target/arm/neon-dp.decode       |  186 ++++
 target/arm/neon-ls.decode       |   52 +
 target/arm/neon-shared.decode   |   66 ++
 10 files changed, 1967 insertions(+), 1190 deletions(-)
 create mode 100644 target/arm/translate-neon.inc.c
 create mode 100644 target/arm/neon-dp.decode
 create mode 100644 target/arm/neon-ls.decode
 create mode 100644 target/arm/neon-shared.decode

-- 
2.20.1


