Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A4AC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:45:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA3C21479
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iyelCnjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA3C21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38187 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkgP-0000KG-Cz
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:45:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWn-0000AP-8T
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWl-0008CN-QX
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:13 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:39173)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWl-0008A7-I0
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:11 -0400
Received: by mail-pf1-x441.google.com with SMTP id i17so3465645pfo.6
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=rwFKyv2b5NvlMBSdo8f6yzy4Wn8y0WFPdVUtat/RHMA=;
	b=iyelCnjj2WRCh+VeUbpUaz5l1itmrJ28CqUyxBW1bEEmF8cI70Xwpso0XRUtxbzRPe
	nThq+c35fxVSq4PVO67fPKzRlb2Kxm3R82XKDTi8POXycdYgv604BIOiAK2lYnsrJy3S
	vb+B7ATX+e+39acyQd3OKi0ddfoY4NA06tgll9/2Z5PscddrjbGj5ZMpo9WnfhSPFW9K
	+05+XGzmU46PqJEFbfDpzwSPpE00/GbjrP5Ab9tUsbQvEVvt9S07T8F7sS3eT5cUxt35
	gY56uxuXPXEFv2bBMx+/NZoCFwzWLl5I79xIN7/t2c6c9Kho1IKMXPW6dFeTFolrRqav
	6bMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=rwFKyv2b5NvlMBSdo8f6yzy4Wn8y0WFPdVUtat/RHMA=;
	b=nEgOwJaLnd13X/032UDJsrY0Tu9G1RDk9uTqkzAFPzUtLxR4Iq9G9Jbug19+imQHxU
	iDjJlzOX2nTded/NAF5k9O1oEJzKRBjV+ra5IvsZpz3xGCqeWcG2xADqKd5eQjMutKWF
	etRX6iEBcbpLN5T0NHb582Ozf6PPacPcPl/395nHx2npDXP2a0IG60jnTnhj7BB6rpM4
	nhVdxQ7VRnYbpVtdUUK4M8JGIVvzmwoNZmPRmbDoru3JHFx+qJuuifRJt236Na+oXRiW
	uNJs6ZFRIhPKRJ2i0SyekU6Zto4V4vPg9/ejbA/Ka8xKHmP1IFqlB4LN9Bbxp+02JFJo
	/zWA==
X-Gm-Message-State: APjAAAVCRh+CkKM8Pd5UKu0kUE/XO033m+Yzlu+b5RcOAs9tWMCFiugV
	FDj3BOsn7HYtVluKHb9xIc1wnETJWCM=
X-Google-Smtp-Source: APXvYqwT2kRYcKcbWe/RIlDLpd62dH/EKQczjKRIKSNOj+lmBfV12tUp0esCQTpLi/vvxAveWCVE7Q==
X-Received: by 2002:a63:ad4b:: with SMTP id y11mr8086160pgo.405.1555745709970; 
	Sat, 20 Apr 2019 00:35:09 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.35.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:35:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:19 -1000
Message-Id: <20190420073442.7488-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::441
Subject: [Qemu-devel] [PATCH 15/38] tcg: Implement tcg_gen_gvec_3i()
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
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073419.JT7gTObBNxZ1M--RhBGB1BCLnrRhejNitVORkA-Udu4@z>

From: David Hildenbrand <david@redhat.com>

Let's add tcg_gen_gvec_3i(), similar to tcg_gen_gvec_2i(), however
without introducing "gen_helper_gvec_3i *fnoi", as it isn't needed
for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20190416185301.25344-2-david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.h |  24 ++++++++
 tcg/tcg-op-gvec.c | 139 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 163 insertions(+)

diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
index 1cd18a959a..aaeb6e5d8b 100644
--- a/tcg/tcg-op-gvec.h
+++ b/tcg/tcg-op-gvec.h
@@ -164,6 +164,27 @@ typedef struct {
     bool load_dest;
 } GVecGen3;
 
