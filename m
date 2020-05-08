Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9E3C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:12:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BE5206B8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 15:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCK3MOG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BE5206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX4fj-0004Pm-Po
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 11:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4eb-0002gB-Mp
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:38145)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jX4ea-00045Z-Jj
 for qemu-devel@nongnu.org; Fri, 08 May 2020 11:11:09 -0400
Received: by mail-pf1-x42f.google.com with SMTP id y25so1068536pfn.5
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=usEU+0THdbgtBj9wJbgNK97HinYANEa/S4b+EK/lCNc=;
 b=GCK3MOG1PFMyBYUWn8kNTX23z6NZiVTZCF/6GcwNrfM6DUay3EIEf4lk3gWo0eSlCF
 MpR3OnDGrmpEOI2xkTBHrSK9DHB0DazDbSdnbs7cFDRw+wl4bD/Kil+V/o1wHmt4AywU
 mj1+Wcqq9GMW7V+aAMPtxI4WYrWRcnvFV4f1btl60eGxHSWQvSHdDei5atG9Cxx7LrID
 mjiwC3y2W2lRByTBWqheKlusFoiAiXrCWpSoA0o3TaUp46vaiCrZtFC5PNCDl6Lj1s3L
 k/Grgi2mq+FD/O0AzYqOUfUe0Bhz66eYvFZHeW/fz1e2oW+KRvdSpDxFosgKuT48AhMZ
 RuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=usEU+0THdbgtBj9wJbgNK97HinYANEa/S4b+EK/lCNc=;
 b=dmB9tEcBsYURNZWoV+X5AfWItBj4g0vA3SIzZpz9cjigBcTjhO4kOcCZgxPKlffuHb
 nzq77ffBBjcxu9D3+GbDV4aIU9YVB0FBKOC/iYu3W46+G0zPP0HWzzVcENmasXv+fSuf
 QtMhAgoBcf4d68XIATrhtxrZwcvfaZegg/8KcsjZwBoAbDgq9iwsSXeoC06BSGIr2wXg
 LnRHY96EXsZFeTM4sED2j6zhrTd3zNRSnJhHHCtjt9N/3O63k9K60zNaaXhNRZL12Cwp
 8fgHKOupnIFOS8ytWbgMfuecZu60b7GWRcyF/8jzhfC0PJX0ck8KbWrGOnD/AcOJcRS6
 jY9Q==
X-Gm-Message-State: AGi0PubEuEBv1iEJwmPBxs8aUGlXZ2yD8xKF1J/zE85LnqIKEZqsCYbP
 ffOVd6UjZFNp67sIx9aNbmfrnRl5Iqk=
X-Google-Smtp-Source: APiQypKaUXuOl8AeerpMAPJmcf0M6foKReF/8p2WM8hVrI99Qm5HWwV0TzgwtywjhjEtqeylfO34ZA==
X-Received: by 2002:a65:6417:: with SMTP id a23mr2402252pgv.97.1588950666747; 
 Fri, 08 May 2020 08:11:06 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d13sm1557562pga.64.2020.05.08.08.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2020 08:11:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/10] target/ppc: Use tcg_gen_gvec_rotlv
Date: Fri,  8 May 2020 08:10:53 -0700
Message-Id: <20200508151055.5832-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508151055.5832-1-richard.henderson@linaro.org>
References: <20200508151055.5832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
Cc: alex.bennee@linaro.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  4 ----
 target/ppc/int_helper.c             | 17 -----------------
 target/ppc/translate/vmx-impl.inc.c |  8 ++++----
 3 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index a95c010391..b0114fc915 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -213,10 +213,6 @@ DEF_HELPER_3(vsubuqm, void, avr, avr, avr)
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
index 6d238b989d..ee308da2ca 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1347,23 +1347,6 @@ VRFI(p, float_round_up)
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
2.20.1


