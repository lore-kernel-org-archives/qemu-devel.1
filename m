Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D32C433E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916D520888
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 00:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fs3UQjer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916D520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jylae-0001Ww-Pi
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 20:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZN-00008a-AW
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:13 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033]:35708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jylZL-0008EA-Ew
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 20:28:12 -0400
Received: by mail-pj1-x1033.google.com with SMTP id f16so4144337pjt.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 17:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cm9Q77zIpSR4g6kAlyZmv1zEyb9gfHMJv/3peZTbcgI=;
 b=fs3UQjerbWhKggKxkwh0PG47Q+Fo+tJzra9jkdtabTg2OFPBpGrQADt7fA46nhoSqx
 aV/n0YS3OuqUHcMZm+D1JkdiyHjEgdKdgrd9QCz2itbRNgw3/z2CmTIh3vLdDWi9aYVv
 ligjwtDHNj4WKVUZVYukzbzf2BSMCWHXMWaC8eqzY2wjAIe/dQGt0KaAFaL9aM0G8gAp
 4L//N3e+VIP7IobRBAlo5Oski1PZH5gwUQlPopvNUoopjUujs2fILFoaxlGqbXw9AFTv
 9wwlTzhHy3MDtu0WDZcMOLOD/9WvgafDgZ9NEK4aFfoYaqHtVCOF0iV8Qs8fYsLLz7QS
 01mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=cm9Q77zIpSR4g6kAlyZmv1zEyb9gfHMJv/3peZTbcgI=;
 b=t6swsUpU8xKbG/oD9LRoQi2rYSa2MSyF767y6THE7kmdL1C+87Rhz2LGK9c9ja6mTK
 Sqv1ng2tZMtQ6kTUFNcUvANjEI/RZJo75SZBTlLc1HlSE9vPIQhKQf9dDeMnM1Nsen0/
 JCjvQDX2KTHd/07QR97YqNbgzlsS5+TZfcDpCuPx9jQnm0Bc9lbhimpcpoC9hZNsfKZc
 dZHHVhN7kg92nRCh04mzZRzkH6BzNHa0V2v03oPeXnleyhu/a/NP1hJCqXuMZralnAiG
 NH4rjv61Q0HV4GxrZR4uygSZ/PaCx22FKTDQ7N/+Sel2t9ogtPD+mEw59MDOKb8KwPV6
 C55A==
X-Gm-Message-State: AOAM533V5qp6SeDeUntPuGJwXctCqd0kdNmJNNLpOKCtiUpL6ug+kiAn
 NHPlI0KqfnwHC2BU8FNMys2Pv8daKRw=
X-Google-Smtp-Source: ABdhPJw5dsGnvos3leEixg7g7AOPycuPE+YE5Y5HBQvO0EIMSsOtQB6T/LcPr6z/i9uppPKhzpqecQ==
X-Received: by 2002:a17:90a:c592:: with SMTP id
 l18mr2900897pjt.119.1595550489012; 
 Thu, 23 Jul 2020 17:28:09 -0700 (PDT)
Received: from localhost.localdomain (216-160-65-90.tukw.qwest.net.
 [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id q20sm4224635pfn.111.2020.07.23.17.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 17:28:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/7] target/riscv: NaN-boxing for multiple precison
Date: Thu, 23 Jul 2020 17:28:00 -0700
Message-Id: <20200724002807.441147-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: frank.chang@sifive.com, alistair23@gmail.com, qemu-riscv@nongnu.org,
 zhiwei_liu@c-sky.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is my take on Liu Zhiwei's patch set:
https://patchew.org/QEMU/20200626205917.4545-1-zhiwei_liu@c-sky.com

This differs from Zhiwei's v1 in:

 * If a helper is involved, the helper does the boxing and unboxing.

 * Which leaves only LDW and FSGN*.S as the only instructions that
   are expanded inline which need to handle nanboxing.

 * All mention of RVD is dropped vs boxing.  This means that an
   RVF-only cpu will still generate and check nanboxes into the
   64-bit cpu_fpu slots.  There should be no way an RVF-only cpu
   can generate an unboxed cpu_fpu value.

   This choice is made to speed up the common case: RVF+RVD, so
   that we do not have to check whether RVD is enabled.

 * The translate.c primitives take TCGv values rather than fpu
   regno, which will make it possible to use them with RVV,
   since v0.9 does proper nanboxing.

 * I have adjusted the current naming to be float32 specific ("*_s"),
   to avoid confusion with the float16 data type supported by RVV.


r~


LIU Zhiwei (2):
  target/riscv: Clean up fmv.w.x
  target/riscv: check before allocating TCG temps

Richard Henderson (5):
  target/riscv: Generate nanboxed results from fp helpers
  target/riscv: Generalize gen_nanbox_fpr to gen_nanbox_s
  target/riscv: Generate nanboxed results from trans_rvf.inc.c
  target/riscv: Check nanboxed inputs to fp helpers
  target/riscv: Check nanboxed inputs in trans_rvf.inc.c

 target/riscv/internals.h                |  16 ++++
 target/riscv/fpu_helper.c               | 102 ++++++++++++++++--------
 target/riscv/insn_trans/trans_rvd.inc.c |   8 +-
 target/riscv/insn_trans/trans_rvf.inc.c |  99 ++++++++++++++---------
 target/riscv/translate.c                |  29 +++++++
 5 files changed, 178 insertions(+), 76 deletions(-)

-- 
2.25.1


