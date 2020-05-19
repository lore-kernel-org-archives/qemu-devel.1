Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A38CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:25:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 363F220758
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 21:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4zghGbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 363F220758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb9kM-0007SG-Bq
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 17:25:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb9jP-0006WA-L4
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:24:59 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:37017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb9jO-0005xJ-Su
 for qemu-devel@nongnu.org; Tue, 19 May 2020 17:24:59 -0400
Received: by mail-pl1-x643.google.com with SMTP id x10so412151plr.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vNnf1Z3O76puR4Ng9rbHBmplMSYxwbl0e181XAAkbmE=;
 b=w4zghGbGyjPOLHDyHbDHmfRFZ4udpfJBVcKwZlFeaBE5lW22Y3rmeY293oB3IW0OyC
 CNnyrxsAEk3T0gHIEdUmNfh/seD4OKegY18n+be1uLo9PzlgYMsElhf/3ftSMxCWb975
 MTVJCxH4puoWq3wrS02eEBD7FxgI0dkp/m1Et8ApjwDQdk0U/PzxN1EqRD3U3X8zU/jF
 0+w1DLVloJNFSsU7ybWa4KNPX80xY/HdP3owfQIkWrspnTmrqZqchwtnXLBjwxWiJOj7
 fcJ6tg7RquYnMkAAgqFv45bJWto9i377ARGd4xVkwjdCAUu0mS0J7SnYXqcUPRMtzE0/
 j1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vNnf1Z3O76puR4Ng9rbHBmplMSYxwbl0e181XAAkbmE=;
 b=JrX4kD3qI2Fmip8kBrNWNpGUES3giNlAEyHGylL8DuGSxJeGfAHZBTSMJCuanSZv5K
 6iYUzvRmBb8Ked8V8BmOUv9v1dqpgO84pBAU5Wmjt5om0neq6+EetTp8PNrrcQNFk0Z0
 Y9CmNEr5yrempteuaFc8lkDoCemSmU/vXbeSbxU4UrGUY94vucvOEgj2daDV15auOKWF
 1jJmf2lxz/KAIzgRDfHIdTSLk78KDCSaoYMMJ3iEu2yuI7P4K9819jJKBXZciij9UgRd
 NMZcJfKO0rYeXMg7iadFQ+SYjoOBhdEvVcfnW2PU5vY7tUWqedrkMHjgUz266tFQhixO
 S/ow==
X-Gm-Message-State: AOAM533kBBheVfh/kaodbWnrP00l1XkNm1GNPec3wOU8DDDvi2D7RRUA
 a6sCgn2jSVwOrFuTsMStKccMC3TsBd0=
X-Google-Smtp-Source: ABdhPJxNlg0MfPtwiKx+o+Lt1GRmW+Be/Xbz087KKrKX34hHjC3cB5/5hA9gd/psHc/6QbItCIf91Q==
X-Received: by 2002:a17:90a:5ae6:: with SMTP id
 n93mr1616598pji.159.1589923496961; 
 Tue, 19 May 2020 14:24:56 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id v5sm386134pjy.4.2020.05.19.14.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2020 14:24:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] target/arm: Use tcg_gen_gvec_mov for clear_vec_high
Date: Tue, 19 May 2020 14:24:52 -0700
Message-Id: <20200519212453.28494-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200519212453.28494-1-richard.henderson@linaro.org>
References: <20200519212453.28494-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 8-byte store for the end a !is_q operation can be
merged with the other stores.  Use a no-op vector move
to trigger the expand_clr portion of tcg_gen_gvec_mov.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 991e451644..4f6edb2892 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -496,14 +496,8 @@ static void clear_vec_high(DisasContext *s, bool is_q, int rd)
     unsigned ofs = fp_reg_offset(s, rd, MO_64);
     unsigned vsz = vec_full_reg_size(s);
 
-    if (!is_q) {
-        TCGv_i64 tcg_zero = tcg_const_i64(0);
-        tcg_gen_st_i64(tcg_zero, cpu_env, ofs + 8);
-        tcg_temp_free_i64(tcg_zero);
-    }
-    if (vsz > 16) {
-        tcg_gen_gvec_dup_imm(MO_64, ofs + 16, vsz - 16, vsz - 16, 0);
-    }
+    /* Nop move, with side effect of clearing the tail. */
+    tcg_gen_gvec_mov(MO_64, ofs, ofs, is_q ? 16 : 8, vsz);
 }
 
 void write_fp_dreg(DisasContext *s, int reg, TCGv_i64 v)
-- 
2.20.1


