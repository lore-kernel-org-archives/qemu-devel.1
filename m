Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCCDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D29B422CE3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCcKJbU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D29B422CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dPr-00077O-8v
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 06:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3dON-0005Om-Ev
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:44:59 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3dOL-0007I0-LA
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:44:59 -0400
Received: by mail-wm1-x342.google.com with SMTP id 3so9208798wmi.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XgfKTN3qrqCoJzqdKSDYPfcqMN4ERFivhSFSxjBulnI=;
 b=lCcKJbU5KuhIb6JLh5s8gkFEsvgL//e3Xz8UG4CeSUK/9l6u7pPv/JzdpQc4nLtTuj
 HfOvfHsx8+39yeg5oDaNN4+AcGUjm5eXqpwWujJQnZJlNjL1hMqtt0Q8puoGJmdzx/Fx
 Zw+MAInnwTIkoczMfrSLhQuv72D3VHIpEgmczQCC/iaIYrMXndzGfAASym0ihPJZCp1D
 QsWTsU6vATEqwyPESXRoLeCeiiO6+rOL7GdE/+Rzi5q9wJsSIoIo12S6Ss4a+OokhW53
 keQ2MZ6amcmXBxxPqtLxEGSC7cqVEBWbs60t7IVBgrWZ/atuuSIdhPcWoR3VRp+ZN84c
 q0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XgfKTN3qrqCoJzqdKSDYPfcqMN4ERFivhSFSxjBulnI=;
 b=nEYarh9p3b41kZHLE7PELo2hycuZ5C5hYYTtknWAiOrKTMAJoubI/nD0a990aG7mXP
 0Bcm/YQARf4sHWvR8F7qBN4MOnNp1Sn1rlEXrJ92KO8wqAGaFMYMphOwyAUV9mUnLSc4
 yGVOCf/9bO2Bc7iiMFgk61kRSfY/RbkgD7uu9ySlJGHirGlPNUpXlG/HyY8fAIS2Nhca
 p6Q7YzWYpLs9kNv4ViljHs/D06ygIiu/A5m8OJQYgw86xd2Lu1Lw42K0l8IWbPQ/X0O0
 3fIBRKl3JzMAprAfciQYsjXy7Ollfkj7J637SXfE/z49qJsof+4W9pLfqwK6Jj/e9hjk
 YUTg==
X-Gm-Message-State: AOAM532woAVmMzgY+vfLong8BDKQpWt3WywC2sb1+eGj1ShaK3UGt5d1
 hSBPV3siIaI0CQPt65Vs8XlZ4Q==
X-Google-Smtp-Source: ABdhPJwqO4vGRDU3MiLYLbFa4n2ZNUhgk8vOhKmcgC0WwraNG3h7uUPKoSzx72PSk8pdYRMMuHmqBA==
X-Received: by 2002:a7b:ca5a:: with SMTP id m26mr7308262wml.27.1596710695531; 
 Thu, 06 Aug 2020 03:44:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id a10sm6042189wrx.15.2020.08.06.03.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:44:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/4] Refactor get_fpstatus_ptr() ready for AArch32 fp16
Date: Thu,  6 Aug 2020 11:44:49 +0100
Message-Id: <20200806104453.30393-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x342.google.com
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

This patchset refactors the existing get_fpstatus_ptr() functions,
and fixes a bug where we weren't getting FZ16 right for AArch32
VCMLA, VCADD of fp16 types.

We currently have two versions of get_fpstatus_ptr(), which both take
an effectively boolean argument:
 * the one for A64 takes "bool is_f16" to distinguish fp16 from other ops
 * the one for A32/T32 takes "int neon" to distinguish Neon from other ops

This is confusing, and to implement ARMv8.2-FP16 the A32/T32 one will
need to make a four-way distinction between "non-Neon, FP16",
"non-Neon, single/double", "Neon, FP16" and "Neon, single/double".
The A64 version will then be a strict subset of the A32/T32 version.

The patchset creates a single fpstatus_ptr() function which takes
an enum selecting between the 4 possible fpstatus options.
It then adds the implementation of the "Neon standard FPST for f16".
Finally, we can then use to fix a bug in the VCMLA/VCADD fp16
handling where we were using FPST_STD rather than FPST_STD_F16.
(The difference is that the former will not honour FPSCR.FZ16.)

Based-on: 20200803111849.13368-1-peter.maydell@linaro.org
("[PATCH 0/7] target/arm: copro decode cleanup)
but only textually; there are no semantic dependencies to that series.

thanks
-- PMM

Peter Maydell (4):
  target/arm: Replace A64 get_fpstatus_ptr() with generic fpstatus_ptr()
  target/arm: Make A32/T32 use new fpstatus_ptr() API
  target/arm: Implement FPST_STD_F16 fpstatus
  target/arm: Use correct FPST for VCMLA, VCADD on fp16

 target/arm/cpu.h                |  9 +++-
 target/arm/translate-a64.h      |  1 -
 target/arm/translate.h          | 52 +++++++++++++++++++
 target/arm/cpu.c                |  3 ++
 target/arm/translate-a64.c      | 89 +++++++++++++--------------------
 target/arm/translate-neon.inc.c | 28 +++++------
 target/arm/translate-sve.c      | 34 ++++++-------
 target/arm/translate-vfp.inc.c  | 44 ++++++++--------
 target/arm/translate.c          | 13 -----
 target/arm/vfp_helper.c         |  5 ++
 10 files changed, 156 insertions(+), 122 deletions(-)

-- 
2.20.1


