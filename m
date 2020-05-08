Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AB0C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6FB207DD
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j2ZTMJS4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6FB207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX560-0006db-Cv
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4pA-0004Ep-MR
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:04 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:51333)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4p9-0006u3-NU
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:22:04 -0400
Received: by mail-pj1-x1034.google.com with SMTP id mq3so4414986pjb.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B6btfdK7/9+4Q/BzMDOEwWH4pYmbzqbicJsbGnozNUE=;
 b=j2ZTMJS4mfLtrXHqWxlRvoJ+JFtAgLn3A4+AS3ILjjaC25DZa6B9JuuRQ8OLQMXgEX
 eBF+xLUempuJjkUlz36QTCD4WFHRfsWhEmc6B98HwxzFmMb7OWY6tltDDvPe+4HmUav6
 loGkiS+TNTRj3YOzciJJFPlpOVyMTUWRuKoHHxqm/gYLv+nP6T4G2R7ajMCD5uTqEobw
 m3jMod7eSu0BVzZh+Y67i3MmYHmQEibg9Kt/XIPYROngZdj7pBgOWPM3HM0Xq+8gurjN
 ZBBRdOxFk6XnfR24a4ildXqFCD6JfAlD5lwCRQm84foHA+kH6LL1J2H0jwIv4psKncgX
 ObMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B6btfdK7/9+4Q/BzMDOEwWH4pYmbzqbicJsbGnozNUE=;
 b=p5fJCddd6Qav0vJmF3dhoZwcWGSRd5yHYWk4vi9OwbhVC1DTe9nNJlOoXzmxzkpVNM
 OY/QXo/VgEW70xBX7pnY9l0fEchX/rK3UqXRLmogfmYOd1A+bMSf837NMNucifhMuT7q
 UqyK1nsNmx5C43G++j9YVaI6ygv8Z7J349RUnQG1xPgLJb3BIgRKqIGe6CTbb55QqPTB
 eVC8ASbIencEArkG3bd0S3f27A+EyetHxjGCcAfezj0wHBkVBaR37vx+ANskzIu4Jrt4
 ojSOH3D6o2uL+0qIvLaCKdk+YP7a55iIm+gdW42q1BN6RzGHHNTqv+lkheqgV2BQ/n+C
 bTUw==
X-Gm-Message-State: AGi0PuYxHs5vhpgJoyQ0La5KhddRFBKMkM3Nfj5FVbmHI9f3ioJiiRRI
 wzfekQUePHjQmw3gstWq/Pd0w0WQlDY=
X-Google-Smtp-Source: APiQypKVvuUXCb5xEQLcCe5cJqCKFK22Ho7FgNItlFEB9i9z+iyhbWtbMCfgOm13n+V1faHGO4pkBw==
X-Received: by 2002:a17:90a:3266:: with SMTP id
 k93mr6889143pjb.118.1588951321912; 
 Fri, 08 May 2020 08:22:01 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id n16sm2104575pfq.61.2020.05.08.08.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:22:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 00/16] target/arm: partial vector cleanup
Date: Fri,  8 May 2020 08:21:44 -0700
Message-Id: <20200508152200.6547-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

This is not complete, but shows the direction I'd like to go.

Version 2 extracts more bits from my sve2 branch.  There's
still more to pull back, especially for crypto_helper.c, where
there are also tail clearing bugs to fix.

Version 3 rebases on master, which has some of the arm neon
decodetree conversion applied.


r~


Richard Henderson (16):
  target/arm: Create gen_gvec_[us]sra
  target/arm: Create gen_gvec_{u,s}{rshr,rsra}
  target/arm: Create gen_gvec_{sri,sli}
  target/arm: Remove unnecessary range check for VSHL
  target/arm: Tidy handle_vec_simd_shri
  target/arm: Create gen_gvec_{ceq,clt,cle,cgt,cge}0
  target/arm: Create gen_gvec_{mla,mls}
  target/arm: Swap argument order for VSHL during decode
  target/arm: Create gen_gvec_{cmtst,ushl,sshl}
  target/arm: Create gen_gvec_{uqadd,sqadd,uqsub,sqsub}
  target/arm: Remove fp_status from helper_{recpe,rsqrte}_u32
  target/arm: Create gen_gvec_{qrdmla,qrdmls}
  target/arm: Pass pointer to qc to qrdmla/qrdmls
  target/arm: Clear tail in gvec_fmul_idx_*, gvec_fmla_idx_*
  target/arm: Vectorize SABD/UABD
  target/arm: Vectorize SABA/UABA

 target/arm/helper.h             |   71 +-
 target/arm/translate.h          |   84 +-
 target/arm/neon-dp.decode       |    9 +-
 target/arm/neon_helper.c        |   10 -
 target/arm/translate-a64.c      |  210 +---
 target/arm/translate-neon.inc.c |   59 +-
 target/arm/translate.c          | 1908 ++++++++++++++++++++-----------
 target/arm/vec_helper.c         |  233 +++-
 target/arm/vfp_helper.c         |    4 +-
 9 files changed, 1667 insertions(+), 921 deletions(-)

-- 
2.20.1