+typedef struct {
+    /*
+     * Expand inline as a 64-bit or 32-bit integer. Only one of these will be
+     * non-NULL.
+     */
+    void (*fni8)(TCGv_i64, TCGv_i64, TCGv_i64, int64_t);
+    void (*fni4)(TCGv_i32, TCGv_i32, TCGv_i32, int32_t);
+    /* Expand inline with a host vector type.  */
+    void (*fniv)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec, int64_t);
+    /* Expand out-of-line helper w/descriptor, data in descriptor.  */
+    gen_helper_gvec_3 *fno;
+    /* The opcode, if any, to which this corresponds.  */
+    TCGOpcode opc;
+    /* The vector element size, if applicable.  */
+    uint8_t vece;
+    /* Prefer i64 to v64.  */
+    bool prefer_i64;
+    /* Load dest as a 3rd source operand.  */
+    bool load_dest;
+} GVecGen3i;
+
 typedef struct {
     /* Expand inline as a 64-bit or 32-bit integer.
        Only one of these will be non-NULL.  */
@@ -193,6 +214,9 @@ void tcg_gen_gvec_2s(uint32_t dofs, uint32_t aofs, uint32_t oprsz,
                      uint32_t maxsz, TCGv_i64 c, const GVecGen2s *);
 void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen3 *);
+void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                     uint32_t oprsz, uint32_t maxsz, int64_t c,
+                     const GVecGen3i *);
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen4 *);
 
diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 5d28184045..3eb9126f50 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -659,6 +659,29 @@ static void expand_3_i32(uint32_t dofs, uint32_t aofs,
     tcg_temp_free_i32(t0);
 }
 
+static void expand_3i_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                          uint32_t oprsz, int32_t c, bool load_dest,
+                          void (*fni)(TCGv_i32, TCGv_i32, TCGv_i32, int32_t))
+{
+    TCGv_i32 t0 = tcg_temp_new_i32();
+    TCGv_i32 t1 = tcg_temp_new_i32();
+    TCGv_i32 t2 = tcg_temp_new_i32();
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += 4) {
+        tcg_gen_ld_i32(t0, cpu_env, aofs + i);
+        tcg_gen_ld_i32(t1, cpu_env, bofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i32(t2, cpu_env, dofs + i);
+        }
+        fni(t2, t0, t1, c);
+        tcg_gen_st_i32(t2, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
+    tcg_temp_free_i32(t2);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
 static void expand_4_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                          uint32_t cofs, uint32_t oprsz, bool write_aofs,
@@ -766,6 +789,29 @@ static void expand_3_i64(uint32_t dofs, uint32_t aofs,
     tcg_temp_free_i64(t0);
 }
 
+static void expand_3i_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                          uint32_t oprsz, int64_t c, bool load_dest,
+                          void (*fni)(TCGv_i64, TCGv_i64, TCGv_i64, int64_t))
+{
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 t2 = tcg_temp_new_i64();
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += 8) {
+        tcg_gen_ld_i64(t0, cpu_env, aofs + i);
+        tcg_gen_ld_i64(t1, cpu_env, bofs + i);
+        if (load_dest) {
+            tcg_gen_ld_i64(t2, cpu_env, dofs + i);
+        }
+        fni(t2, t0, t1, c);
+        tcg_gen_st_i64(t2, cpu_env, dofs + i);
+    }
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+    tcg_temp_free_i64(t2);
+}
+
 /* Expand OPSZ bytes worth of three-operand operations using i64 elements.  */
 static void expand_4_i64(uint32_t dofs, uint32_t aofs, uint32_t bofs,
                          uint32_t cofs, uint32_t oprsz, bool write_aofs,
@@ -879,6 +925,35 @@ static void expand_3_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
     tcg_temp_free_vec(t0);
 }
 
