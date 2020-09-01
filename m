Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FABC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:20:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEA420767
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:20:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0kfW6qA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FEA420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD85X-0003vb-Dt
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83L-0007Gr-Cl
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:31 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kD83I-00069a-Ep
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:31 -0400
Received: by mail-wr1-x42c.google.com with SMTP id g4so1493771wrs.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 08:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aevIgEm+B5kgZFapzqkKHf9iqIOu0mXm/5QZrA+DeW4=;
 b=R0kfW6qA4J1to1fZAGJBrRza4prK0Js7xe6FNkqqAHMpEGjWesplmTcBwaHBdEhAhq
 o4HXIfTm7SIq9iMVwjPWK2bctaLqcw41cqQIFoJ3+qzFKupkXlK8GSjR6tjczx41NrCT
 y8AJRSNMw+K1cLuNwGdoJwlgm14r2qmGZTFYKFnO3z7u2XLO8tznxeHIBic7z8hzH49g
 xD9SSqmcs6yeQRt6GB2lg2TPNacA2NnVQcMs8vCfS+MwE6e3fqSO+20cND8IiwdBkqYa
 H7l6G3uLzHm6gJgnlRGUQ2sfcFEOSS6Wlppk+Yqk7mj1rcch/vdvlrM4ybhVR38D2B9p
 qZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=aevIgEm+B5kgZFapzqkKHf9iqIOu0mXm/5QZrA+DeW4=;
 b=b89/B31Z7Qvbh6899IE9sMaLuCrF/ERSgi0tGBYn7mdEfKnCYspzW0Nfmqtx5zYqw5
 adfiTUYZ+ryXcSzBYTOvcue7ytIxAbWY8hTOPgtTDCUftHhCAudj9Gj9VC/CKTNWB7ey
 xjkErrmTCPXREw17hnLz5GseMy9yxQDpv7qeQVmrGM0NNd/z8q2wftSLyVs7km8ga42O
 CqAioOu5MeFISt6PVFjNo4gmSRzEwWVw/0pP3+Rhk2WOaucF37kVsFRFqrzD3RiGjefQ
 WXeQSovtKzSLoaeigX+8asPhxG33pQDv6yrGeT25kvdfTRSPzLGXRPSPweyIPWgI+LVC
 XEMg==
X-Gm-Message-State: AOAM5316oL9z2Jp5oe5PuPZf7vMKNJVLNfAVUE1wDnL/6a1b/5g0mv43
 DEX6KY6kp2RSlTZhsbW8p9aZUHi1Y47TGPYp
X-Google-Smtp-Source: ABdhPJzTmViv2oatWc5FmwJZm5ZGZ4gGTOtYcw1+q+DONPN7fWZE1bAH/Wz1DyytfAhGUfJNNy6wSQ==
X-Received: by 2002:a5d:6685:: with SMTP id l5mr2508035wru.264.1598973505943; 
 Tue, 01 Sep 2020 08:18:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2242317wma.4.2020.09.01.08.18.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 08:18:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/47] target-arm queue
Date: Tue,  1 Sep 2020 16:17:36 +0100
Message-Id: <20200901151823.29785-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Just my fp16 work, plus some small stuff for the sbsa-ref board;
but my rule of thumb is to send a pullreq once I get over about
30 patches...

-- PMM

The following changes since commit 2f4c51c0f384d7888a04b4815861e6d5fd244d75:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200831-pull-request' into staging (2020-08-31 19:39:13 +0100)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20200901

for you to fetch changes up to 3f462bf0f6ea6382dd1502d4eb1fcd33c8e774f5:

  hw/arm/sbsa-ref : Add embedded controller in secure memory (2020-09-01 14:01:34 +0100)

----------------------------------------------------------------
target-arm queue:
 * Implement fp16 support for AArch32 VFP and Neon
 * hw/arm/sbsa-ref: add "reg" property to DT cpu nodes
 * hw/arm/sbsa-ref : Add embedded controller in secure memory

----------------------------------------------------------------
Graeme Gregory (2):
      hw/misc/sbsa_ec : Add an embedded controller for sbsa-ref
      hw/arm/sbsa-ref : Add embedded controller in secure memory

Leif Lindholm (1):
      hw/arm/sbsa-ref: add "reg" property to DT cpu nodes

Peter Maydell (44):
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
      target/arm: Make VFP_CONV_FIX macros take separate float type and float size
      target/arm: Use macros instead of open-coding fp16 conversion helpers
      target/arm: Implement VFP fp16 VCVT between float and fixed-point
      target/arm: Implement VFP vp16 VCVT-with-specified-rounding-mode
      target/arm: Implement VFP fp16 VSEL
      target/arm: Implement VFP fp16 VRINT*
      target/arm: Implement new VFP fp16 insn VINS
      target/arm: Implement new VFP fp16 insn VMOVX
      target/arm: Implement VFP fp16 VMOV between gp and halfprec registers
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
      target/arm/vec_helper: Handle oprsz less than 16 bytes in indexed operations
      target/arm/vec_helper: Add gvec fp indexed multiply-and-add operations
      target/arm: Implement fp16 for Neon VMUL, VMLA, VMLS
      target/arm: Enable FP16 in '-cpu max'

 target/arm/cpu.h                |   7 +-
 target/arm/helper.h             | 133 ++++++-
 target/arm/neon-dp.decode       |   8 +-
 target/arm/vfp-uncond.decode    |  27 +-
 target/arm/vfp.decode           |  34 +-
 hw/arm/sbsa-ref.c               |  43 ++-
 hw/misc/sbsa_ec.c               |  98 +++++
 target/arm/cpu.c                |   3 +-
 target/arm/cpu64.c              |  10 +-
 target/arm/helper-a64.c         |  11 -
 target/arm/translate-sve.c      |   4 -
 target/arm/vec_helper.c         | 431 ++++++++++++++++++++-
 target/arm/vfp_helper.c         | 244 +++++-------
 hw/misc/meson.build             |   2 +
 target/arm/translate-neon.c.inc | 755 +++++++++++++------------------------
 target/arm/translate-vfp.c.inc  | 810 ++++++++++++++++++++++++++++++++++++----
 16 files changed, 1819 insertions(+), 801 deletions(-)
 create mode 100644 hw/misc/sbsa_ec.c

