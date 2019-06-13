Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F923C31E4A
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40E95208CA
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T4cjloOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40E95208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41082 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRvh-0001Af-Nf
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36719)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbQWw-0002kS-NG
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbQWu-0003ST-3N
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:16:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432]:33136)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbQWr-0003EC-VB
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:16:38 -0400
Received: by mail-wr1-x432.google.com with SMTP id n9so21031311wru.0
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 07:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xb17Uz1c02HfYhndfX/Q4/m1ExnHU7WnIrWym5GJ2wU=;
 b=T4cjloOtMATvHDBh3GvKv4mZNeyVjqqoyG+0v/gsAs1pLa2rzAoe4cxELECh2xvUaN
 cAUusKmvLkuEpP0EaPGOyUtPO4oPQIzmcqOonChSD+AuZOA4T8vBOeiEOGCmwPhm/VI9
 R9mw6PdtFP5hvi8akd5qgPE5lpnkHkq9YAPkr086iyNMzsNe7VzUYDVPSQRuiUiqZERx
 /PNCNw9wi+Gidm8E3/m79YY6P/dGegTPqkctSFq+fjUTHjFXoyHU3GhVRWvMNacoIjCB
 1CtHuuNyOl42DJEO322aKDYYQ7qE4sxbmsqtKHi8sCJyBENDqbLE4cbvoxnFdiUdx2bk
 EVyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Xb17Uz1c02HfYhndfX/Q4/m1ExnHU7WnIrWym5GJ2wU=;
 b=IynhyecyrR1M/ndOgpHx76KZeF6oABsczJ2a1rkKCw+82lVhekNQ0TdJmc9owRdkLp
 TN8c9c+6osykq2lZ5P7fUzpWmPridUFncCwiiebPCZ8CQBSwbBvwwEJCzfP2OQA0GLs2
 tIqddaomZypCiHxgqYRNT23u6PhtZsTQFwz1/P6dLbhwZ2xB+WCp9f7edcGGE0nJ8MnY
 hkdJWws1CwRwTe32oBjF82wv173i9hiSeyWzyAS1PmJ89vla0tyvlhGKQ/2srvKpBueN
 On3Vrwu/jSvhVCJcNahZrRoTznhcJ4zRzcjwjzuO++esQUp4jSayRZ2/1NZ8uBDK0jgw
 JD1g==
X-Gm-Message-State: APjAAAVPGUEXU5etM/cmETjT5LHXTDuO75aZg7DCfcI29yjDxwpe3SbO
 9Ibjh3bUQBjgIHGHkoeZoavOxXH4o0wwYg==
X-Google-Smtp-Source: APXvYqxav9Ue9I4v1NJfREqmW7RykeMHaEG0xjm0fM+G6e4AVR6UyoYI8sXjCI/oLt4cATyHdRFHhQ==
X-Received: by 2002:a5d:4e4d:: with SMTP id r13mr16826257wrt.295.1560435377004; 
 Thu, 13 Jun 2019 07:16:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s7sm5953326wmc.2.2019.06.13.07.16.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 07:16:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 15:16:14 +0100
Message-Id: <20190613141614.20157-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::432
Subject: [Qemu-devel] [PULL v2 00/47] target-arm queue
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2: dropped USHL/SSHL patch

The following changes since commit 785a602eae7ad97076b9794ebaba072ad4a9f74f:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20190613-pull-request' into staging (2019-06-13 13:25:25 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190613-1

for you to fetch changes up to 18cf951af9a27ae573a6fa17f9d0c103f7b7679b:

  target/arm: Fix short-vector increment behaviour (2019-06-13 15:14:06 +0100)

----------------------------------------------------------------
target-arm queue:
 * convert aarch32 VFP decoder to decodetree
   (includes tightening up decode in a few places)
 * fix minor bugs in VFP short-vector handling
 * hw/core/bus.c: Only the main system bus can have no parent
 * smmuv3: Fix decoding of ID register range
 * Implement NSACR gating of floating point
 * Use tcg_gen_gvec_bitsel

