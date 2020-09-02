Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E33FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:03:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D49D2067C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYpzGK9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D49D2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWAY-0004ZS-7z
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDW8W-0000Si-LI
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:01:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDW8U-0000Il-M9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:01:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id w186so2837221pgb.8
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E3tqAQ40jh0sPTD1d9xIkZ9WYrXugWo7nhLWb57uF6Q=;
 b=MYpzGK9KlMiUrXXFF850wn8h65J7d8mGHdjaCNe9s6Z3umbJDiz5FKpa9albrVTQZJ
 TjLYEbUcziIIRoY9B9KMAXMN5BzxD4BHa8S4d17NcR+S34esqStWL+gDdcLbgSCOhor3
 fce9twXlIILn18nyByZ+0wzaS/2p8+oU1O3xekBlkDOYkPhOn5ZrclK+e/EOThk0RB5A
 LXU8fScQa7kjwuSYxISbUoJxvYAzuMigiSLSMuXhPrHqu99vCiyvn7xnIfMijHRzCqBH
 tjp57A+03oc8q4V+JzpsNtSd/PMBeSOqHX1DcX+Qwr2zajRykN8OOBzh3rX4WJ9+tkPD
 B9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E3tqAQ40jh0sPTD1d9xIkZ9WYrXugWo7nhLWb57uF6Q=;
 b=Qiqos/0pC4SeoQnCT1c8G3HZxsKQ9Q8VitSoy9FXJ6VkPYD1M+U44pI+o5V+XjhnSg
 Ja6uR19fmr3bmIu2zoIf6gWCjnQ6ESOLl6SrVAKXwOXPsXcTuE/1DDu8ziKL30NWOeiK
 Mi6qha52K1ydajJUJUgFPYmhho7oHiTblY3mnxzMP7/q0z7cI9S9lipFhaa7OivjjSRA
 aDQw9cWLLuCzg250ohmLDuI2VgASDYWPR4nwkr1MQ5RmlVBiob0dLIcCinskRQsr6wVO
 p60ecS3SROKrxZw6i0vyWG51y0l8TUxQuJx5UI07RUubgvh7Ln37IHfaoF2ZTQM+3v6r
 mYuQ==
X-Gm-Message-State: AOAM530mh56lzxKfW+qAAxog/xg1MFojQyuz0UkobRNPKsqviVH3Cx5N
 wH4yQyhuAW2frIdS7gIgcjrtNqqSHRI=
X-Google-Smtp-Source: ABdhPJw/nrFFE2q++6Z+N+Bkp6OL8Li2KvrhrfpqIcZQNu6pFURuIWQTh7jdlku6MPOnmv20zWe1LQ==
X-Received: by 2002:a62:2e81:: with SMTP id u123mr3968934pfu.304.1599066080665; 
 Wed, 02 Sep 2020 10:01:20 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x4sm40527pfm.86.2020.09.02.10.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 10:01:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] tcg: Fixes dup_const link error
Date: Thu,  3 Sep 2020 01:00:52 +0800
Message-Id: <20200902170054.810-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200902170054.810-1-luoyonggang@gmail.com>
References: <20200902170054.810-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=luoyonggang@gmail.com; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Rename function dup_const to dup_const_eval for avoid confliction with macro dup_const

The link error on msys2

Linking target qemu-system-alpha.exe
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_optimize.c.obj: in function `tcg_optimize':
E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/optimize.c:1106: undefined reference to `dup_const'
C:/CI-Tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: libqemu-alpha-softmmu.fa.p/tcg_tcg-op-vec.c.obj: in function `tcg_gen_dupi_vec':
E:\CI-Cor-Ready\xemu\qemu-build/../qemu.org/tcg/tcg-op-vec.c:283: undefined reference to `dup_const'
collect2.exe: error: ld returned 1 exit status

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 include/tcg/tcg.h | 6 +++---
 tcg/tcg-op-gvec.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 53ce94c2c5..7f6fe8454b 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1251,15 +1251,15 @@ static inline int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)
 void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
 
 /* Replicate a constant C accoring to the log2 of the element size.  */
-uint64_t dup_const(unsigned vece, uint64_t c);
+uint64_t dup_const_eval(unsigned vece, uint64_t c);
 
 #define dup_const(VECE, C)                                         \
     (__builtin_constant_p(VECE)                                    \
      ? (  (VECE) == MO_8  ? 0x0101010101010101ull * (uint8_t)(C)   \
         : (VECE) == MO_16 ? 0x0001000100010001ull * (uint16_t)(C)  \
         : (VECE) == MO_32 ? 0x0000000100000001ull * (uint32_t)(C)  \
-        : dup_const(VECE, C))                                      \
-     : dup_const(VECE, C))
+        : dup_const_eval(VECE, C))                                      \
+     : dup_const_eval(VECE, C))
 
 
 /*
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 3707c0effb..cbb6cd04bc 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -359,7 +359,7 @@ static inline bool check_size_impl(uint32_t oprsz, uint32_t lnsz)
 static void expand_clr(uint32_t dofs, uint32_t maxsz);
 
 /* Duplicate C as per VECE.  */
-uint64_t (dup_const)(unsigned vece, uint64_t c)
+uint64_t dup_const_eval(unsigned vece, uint64_t c)
 {
     switch (vece) {
     case MO_8:
-- 
2.27.0.windows.1


