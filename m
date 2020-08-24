Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB47BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:31:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9224B205CB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0Da1v34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9224B205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADUz-0001VG-LC
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42896)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTg-00081h-Il
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:40 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:43064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADTe-0002eb-PE
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:29:40 -0400
Received: by mail-wr1-x431.google.com with SMTP id a15so8898394wrh.10
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NHUufnyxKdqWA9jlUAJvMBRPiSTfhinIWCD6n38nQJw=;
 b=N0Da1v34vjCpKLAG2ERU2lDTX6c4dcpCTijWBLQzZ5h+jLWUNidP5D0vxrGoAPg8/z
 ShQjTgcwQ68hvQu3Kq1qDUNvITH+Uq0Z5cydP7AphY1cbJg4oHheyUU6x1q4teDcpPrX
 DIG3zX3rpzT7CbJQSrwb/z80tO8kiVOLXcskmC+YVbt5kNPG43QP2vK2xmIZqpuSm5/J
 3Yl1m8pVM6b8VkGoZmqb2/u6/uXPQbtEJF/Ud5qD3JxifaJSeDykqUz3Ryml5Z4NSaZM
 2V4ucN/z6Kmo4fXv22aQvGH1CzfDFmE3i2K5t/5zWjBT7UFECrBpwPvTE5w9nfoEKVfQ
 8+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NHUufnyxKdqWA9jlUAJvMBRPiSTfhinIWCD6n38nQJw=;
 b=J/vhdVtH81Mm8sgb/vBKptd+USQ2jPN7R1dDndIcsEzx5b5aav1a8J95K4sNBZDaUa
 plOOGMVGovjOMTxvBsuS87zDWWBpOmi3+lVLwJpIdBayGj+MP8qlf+TcoiZmVrIiqB6u
 bb7nK+ZVGRe2fbZ2gkhJohDbPyHIEAfzM7YuFq6tWuVyeZgRfEOOZalRWPpnQRnA5Bve
 SCVRm/C2m+GjaLRCAhxbDz+VPyZilXZmVUgpYVe5ioSa01CYMA047pC5OREMOCXFpTEM
 /P8oqthuQ+67faWh5bCponRR07cqlAz4BldgrKI2bZXhisN8hzGttNrUeYu2qqfePZ0D
 XcNg==
X-Gm-Message-State: AOAM532GqQODDhueovtPeUpYDfgF64izh7gI882h9ZHQAlAbHqXAp7Ix
 g+ilkw3mTakmg1CY3uQzfcyRnah68hBHM6cQ
X-Google-Smtp-Source: ABdhPJzyGjHWoJrMX/up1gvaUrvDM25ojaPHta1BjgPIWjBE+6XjpmYF3N+XOGnBx9RCdvJKFhijmA==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr6106190wrw.155.1598279376934; 
 Mon, 24 Aug 2020 07:29:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b14sm24499091wrj.93.2020.08.24.07.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 07:29:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/22] target/arm: Implement fp16 for AArch32 VFP
Date: Mon, 24 Aug 2020 15:29:12 +0100
Message-Id: <20200824142934.20850-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

This patchset implements fp16 support for AArch32 VFP.
I've included the final "turn it on in -cpu max" patch for
convenience for testing, but we shouldn't commit that until
we've also added AArch32 Neon fp16 support. (I have a patchset
for that in progress, but I still have a handful of insns still to
convert; I figured I'd send this lot out for review rather than
waiting and sending a 50-patch set that covered VFP and Neon.)

I'll send out the risu patch that adds patterns for fp16
insns in a moment.

thanks
-- PMM

Peter Maydell (22):
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
  target/arm: Enable FP16 in '-cpu max'

 target/arm/cpu.h               |   7 +-
 target/arm/helper.h            |  22 +
 target/arm/vfp-uncond.decode   |  27 +-
 target/arm/vfp.decode          |  34 +-
 target/arm/cpu.c               |   3 +-
 target/arm/cpu64.c             |  10 +-
 target/arm/helper-a64.c        |  11 -
 target/arm/translate-sve.c     |   4 -
 target/arm/vfp_helper.c        | 198 ++++----
 target/arm/translate-vfp.c.inc | 810 +++++++++++++++++++++++++++++----
 10 files changed, 894 insertions(+), 232 deletions(-)

-- 
2.20.1


