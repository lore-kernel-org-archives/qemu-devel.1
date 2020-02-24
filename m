Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6B4C38BFF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB552176D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 22:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQ0nbMbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB552176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6MDi-00078s-9j
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 17:28:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7Z-0003yK-EZ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j6M7Y-0005ih-6W
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:37 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:34248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j6M7Y-0005iE-1Z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 17:22:36 -0500
Received: by mail-pf1-x42a.google.com with SMTP id i6so6079073pfc.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 14:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NdhOCLWIrz3fKIXemltzqY1AnfnjgmcetiILUwX+2Hc=;
 b=AQ0nbMbbKnOeXsuYdonsMfDDDPEJjkI38Uzua9Vt26W3gFIcZspa0QnA8fAqDipIpB
 87NkJClQkVnM0wsekdo+cCMIFK+V4+nQuLHMiLLXJ7dOZyhzTviRwjdV0pVjXRirJsr5
 SIpt4EaeZ6Z2o1IUjH8cbk3UiQVnr6sZuT8apcOD8BMVqLA9TqIWuflksMCK0DjNXI8q
 aVsCNsBDU0B8UJ764Zf7m5/FpDca5pmrr2Hsuj0QRnqpMcrlw8BkY5+WxAp0lKMRm3WV
 4babYVtAAUVWX0tmFP/zsYlmsdj3cmf7qy21ifmYPRQOPCu1OMqkOmX9BSx4eGyC6Mn3
 cDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NdhOCLWIrz3fKIXemltzqY1AnfnjgmcetiILUwX+2Hc=;
 b=f2EEFxR7Vt+CEjfcVB5+/a8VSIc7Dq6AALuvpm2G+pnz3tP0inXZlmkx5IzKAMOo4Z
 9b/Lgbj049114Zp3YY42MfMJv01V6SLaUsWQS4S06MprjG59pSDG9vbGnXyxPFenvGyg
 j0UMCGgOxLAL66Nj67fc5K6hr8l/Pcy1o/dSSLWtnE0xvzggoZsRJ20NqjQfmhyLpIUZ
 RvdOF+kAKlKyl2Xs2Z1LzA8Y8rZGPdc9eXB//Xbsb8rjW3Ro4f1bSVqofrSF7drg3wIJ
 4bRkBkFSM+Q325yO1hGDUA8FDL5zBSCKSJflX8cV8dMll7a2tounvMM5mslkRrbfPAEy
 Tt+A==
X-Gm-Message-State: APjAAAXIOAeUf1/LZGNLpHqCBNirWjMA3hFdAszmGfTfaCutpZl3oAsG
 J8LUYY5FyEwU++ABw4zM0fFGgOeqWcw=
X-Google-Smtp-Source: APXvYqzDdMCbzbXGMlzHprNKacJERGBQvsx5nYlMY2km95VUtQlvMIoLqQsClsTCPcGTqJHCA8j38g==
X-Received: by 2002:a62:5bc3:: with SMTP id
 p186mr31464637pfb.162.1582582954575; 
 Mon, 24 Feb 2020 14:22:34 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id o6sm13897097pgg.37.2020.02.24.14.22.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2020 14:22:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/17] target/arm: vfp feature and decodetree cleanup
Date: Mon, 24 Feb 2020 14:22:15 -0800
Message-Id: <20200224222232.13807-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42a
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The main goal of the patchset is to move the ARM_FEATURE_VFP test from
outside of the disas_vfp_insn() to inside each of the trans_* functions,
so that we get the proper ISA check for each case.  At the end of that,
it is easy to eliminate all of the remaining tests vs ARM_FEATURE_VFP*
in favor of the preferred ISAR tests.  Finally, there are a couple of
cleanups to vfp.decode to make things a bit more legible.

Changes for v2:
  * Replace aa32_simd_r16 by aa32_vfp_simd.
  * Add aa64_fp_simd, aa32_vfp.
  * Improve aa64 has_vfp/has_neon check.
  * Fix some "any" tests.


r~


Richard Henderson (17):
  target/arm: Add isar_feature_aa32_vfp_simd
  target/arm: Rename isar_feature_aa32_fpdp_v2
  target/arm: Add isar_feature_aa32_{fpsp_v2,fpsp_v3,fpdp_v3}
  target/arm: Add isar_feature_aa64_fp_simd, isar_feature_aa32_vfp
  target/arm: Improve ID_AA64PFR0 FP/SIMD validation
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

 target/arm/cpu.h               |  57 ++++-
 target/arm/vfp-uncond.decode   |  12 +-
 target/arm/vfp.decode          | 153 +++++------
 hw/intc/armv7m_nvic.c          |  20 +-
 linux-user/arm/signal.c        |   4 +-
 linux-user/elfload.c           |  23 +-
 target/arm/arch_dump.c         |  11 +-
 target/arm/cpu.c               |  67 ++---
 target/arm/cpu64.c             |   3 -
 target/arm/helper.c            |   4 +-
 target/arm/kvm32.c             |   5 -
 target/arm/kvm64.c             |   1 -
 target/arm/m_helper.c          |  11 +-
 target/arm/machine.c           |   5 +-
 target/arm/translate-vfp.inc.c | 448 ++++++++++++++++++++-------------
 target/arm/translate.c         | 122 +++------
 16 files changed, 498 insertions(+), 448 deletions(-)

-- 
2.20.1


