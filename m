Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A66C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B65A1207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 21:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2ZYtaPK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B65A1207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDaXv-0007qY-SH
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 17:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDaWg-0006F2-17
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:42:42 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35984)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDaWe-0001Re-BQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 17:42:41 -0400
Received: by mail-pf1-x443.google.com with SMTP id m8so462793pfh.3
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 14:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=E3tqAQ40jh0sPTD1d9xIkZ9WYrXugWo7nhLWb57uF6Q=;
 b=F2ZYtaPKfe71R5Q+FDdXjkZ419FMcAJOOoG3iog8RmhaJYP8FzXdw295a2KG0kTXYB
 Rwb4W1cTab8rQtKomzZbuzfSkzVd4I7ia7GEKZEmPVLAjcGWfJdeydyR07r0cOplDDUV
 rxgALDJ+SP42d0M9ZraHgb4JZkLg/9VTJ/fqSxy266pgcoErP0PhYEe92Mim/zWntnlq
 +VGD2QXH/nj2jCX1+M5JqVMYn5v9eN/FQfX6CRx6IofMyNaV1SPIZgCH3JVi1OvsuTAj
 EBIfsbl82NUm+uDz9QiKhsvldawVjuhhIIW3yiFCmEbQCwM5fLAwqjOU880DqrLpgV2P
 8Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=E3tqAQ40jh0sPTD1d9xIkZ9WYrXugWo7nhLWb57uF6Q=;
 b=k26svJNNAPYgqEYjy6fx+vcqnUf+yADOacrsLmIcw/Kvxk7cI8FHepiid17klxPhFJ
 JkNtnt0h4XS/duB0eFoI3z5PP41xLImIMKtXdBikkIIR38gYLJFSp4ovexWBXLmu1AOl
 YaE40j72dTE8dmGud7vWbdGiZDvPNtuNAm4Oj4ZsqaGu5oqENN6fdy1omHSbZheI7Dmh
 Ryy4ri9AG5vQ/v7RuB//bZ0pDrzFQgW7yt3xMlSztLVyiJZsd4dplKXIa8lvYCwfB/ed
 oOv4DGoWFqFmsNeqpZeqyLrarOV8mrwQ30rzfOcq3MknJKV3ZQvaHTmVGy0JML/BIV+C
 ccdA==
X-Gm-Message-State: AOAM532WMPEg6L3xesaX86fZmnMaH9y78aG4S+18vRGSNp/ho0+xWIRe
 1jd01YwY9vorZXYBcO9FLaGE0jD0agCqgg==
X-Google-Smtp-Source: ABdhPJyo8EgX7CfA3fvUTPDu9UJBCFaadXXz1uASrLT7g36HFfKeyy8WXER3GscAE4eJI2TuxMo/jw==
X-Received: by 2002:a62:4e49:: with SMTP id c70mr447626pfb.100.1599082958535; 
 Wed, 02 Sep 2020 14:42:38 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x12sm328863pjq.43.2020.09.02.14.42.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 14:42:37 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/9] tcg: Fixes dup_const link error
Date: Thu,  3 Sep 2020 05:42:05 +0800
Message-Id: <20200902214211.337-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.27.0.windows.1
In-Reply-To: <20200902214211.337-1-luoyonggang@gmail.com>
References: <20200902214211.337-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=luoyonggang@gmail.com; helo=mail-pf1-x443.google.com
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


