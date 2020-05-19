Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D498AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 811B52075F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 16:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gns4V4z1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811B52075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb5SU-00069V-Gi
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 12:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RK-0004bp-Ei
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:02 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:44331)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb5RJ-0006Ad-7I
 for qemu-devel@nongnu.org; Tue, 19 May 2020 12:50:01 -0400
Received: by mail-pg1-x52d.google.com with SMTP id p30so90003pgl.11
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 09:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bEgsFoMyxLURqGVZPX53gi79nIPTLbbAyCltgsLwy8s=;
 b=Gns4V4z1dsjp4LnsfhdxS9T+OO+3+zQPoSPV/HDy1iPQhg0LHJc/kLB3X5QZ1Oa4UJ
 XvDA84G19S4ftCTI7ONwuUF+TOmIi0/haz8zTyUN3Vl1qoK2dZZM0mi71wN21gCb1YUI
 KLBO56cY87R0MNVfPHIc2mKH/G1PIz4UKsNq+3ePLq91i1gTY1FLNzcn8P8cTtLP4MVU
 ZDCiOkvJPgbhCPiW+y2hWwP+BmKLWb4ekAhZTYGmPHIq9+vdmzQyMnj6x/ZrKhYpswJG
 J6jvB8XgpRgc1Y6KHI31FMtz1iQemuUgPHVM4de2Bi5e55bs/YTLxbLHhNXbYQr4GVS4
 wnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=bEgsFoMyxLURqGVZPX53gi79nIPTLbbAyCltgsLwy8s=;
 b=P2xkqU8MPvWhCcN3VphFIxn0cZ6aSqZ3SLG2oUgsJBJcBMc/kLDhSBFaQYs1/O7gJP
 yaRpAelhx6QIPybCwwbIoW5Rihz92nyaN6v8WmpyQqxJqGHcDOqaDEc1JcD/mqWYAzUA
 r0YYRn6eCalQg7y/REaFQlgkraI063NR/cgBIa2g2paVtQEB4tYAA3oi5oGxIOT3I2BI
 X/wnR/UUVzdCgWZiV6obi7dTmguptPGwIdBnaCPVACyId8CZnFPCa+zGGdsNcLA0lecy
 SkXMGARBPZIX181x2taqBC2UrIfojeKOahukNu2QE5CjH1f9vHp2Sh+kbKjnk3ZauFPb
 IvjA==
X-Gm-Message-State: AOAM531Lp0k2bnX3ceZARHiXhdLByKEKA1FF8FqG8cP6N3sHECrrEpgD
 kxyPyvAWsAx1qt4YZUQhcUEYRESTb5g=
X-Google-Smtp-Source: ABdhPJz+640VvSVLfnYECL1pZxW30Pi7dDZFbzfq3Ib6Vvmfr9k0fI5VpymWhZQOfj7uvzAaN34vyA==
X-Received: by 2002:a63:e74a:: with SMTP id j10mr87496pgk.261.1589906998661;
 Tue, 19 May 2020 09:49:58 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gx21sm96685pjb.47.2020.05.19.09.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 09:49:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] softfloat misc cleanups
Date: Tue, 19 May 2020 09:49:47 -0700
Message-Id: <20200519164957.26920-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f2465433b43fb87766d79f42191607dac4aed5b4:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-05-19 13:42:58 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-fpu-20200519

for you to fetch changes up to 150c7a91ce7862bcaf7422f6038dcf0ba4a7eee3:

  softfloat: Return bool from all classification predicates (2020-05-19 08:43:05 -0700)

----------------------------------------------------------------
Misc cleanups

----------------------------------------------------------------
Richard Henderson (10):
      softfloat: Use post test for floatN_mul
      softfloat: Replace flag with bool
      softfloat: Change tininess_before_rounding to bool
      softfloat: Name rounding mode enum
      softfloat: Name compare relation enum
      softfloat: Inline float32 compare specializations
      softfloat: Inline float64 compare specializations
      softfloat: Inline float128 compare specializations
      softfloat: Inline floatx80 compare specializations
      softfloat: Return bool from all classification predicates

 include/fpu/softfloat-helpers.h |   27 +-
 include/fpu/softfloat-macros.h  |   24 +-
 include/fpu/softfloat-types.h   |   28 +-
 include/fpu/softfloat.h         |  336 +++++++---
 target/i386/ops_sse.h           |    8 +-
 fpu/softfloat-specialize.inc.c  |   32 +-
 fpu/softfloat.c                 | 1305 +++++----------------------------------
 target/arm/sve_helper.c         |    8 +-
 target/arm/vfp_helper.c         |   14 +-
 target/hppa/op_helper.c         |    7 +-
 target/i386/fpu_helper.c        |    8 +-
 target/m68k/fpu_helper.c        |    6 +-
 target/m68k/softfloat.c         |   70 +--
 target/mips/msa_helper.c        |   10 +-
 target/openrisc/fpu_helper.c    |    4 +-
 target/ppc/int_helper.c         |   13 +-
 target/s390x/fpu_helper.c       |   22 +-
 target/s390x/vec_fpu_helper.c   |    2 +-
 target/sparc/fop_helper.c       |    4 +-
 target/unicore32/ucf64_helper.c |    6 +-
 target/xtensa/fpu_helper.c      |    6 +-
 tests/fp/fp-test.c              |    2 +-
 22 files changed, 547 insertions(+), 1395 deletions(-)