+/*
+ * Expand OPSZ bytes worth of three-vector operands and an immediate operand
+ * using host vectors.
+ */
+static void expand_3i_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
+                          uint32_t bofs, uint32_t oprsz, uint32_t tysz,
+                          TCGType type, int64_t c, bool load_dest,
+                          void (*fni)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec,
+                                      int64_t))
+{
+    TCGv_vec t0 = tcg_temp_new_vec(type);
+    TCGv_vec t1 = tcg_temp_new_vec(type);
+    TCGv_vec t2 = tcg_temp_new_vec(type);
+    uint32_t i;
+
+    for (i = 0; i < oprsz; i += tysz) {
+        tcg_gen_ld_vec(t0, cpu_env, aofs + i);
+        tcg_gen_ld_vec(t1, cpu_env, bofs + i);
+        if (load_dest) {
+            tcg_gen_ld_vec(t2, cpu_env, dofs + i);
+        }
+        fni(vece, t2, t0, t1, c);
+        tcg_gen_st_vec(t2, cpu_env, dofs + i);
+    }
+    tcg_temp_free_vec(t0);
+    tcg_temp_free_vec(t1);
+    tcg_temp_free_vec(t2);
+}
+
 /* Expand OPSZ bytes worth of four-operand operations using host vectors.  */
 static void expand_4_vec(unsigned vece, uint32_t dofs, uint32_t aofs,
                          uint32_t bofs, uint32_t cofs, uint32_t oprsz,
@@ -1170,6 +1245,70 @@ void tcg_gen_gvec_3(uint32_t dofs, uint32_t aofs, uint32_t bofs,
     }
 }
 
+/* Expand a vector operation with three vectors and an immediate.  */
+void tcg_gen_gvec_3i(uint32_t dofs, uint32_t aofs, uint32_t bofs,
+                     uint32_t oprsz, uint32_t maxsz, int64_t c,
+                     const GVecGen3i *g)
+{
+    TCGType type;
+    uint32_t some;
+
+    check_size_align(oprsz, maxsz, dofs | aofs | bofs);
+    check_overlap_3(dofs, aofs, bofs, maxsz);
+
+    type = 0;
+    if (g->fniv) {
+        type = choose_vector_type(g->opc, g->vece, oprsz, g->prefer_i64);
+    }
+    switch (type) {
+    case TCG_TYPE_V256:
+        /*
+         * Recall that ARM SVE allows vector sizes that are not a
+         * power of 2, but always a multiple of 16.  The intent is
+         * that e.g. size == 80 would be expanded with 2x32 + 1x16.
+         */
+        some = QEMU_ALIGN_DOWN(oprsz, 32);
+        expand_3i_vec(g->vece, dofs, aofs, bofs, some, 32, TCG_TYPE_V256,
+                      c, g->load_dest, g->fniv);
+        if (some == oprsz) {
+            break;
+        }
+        dofs += some;
+        aofs += some;
+        bofs += some;
+        oprsz -= some;
+        maxsz -= some;
+        /* fallthru */
+    case TCG_TYPE_V128:
+        expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 16, TCG_TYPE_V128,
+                      c, g->load_dest, g->fniv);
+        break;
+    case TCG_TYPE_V64:
+        expand_3i_vec(g->vece, dofs, aofs, bofs, oprsz, 8, TCG_TYPE_V64,
+                      c, g->load_dest, g->fniv);
+        break;
+
+    case 0:
+        if (g->fni8 && check_size_impl(oprsz, 8)) {
+            expand_3i_i64(dofs, aofs, bofs, oprsz, c, g->load_dest, g->fni8);
+        } else if (g->fni4 && check_size_impl(oprsz, 4)) {
+            expand_3i_i32(dofs, aofs, bofs, oprsz, c, g->load_dest, g->fni4);
+        } else {
+            assert(g->fno != NULL);
+            tcg_gen_gvec_3_ool(dofs, aofs, bofs, oprsz, maxsz, c, g->fno);
+            return;
+        }
+        break;
+
+    default:
+        g_assert_not_reached();
+    }
+
+    if (oprsz < maxsz) {
+        expand_clr(dofs + oprsz, maxsz - oprsz);
+    }
+}
+
 /* Expand a vector four-operand operation.  */
 void tcg_gen_gvec_4(uint32_t dofs, uint32_t aofs, uint32_t bofs, uint32_t cofs,
                     uint32_t oprsz, uint32_t maxsz, const GVecGen4 *g)
-- 
2.17.1


