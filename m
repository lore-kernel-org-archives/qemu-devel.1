Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38928C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D2B2173E
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 18:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a7crd209"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D2B2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX7vZ-0002ly-6t
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 14:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7hu-0007Dl-Lq
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:46 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:35309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX7ht-0007dG-Nt
 for qemu-devel@nongnu.org; Fri, 08 May 2020 14:26:46 -0400
Received: by mail-pf1-x430.google.com with SMTP id r14so1382883pfg.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 11:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=MsIsFqiezDMWfyTAinzx1qI+y1izKFiwu84PgQkXZ9I=;
 b=a7crd209Oap8vp4zwc7T5zRHgpkvgjsBmtDgToenz29yDt/rfaVqzuSYiX80ekMNYb
 KOyI6PTF6jn0//NppcnsmpUndvMSXuQIdL36IvjuqxODkN8ZJlMCSE+zjcUA4C9erYFC
 BxdE5eBbvKGZkixTjuTEp7hwTqrXACQIr9jRu5iiV/yk30g/inTBkE4c/urZTIYdpIXu
 eWl/xJtRKR+POIGRbDUbIj8XqKl9RKa+valkF1j1EKEdkGMgScP25JbSKcjQK+2D9Tgx
 NMjSe4MY7u4mpg6QfIpPwuZNbolvz3S0RIJ3MdhjkSK8Q8dvquEsb/7AtpSeWWZtptU+
 IZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MsIsFqiezDMWfyTAinzx1qI+y1izKFiwu84PgQkXZ9I=;
 b=Fokt1pRIVBPplXbpMdJJXgN0F3dkw/diMFX+Wy73f2RJJEQ1ADeN2Ml2rXgel56sIG
 /+Q0z7Od1zdUDYo730Y2NER+2MxD7z4xCiQQAUhssq1Wt7v+cKLnDo2ihme90YeDLl9a
 kKIRhDjJ4qHsWX0vsqN337QzD+/tO1gFNtTb23b38GiDEkkXSBqyleERwyFFea6/hPFS
 lBEu2rjHAfjm+yFL01mmipuZSV3OGvf+KfZL7woUyp71biJv4fY1PeH57aG6OCwywIN5
 zrlp/cRo2MNN7PnnUL0wTGMA82BWXaNPHdiPiKYvQf7KtWMN+mNbBtJ+A0qk8VJmR8S4
 msVQ==
X-Gm-Message-State: AGi0PuZE8DWVhlugunQ3/GB3R5qcRpvv+2V1s1RSwKqMQTnpFW9H8ap+
 NXsE3mTAMdMKHOFVkXJ1NvrhA7lAqlc=
X-Google-Smtp-Source: APiQypLCclAuQ52dGyDUK/uwQZZmaQOx9lQqYvmLnmhW5AlF15E2HQPuoR+EmFOln1cZrz6q4tnXWg==
X-Received: by 2002:aa7:8619:: with SMTP id p25mr4137439pfn.105.1588962403977; 
 Fri, 08 May 2020 11:26:43 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id u9sm2421775pfn.197.2020.05.08.11.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 11:26:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 19/19] tcg: Remove tcg_gen_dup{8,16,32,64}i_vec
Date: Fri,  8 May 2020 11:26:16 -0700
Message-Id: <20200508182616.18318-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508182616.18318-1-richard.henderson@linaro.org>
References: <20200508182616.18318-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These interfaces have been replaced by tcg_gen_dupi_vec
and tcg_constant_vec.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h |  4 ----
 tcg/tcg-op-vec.c     | 20 --------------------
 2 files changed, 24 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index b4fba35e87..d0319692ec 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -959,10 +959,6 @@ void tcg_gen_mov_vec(TCGv_vec, TCGv_vec);
 void tcg_gen_dup_i32_vec(unsigned vece, TCGv_vec, TCGv_i32);
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec, TCGv_i64);
 void tcg_gen_dup_mem_vec(unsigned vece, TCGv_vec, TCGv_ptr, tcg_target_long);
-void tcg_gen_dup8i_vec(TCGv_vec, uint32_t);
-void tcg_gen_dup16i_vec(TCGv_vec, uint32_t);
-void tcg_gen_dup32i_vec(TCGv_vec, uint32_t);
-void tcg_gen_dup64i_vec(TCGv_vec, uint64_t);
 void tcg_gen_dupi_vec(unsigned vece, TCGv_vec, uint64_t);
 void tcg_gen_add_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
 void tcg_gen_sub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b);
diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 4681d26973..9c5deafd5f 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -284,26 +284,6 @@ void tcg_gen_dupi_vec(unsigned vece, TCGv_vec dest, uint64_t val)
     tcg_gen_mov_vec(dest, tcg_constant_vec(type, vece, val));
 }
 
-void tcg_gen_dup64i_vec(TCGv_vec dest, uint64_t val)
-{
-    tcg_gen_dupi_vec(MO_64, dest, val);
-}
-
-void tcg_gen_dup32i_vec(TCGv_vec dest, uint32_t val)
-{
-    tcg_gen_dupi_vec(MO_32, dest, val);
-}
-
-void tcg_gen_dup16i_vec(TCGv_vec dest, uint32_t val)
-{
-    tcg_gen_dupi_vec(MO_16, dest, val);
-}
-
-void tcg_gen_dup8i_vec(TCGv_vec dest, uint32_t val)
-{
-    tcg_gen_dupi_vec(MO_8, dest, val);
-}
-
 void tcg_gen_dup_i64_vec(unsigned vece, TCGv_vec r, TCGv_i64 a)
 {
     TCGArg ri = tcgv_vec_arg(r);
-- 
2.20.1


