Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E791C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:10:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 043A52086A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 06:10:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqlRZCs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 043A52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40008 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQQe1-0002TV-3z
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 02:10:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQQcw-0001re-33
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:09:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQQcv-000722-6A
	for qemu-devel@nongnu.org; Tue, 14 May 2019 02:09:26 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532]:38012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQKxA-00035d-QN
	for qemu-devel@nongnu.org; Mon, 13 May 2019 20:05:58 -0400
Received: by mail-pg1-x532.google.com with SMTP id j26so7597823pgl.5
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jMr4oVpt08WI1vYqrX0gvWFc/UY/0FSsdcwMQYw/C7U=;
	b=qqlRZCs7JRToB5ZfRsgr96EGQPqxfTfXeXuyOuXqL+hxuTEch6+KRMPYH32OY2r12d
	z7hNC35yW28DBFczbreaGOrMKBSLpVDAuGex6Sts3FdLIqATvg1R/Ob6iztzUvCMxDGW
	4u+pTEEYcMDl++yMcNj/cfB38ObrlX6EnuzVIp4DdEvzI7GYtxkuVWbW0DuD6jxK7kVN
	AzO5gRf+85yzLlODaPnt7JkcyvPbYykg+YLS4zZs99bL3ZnHg6Kx8ZlAM0+DCs98Jkxp
	GsVAF8rTBtzSw4FTGjayUBeenf+UWDHSYNu4Cvh4XHUI++9Pj5z397P7bA/8bSn8s0LV
	lzFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=jMr4oVpt08WI1vYqrX0gvWFc/UY/0FSsdcwMQYw/C7U=;
	b=i7BQ0npdekWukyNtuiSe/e5EBbP4jgg/lYk5sk9du9tsqOz+x3c8kfdEIJPI92nf7i
	Rcmlk+VBBHQISNcAX9asIwwrJ9IAGgQ9pNUCp66/9kl2FdW7oWbuD/HQBy/8xHdLZda3
	xW7IcQtq3a9OdOPDnqFTSffTMWbWeUn3jbTAPEcHgBi4M0mFyGg7ALeuaqpjh2wL+BZj
	i6jZfllePNYeLzWFU0IQK9kAozpMkV3GqgQxIzsawNQxXhfj8BdIEN/spjI97VOz0GiC
	04TbkZGV+FN4N3jdtnho11gApCqeqXWS2x5k5XaAMxUilzpluIk6PPYnKpMzxE6qyNSo
	71Zg==
X-Gm-Message-State: APjAAAX2aDadAXQhLiErK+uwQ4Gzv82t/AjLu3qGzztt0dnQeZD3ajgf
	ZpG8XHsAkKpTvbfKGPpTiDfT+WLgkXE=
X-Google-Smtp-Source: APXvYqxR2SakVOJ9wcAmsLSEZS1PNvQbBuf2apjdtKWvdkHjiCeCSmWLG5J+9xpKrV0Kzztn85wH9g==
X-Received: by 2002:a62:5cc6:: with SMTP id q189mr6419457pfb.114.1557792354415;
	Mon, 13 May 2019 17:05:54 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231])
	by smtp.gmail.com with ESMTPSA id u3sm238151pfn.29.2019.05.13.17.05.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 13 May 2019 17:05:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon, 13 May 2019 17:05:17 -0700
Message-Id: <20190514000540.4313-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514000540.4313-1-richard.henderson@linaro.org>
References: <20190514000540.4313-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::532
Subject: [Qemu-devel] [PULL 08/31] tcg: Support cross-class moves without
 instruction support
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
Cc: peter.maydell@linux.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PowerPC Altivec does not support direct moves between vector registers
and general registers.  So when tcg_out_mov fails, we can use the
backing memory for the temporary to perform the move.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 8ed7cb8654..68d86361e2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3368,7 +3368,20 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
                                          ots->indirect_base);
             }
             if (!tcg_out_mov(s, otype, ots->reg, ts->reg)) {
-                abort();
+                /*
+                 * Cross register class move not supported.
+                 * Store the source register into the destination slot
+                 * and leave the destination temp as TEMP_VAL_MEM.
+                 */
+                assert(!ots->fixed_reg);
+                if (!ts->mem_allocated) {
+                    temp_allocate_frame(s, ots);
+                }
+                tcg_out_st(s, ts->type, ts->reg,
+                           ots->mem_base->reg, ots->mem_offset);
+                ots->mem_coherent = 1;
+                temp_free_or_dead(s, ots, -1);
+                return;
             }
         }
         ots->val_type = TEMP_VAL_REG;
@@ -3470,7 +3483,13 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             reg = tcg_reg_alloc(s, arg_ct->u.regs, i_allocated_regs,
                                 o_preferred_regs, ts->indirect_base);
             if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
-                abort();
+                /*
+                 * Cross register class move not supported.  Sync the
+                 * temp back to its slot and load from there.
+                 */
+                temp_sync(s, ts, i_allocated_regs, 0, 0);
+                tcg_out_ld(s, ts->type, reg,
+                           ts->mem_base->reg, ts->mem_offset);
             }
         }
         new_args[i] = reg;
@@ -3631,7 +3650,13 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
                 if (ts->reg != reg) {
                     tcg_reg_free(s, reg, allocated_regs);
                     if (!tcg_out_mov(s, ts->type, reg, ts->reg)) {
-                        abort();
+                        /*
+                         * Cross register class move not supported.  Sync the
+                         * temp back to its slot and load from there.
+                         */
+                        temp_sync(s, ts, allocated_regs, 0, 0);
+                        tcg_out_ld(s, ts->type, reg,
+                                   ts->mem_base->reg, ts->mem_offset);
                     }
                 }
             } else {
-- 
2.17.1


