Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C400DC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D030222C2
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 18:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ib8JzQet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D030222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2fWR-0005u1-Ms
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 13:17:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVI-0004Dd-2f
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j2fVG-0008U7-TX
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:51 -0500
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e]:36910)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j2fVG-0008TZ-MN
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 13:15:50 -0500
Received: by mail-pg1-x52e.google.com with SMTP id z12so5353403pgl.4
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2020 10:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ru+6cKgRUaTCm+8Sv6aB+qI5kicAcCfM8654wxUWirY=;
 b=Ib8JzQet9Sa+/d5x5B7sSCFywP5FuIgkslBxfD+XWR+toOjknuBj3Iu7ZRFP+y2tNM
 g+J2dX99P5+sj+cCjZdC6Sfn6dujEuG6DvXptYNp0fun70G43Qygaz0bTXR86C29kZtc
 vLiigrM5XyWnVsqrpF+m79Dzu1tTmdgeEzaP1TvcpXs3rNHtZVZg0H6uVIaFSX42uYPL
 +DgwBDZBscdm/jjAgXlVvvgSiUe2zGYN+2fSkCSANzCov1/yFoOrcj5rPyqkOMkxX0/+
 JkwNVbl/Nx1fWfxcd/8ExPyIm7keWrYaMtRRj60BuHnmzCoQ1FqYbc4asAxb+NA1I4Oz
 LSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ru+6cKgRUaTCm+8Sv6aB+qI5kicAcCfM8654wxUWirY=;
 b=kweHFQRJ2RGDQGgjs91dcuxw5Hir2vpsGytwONSpXhdVpccoyDx7OwC2Bnnia2KPkH
 2StwMtjVIb0JNHIUKMvfJgxNGI/dIYq8IC5M4VG29c1N4oVWsoWh6PBCt0WDiFI9OzKi
 1tOkub9fff0eiL619Oaecz4tvYGSA6bxlL2gll1TAGWYYjcckvBmJRPPO7SuqGgrBS51
 UDPIhGqrgiNh72q8Hh31x7G4fl0SKgchRJnMkw/7RCUWVuKiRO9R3TlyJ76BktPnnuc2
 mzvaG9THY7K+gu8bKW3f+YJdSnRmTyPhlcfajsHUoEvPtNDP7fx73Qv+KBXxnSDwKKF0
 LhRw==
X-Gm-Message-State: APjAAAUemXtwifsB+pCkMmZIpiO/X0+r3C6JPIhCcYUad4Qdo+dRTu2Q
 1y97nPuCg4wCHqTne8osR7fm/lochXA=
X-Google-Smtp-Source: APXvYqxzEQ/tQzh/bPq9FfZLMlX0Hbax8N7CRDrSAq36uOxCGoFprYLTLFVf9Mi5SzSwRyIMU/nhtg==
X-Received: by 2002:a62:fb06:: with SMTP id x6mr4544602pfm.149.1581704148688; 
 Fri, 14 Feb 2020 10:15:48 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id i3sm7525123pfg.94.2020.02.14.10.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2020 10:15:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/19] target/arm: vfp feature and decodetree cleanup
Date: Fri, 14 Feb 2020 10:15:28 -0800
Message-Id: <20200214181547.21408-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52e
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The main goal of the patchset is to move the ARM_FEATURE_VFP
test from outside of the disas_vfp_insn() to inside each of
the trans_* functions, so that we get the proper ISA check
for each case.

At the end of that, it is easy to eliminate all of the remaining
tests vs ARM_FEATURE_VFP* in favor of the preferred ISAR tests.

Finally, there are a couple of cleanups to vfp.decode to make
things a bit more legible.


r~


Richard Henderson (19):
  target/arm: Fix field extract from MVFR[0-2]
  target/arm: Rename isar_feature_aa32_simd_r32
  target/arm: Use isar_feature_aa32_simd_r32 more places
  target/arm: Set MVFR0.FPSP for ARMv5 cpus
  target/arm: Add isar_feature_aa32_simd_r16
  target/arm: Rename isar_feature_aa32_fpdp_v2
  target/arm: Add isar_feature_aa32_{fpsp_v2,fpsp_v3,fpdp_v3}
  target/arm: Perform fpdp_v2 check first
  target/arm: Replace ARM_FEATURE_VFP3 checks with fp{sp,dp}_v3
  target/arm: Add missing checks for fpsp_v2
  target/arm: Replace ARM_FEATURE_VFP4 with isar_feature_aa32_simdfmac
  target/arm: Remove ARM_FEATURE_VFP check from disas_vfp_insn
  target/arm: Move VLLDM and VLSTM to vfp.decode
  target/arm: Move the vfp decodetree calls next to the base isa
  linux-user/arm: Replace ARM_FEATURE_VFP* tests for HWCAP
  target/arm: Remove ARM_FEATURE_VFP*
  target/arm: Add formats for some vfp 2 and 3-register insns
  target/arm: Split VFM decode
  target/arm: Split VMINMAXNM decode

 target/arm/cpu.h               |  56 ++--
 target/arm/vfp-uncond.decode   |  12 +-
 target/arm/vfp.decode          | 153 +++++------
 hw/intc/armv7m_nvic.c          |  20 +-
 linux-user/arm/signal.c        |   4 +-
 linux-user/elfload.c           |  24 +-
 target/arm/arch_dump.c         |  11 +-
 target/arm/cpu.c               |  50 +---
 target/arm/cpu64.c             |   3 -
 target/arm/helper.c            |  17 +-
 target/arm/kvm32.c             |   5 -
 target/arm/kvm64.c             |   1 -
 target/arm/m_helper.c          |  11 +-
 target/arm/machine.c           |   3 +-
 target/arm/translate-vfp.inc.c | 467 ++++++++++++++++++++-------------
 target/arm/translate.c         | 121 ++-------
 16 files changed, 479 insertions(+), 479 deletions(-)

-- 
2.20.1