----------------------------------------------------------------
Peter Maydell (44):
      target/arm: Implement NSACR gating of floating point
      hw/arm/smmuv3: Fix decoding of ID register range
      hw/core/bus.c: Only the main system bus can have no parent
      target/arm: Add stubs for AArch32 VFP decodetree
      target/arm: Factor out VFP access checking code
      target/arm: Fix Cortex-R5F MVFR values
      target/arm: Explicitly enable VFP short-vectors for aarch32 -cpu max
      target/arm: Convert the VSEL instructions to decodetree
      target/arm: Convert VMINNM, VMAXNM to decodetree
      target/arm: Convert VRINTA/VRINTN/VRINTP/VRINTM to decodetree
      target/arm: Convert VCVTA/VCVTN/VCVTP/VCVTM to decodetree
      target/arm: Move the VFP trans_* functions to translate-vfp.inc.c
      target/arm: Add helpers for VFP register loads and stores
      target/arm: Convert "double-precision" register moves to decodetree
      target/arm: Convert "single-precision" register moves to decodetree
      target/arm: Convert VFP two-register transfer insns to decodetree
      target/arm: Convert VFP VLDR and VSTR to decodetree
      target/arm: Convert the VFP load/store multiple insns to decodetree
      target/arm: Remove VLDR/VSTR/VLDM/VSTM use of cpu_F0s and cpu_F0d
      target/arm: Convert VFP VMLA to decodetree
      target/arm: Convert VFP VMLS to decodetree
      target/arm: Convert VFP VNMLS to decodetree
      target/arm: Convert VFP VNMLA to decodetree
      target/arm: Convert VMUL to decodetree
      target/arm: Convert VNMUL to decodetree
      target/arm: Convert VADD to decodetree
      target/arm: Convert VSUB to decodetree
      target/arm: Convert VDIV to decodetree
      target/arm: Convert VFP fused multiply-add insns to decodetree
      target/arm: Convert VMOV (imm) to decodetree
      target/arm: Convert VABS to decodetree
      target/arm: Convert VNEG to decodetree
      target/arm: Convert VSQRT to decodetree
      target/arm: Convert VMOV (register) to decodetree
      target/arm: Convert VFP comparison insns to decodetree
      target/arm: Convert the VCVT-from-f16 insns to decodetree
      target/arm: Convert the VCVT-to-f16 insns to decodetree
      target/arm: Convert VFP round insns to decodetree
      target/arm: Convert double-single precision conversion insns to decodetree
      target/arm: Convert integer-to-float insns to decodetree
      target/arm: Convert VJCVT to decodetree
      target/arm: Convert VCVT fp/fixed-point conversion insns to decodetree
      target/arm: Convert float-to-integer VCVT insns to decodetree
      target/arm: Fix short-vector increment behaviour

Richard Henderson (3):
      target/arm: Use tcg_gen_gvec_bitsel
      target/arm: Fix output of PAuth Auth
      decodetree: Fix comparison of Field

 target/arm/Makefile.objs          |   13 +
 tests/tcg/aarch64/Makefile.target |    2 +-
 target/arm/cpu.h                  |   11 +
 target/arm/translate-a64.h        |    2 +
 target/arm/translate.h            |    3 -
 hw/arm/smmuv3.c                   |    2 +-
 hw/core/bus.c                     |   21 +-
 target/arm/cpu.c                  |    6 +
 target/arm/helper.c               |   75 +-
 target/arm/pauth_helper.c         |    4 +-
 target/arm/translate-a64.c        |   15 +-
 target/arm/translate-vfp.inc.c    | 2672 +++++++++++++++++++++++++++++++++++++
 target/arm/translate.c            | 1581 +---------------------
 tests/tcg/aarch64/pauth-2.c       |   61 +
 scripts/decodetree.py             |    2 +-
 target/arm/vfp-uncond.decode      |   63 +
 target/arm/vfp.decode             |  242 ++++
 17 files changed, 3203 insertions(+), 1572 deletions(-)
 create mode 100644 target/arm/translate-vfp.inc.c
 create mode 100644 tests/tcg/aarch64/pauth-2.c
 create mode 100644 target/arm/vfp-uncond.decode
 create mode 100644 target/arm/vfp.decode

