Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD673C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:35:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 775F62065F
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 18:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOmQagTQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 775F62065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBjDu-0004CS-IS
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 14:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCK-00027R-OL
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:40201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBjCI-0005vA-Pc
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 14:34:00 -0400
Received: by mail-wm1-x32c.google.com with SMTP id k20so104998wmi.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SMP+9dLyuBXrBOEKbSUabOjTS+nr6/zOWHkUllhu5EI=;
 b=wOmQagTQ8vEBu159VY7CYec/TjDmr9eEi1eo1g1WHgmaHzxCBspPm3CR52awlZQ1Fg
 s/vSBtyKf9FTv/GTmhfM9EoDrFdl8uQ01U+DbepxPm7KOlOyuXKADtbtXrS848VgfC6c
 XmdRiNpjvJ8sVE2TJqJvq+k/sN9xpG1q8cGTQIurKuB6FFmsBMHRDfY1sMBOJ1NeqCqc
 VDj/4wVkIKN1BuAblmDg6jDNKzA97bRCMI5Pocef0wENQcwD2JfWtucgrdOK56h8yNTW
 92L/3dpn/mh9f8kRLZGIKSccct4geh5IV5h8QkmqZzrx+50eAaNrjTw8eOC9hHVLbaiY
 2M6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=SMP+9dLyuBXrBOEKbSUabOjTS+nr6/zOWHkUllhu5EI=;
 b=kLEmNU1y4J9ltLWwYaoDJvT1MRNwdMq0AJHmV3ALx24WKW9hXhfvmBSqiT0LqR2Svn
 eBkOL3IG4W4rqIek+44dwLNPISBYJ/lyns1gY4jZMaHBEdlYQgWGIoLC0rom4rYb+xI2
 yZdXOvDtDxuehJELamZNRacNqbtIichOEgi2mARJgCenfPcL7H6H05dAIifH0aFWfFMw
 RDlSeUZw8exOJWcWHkFvgOhnnEkq5yqouDHkw6z5ZXsEuG3l+ZLoWZ7I3bx1L9OivcFB
 ZwbAgOtN3ddKqeRHccB2C2M5y9RSR4u7hWu+Fn5jb7DGGeWDnrovSRy6+qU4miJHvvXV
 7/Kg==
X-Gm-Message-State: AOAM530gz9WISFWZMe7nM6hcrfSDq1sOXykFUi2FJm+uAX4NgtaFwOef
 +X+ZXzKHHHvCiTtqVNYiy27VCw==
X-Google-Smtp-Source: ABdhPJxqsSf9z21xEGE3yip1ciiScrk0d1smwvCV99soNsS5T5jTguuG4cp/QBXXAyismdzcorKSGw==
X-Received: by 2002:a1c:f207:: with SMTP id s7mr52743wmc.22.1598639636503;
 Fri, 28 Aug 2020 11:33:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id s20sm356251wmh.21.2020.08.28.11.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 11:33:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 00/45] target/arm: Implement fp16 for AArch32 VFP and Neon
Date: Fri, 28 Aug 2020 19:33:09 +0100
Message-Id: <20200828183354.27913-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset implements fp16 support for AArch32, both VFP and Neon.

Patches 1-21 and 45 are the same as from the v1 vfp-only series,
and have all been reviewed. (I've included the minor fixups to
use 'f16' and the 'dh_ctype_f16' type.) Patches 22-44 are new and
cover Neon.

thanks
-- PMM

Peter Maydell (45):
  target/arm: Remove local definitions of float constants
  target/arm: Use correct ID register check for aa32_fp16_arith
  target/arm: Implement VFP fp16 for VFP_BINOP operations
  target/arm: Implement VFP fp16 VMLA, VMLS, VNMLS, VNMLA, VNMUL
  target/arm: Macroify trans functions for VFMA, VFMS, VFNMA, VFNMS
  target/arm: Implement VFP fp16 for fused-multiply-add
  target/arm: Macroify uses of do_vfp_2op_sp() and do_vfp_2op_dp()
  target/arm: Implement VFP fp16 for VABS, VNEG, VSQRT
  target/arm: Implement VFP fp16 for VMOV immediate
  target/arm: Implement VFP fp16 VCMP
  target/arm: Implement VFP fp16 VLDR and VSTR
  target/arm: Implement VFP fp16 VCVT between float and integer
  target/arm: Make VFP_CONV_FIX macros take separate float type and
    float size
  target/arm: Use macros instead of open-coding fp16 conversion helpers
  target/arm: Implement VFP fp16 VCVT between float and fixed-point
  target/arm: Implement VFP vp16 VCVT-with-specified-rounding-mode
  target/arm: Implement VFP fp16 VSEL
  target/arm: Implement VFP fp16 VRINT*
  target/arm: Implement new VFP fp16 insn VINS
  target/arm: Implement new VFP fp16 insn VMOVX
  target/arm: Implement VFP fp16 VMOV between gp and halfprec registers
  fpu: Add float16 comparison functions
  target/arm: Implement FP16 for Neon VADD, VSUB, VABD, VMUL
  target/arm: Implement fp16 for Neon VRECPE, VRSQRTE using gvec
  target/arm: Implement fp16 for Neon VABS, VNEG of floats
  target/arm: Implement fp16 for VCEQ, VCGE, VCGT comparisons
  target/arm: Implement fp16 for VACGE, VACGT
  target/arm: Implement fp16 for Neon VMAX, VMIN
  target/arm: Implement fp16 for Neon VMAXNM, VMINNM
  target/arm: Implement fp16 for Neon VMLA, VMLS operations
  target/arm: Implement fp16 for Neon VFMA, VMFS
  target/arm: Implement fp16 for Neon fp compare-vs-0
  target/arm: Implement fp16 for Neon VRECPS
  target/arm: Implement fp16 for Neon VRSQRTS
  target/arm: Implement fp16 for Neon pairwise fp ops
  target/arm: Implement fp16 for Neon float-integer VCVT
  target/arm: Convert Neon VCVT fixed-point to gvec
  target/arm: Implement fp16 for Neon VCVT fixed-point
  target/arm: Implement fp16 for Neon VCVT with rounding modes
  target/arm: Implement fp16 for Neon VRINT-with-specified-rounding-mode
  target/arm: Implement fp16 for Neon VRINTX
  target/arm/vec_helper: Handle oprsz less than 16 bytes in indexed
    operations
  target/arm/vec_helper: Add gvec fp indexed multiply-and-add operations
  target/arm: Implement fp16 for Neon VMUL, VMLA, VMLS
  target/arm: Enable FP16 in '-cpu max'

 include/fpu/softfloat.h         |  41 ++
 target/arm/cpu.h                |   7 +-
 target/arm/helper.h             | 133 +++++-
 target/arm/neon-dp.decode       |   8 +-
 target/arm/vfp-uncond.decode    |  27 +-
 target/arm/vfp.decode           |  34 +-
 target/arm/cpu.c                |   3 +-
 target/arm/cpu64.c              |  10 +-
 target/arm/helper-a64.c         |  11 -
 target/arm/translate-sve.c      |   4 -
 target/arm/vec_helper.c         | 431 ++++++++++++++++-
 target/arm/vfp_helper.c         | 244 ++++------
 target/arm/translate-neon.c.inc | 751 ++++++++++-------------------
 target/arm/translate-vfp.c.inc  | 810 ++++++++++++++++++++++++++++----
 14 files changed, 1719 insertions(+), 795 deletions(-)

-- 
2.20.1


