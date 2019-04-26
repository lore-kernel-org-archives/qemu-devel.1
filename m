Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B4EC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 393712146E
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 17:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S8cewnN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393712146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49931 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK4cC-0001Hf-C1
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 13:26:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aK-0008OG-MF
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hK4aJ-0006Ab-Bu
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:28 -0400
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b]:40737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hK4aJ-00068h-1n
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 13:24:27 -0400
Received: by mail-pg1-x52b.google.com with SMTP id d31so1929460pgl.7
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 10:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=ttC6fl6fwWNP1yc7/CG0jAts66wPZDS8qpyi15deS9k=;
	b=S8cewnN1aH16vqnqdoeeU3kRenXtU02RlOrVXpN2fChpnGBu7Bz+wUu205hgC4jxKE
	1aB1mKoWzPaysPiYl2dw7yZtGs1dfpkBmi9ZQ1tyuK8NKUMUI+eXkN0js/OqtPIZsdMm
	MIIHu53fjqR5qcVx/+0UJJVdH7EthAIq1dfOmwdd+zn6bDpf4B5H2ssPY6yy52Z1NBUD
	tiGyY8KRKCcDS/vKPyJzcQXQlAB41cMQcDHxGR10A6X6yXh6OjFVhOeAmSgP6FrUOf4h
	8ud2GKHXzWYCNfKoV6TWMMD2h2eKTisAlkzQWAPBbTmWp7Rx3rxEaDgKaYEnd+BMDSYY
	GxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=ttC6fl6fwWNP1yc7/CG0jAts66wPZDS8qpyi15deS9k=;
	b=GKsnKdX54zZbX1oFRRZimgyHICkTEM6/uEoNVNVbl3/QE5E1aPSe7I7vWDO4divKd8
	5KVKUIntOGwDpKZmY9Ov3HoCnKDS8j8XorKPm2m45Gg8Sm4jmrh9MaOrzuzMH/nLXQQN
	OkHXDh6lb47G8lZ/wnRvja4u62AheG9678DuzP6D6uWqSDDaGYKF844xXN8awM3Euz0/
	XpJLv6ad/G+u9HmxxY7QGE23bPcMSolvYmd28saThJoiU1CWiJocb1DTQ9uSXYc2Zh7F
	AHy46LhvQkov3BXKM3m11irtyvLv2ayMQ1H9oUS2iC1LKMx3WC7pCfpcJgUqodxmxyeR
	uQ/w==
X-Gm-Message-State: APjAAAXHL6F9XBym2Yu9KCYZee+UVgpxA2xHfeLZAf/EhOhbCMoySaDw
	42gLGlHyy7VuDFbfbTZSahJfgowfS7E=
X-Google-Smtp-Source: APXvYqyf0qQem+4VWTzykxblVHHRJehgl6VT+6WjUd3j5wB0h+ceBheRFfH6taOPHAaIy8oH4mdvpQ==
X-Received: by 2002:a63:6849:: with SMTP id d70mr43407174pgc.21.1556299464851; 
	Fri, 26 Apr 2019 10:24:24 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	j5sm7901762pfg.186.2019.04.26.10.24.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 10:24:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Apr 2019 10:24:07 -0700
Message-Id: <20190426172421.27133-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190426172421.27133-1-richard.henderson@linaro.org>
References: <20190426172421.27133-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52b
Subject: [Qemu-devel] [PULL 01/15] tcg: Implement tcg_gen_extract2_{i32, i64}
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426172407.mx9hty54HZMolxk_kDCBYAjcLvn3GYX_eXm0CJ087A4@z>

From: David Hildenbrand <david@redhat.com>

