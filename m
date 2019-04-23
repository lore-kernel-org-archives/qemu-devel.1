Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54609C282DD
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBAA2175B
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 15:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPpjm/wD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBAA2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55591 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIxZv-0004hb-9o
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 11:43:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVf-00019T-Se
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hIxVe-0006xb-Sj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:03 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hIxVe-0006x7-Mg
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 11:39:02 -0400
Received: by mail-pg1-x542.google.com with SMTP id g8so7813247pgf.2
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=SJOqjegP+m673OZYoqgV5dWxHoBCuzthxG6rISUB5Lg=;
	b=RPpjm/wD0KiSqAmeZRidiNQ2unSolGymuPUL2cu5ZhSf3IC2frP4SRK/K28ZUEpaDk
	cUXpM9e6nyjpgmn8CI2GNV4Uvm3fY8xSUJ/HcA/8kvxYJy4+0oh/p9qtNHwlbXW2EZX/
	VmOEIwSXFsIn0sn0okF+unf2CihX0Boq/u/nRF2BUUDAzRvt1OmGVmXZOG41PdtdvOZL
	9GH0X66Jmmy2RLF7tCdsC1G/aJojJIVapiBX3yl1FalfcaufBzatfU6eLlqnhVvCL2Go
	zdy4qwjol4trb433/cZuO9TVXQ8aWVxViLjBQS77lZZMgohjbaqvlNqe3j1yKfb3dQzB
	yc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=SJOqjegP+m673OZYoqgV5dWxHoBCuzthxG6rISUB5Lg=;
	b=p/ZwD6DKjexsZwK5KOnjybGwjDZDVD2+Vp/n9e+/1nkultEem+8d9oiG9zmQORFjtN
	B6lg5I4nwnCjtZ34YBnm+7weO1V6/RYSqOkGxr9T3I0n1eO3LJV3pN3TvbCeL5envAOc
	SiKqKCsFC1dHHH38/rkxsWKZRxc008qYXtxfTEi06UHrOy4bhFJn110sK7NafaHcjkQ1
	MJP7cHEuuV6XycuG2t5a5JyzJUxV7VEn1JlkI0QX5vjaxvRKQBKUC95WQIoVgBj100qw
	NbnHYWgQcOzV83+lJTad9ANWkm1LSGG/3JaAkS1mtH3CDulmKpN+IOxCk3Gn2CJTGtrl
	bojA==
X-Gm-Message-State: APjAAAVsoZ/oA7Bv1G1vzd0Ez++A2THQ96FUDB3v3SMTXg0wns7NynX9
	u+5znj+9EetvCbps186dZyGBI0+WTR8=
X-Google-Smtp-Source: APXvYqyx3aguO2hpm+z8MwU+kPJt9rLXyHz9RrbVqZVHP088cNSWv9vOLqoDC9FtIZcO9h8dcG6pFQ==
X-Received: by 2002:a63:5a4b:: with SMTP id k11mr25055482pgm.119.1556033941333;
	Tue, 23 Apr 2019 08:39:01 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	c25sm24366591pfo.69.2019.04.23.08.39.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 08:39:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 08:38:50 -0700
Message-Id: <20190423153853.19790-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190423153853.19790-1-richard.henderson@linaro.org>
References: <20190423153853.19790-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH v2 4/7] tcg: Restart TB generation after
 constant pool overflow
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
Cc: alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190423153850.8eiiqhFZlSyjYFGwe8SK4yzOzMHahuWri2JChqWbcuE@z>

This is part b of relocation overflow handling.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-pool.inc.c | 12 +++++++-----
 tcg/tcg.c          |  9 +++++----
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/tcg/tcg-pool.inc.c b/tcg/tcg-pool.inc.c
index 7af5513ff3..4eaa84b631 100644
--- a/tcg/tcg-pool.inc.c
+++ b/tcg/tcg-pool.inc.c
@@ -121,14 +121,14 @@ static inline void new_pool_l8(TCGContext *s, int rtype, tcg_insn_unit *label,
 /* To be provided by cpu/tcg-target.inc.c.  */
 static void tcg_out_nop_fill(tcg_insn_unit *p, int count);
 
-static bool tcg_out_pool_finalize(TCGContext *s)
+static int tcg_out_pool_finalize(TCGContext *s)
 {
     TCGLabelPoolData *p = s->pool_labels;
     TCGLabelPoolData *l = NULL;
     void *a;
 
     if (p == NULL) {
-        return true;
+        return 0;
     }
 
     /* ??? Round up to qemu_icache_linesize, but then do not round
@@ -142,15 +142,17 @@ static bool tcg_out_pool_finalize(TCGContext *s)
         size_t size = sizeof(tcg_target_ulong) * p->nlong;
         if (!l || l->nlong != p->nlong || memcmp(l->data, p->data, size)) {
             if (unlikely(a > s->code_gen_highwater)) {
-                return false;
+                return -1;
             }
             memcpy(a, p->data, size);
             a += size;
             l = p;
         }
-        patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend);
+        if (!patch_reloc(p->label, p->rtype, (intptr_t)a - size, p->addend)) {
+            return -2;
+        }
     }
 
     s->code_ptr = a;
-    return true;
+    return 0;
 }
diff --git a/tcg/tcg.c b/tcg/tcg.c
index ab11235c42..50eb933efe 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1018,8 +1018,8 @@ void tcg_prologue_init(TCGContext *s)
 #ifdef TCG_TARGET_NEED_POOL_LABELS
     /* Allow the prologue to put e.g. guest_base into a pool entry.  */
     {
-        bool ok = tcg_out_pool_finalize(s);
-        tcg_debug_assert(ok);
+        int result = tcg_out_pool_finalize(s);
+        tcg_debug_assert(result == 0);
     }
 #endif
 
@@ -4000,8 +4000,9 @@ int tcg_gen_code(TCGContext *s, TranslationBlock *tb)
     }
 #endif
 #ifdef TCG_TARGET_NEED_POOL_LABELS
-    if (!tcg_out_pool_finalize(s)) {
-        return -1;
+    i = tcg_out_pool_finalize(s);
+    if (i < 0) {
+        return i;
     }
 #endif
     if (!tcg_resolve_relocs(s)) {
-- 
2.17.1


