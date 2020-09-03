Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB8C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:35:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99B60205F4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 08:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsHWqg2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99B60205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDkik-00055Z-Nh
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 04:35:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfC-0007lN-Mr
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDkfA-0001W7-R4
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 04:32:10 -0400
Received: by mail-pf1-x442.google.com with SMTP id m8so1734543pfh.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 01:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fCP0cNZ4D2nuzBkSSr3MTW3OAB9zlS/A3EmERAQOTPw=;
 b=RsHWqg2RXKdG7w1y6mIg4rgQUXKqu+OyjzxIdA+OyTN8bouQU+EdPpHIn4zF3Rd1D/
 kfQtJuLwcL7uqpyP4jupzKHGEORhQjpbXb6ysDXaLyLV0yCr2KdmjHYr/RGEyBOr50nA
 gUvliVq+PPyj0xrKPoZocHEaaOm36J1RP5QZFyjH3DRyBoyWj0AeO5dJXpwMh7kb/oUS
 J3VY/SPwwM+ILCRRsVHQ14VyoiJhvHK2HjIonA9tG8+8TOiBdXzelniBxWfJ9kdP3tkC
 XHXX5EZR1Mzs9EF9qPmrx+gL8JZf41sHplhRvsxUEb0SATMjOGeXJS6dYW1tVMohCmEe
 f81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=fCP0cNZ4D2nuzBkSSr3MTW3OAB9zlS/A3EmERAQOTPw=;
 b=ugfaWYYe71Fcf6Viq8GnOuxQcEyBXIQd/L57G1LBUfV10PMzSJk/+t8DNQ3LKnz5OW
 pV1uqz6ZhgBfptDmyLu4oJBqVYO06J6x6v3ZoUDF1lZnssZgkQ9vQbeKXrPsVNdsFXiJ
 Ws8toZydFFfeGCrjfIHAPfIpAJyBCxEgI92jVOobWTAWAfAXNQ3pGoImuUth57uI/IyT
 9R3iXoOeImfLCd0EzFG45mBvF3kRSWTvVfNWRTBfrwy86wWixcGIDwfR+8vYuOhPIJxr
 789vBo7I9u7JCyxym9iS7LC3qiPBNOuBo0+ecRCqK6hJOiAm0bVmxjMTeGUxNHcDQ+w3
 GHgw==
X-Gm-Message-State: AOAM531SxgeO37wzzrUf7kp4QdmCVIf18UkExkfcwZ/F+PGvq7TcqdzJ
 CiCY4zl+k6vwSSkKaPF+ioaWOuNKr3/KXLRG
X-Google-Smtp-Source: ABdhPJwB3L4tLXw8mkrTnDYTokXYotLrDFHhiVJdP8Swf25X2QOqerGeHWuB08gT2yU4nK6oF1j/EQ==
X-Received: by 2002:a17:902:6ac9:: with SMTP id
 i9mr2846337plt.128.1599121927044; 
 Thu, 03 Sep 2020 01:32:07 -0700 (PDT)
Received: from localhost.localdomain ([222.95.248.6])
 by smtp.googlemail.com with ESMTPSA id e7sm1759201pgn.64.2020.09.03.01.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 01:32:06 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 03/12] tcg: Fixes dup_const link error
Date: Thu,  3 Sep 2020 16:31:38 +0800
Message-Id: <20200903083147.707-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20200903083147.707-1-luoyonggang@gmail.com>
References: <20200903083147.707-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x442.google.com
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
2.28.0.windows.1


