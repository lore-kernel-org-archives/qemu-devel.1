Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB073C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30D822D3E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="gHaEUTj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30D822D3E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3dw2-0002PP-S6
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSq-00042G-NB
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:38 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1k3dSo-00082N-HY
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 06:49:36 -0400
Received: by mail-pf1-x441.google.com with SMTP id a79so8953232pfa.8
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 03:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=uveFuVrXJlEx57TSQIau0d1s6zfy9//TT6DkYSm5JUc=;
 b=gHaEUTj7qcehTpJ2Y6XPjwQql+YAtvy5KkwnR/4QNRyeWixj8hiWIuKnqg9I01GSov
 iWV6wMipstNO/gq/mle+DsHmapdX95yUC0KgnSc4rbfBIZqVmt27vCDgTyVmFU2wgoM/
 8AfK12OiVQf7IBkmdnv5/eqQtkbY5VgxfshDa06ev5B96Pk5h6L7U2O6Ss6K/0WGDmvs
 HcsUDNGuBSUycAfEP6Bq1hq8KgGhZsE5KECqP1euqyptt23+MOkuyJMPgInZ8omBlFUr
 1et5xo2u240wNIpzKAs2o5NXQiFjV+36UkAlOLdRHo+Sb1IOy+kh57+z9Iq3gXsFAkoQ
 28Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=uveFuVrXJlEx57TSQIau0d1s6zfy9//TT6DkYSm5JUc=;
 b=nkmBat0+LIB3SJC2QzC1gpHWhUAiZ/y6xxCU7odBc6A6eEKW6N6G88STX2fFR7FSrl
 v2iZYwRSFFN67mdpXM5J3welrQuE0+sOryLPpQTmPNt0Vn60bDP+MW4P4hf15aYQpkW8
 KJR3CpQ4GCFlZaXMMlLclLwMhjGfVqZVrTQjA3AD1kbNsA1okNZtP8BWWbUEhIZWJ08B
 /PXYGrAqKW9xhAix9ZuidW8nVS8ib5z0WrHe+NZoHtOnseoxXjRqzQunTyuKyl/fBxNf
 aOhv7bGg4DYtx3pR9hJhG59tgE0JRLW8MmwXhurIsGzF1hXg1gotYHtcxbUo6jUWCZsG
 qyuQ==
X-Gm-Message-State: AOAM532/Ry1qrX4lwB8vSaw2IlePorY1qsXGMSS9eO9bXMjWuTVeZrrr
 hxdgXEDUr3OQZJ6RIgc7vp7WY8Wd1bY=
X-Google-Smtp-Source: ABdhPJyxsvq+Z3rcA5I33Ign7C33t2kVpBbrxFYTBczqjdxMpJerYfvOcag2Cw7WIZ+DFJOJwZ6TuA==
X-Received: by 2002:a63:29c8:: with SMTP id p191mr7113165pgp.333.1596710972806; 
 Thu, 06 Aug 2020 03:49:32 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id f18sm6567309pgv.84.2020.08.06.03.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 03:49:32 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v3 54/71] target/riscv: rvv-1.0: slide instructions
Date: Thu,  6 Aug 2020 18:46:51 +0800
Message-Id: <20200806104709.13235-55-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806104709.13235-1-frank.chang@sifive.com>
References: <20200806104709.13235-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Frank Chang <frank.chang@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Frank Chang <frank.chang@sifive.com>

* Remove clear function from helper functions as the tail elements
  are unchanged in RVV 1.0.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/vector_helper.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 59c35343790..1e779723a0f 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4707,17 +4707,22 @@ GEN_VEXT_VSLIDEUP_VX(vslideup_vx_d, uint64_t, H8)
 void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
                   CPURISCVState *env, uint32_t desc)                      \
 {                                                                         \
-    uint32_t vlmax = env_archcpu(env)->cfg.vlen;                          \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);          \
     uint32_t vm = vext_vm(desc);                                          \
     uint32_t vl = env->vl;                                                \
-    target_ulong offset = s1, i;                                          \
+    target_ulong i_max, i;                                                \
                                                                           \
-    for (i = 0; i < vl; ++i) {                                            \
-        target_ulong j = i + offset;                                      \
-        if (!vm && !vext_elem_mask(v0, i)) {                              \
-            continue;                                                     \
+    i_max = MIN(s1 < vlmax ? vlmax - s1 : 0, vl);                         \
+    for (i = 0; i < i_max; ++i) {                                         \
+        if (vm || vext_elem_mask(v0, i)) {                                \
+            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + s1));          \
+        }                                                                 \
+    }                                                                     \
+                                                                          \
+    for (i = i_max; i < vl; ++i) {                                        \
+        if (vm || vext_elem_mask(v0, i)) {                                \
+            *((ETYPE *)vd + H(i)) = 0;                                    \
         }                                                                 \
-        *((ETYPE *)vd + H(i)) = j >= vlmax ? 0 : *((ETYPE *)vs2 + H(j));  \
     }                                                                     \
 }
 
-- 
2.17.1


