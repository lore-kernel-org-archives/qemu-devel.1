Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2454C35250
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:59:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BCFF20726
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 12:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AS2dhyHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BCFF20726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Phk-0001y8-LG
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 07:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41302)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgj-0000OB-Nh
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Pgi-0004Wy-G4
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:21 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:40244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Pgi-0004RM-9C
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:20 -0500
Received: by mail-wm1-x32f.google.com with SMTP id t14so5596256wmi.5
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kj0o4rjDF/bDBgTNcCHdm/WE+i3ZIlQjUcoYosDZcmA=;
 b=AS2dhyHbDEusIcv4da/9mZz+a5x0jEgpv1vj9bEj6uH9SLWYbrpcKEEdEZvAd36kGB
 smgA19wJMUv0lBgKdsq0RE3TeDXaBJ0ppmaSrInn+ohUfdiU77lw+hjbTKQidJm4MAp/
 m6gWl0m/DkqXlx35sqCdK9qPWRlqfa7m8cM78chIxm5WpYWSgCZL4Gk9wv9sGimLBO/0
 3bexGyRECAmmkZjUi1n95c9S1psQM4E7BJd8KEqdqrUHeBZWVZh/96y+lRFNWIzJwOmE
 I/wDObULo+dj7er6sh5iVXcvXjcl/dHaPq5Yf7MpISEhCQzttNceioD+fiRGdlKWBTzb
 64Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kj0o4rjDF/bDBgTNcCHdm/WE+i3ZIlQjUcoYosDZcmA=;
 b=Ky6No6drD6H1eQQ37mROMlLwHlG08t/zPHIe9mfuz3nlu4M9iERYLpnO35tFsjrF58
 9asFBd+TbndtDqxMp6dL0iU61a0o1jH2Jhn6sMUQ5LZqWtp1jO/hzx2Q5ZCMbZ7CrjQO
 ergKuTuKFuQUU78FxgHi6ElKB8quwNT1M8oXjxydrPnfTY1ftJTknAWZ335Jfaqp4OIs
 oAUig4LtPrI4XHFVen0TTe5uMwelo/0EGrGxDhFXtSX5XdtP0LcMPBn2eT4hlqhFMSLB
 pPGf4CK9WF+Zqbg0zmI6WLpssnsVs8pUCFNtDknnP4YeYbnI0+V15nINX497xJSEqphv
 8YyQ==
X-Gm-Message-State: APjAAAXo/kvwuhPUZoqkg9wqkDeUtqpyaSVB0jVisszDLA+sChTqZcp5
 ef/VAf2TJKPpSTJlk/VQ/SHpzX149Gp4BA==
X-Google-Smtp-Source: APXvYqy609tz91p7gJ6pBd/vX005aVwRbgBjDMCv/YP4ENf+Dyds8n5/VVhb10u8eDeikIN8l8Kf8g==
X-Received: by 2002:a05:600c:21c6:: with SMTP id
 x6mr4376757wmj.177.1581166698079; 
 Sat, 08 Feb 2020 04:58:18 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 00/20] target/arm: Implement PAN, ATS1E1, UAO
Date: Sat,  8 Feb 2020 12:57:56 +0000
Message-Id: <20200208125816.14954-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Based-on: https://git.linaro.org/people/peter.maydell/qemu-arm.git/log/?h=target-arm.next

Version 4 incorporates the feedback on v3.  In particular:
  * Split out CPSR_J masking to its own patch.
  * Merge trivial braces formatting fixes into patch 5.
  * Drop "Tidy msr_mask" patch, leaving CPSR_USER handling alone.
  * Fixes for EL3 in "Set PAN bit as required on exception entry".

Patches without review:

  0005-target-arm-Split-out-aarch32_cpsr_valid_mask.patch
  0006-target-arm-Mask-CPSR_J-when-Jazelle-is-not-enable.patch
  0009-target-arm-Remove-CPSR_RESERVED.patch
  0014-target-arm-Set-PAN-bit-as-required-on-exception-e.patch


r~


Richard Henderson (20):
  target/arm: Add arm_mmu_idx_is_stage1_of_2
  target/arm: Add mmu_idx for EL1 and EL2 w/ PAN enabled
  target/arm: Add isar_feature tests for PAN + ATS1E1
  target/arm: Move LOR regdefs to file scope
  target/arm: Split out aarch32_cpsr_valid_mask
  target/arm: Mask CPSR_J when Jazelle is not enabled
  target/arm: Replace CPSR_ERET_MASK with aarch32_cpsr_valid_mask
  target/arm: Use aarch32_cpsr_valid_mask in helper_exception_return
  target/arm: Remove CPSR_RESERVED
  target/arm: Introduce aarch64_pstate_valid_mask
  target/arm: Update MSR access for PAN
  target/arm: Update arm_mmu_idx_el for PAN
  target/arm: Enforce PAN semantics in get_S1prot
  target/arm: Set PAN bit as required on exception entry
  target/arm: Implement ATS1E1 system registers
  target/arm: Enable ARMv8.2-ATS1E1 in -cpu max
  target/arm: Add ID_AA64MMFR2_EL1
  target/arm: Update MSR access to UAO
  target/arm: Implement UAO semantics
  target/arm: Enable ARMv8.2-UAO in -cpu max

 target/arm/cpu-param.h     |   2 +-
 target/arm/cpu.h           |  95 ++++++++---
 target/arm/internals.h     |  85 ++++++++++
 target/arm/cpu.c           |   4 +
 target/arm/cpu64.c         |   9 +
 target/arm/helper-a64.c    |   6 +-
 target/arm/helper.c        | 327 +++++++++++++++++++++++++++++--------
 target/arm/kvm64.c         |   2 +
 target/arm/op_helper.c     |  14 +-
 target/arm/translate-a64.c |  31 ++++
 target/arm/translate.c     |  42 +++--
 11 files changed, 499 insertions(+), 118 deletions(-)

-- 
2.20.1


