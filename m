Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87030C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:09:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594FA20873
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 19:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nv8tgCKE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594FA20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37619 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS4iB-0006tU-GT
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 15:09:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4dQ-0002lS-Ja
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS4aw-0002dW-2E
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:11 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS4av-0002d6-PR
	for qemu-devel@nongnu.org; Sat, 18 May 2019 15:02:10 -0400
Received: by mail-pf1-x444.google.com with SMTP id z26so5254362pfg.6
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 12:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=Dp2wE06ppFvr7SDc7+wjEouETDXh/6Jd86FUlkd8ziE=;
	b=Nv8tgCKEQwfqnpVeDr/mOFgdZIrwTTm0x6+1Xh722DfqBMm8Ret9tLRopYz0AtyqCm
	OXrhAXUremVVi2bTpXmmlI1ZtFN/ZIWu+IDF5OFe+kZs3MyCQAIJT7W4Fh/DF2pAwyjH
	0IxEy1bGn+li9hUklTdvXoTheFgugsYC/1P40zsHIFvwmYN4HxzdospZeidVANAJ6eEO
	GFkPEOQBp/RliGa1amqjp48qR4ParxP2JGdm6IPSa7nH72gSpfvNiW0ZWCnNpXFJWqAZ
	K66L9iqbF26IvlsA7Av3w1GIXYJ8QCLLlrr6G6tw9jKcRqyVcsR/e5OnPiDrrBErqyyb
	YoCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=Dp2wE06ppFvr7SDc7+wjEouETDXh/6Jd86FUlkd8ziE=;
	b=QgjIrAGQYb262g16/sZZC4wUMmUKC7HnqSYLzrGGlYDzN1XmCTBEilXKneH6N6VBAk
	cX3FrOg6PMQ7WaLOQl1UfrytQ1DmbHvvYZzXLeaz7EYKExuDJmYhCaIzdW3Bp4LRqliU
	vpKTq5utAV7Al2jIXC5mJEOVFekpKelUFw1u3+ejhmO9pUKzBTxbRkwjHY5OpYaJg4cP
	hJr8NLd/LXAllt3IR6rkW/L0a9EQ0zeWXFfew4OtM4oNr9vNWoq0M9sXzephx73jRQbi
	07bL2T9QqResKoqTZngUlWvG91HIM3XC6/2whyPUMt6EGbgolp46ahODwCXuDE+lQe/h
	+8rw==
X-Gm-Message-State: APjAAAUnqFMvnqEaK8KNLkyGe6iww6VnmCmgHvEFhjMQVYc62tVW0u6w
	YL09IO9Uss+YKI88GiuNzuvzQUdA+T8=
X-Google-Smtp-Source: APXvYqzr5OCTom3DTNmQpBGsKVoDLRYser03zrPph7KMiOuborGbVHdNtqaU5BA4AZLApkYlaQsfPg==
X-Received: by 2002:aa7:8008:: with SMTP id j8mr69359424pfi.120.1558206128483; 
	Sat, 18 May 2019 12:02:08 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id m9sm2751274pgd.23.2019.05.18.12.02.07
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 12:02:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Sat, 18 May 2019 12:01:47 -0700
Message-Id: <20190518190157.21255-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518190157.21255-1-richard.henderson@linaro.org>
References: <20190518190157.21255-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 06/16] tcg: Expand vector minmax using
 cmp+cmpsel
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Provide a generic fallback for the min/max operations.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-vec.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
index 004a34935b..501d9630a2 100644
--- a/tcg/tcg-op-vec.c
+++ b/tcg/tcg-op-vec.c
@@ -120,6 +120,10 @@ bool tcg_can_emit_vecop_list(const TCGOpcode *list,
             }
             break;
         case INDEX_op_cmpsel_vec:
+        case INDEX_op_smin_vec:
+        case INDEX_op_smax_vec:
+        case INDEX_op_umin_vec:
+        case INDEX_op_umax_vec:
             if (tcg_can_emit_vec_op(INDEX_op_cmp_vec, type, vece)) {
                 continue;
             }
@@ -632,24 +636,32 @@ void tcg_gen_ussub_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
     do_op3_nofail(vece, r, a, b, INDEX_op_ussub_vec);
 }
 
+static void do_minmax(unsigned vece, TCGv_vec r, TCGv_vec a,
+                      TCGv_vec b, TCGOpcode opc, TCGCond cond)
+{
+    if (!do_op3(vece, r, a, b, opc)) {
+        tcg_gen_cmpsel_vec(cond, vece, r, a, b, a, b);
+    }
+}
+
 void tcg_gen_smin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_smin_vec);
+    do_minmax(vece, r, a, b, INDEX_op_smin_vec, TCG_COND_LT);
 }
 
 void tcg_gen_umin_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_umin_vec);
+    do_minmax(vece, r, a, b, INDEX_op_umin_vec, TCG_COND_LTU);
 }
 
 void tcg_gen_smax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_smax_vec);
+    do_minmax(vece, r, a, b, INDEX_op_smax_vec, TCG_COND_GT);
 }
 
 void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
 {
-    do_op3_nofail(vece, r, a, b, INDEX_op_umax_vec);
+    do_minmax(vece, r, a, b, INDEX_op_umax_vec, TCG_COND_GTU);
 }
 
 void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
-- 
2.17.1


