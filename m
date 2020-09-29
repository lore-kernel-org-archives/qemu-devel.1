Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A650C4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:47:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FAE8207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 19:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="G+tI3Xaw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FAE8207F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNLb6-0002V5-EG
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 15:47:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKyt-0006xM-QC
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:08 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429]:43637)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1kNKys-0002N0-25
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 15:08:07 -0400
Received: by mail-pf1-x429.google.com with SMTP id f18so5516687pfa.10
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VayNy6WNBL4cZZfrNwtrFRs18luSxkt42LlMHvIBi7M=;
 b=G+tI3Xaw38igCBcvqUGHR8D8uq0UBc7YdLdolBHUd3TcejTC2eRqD+dXG+1PHE+nR+
 gI0MSd0dvGbNAWBG5JpvY7AQkYWwOJUyAz/InAomJsoMMxSkf2WWP4dnNwOxtbie9lCV
 ZBLjSak/xacMJbOx3kiKopkg80T6oc2Mf5Pvsb0kovCtjcm2wMJnzuLT8feTt/7io6nF
 Z86Az2x3u4pHmIQNgB+7yhXhYdsWtIpGm/I7rUqJ0P9qaVa+sR8kLvhtByfnt+KnUAkD
 GIXUIxZbgVeaR4pP+cje4YAqOETtpAOMMZn4VjiXXUHPf0SyJBwSW0T8KF+2C2RjU66d
 ofHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VayNy6WNBL4cZZfrNwtrFRs18luSxkt42LlMHvIBi7M=;
 b=OKCkqsB/w+TI0h17UXlkrTjq/ri88XQbtY8e5ONCiG+ZlqEK/rhtJBDs7682CUEZnr
 g1pE7fjfT62HFk1vUFGF1p//F+9lCxtTeeYasVD7hO+00+XOiE4qIR8ycQi/e8qFQCBK
 qvb/B0mm9SjTKb4LcJAkbglpjjC37vL0BDMnYFEGRVFkGPyTlJOnVnjWLj8GLpqhVP5B
 87tC9HzI9oCh4bF95RXHh2n/7K/ICPnpjJAmSWcK/5lR05J2RoGv8FDm6Ey8Sq7r0Yy+
 +qjr7R58reJhKM3D0b52GNJ30YnNkztEOmXGDpkn64Ym8vNr4xe2Kmom7EVt+tJ6O+o2
 Ub5Q==
X-Gm-Message-State: AOAM532rbtGWDvWbQ00VuqQmy8opuMrjZkn4cYEwMjVv7z5acSejNx53
 GuIV2/6WE/6VzIsY0rng9pee8i6qjY/bBw==
X-Google-Smtp-Source: ABdhPJzScCVotYZfolNpJcw5GTNTZpvZRcM0MAcJDyLBVwBj1BwZSD+Ps9Dok+XHpMUpkZPEmKe8yQ==
X-Received: by 2002:a17:902:9f97:b029:d2:89d4:bc with SMTP id
 g23-20020a1709029f97b02900d289d400bcmr6236396plq.12.1601406484572; 
 Tue, 29 Sep 2020 12:08:04 -0700 (PDT)
Received: from localhost.localdomain (122-116-72-36.HINET-IP.hinet.net.
 [122.116.72.36])
 by smtp.gmail.com with ESMTPSA id v8sm6003950pgg.58.2020.09.29.12.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 12:08:04 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v5 47/68] target/riscv: rvv-1.0: floating-point compare
 instructions
Date: Wed, 30 Sep 2020 03:04:22 +0800
Message-Id: <20200929190448.31116-48-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929190448.31116-1-frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x429.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/vector_helper.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 5622fb23f8..93ed6f54e9 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -3919,7 +3919,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
 {                                                             \
     uint32_t vm = vext_vm(desc);                              \
     uint32_t vl = env->vl;                                    \
-    uint32_t vlmax = vext_maxsz(desc) / sizeof(ETYPE);        \
     uint32_t i;                                               \
                                                               \
     for (i = 0; i < vl; i++) {                                \
@@ -3931,9 +3930,6 @@ void HELPER(NAME)(void *vd, void *v0, void *vs1, void *vs2,   \
         vext_set_elem_mask(vd, i,                             \
                            DO_OP(s2, s1, &env->fp_status));   \
     }                                                         \
-    for (; i < vlmax; i++) {                                  \
-        vext_set_elem_mask(vd, i, 0);                         \
-    }                                                         \
 }
 
 GEN_VEXT_CMP_VV_ENV(vmfeq_vv_h, uint16_t, H2, float16_eq_quiet)
@@ -3946,7 +3942,6 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
 {                                                                   \
     uint32_t vm = vext_vm(desc);                                    \
     uint32_t vl = env->vl;                                          \
-    uint32_t vlmax = vext_max_elems(desc, ctzl(sizeof(ETYPE)));     \
     uint32_t i;                                                     \
                                                                     \
     for (i = 0; i < vl; i++) {                                      \
@@ -3957,9 +3952,6 @@ void HELPER(NAME)(void *vd, void *v0, uint64_t s1, void *vs2,       \
         vext_set_elem_mask(vd, i,                                   \
                            DO_OP(s2, (ETYPE)s1, &env->fp_status));  \
     }                                                               \
-    for (; i < vlmax; i++) {                                        \
-        vext_set_elem_mask(vd, i, 0);                               \
-    }                                                               \
 }
 
 GEN_VEXT_CMP_VF(vmfeq_vf_h, uint16_t, H2, float16_eq_quiet)
-- 
2.17.1


