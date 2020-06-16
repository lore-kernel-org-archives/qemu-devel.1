Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B89EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:09:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8772098B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VoCLw/Np"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8772098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlF5p-0002rY-DP
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:09:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF4t-0000zA-TM
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:51 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:33557)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlF4r-0007QE-Il
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:08:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id j198so2692311wmj.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZjLnKVZ43LyQ+p0ER8o5X1d7VJQL/NrnekmdPJtYTzM=;
 b=VoCLw/NpY6+c9VU3QZKkOJPXKDuB/GdvkY8zq1yg5S19mm+0NWWCS09vFG7rIvxvYw
 F5BgB1dYYJ0I8lqVEEnghNN7HxE5nA7tdKh/aph1/wGxfjKJoYCcOkSeC1pQ0Ux9Xdv9
 wLTnyCYjmy4ZwqP3pkBZqQvWdkKhqx7XG9IKcj8meqvcmqUeN43M6WFnPRqgIuGEN0bK
 xtisaZPQhv6BLn1EGzUA6l+MzhTVCVkk+rxZhoiS4XnvBPSSZ/hf6Uwai9jem7jiBBiy
 JV3yZ0HwfkHwcehMl6sVYS5Py6nOObPw89FFAesTppFuBDhuHtfg4KpvTJXe+fWPrCOu
 Op2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZjLnKVZ43LyQ+p0ER8o5X1d7VJQL/NrnekmdPJtYTzM=;
 b=WDqzPgichmZMO4rZ6a/Cj1+8FNcD9JAnlmggskhGxNuOFGfpTAFoEWzlB7unm9FmAn
 wNcfO1gWYUc4RDAtTk4X8AlouS+5VclXjZ76btcFuTTdHO3Ip0daOrIF/3qExZYJR11H
 p+o0Cw7z4S3ZAj+Sgp5V46ic1mLRt90rG5yPU0yjkV6wQ6PBhcuFcufNVtWkKqsaotw6
 Geq5/jmyITbgNAblkREyfJyegRfm+jfkdnqUTS84hhKE/4DvmTVixYl49+auiwE/FGPb
 xjQJPdotI8pp1LQ71g18+SFDEbJekdW2ZG5mYI/r3GmsxhK3kMhxwHmqGbJeSJgKk6oo
 dupA==
X-Gm-Message-State: AOAM530TzaAXB1y0ZfeXe9Y1W4hlxmK0NNAJgZueWTosw3ApmzqBUNwy
 Bk1etfZ6i7R6IM2QDpEHMzM3WA==
X-Google-Smtp-Source: ABdhPJwlZC/aC9IXcAsfI0o0atGHHUGajwaLUkKBQrGYnVjmE5zUwfMnG8oaKYXd+ZdM2qRQSAosvw==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr4012327wme.64.1592327327995; 
 Tue, 16 Jun 2020 10:08:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y80sm5263216wmc.34.2020.06.16.10.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:08:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 00/21] target/arm: Finish neon decodetree conversion
Date: Tue, 16 Jun 2020 18:08:23 +0100
Message-Id: <20200616170844.13318-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patchset completes the conversion of Neon to decodetree
by converting all the instructions in the 2-reg-misc grouping.

There are some potential further cleanups available, which I don't
propose to do (I've spent what feels like too much time on this
refactoring already; I want to move onto implementing FP16 now,
which is what the refactoring was intended to permit):

 * the oddball "TCG temps in global variables" cpu_V0, cpu_V1,
   cpu_M0 are now used only in the iwmmxt codegen; V0 and V1
   would be easy to replace with local temporaries. M0 is
   slightly trickier. The main thing that dissuades me from
   this refactoring is that I don't have an easy way to test the
   iwmmxt codegen.

 * we have a confusingly large number of ways to load and
   store from the Neon/VFP register file:
    - neon_load_reg/neon_store_reg
    - neon_load_reg64/neon_store_reg64
    - neon_load_reg32/neon_store_reg32
    - neon_load_element/neon_store_element
    - neon_load_element64/neon_store_element64
   which all have subtly different semantics. The way that
   neon_load_reg/neon_store_reg do a "create temp on load,
   destroy temp on store" and none of the rest do is particularly
   confusing. I'd like us to have fewer of these but it's not
   immediately obvious what the correct small set of primitives
   should be.

 * it would be nice to make the vfp and neon decode really
   separate translation units rather than #including them
   into translate.c someday

thanks
-- PMM

Peter Maydell (21):
  target/arm: Convert Neon 2-reg-misc VREV64 to decodetree
  target/arm: Convert Neon 2-reg-misc pairwise ops to decodetree
  target/arm: Convert VZIP, VUZP to decodetree
  target/arm: Convert Neon narrowing moves to decodetree
  target/arm: Convert Neon 2-reg-misc VSHLL to decodetree
  target/arm: Convert Neon VCVT f16/f32 insns to decodetree
  target/arm: Convert vectorised 2-reg-misc Neon ops to decodetree
  target/arm: Convert Neon 2-reg-misc crypto operations to decodetree
  target/arm: Rename NeonGenOneOpFn to NeonGenOne64OpFn
  target/arm: Fix capitalization in NeonGenTwo{Single,Double}OPFn
    typedefs
  target/arm: Make gen_swap_half() take separate src and dest
  target/arm: Convert Neon 2-reg-misc VREV32 and VREV16 to decodetree
  target/arm: Convert remaining simple 2-reg-misc Neon ops
  target/arm: Convert Neon VQABS, VQNEG to decodetree
  target/arm: Convert simple fp Neon 2-reg-misc insns
  target/arm: Convert Neon 2-reg-misc fp-compare-with-zero insns to
    decodetree
  target/arm: Convert Neon 2-reg-misc VRINT insns to decodetree
  target/arm: Convert Neon 2-reg-misc VCVT insns to decodetree
  target/arm: Convert Neon VSWP to decodetree
  target/arm: Convert Neon VTRN to decodetree
  target/arm: Move some functions used only in translate-neon.inc.c to
    that file

 target/arm/translate.h          |    8 +-
 target/arm/neon-dp.decode       |  106 +++
 target/arm/translate-a64.c      |    8 +-
 target/arm/translate-neon.inc.c | 1191 ++++++++++++++++++++++++++++++-
 target/arm/translate.c          | 1061 +--------------------------
 5 files changed, 1311 insertions(+), 1063 deletions(-)

-- 
2.20.1


