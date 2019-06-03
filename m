Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912B8C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:58:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63B6F246DE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 16:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JynOt/j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B6F246DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38078 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXqI0-0001or-Mo
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 12:58:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXqHH-0001Y2-00
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXqHF-0006Ou-Kr
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:57:42 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXqHF-0006N5-EA
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 12:57:41 -0400
Received: by mail-oi1-x241.google.com with SMTP id 203so13329657oid.13
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=Z16mSEfJcCmDQbOGYHSA8D+ldy5k0zTmMQKPbURTJ5E=;
	b=JynOt/j8I7vZJL1cwc0yXNNvyYqnt/jbv0qR00Nz7wel+h1SQ4SBCEVKbUry2vNMRU
	D7LMteMrznDlwaytO9GbFCnPDt0fAJ7wzRHnAPaI0DnJFzvAsXPWVuAi9kmWsfOk6NZU
	fEStBeyNTqgF+oRaBdXZZatec44LMKoAEBBZJuG/phA8I0S1w3+4dcfgTMTzUWmtge+S
	hTcCUuoAwyArBDoX+zt5YNUCwQctOM9DUM5e1iAHNHJ0hREm6KScCxlov6BIMOOLD+8u
	fa1ZlNtsPIPYSVFD1kMrAGjNAXlfqORRa6Wsv8qD7etX0duE+zNxZPY0wYvL6nqUBDmc
	CkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Z16mSEfJcCmDQbOGYHSA8D+ldy5k0zTmMQKPbURTJ5E=;
	b=B192IkbblJhXu+41HJ/DYPuAcpu8kN4d5vsukTmIdnshORJ3UOHwIdGvA4UdSvUm35
	q0Utgmgt/WG6wqEpCR6YyP9H+Mk9yx8BZTbjTfgJLOsm/AMzBpYfalCva0vIF8wc/m1X
	5QigeJXep3eIc2PGcc4Mc6e62Jx1AAYRmKpEMsDsuxyzdrNtbLegej0XekFR9BOAQEJq
	SPlsX18XpRjS5Fwm4aYk1uU9LHlVtKv0Ns3c0fW4hqUtveNhcG5JeIxm6IyuuzaQAhj5
	iv7ksVVIfJIwR5IeHnCE3Mv79Y1R/XSF60J01RhO20fLk+9hx50V9Ozszgl4O1paT7l2
	6yzQ==
X-Gm-Message-State: APjAAAVa1JnjWV4ZPbwKzSXANBO2YSwfIznBoqyBVpGD19Vuz3Xtr1De
	23O0YJXuzKTdKaum3LalCMs/OjW692/64w==
X-Google-Smtp-Source: APXvYqzU7/E9Zav735sA7QFvAg7ObAiI48KlZOInzb8EGbd7RcBBxtwhtMQa4yki/1Emh1C/n13Tiw==
X-Received: by 2002:aca:5c06:: with SMTP id q6mr48039oib.63.1559581059945;
	Mon, 03 Jun 2019 09:57:39 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id e16sm2820998otk.1.2019.06.03.09.57.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 09:57:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Mon,  3 Jun 2019 11:57:35 -0500
Message-Id: <20190603165735.8934-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: [Qemu-devel] [PATCH] target/s390x: Use tcg_gen_gvec_bitsel
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
Cc: cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This replaces the target-specific implementations for VSEL.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/translate_vx.inc.c | 38 ++++++---------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
index 7e0bfcb190..a8603cbfd6 100644
--- a/target/s390x/translate_vx.inc.c
+++ b/target/s390x/translate_vx.inc.c
@@ -233,6 +233,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
 #define gen_gvec_fn_3(fn, es, v1, v2, v3) \
     tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
                       vec_full_reg_offset(v3), 16, 16)
+#define gen_gvec_fn_4(fn, es, v1, v2, v3, v4) \
+    tcg_gen_gvec_##fn(es, vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
+                      vec_full_reg_offset(v3), vec_full_reg_offset(v4), 16, 16)
 
 /*
  * Helper to carry out a 128 bit vector computation using 2 i64 values per
@@ -903,40 +906,11 @@ static DisasJumpType op_vsce(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static void gen_sel_i64(TCGv_i64 d, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
-{
-    TCGv_i64 t = tcg_temp_new_i64();
-
-    /* bit in c not set -> copy bit from b */
-    tcg_gen_andc_i64(t, b, c);
-    /* bit in c set -> copy bit from a */
-    tcg_gen_and_i64(d, a, c);
-    /* merge the results */
-    tcg_gen_or_i64(d, d, t);
-    tcg_temp_free_i64(t);
-}
-
-static void gen_sel_vec(unsigned vece, TCGv_vec d, TCGv_vec a, TCGv_vec b,
-                        TCGv_vec c)
-{
-    TCGv_vec t = tcg_temp_new_vec_matching(d);
-
-    tcg_gen_andc_vec(vece, t, b, c);
-    tcg_gen_and_vec(vece, d, a, c);
-    tcg_gen_or_vec(vece, d, d, t);
-    tcg_temp_free_vec(t);
-}
-
 static DisasJumpType op_vsel(DisasContext *s, DisasOps *o)
 {
-    static const GVecGen4 gvec_op = {
-        .fni8 = gen_sel_i64,
-        .fniv = gen_sel_vec,
-        .prefer_i64 = TCG_TARGET_REG_BITS == 64,
-    };
-
-    gen_gvec_4(get_field(s->fields, v1), get_field(s->fields, v2),
-               get_field(s->fields, v3), get_field(s->fields, v4), &gvec_op);
+    gen_gvec_fn_4(bitsel, ES_8, get_field(s->fields, v1),
+                  get_field(s->fields, v4), get_field(s->fields, v2),
+                  get_field(s->fields, v3));
     return DISAS_NEXT;
 }
 
-- 
2.17.1


