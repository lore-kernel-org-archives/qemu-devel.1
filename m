Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33992C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:25:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0449821721
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 12:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihwILJw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0449821721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39376 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbOn6-0003ab-9q
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 08:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58704)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcp-0007sd-Ha
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbOcn-0003rr-OV
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:39 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429]:39133)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbOcn-0003qe-BA
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 08:14:37 -0400
Received: by mail-wr1-x429.google.com with SMTP id x4so17872037wrt.6
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OpNGifX3j6ckf1FbrBvHqt2Qxj/aFsbPmv10L0Shg4k=;
 b=ihwILJw6miM7AMiTH2wnwM0K+u3o2uB5qZY4c3FBk5f8XiCSAN2TRURb1jD8ip/xbY
 0NhiCvSxU3DSEBgQqn2V3Plq//TT+rCLRHi1bBg6Ox2o/UqzRVm6fUjPp1SWERvTLbe0
 xrfFuJ3/zzNlYYyuQETtv0vyqELyZ5rilQn0TeMqyI6uijp+t7x/Ol21ZLQMYoziiOBa
 A2ZVVzfOjcxGLzL59/t3207A1Flx1Nfl0tNqyD+1ArH3yU7Mu/0qQ0XtiJbvqpeY743L
 NshezMsICamSxTCjC3SzdjLIUGNni3MAPDu4ntpctZzwW4I3L034YP2ZFgFoi5MYUbTK
 DzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=OpNGifX3j6ckf1FbrBvHqt2Qxj/aFsbPmv10L0Shg4k=;
 b=ZgG+kDPFy30DWjqBqzlk3fjl5m7nLZaf4hdCOjQWwGpKvcGWHh/iWyQRNkhnYcFYff
 BvCISUUKbBBLUtY1ixO583P4e4EZjpFFED4PLMTsYjMyZSfCfewe5BbttFMCEOTHapKE
 3iGJ6Cybjq6h9AG39O58pfOT32ZnnpY9LhHwglN94xI4PDozKRme+rlEfKop0hr986aV
 pHh790KdpjtVLdId/fU7xHkhUthv8JRxCI/bfvJgncbKx3eud3VaOw4/gF/VMdV6OJ4Q
 CQqx4Nijq0jOF7FpRfDYLT5h5E63/wirjtxqxp0hErUI9os1l9uQJLJ4PeV7fK/johZd
 ZR1w==
X-Gm-Message-State: APjAAAXySnErLG317qpUGOu/SDY/EreONKoBOVy7S7rlajh9aB+UpI3n
 oHoKkilTmdRuoKzjEW+YRrmJVTf6tMMxwQ==
X-Google-Smtp-Source: APXvYqzVueNiVT4D+eVsA6f2664jiXINKYjR/L9FfDY/BYfFVVPUEObMxGeaOY7wZhwqQDk+knxL4g==
X-Received: by 2002:a5d:4949:: with SMTP id r9mr750088wrs.289.1560428075149;
 Thu, 13 Jun 2019 05:14:35 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y6sm2010576wrp.12.2019.06.13.05.14.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 05:14:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 13:13:45 +0100
Message-Id: <20190613121433.5246-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::429
Subject: [Qemu-devel] [PULL 00/48] target-arm queue
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

Arm queue; the bulk of this is the VFP decodetree conversion...

thanks
-- PMM

The following changes since commit 4747524f9f243ca5ff1f146d37e423c00e923ee1:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-qapi-2019-06-12' into staging (2019-06-13 11:58:00 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20190613

for you to fetch changes up to 07e4c7f769120c9a5bd6a26c2dc1421f2f838d80:

  target/arm: Fix short-vector increment behaviour (2019-06-13 12:57:37 +0100)

----------------------------------------------------------------
target-arm queue:
 * convert aarch32 VFP decoder to decodetree
   (includes tightening up decode in a few places)
 * fix minor bugs in VFP short-vector handling
 * hw/core/bus.c: Only the main system bus can have no parent
 * smmuv3: Fix decoding of ID register range
 * Implement NSACR gating of floating point
 * Use tcg_gen_gvec_bitsel
 * Vectorize USHL and SSHL

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

Richard Henderson (4):
      target/arm: Vectorize USHL and SSHL
      target/arm: Use tcg_gen_gvec_bitsel
      target/arm: Fix output of PAuth Auth
      decodetree: Fix comparison of Field

 target/arm/Makefile.objs          |   13 +
 tests/tcg/aarch64/Makefile.target |    2 +-
 target/arm/cpu.h                  |   11 +
 target/arm/helper.h               |   11 +-
 target/arm/translate-a64.h        |    2 +
 target/arm/translate.h            |    9 +-
 hw/arm/smmuv3.c                   |    2 +-
 hw/core/bus.c                     |   21 +-
 target/arm/cpu.c                  |    6 +
 target/arm/helper.c               |   75 +-
 target/arm/neon_helper.c          |   33 -
 target/arm/pauth_helper.c         |    4 +-
 target/arm/translate-a64.c        |   33 +-
 target/arm/translate-vfp.inc.c    | 2672 +++++++++++++++++++++++++++++++++++++
 target/arm/translate.c            | 1881 +++++---------------------
 target/arm/vec_helper.c           |   88 ++
 tests/tcg/aarch64/pauth-2.c       |   61 +
 scripts/decodetree.py             |    2 +-
 target/arm/vfp-uncond.decode      |   63 +
 target/arm/vfp.decode             |  242 ++++
 20 files changed, 3593 insertions(+), 1638 deletions(-)
 create mode 100644 target/arm/translate-vfp.inc.c
 create mode 100644 tests/tcg/aarch64/pauth-2.c
 create mode 100644 target/arm/vfp-uncond.decode
 create mode 100644 target/arm/vfp.decode

