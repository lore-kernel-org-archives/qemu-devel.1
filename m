Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C08C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:47:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0402208B3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQ6sTO8B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0402208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCs3-0005l5-Uk
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:47:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57810)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ8-0002n5-QB; Tue, 16 Jun 2020 10:18:37 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:37871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCQ6-0006p3-5Z; Tue, 16 Jun 2020 10:18:36 -0400
Received: by mail-oi1-x244.google.com with SMTP id a3so19411717oid.4;
 Tue, 16 Jun 2020 07:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JwnlDNPbrLcvfJMKjMv3fUQyb6M3rRDS3gPnPd6DoeI=;
 b=DQ6sTO8BmJxCdDff6CoXV8iE76R/p6LqXYLhi7td3vcF8xHszO8WGtLmEu1Gc+8eLA
 MFi7Euax6CM1oyw1drQc3GFy2RMzLYYxeEyB6aSfRq9m1n9ohnSoRS0NHr9UNYHkI4oV
 +mXlKy1e4V5EkKlFqyrbZ2lvHjdzXLt+JcZPFLvhYw0BBYWlyeAXaHth8D06oJHN5/bH
 7GPrvEAOHLopp3SO2z2P5tpKsG+AKO8njIXAyZyxaRibtqIplYiq7O6goWcjT9TwpfYB
 6ix2K6U7nemQmD9U/DYF5sTKsN/T2b9/ziCI2wwsWWyZoFAAQo76y3XTdFcKteqx4asT
 SMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=JwnlDNPbrLcvfJMKjMv3fUQyb6M3rRDS3gPnPd6DoeI=;
 b=lA821lgJg4v9hAVN1O4bLaz5HJgW8XayBcnxUOCkbDSY2axgS+UtXEjaVF92fJ0xVJ
 eJMPCb2gzEXzVkBdNHNq2okOHR+xnGjL6cbwv86iiSF9Sgx2KG4lSRKtHOnf2gEKVs0s
 60ylh6x7rug3IX5H8uVu54mw1bRH3niUiNxbXHRkUlKQ52jtR3aeZuuR697qiBSSpncN
 80FUx7s0CWb5Ij3h1MqFoJU0/6GeSYV8fWsJFHNUVAWO7uL3K5QF9vQtyTmJ7Ax385XK
 zZWp40koroZMUzH2iB5KmQhbyYizgUvi61Y1K/IqhAIzKxtoi3Fs1vYywiOC67oyiCKr
 Fh9A==
X-Gm-Message-State: AOAM531Lg85tbYtc2tSv4z5Eq0nkD5kZVKx0tCIRLsC4RVcSy5wOhWHH
 JsR18U/jfQBZhaecumRmBdnqv8XA
X-Google-Smtp-Source: ABdhPJzaiHmMLm2W4XQ9jtgG7t3fD8V8IH+SmzE3kRXKRUuGbtzp3Oagqm3c0BPOQc08QEwvvIygLQ==
X-Received: by 2002:a54:4718:: with SMTP id k24mr3241700oik.133.1592317112536; 
 Tue, 16 Jun 2020 07:18:32 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id w10sm4087452otp.44.2020.06.16.07.18.31
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:31 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 43/78] tcg: save vaddr temp for plugin usage
Date: Tue, 16 Jun 2020 09:15:12 -0500
Message-Id: <20200616141547.24664-44-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alex Bennée <alex.bennee@linaro.org>

While do_gen_mem_cb does copy (via extu_tl_i64) vaddr into a new temp
this won't help if the vaddr temp gets clobbered by the actual
load/store op. To avoid this clobbering we explicitly copy vaddr
before the op to ensure it is live my the time we do the
instrumentation.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Cc: qemu-stable@nongnu.org
Message-Id: <20200225124710.14152-18-alex.bennee@linaro.org>
(cherry picked from commit fcc54ab5c7ca84ae72e8bf3781c33c9193a911aa)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 tcg/tcg-op.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c245126f98..eb5d172e49 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -2794,13 +2794,26 @@ static void tcg_gen_req_mo(TCGBar type)
     }
 }
 
+static inline TCGv plugin_prep_mem_callbacks(TCGv vaddr)
+{
+#ifdef CONFIG_PLUGIN
+    if (tcg_ctx->plugin_insn != NULL) {
+        /* Save a copy of the vaddr for use after a load.  */
+        TCGv temp = tcg_temp_new();
+        tcg_gen_mov_tl(temp, vaddr);
+        return temp;
+    }
+#endif
+    return vaddr;
+}
+
 static inline void plugin_gen_mem_callbacks(TCGv vaddr, uint16_t info)
 {
 #ifdef CONFIG_PLUGIN
-    if (tcg_ctx->plugin_insn == NULL) {
-        return;
+    if (tcg_ctx->plugin_insn != NULL) {
+        plugin_gen_empty_mem_callback(vaddr, info);
+        tcg_temp_free(vaddr);
     }
-    plugin_gen_empty_mem_callback(vaddr, info);
 #endif
 }
 
@@ -2822,6 +2835,7 @@ void tcg_gen_qemu_ld_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
         }
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i32(INDEX_op_qemu_ld_i32, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
@@ -2868,6 +2882,7 @@ void tcg_gen_qemu_st_i32(TCGv_i32 val, TCGv addr, TCGArg idx, MemOp memop)
         memop &= ~MO_BSWAP;
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i32(INDEX_op_qemu_st_i32, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
@@ -2905,6 +2920,7 @@ void tcg_gen_qemu_ld_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
         }
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i64(INDEX_op_qemu_ld_i64, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
@@ -2967,6 +2983,7 @@ void tcg_gen_qemu_st_i64(TCGv_i64 val, TCGv addr, TCGArg idx, MemOp memop)
         memop &= ~MO_BSWAP;
     }
 
+    addr = plugin_prep_mem_callbacks(addr);
     gen_ldst_i64(INDEX_op_qemu_st_i64, val, addr, memop, idx);
     plugin_gen_mem_callbacks(addr, info);
 
-- 
2.17.1


