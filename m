Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEFDC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06FA6206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AWwripP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06FA6206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAO9-0008Ty-AO
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39814)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIh-0005pX-Fl
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:07 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b]:47015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgAIg-0007Qo-CI
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:02:07 -0400
Received: by mail-pl1-x62b.google.com with SMTP id n2so1562091pld.13
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=P9h5TBP5WOCBKRHaXQjwNWHN1Wi1jSCendyQQuP2OXQ=;
 b=AWwripP2uew25jcpCAwg5gJKHfGBL7kGuv8QztR8MCcuT3QUvu5G2QzDfOvPT55z+6
 2K4j/Zus2l6rVUP/nwxaeN2lZ2W0xY7T3RXQlLcdH0Y4ShjPo/vyi4TuxfpZBg59tpeE
 6b+IE8QnPG6cwZeA47gVbqfD6m7gRsJ8wA9zE7KEtffunuulc2S4OzO/mMUSgtDK/Als
 Lx6V2hjwWnmSxLAzz8h4kPy614wIreyw7zVfY/UjU4gwBpMIytPFKKja2gUkwBTKNMev
 Q1+8crvJOkclsI/DrA6zEjTthLdeEbjArEpdvECpzSRENLpEVthHHNhzFJqqN1WPOXhR
 xjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=P9h5TBP5WOCBKRHaXQjwNWHN1Wi1jSCendyQQuP2OXQ=;
 b=QjRJWaaPTDXmJoNPN4RJYVFMaOL3kgh8LG6H72UNdi+uZPWi6JCHprIdYe7kK3JjmM
 0ZeXDDzsjyILtgmg9sFDDE/03O0qaw+D9NdXQWOWqxDFfAaneg5wYQ1Nxm5DDriWon80
 V6YnDALwKVrbzlxvrHVOLXYMxmEU9QfqbOCtCj2FGv/XJ06tyTRhsm+Xw/4MCapVk1vy
 3nqcP0kPVh8kE3hvezuho6UYKFCmL3YY/N8VwDzY5ayuSVH0UhSKuEINaJH+XP2Rt8Sj
 yYKh2FLfmgjEcbj81UnTCS+Jbf7gAfYb3/aZFRc3WU1HJ5c1xg5tFUGgmvXvvomVtPp6
 UjXA==
X-Gm-Message-State: AOAM530bOeXyECIR/ksK97UJY7InXcapaeNodHAK1XS50h1lW2ta8xrm
 XsLWAWF4fO/oXh1wkcxqmGMhH0fLKNY=
X-Google-Smtp-Source: ABdhPJyQ12tKqLqXIMJxpPjr9RtEc2+5OyQIDlUYDXORokxa9geVHBY4xSkWORV92UVNWoyzBIgfAg==
X-Received: by 2002:a17:90a:64ce:: with SMTP id
 i14mr170177pjm.48.1591117324565; 
 Tue, 02 Jun 2020 10:02:04 -0700 (PDT)
Received: from localhost.localdomain (174-21-143-238.tukw.qwest.net.
 [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h11sm2723630pjk.20.2020.06.02.10.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 10:02:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/12] target/ppc: Use tcg_gen_gvec_rotlv
Date: Tue,  2 Jun 2020 10:01:47 -0700
Message-Id: <20200602170151.321389-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200602170151.321389-1-richard.henderson@linaro.org>
References: <20200602170151.321389-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  4 ----
 target/ppc/int_helper.c             | 17 -----------------
 target/ppc/translate/vmx-impl.inc.c |  8 ++++----
 3 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 2dfa1c6942..90166cbabd 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -214,10 +214,6 @@ DEF_HELPER_3(vsubuqm, void, avr, avr, avr)
 DEF_HELPER_4(vsubecuq, void, avr, avr, avr, avr)
 DEF_HELPER_4(vsubeuqm, void, avr, avr, avr, avr)
 DEF_HELPER_3(vsubcuq, void, avr, avr, avr)
-DEF_HELPER_3(vrlb, void, avr, avr, avr)
-DEF_HELPER_3(vrlh, void, avr, avr, avr)
-DEF_HELPER_3(vrlw, void, avr, avr, avr)
-DEF_HELPER_3(vrld, void, avr, avr, avr)
 DEF_HELPER_4(vsldoi, void, avr, avr, avr, i32)
 DEF_HELPER_3(vextractub, void, avr, avr, i32)
 DEF_HELPER_3(vextractuh, void, avr, avr, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index be53cd6f68..d8bd3c234a 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1348,23 +1348,6 @@ VRFI(p, float_round_up)
 VRFI(z, float_round_to_zero)
 #undef VRFI
 
-#define VROTATE(suffix, element, mask)                                  \
-    void helper_vrl##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)   \
-    {                                                                   \
-        int i;                                                          \
-                                                                        \
-        for (i = 0; i < ARRAY_SIZE(r->element); i++) {                  \
-            unsigned int shift = b->element[i] & mask;                  \
-            r->element[i] = (a->element[i] << shift) |                  \
-                (a->element[i] >> (sizeof(a->element[0]) * 8 - shift)); \
-        }                                                               \
-    }
-VROTATE(b, u8, 0x7)
-VROTATE(h, u16, 0xF)
-VROTATE(w, u32, 0x1F)
-VROTATE(d, u64, 0x3F)
-#undef VROTATE
-
 void helper_vrsqrtefp(CPUPPCState *env, ppc_avr_t *r, ppc_avr_t *b)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 403ed3a01c..de2fd136ff 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -900,13 +900,13 @@ GEN_VXFORM3(vsubeuqm, 31, 0);
 GEN_VXFORM3(vsubecuq, 31, 0);
 GEN_VXFORM_DUAL(vsubeuqm, PPC_NONE, PPC2_ALTIVEC_207, \
             vsubecuq, PPC_NONE, PPC2_ALTIVEC_207)
-GEN_VXFORM(vrlb, 2, 0);
-GEN_VXFORM(vrlh, 2, 1);
-GEN_VXFORM(vrlw, 2, 2);
+GEN_VXFORM_V(vrlb, MO_8, tcg_gen_gvec_rotlv, 2, 0);
+GEN_VXFORM_V(vrlh, MO_16, tcg_gen_gvec_rotlv, 2, 1);
+GEN_VXFORM_V(vrlw, MO_32, tcg_gen_gvec_rotlv, 2, 2);
 GEN_VXFORM(vrlwmi, 2, 2);
 GEN_VXFORM_DUAL(vrlw, PPC_ALTIVEC, PPC_NONE, \
                 vrlwmi, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM(vrld, 2, 3);
+GEN_VXFORM_V(vrld, MO_64, tcg_gen_gvec_rotlv, 2, 3);
 GEN_VXFORM(vrldmi, 2, 3);
 GEN_VXFORM_DUAL(vrld, PPC_NONE, PPC2_ALTIVEC_207, \
                 vrldmi, PPC_NONE, PPC2_ISA300)
-- 
2.25.1


