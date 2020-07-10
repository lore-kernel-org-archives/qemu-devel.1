Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A14C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5318207BB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 13:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lcmXFF2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5318207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtt2b-0006DA-03
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 09:26:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqek-0005nu-7U
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:26 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jtqee-0006qy-HZ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 06:53:25 -0400
Received: by mail-pf1-x442.google.com with SMTP id i14so2371109pfu.13
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 03:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qtfSsgTIZrjwffHcxDIfNLMAZ/v2FNjlWUaB1SIQIAQ=;
 b=lcmXFF2l9OB4vw6TGnt6M2SHwmgejCldimLE0yej4V6eiMI8PCfwfVO7wYJaGjLOJP
 +fy3b+Mi/tU3XD0SUTffPzE8vJDO4DKPkEbCa6CGYvH/GXJvjZ6731wnaaEGgrjMreYP
 czkbXwyn9c1PfE9u+Jfhv/IYcXCh0dmomq8l8VNDJGjJE0SPQjbZYadYhIjTSQZEV7EZ
 m19/uqaneym/SNDAWAzRxeEALb063rV8MkEMVMKi8t7yFq9cChRm/Pymkt4M/WYOIYye
 oAJvLd/pf2Mnf31bZLbpTd+Rb77OWRqylig/qrVUK/w0ulrqt7a0SPyU/73q5K0Fh2DN
 dl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qtfSsgTIZrjwffHcxDIfNLMAZ/v2FNjlWUaB1SIQIAQ=;
 b=iVw4ISmikIussdlyNN/QT3nuPnBnErxaRuEZyeEHAiqdsYfNDytwbfse2k5LteYAK2
 dbE3GjGMLxRX3K0+75TAwPytO0wCi50q3RhOJihW3/Tclrv22UHfM1aeJIdXwCGfIwo4
 jqrpK4aO3e0j7E7YQgzGXaaHhQPBL6Y9NRHuqrxU4JQ0iZ6kMjGcGMM0PFpUU6FvVGUB
 gX1deI4VE93enY1YONSo2fzpvSamEDRfpiCkM2a3gJFdN0J4ieeskT8cE0txLwHvLtkd
 EJbKvWd/fGo68qiJP1Jm4jf9L+Vo0p4YsBQe4J30A9B3Euy14V32DEmqTB2Wk7UgCHa3
 Gs7Q==
X-Gm-Message-State: AOAM533SKhj3cKiNoeIQMgG663mjgLkaaySPNkH/Pj4mf4PvXSx7io1n
 0WRYTicvIfDZ5SlsaciXZFP4chFug58CWg==
X-Google-Smtp-Source: ABdhPJwqcdxYd0wy9jVRwaAnLJ/7YydEcDgzrktXAliYYfHmU1AP51FaoERgWOhjtIIXaTFjxs8QXw==
X-Received: by 2002:a65:6703:: with SMTP id u3mr54465793pgf.254.1594378399039; 
 Fri, 10 Jul 2020 03:53:19 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id r191sm5519406pfr.181.2020.07.10.03.53.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 03:53:18 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC 41/65] target/riscv: rvv-0.9: floating-point compare instructions
Date: Fri, 10 Jul 2020 18:48:55 +0800
Message-Id: <20200710104920.13550-42-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710104920.13550-1-frank.chang@sifive.com>
References: <20200710104920.13550-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Jul 2020 08:57:18 -0400
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 target/riscv/vector_helper.c | 52 ++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8d251dee58..11c962431e 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -4148,27 +4148,30 @@ GEN_VEXT_VF(vfsgnjx_vf_w, 4, 4, clearl)
 GEN_VEXT_VF(vfsgnjx_vf_d, 8, 8, clearq)
 
 /* Vector Floating-Point Compare Instructions */
-#define GEN_VEXT_CMP_VV_ENV(NAME, ETYPE, H, DO_OP)            \
-void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
-                  CPURISCVState *env, uint32_t desc)          \
-{                                                             \
-    uint32_t vm = vext_vm(desc);                              \
-    uint32_t vl = env->vl;                                    \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
-    uint32_t i;                                               \
-                                                              \
-    for (i = 0; i < vl; i++) {                                \
-        ETYPE s1 = *((ETYPE *)vs1 + H(i));                    \
-        ETYPE s2 = *((ETYPE *)vs2 + H(i));                    \
-        if (!vm && !vext_elem_mask(v0, i)) {                  \
-            continue;                                         \
-        }                                                     \
-        vext_set_elem_mask(vd, i,                             \
-                           DO_OP(s2, s1, &env->fp_status));   \
-    }                                                         \
-    for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, i, 0);                         \
-    }                                                         \
+#define GEN_VEXT_CMP_VV_ENV(NAME, ETYPE, H, DO_OP)               \
+void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,      \
+                  CPURISCVState *env, uint32_t desc)             \
+{                                                                \
+    uint32_t vm = vext_vm(desc);                                 \
+    uint32_t vl = env->vl;                                       \
+    uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false); \
+    uint32_t vta = vext_vta(desc);                               \
+    uint32_t i;                                                  \
+                                                                 \
+    for (i = 0; i < vl; i++) {                                   \
+        ETYPE s1 = *((ETYPE *)vs1 + H(i));                       \
+        ETYPE s2 = *((ETYPE *)vs2 + H(i));                       \
+        if (!vm && !vext_elem_mask(v0, i)) {                     \
+            continue;                                            \
+        }                                                        \
+        vext_set_elem_mask(vd, i,                                \
+                           DO_OP(s2, s1, &env->fp_status));      \
+    }                                                            \
+    if (vta == 1) {                                              \
+        for (; i < vlmax; i++) {                                 \
+            vext_set_elem_mask(vd, i, 0);                        \
+        }                                                        \
+    }                                                            \
 }
 
 static bool float16_eq_quiet(uint16_t a, uint16_t b, float_status *s)
@@ -4188,6 +4191,7 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
     uint32_t vlmax = vext_max_elems(desc, sizeof(ETYPE), false);    \
+    uint32_t vta = vext_vta(desc);                                  \
     uint32_t i;                                                     \
                                                                     \
     for (i = 0; i < vl; i++) {                                      \
@@ -4198,8 +4202,10 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
         vext_set_elem_mask(vd, i,                                   \
                            DO_OP(s2, (ETYPE)s1, &env->fp_status));  \
     }                                                               \
-    for (; i < vlmax; i++) {                                        \
-        vext_set_elem_mask(vd, i, 0);                               \
+    if (vta == 1) {                                                 \
+        for (; i < vlmax; i++) {                                    \
+            vext_set_elem_mask(vd, i, 0);                           \
+        }                                                           \
     }                                                               \
 }
 
-- 
2.17.1