Will be helpful for s390x. Input 128 bit and output 64 bit only,
which is sufficient for now.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190225154204.26751-1-david@redhat.com>
[rth: Add matching tcg_gen_extract2_i32.]
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h |  6 ++++++
 tcg/tcg-op.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index d3e51b15af..1f1824c30a 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -308,6 +308,8 @@ void tcg_gen_extract_i32(TCGv_i32 ret, TCGv_i32 arg,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
+void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
+                          unsigned int ofs);
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *);
 void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
@@ -501,6 +503,8 @@ void tcg_gen_extract_i64(TCGv_i64 ret, TCGv_i64 arg,
                          unsigned int ofs, unsigned int len);
 void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
+void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
+                          unsigned int ofs);
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *);
 void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
@@ -1068,6 +1072,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_deposit_z_tl tcg_gen_deposit_z_i64
 #define tcg_gen_extract_tl tcg_gen_extract_i64
 #define tcg_gen_sextract_tl tcg_gen_sextract_i64
+#define tcg_gen_extract2_tl tcg_gen_extract2_i64
 #define tcg_const_tl tcg_const_i64
 #define tcg_const_local_tl tcg_const_local_i64
 #define tcg_gen_movcond_tl tcg_gen_movcond_i64
@@ -1178,6 +1183,7 @@ void tcg_gen_stl_vec(TCGv_vec r, TCGv_ptr base, TCGArg offset, TCGType t);
 #define tcg_gen_deposit_z_tl tcg_gen_deposit_z_i32
 #define tcg_gen_extract_tl tcg_gen_extract_i32
 #define tcg_gen_sextract_tl tcg_gen_sextract_i32
+#define tcg_gen_extract2_tl tcg_gen_extract2_i32
 #define tcg_const_tl tcg_const_i32
 #define tcg_const_local_tl tcg_const_local_i32
 #define tcg_gen_movcond_tl tcg_gen_movcond_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1bd7ef24af..7c56c92c8e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -809,6 +809,28 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
     tcg_gen_sari_i32(ret, ret, 32 - len);
 }
 
+/*
+ * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
+ * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
+ */
+void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
+                          unsigned int ofs)
+{
+    tcg_debug_assert(ofs <= 32);
+    if (ofs == 0) {
+        tcg_gen_mov_i32(ret, al);
+    } else if (ofs == 32) {
+        tcg_gen_mov_i32(ret, ah);
+    } else if (al == ah) {
+        tcg_gen_rotri_i32(ret, al, ofs);
+    } else {
+        TCGv_i32 t0 = tcg_temp_new_i32();
+        tcg_gen_shri_i32(t0, al, ofs);
+        tcg_gen_deposit_i32(ret, t0, ah, 32 - ofs, ofs);
+        tcg_temp_free_i32(t0);
+    }
+}
+
 void tcg_gen_movcond_i32(TCGCond cond, TCGv_i32 ret, TCGv_i32 c1,
                          TCGv_i32 c2, TCGv_i32 v1, TCGv_i32 v2)
 {
@@ -2297,6 +2319,28 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
     tcg_gen_sari_i64(ret, ret, 64 - len);
 }
 
+/*
+ * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
+ * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
+ */
+void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
+                          unsigned int ofs)
+{
+    tcg_debug_assert(ofs <= 64);
+    if (ofs == 0) {
+        tcg_gen_mov_i64(ret, al);
+    } else if (ofs == 64) {
+        tcg_gen_mov_i64(ret, ah);
+    } else if (al == ah) {
+        tcg_gen_rotri_i64(ret, al, ofs);
+    } else {
+        TCGv_i64 t0 = tcg_temp_new_i64();
+        tcg_gen_shri_i64(t0, al, ofs);
+        tcg_gen_deposit_i64(ret, t0, ah, 64 - ofs, ofs);
+        tcg_temp_free_i64(t0);
+    }
+}
+
 void tcg_gen_movcond_i64(TCGCond cond, TCGv_i64 ret, TCGv_i64 c1,
                          TCGv_i64 c2, TCGv_i64 v1, TCGv_i64 v2)
 {
-- 
2.17.1


