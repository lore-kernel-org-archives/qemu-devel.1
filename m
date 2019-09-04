Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244A8C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E383A21883
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PC6P+R2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E383A21883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bTy-0003xh-QB
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40453)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0K-0004u8-AC
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b0H-0002aI-F2
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:44 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b0H-0002ZU-4K
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:31:41 -0400
Received: by mail-pf1-x443.google.com with SMTP id y9so13910790pfl.4
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=aOeT7JW4syMFoke9pOSfcUTMmUalFkDrt8zliWzFSBI=;
 b=PC6P+R2ZIPGunwlvD2YZXGgZJOQ06RN/RE+cazziFhPqltlTlTHhEBUn1au/EFJ66N
 rM3GuU10yZlTqBGrGqxvOnRrbAlPrJcg3WscIfqDvXTm5QNyroTBJ5J2P7UL6hSR12zY
 Ast5tqsMYeXVrXC727LXHyi58efXyYV86n9seuxEajOJXQ1i/eOruSIspq7fJUbr9dtK
 lyuRKeSOgIoRs62B+vaapzDgyId1v2kh/UX2LgubKTvudTyosqcqJpmF5r57PRN2HLqh
 4+ScQuJ6KRksTDqOb/GeI88pizOyAA3AYWhB3MGmubZOIXB5BMKjATees9YbYKy1D3wq
 noTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=aOeT7JW4syMFoke9pOSfcUTMmUalFkDrt8zliWzFSBI=;
 b=pNE6w6CowiE7q5imAFCsLywZtL2MZmnfXRr2x3l24udVtv2c3KdHov1r/hfyt0mEYr
 XCrzrhuCInqaxTfyXPL+COcpSt+7nEaVOdwamFBN9IHuF12vi+rW6mhJKsnLLyhPMtdZ
 6bQpuHVUKbtDlm/MhvPQ8wDxM/fHTG2zwWdcnFmCUrw5eXWFwXFwTA/fycyIEDKfZBIK
 oFIi44Ti5Zs7+b4sPDLJcL3R3bFW1RljZeiA7kMPTlTAy2N4xyO0Y1JRabADqapPRBm/
 Ph7ez31UDGqZp7phjuft6jiwf6Vk9zJU+GwoVdr9UJN7xieLGhaiT9gCpTMvZFi3O/qb
 csbw==
X-Gm-Message-State: APjAAAWF5Um4Sdf/GvZPHiPCe/0uvoVRnZY8/Ia8KUc5QZz85VXVWrHk
 +qXjFl5D5DzBmZaB/cDpHnPKHkvBBkQ=
X-Google-Smtp-Source: APXvYqxMls52XxXZlM05hnIB2WIpnp+BFSyg4bKNPOLazo/V9w00WzQ8G3tkYHRXL8OsBILTzXVwRw==
X-Received: by 2002:a17:90a:fd8c:: with SMTP id
 cx12mr6705903pjb.95.1567625499743; 
 Wed, 04 Sep 2019 12:31:39 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:31:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:20 -0700
Message-Id: <20190904193059.26202-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v4 30/69] target/arm: Diagnose too few
 registers in list for LDM/STM
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This has been a TODO item for quite a while.  The minimum bit
count for A32 and T16 is 1, and for T32 is 2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index b67e7389d3..b623dbcd48 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -9846,7 +9846,7 @@ static void op_addr_block_post(DisasContext *s, arg_ldst_block *a,
     }
 }
 
-static bool op_stm(DisasContext *s, arg_ldst_block *a)
+static bool op_stm(DisasContext *s, arg_ldst_block *a, int min_n)
 {
     int i, j, n, list, mem_idx;
     bool user = a->u;
@@ -9863,7 +9863,10 @@ static bool op_stm(DisasContext *s, arg_ldst_block *a)
 
     list = a->list;
     n = ctpop16(list);
-    /* TODO: test invalid n == 0 case */
+    if (n < min_n) {
+        unallocated_encoding(s);
+        return true;
+    }
 
     addr = op_addr_block_pre(s, a, n);
     mem_idx = get_mem_index(s);
@@ -9896,7 +9899,8 @@ static bool op_stm(DisasContext *s, arg_ldst_block *a)
 
 static bool trans_STM(DisasContext *s, arg_ldst_block *a)
 {
-    return op_stm(s, a);
+    /* BitCount(list) < 1 is UNPREDICTABLE */
+    return op_stm(s, a, 1);
 }
 
 static bool trans_STM_t32(DisasContext *s, arg_ldst_block *a)
@@ -9906,10 +9910,11 @@ static bool trans_STM_t32(DisasContext *s, arg_ldst_block *a)
         unallocated_encoding(s);
         return true;
     }
-    return op_stm(s, a);
+    /* BitCount(list) < 2 is UNPREDICTABLE */
+    return op_stm(s, a, 2);
 }
 
-static bool do_ldm(DisasContext *s, arg_ldst_block *a)
+static bool do_ldm(DisasContext *s, arg_ldst_block *a, int min_n)
 {
     int i, j, n, list, mem_idx;
     bool loaded_base;
@@ -9938,7 +9943,10 @@ static bool do_ldm(DisasContext *s, arg_ldst_block *a)
 
     list = a->list;
     n = ctpop16(list);
-    /* TODO: test invalid n == 0 case */
+    if (n < min_n) {
+        unallocated_encoding(s);
+        return true;
+    }
 
     addr = op_addr_block_pre(s, a, n);
     mem_idx = get_mem_index(s);
@@ -10006,7 +10014,8 @@ static bool trans_LDM_a32(DisasContext *s, arg_ldst_block *a)
         unallocated_encoding(s);
         return true;
     }
-    return do_ldm(s, a);
+    /* BitCount(list) < 1 is UNPREDICTABLE */
+    return do_ldm(s, a, 1);
 }
 
 static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
@@ -10016,7 +10025,8 @@ static bool trans_LDM_t32(DisasContext *s, arg_ldst_block *a)
         unallocated_encoding(s);
         return true;
     }
-    return do_ldm(s, a);
+    /* BitCount(list) < 2 is UNPREDICTABLE */
+    return do_ldm(s, a, 2);
 }
 
 /*
-- 
2.17.1


