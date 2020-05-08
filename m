Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4FAC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:34:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1077021841
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zoWNiEkn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1077021841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX51I-0007PO-79
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lW-0006EC-DW
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:18 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:47098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4lS-0003Nf-UH
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:18:18 -0400
Received: by mail-pf1-x433.google.com with SMTP id 145so1058619pfw.13
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pb4mNTdVoF7AlivNCkuavLGrYz8n9Jd0hKihdmkcszE=;
 b=zoWNiEknRvdrdtUSzoYAZ4W0OskQOL8BNCfL2cnaDFPiinngBl5XGaoO28DBXVhWZO
 CZKkXaOV70acYwUWGVi+uAfhnRJnRH7WME12CK4TYOgfWKBApF6g1ON8K1F49TEwUHFn
 XM9Kp+wvoAj7sLbTl5uS/kyZIZYkGoPIoltHQ4rreIW3n43425bw3mUcp0VJDr0/fTub
 rrnEut/IgFETJFbcnkEHPGGsdUqcANV2naS2djhfpIRM/Lleh7BeCxF4doYtuVc3DTJN
 WodV0mYyNNMyVVrTp5JNJ5TgiFDJdc0K6SjZ1UXlaBOAs5LTEh9nMllyShqimcLJkWes
 H+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pb4mNTdVoF7AlivNCkuavLGrYz8n9Jd0hKihdmkcszE=;
 b=DMbl8ecTIm55AMxtITL/jmN7BSCMd3Ppukppn8PNwwSZnDRJLO2rZJlZZI7ZHRvny8
 VM3D8EU30buushLX24IkxiK/BEqx/EchPUIfvOvnJ9DNvQMtKQBvYbbgmuHOlFtEIBGL
 VqjLEonVTYy9atHieDIloBvJyQsFpHEcN10w6tjHVzN5JsHHMHc1J3loelf/okJitWKh
 8iFY69Hk8NazlhakWb7HgiLyYSD25F81RCoyWjIaJUM2282ZW/m0F020xQi29zUEGiny
 sv25E3UOvQEGvUarAJjcAxoqxCzMBQR/Wfb8hJgQt9D8J29tsRpP43TxQhtU15XgVh23
 kRGA==
X-Gm-Message-State: AGi0PubQN+BPZ9JTx2Knq5EpgdTP2F12rd3c+q62kofyIK0V28D7p4en
 ppM1K79sZ6OF8RYFBHbVuJcVx9aFVRc=
X-Google-Smtp-Source: APiQypLEWeobuhjuP7j1JznKl5W86NfhDBnjptm2aEeqx29ed16O5Gcc0F7hMj8qkIISwllwCPV9jA==
X-Received: by 2002:a63:7801:: with SMTP id t1mr2443217pgc.192.1588951092681; 
 Fri, 08 May 2020 08:18:12 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id b5sm2125933pfb.190.2020.05.08.08.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:18:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/19] tcg: Remove tcg_gen_dup{8,16,32,64}i_vec
Date: Fri,  8 May 2020 08:17:47 -0700
Message-Id: <20200508151747.6166-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151747.6166-1-richard.henderson@linaro.org>
References: <20200508151747.6166-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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


