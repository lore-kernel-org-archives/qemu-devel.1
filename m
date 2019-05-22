Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0E9C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:30:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE9912089E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 22:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fIPiLh6h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE9912089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52502 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTZki-0004DQ-54
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 18:30:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZiv-00031a-PO
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTZir-0007M9-W2
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:35 -0400
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:40183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTZiq-0007Kd-1q
	for qemu-devel@nongnu.org; Wed, 22 May 2019 18:28:33 -0400
Received: by mail-yb1-xb43.google.com with SMTP id g62so1490373ybg.7
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=Dp2wE06ppFvr7SDc7+wjEouETDXh/6Jd86FUlkd8ziE=;
	b=fIPiLh6hCxAuH1koRb0SzwwUI/pJky6k/oG7kQyC5n9CWGBZUBZTj3hLS0kkJH0+k+
	2QcPfGDNmec2gxWbNmyh7eyH59U8RwF+zAgPeQGT3eeWLEmVtLv43AswahPT1SPBLrwz
	GwA7mrBbYxS2Mh0QY0rtsvvXIxC+OeJJCixj/DigvJSeiX35XdpbT+UKYaPk4GWD7Rtf
	XEV6aVqkYfHPZsdnaq9Y+0wg4r3ytR4zirCq2esL1KY7n0LoD1G066kCHLm1UBw537wg
	4rwr98apdk3ekolWwq7wZvSQ3FKKpNqNoKkXmeQvGm7PdhZJpBALhcLyhZvPaf0qUxC7
	bmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Dp2wE06ppFvr7SDc7+wjEouETDXh/6Jd86FUlkd8ziE=;
	b=qUY4CvIoVCJAi7fXLB5UmYvEZYP70zz6XWcoR9re07eH25Vr194B7LWa3fCzb33SS/
	fGc2N/bNvNbVMcx/snFW7rUHG7vKJ58B9tjVCryn77R01EL5ykxS97Lz9drLsx07owqh
	q7yQlhJwfUsIAhzWQP4IoywBCUAoMH/hX+Y0c+MTyo9kWi2QLTbXDCx2XO10Qj3aMTAw
	QnTgOknUxXeEAOJdTKTxoGTdAm9bmuj99sv7Uu0YFB283ZhADSkRY/tpfP95i4SgGvxj
	WVWUPVjgi5S8TZhRxgT1QVzvDC+kM/eoYDpmCrMrV+MC2k31HbXWP8TebYVSQNkF8YG8
	0vRQ==
X-Gm-Message-State: APjAAAUHuHEh6fosFysyq53+Y9z13jyp9hTn9+L9PYMiwYplUAGzdv20
	vwv/VaSAo7vDNfqlNPxJPKBCmz/g0gI=
X-Google-Smtp-Source: APXvYqzWQBPuxNNMC2A3mH0zOR6sfXEzHdvIulzZp/fQi1YXDfKbTAbcDQiNNeLWXtfVyYY1KVbdyw==
X-Received: by 2002:a25:ce8a:: with SMTP id
	x132mr11836887ybe.239.1558564110477; 
	Wed, 22 May 2019 15:28:30 -0700 (PDT)
Received: from localhost.localdomain ([71.46.56.17])
	by smtp.gmail.com with ESMTPSA id q11sm2276453ywg.7.2019.05.22.15.28.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 22 May 2019 15:28:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:28:11 -0400
Message-Id: <20190522222821.23850-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190522222821.23850-1-richard.henderson@linaro.org>
References: <20190522222821.23850-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b43
Subject: [Qemu-devel] [PULL 06/16] tcg: Expand vector minmax using cmp+cmpsel
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
Cc: peter.maydell@linaro.org
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


