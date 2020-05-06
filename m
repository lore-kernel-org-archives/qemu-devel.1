Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DC9C28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05CA20736
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 18:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mLV8UuV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05CA20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWOsA-0000uo-Mr
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 14:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo8-0004Qf-SZ
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:12 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030]:40063)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jWOo7-0002vj-Uv
 for qemu-devel@nongnu.org; Wed, 06 May 2020 14:30:12 -0400
Received: by mail-pj1-x1030.google.com with SMTP id fu13so1279819pjb.5
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 11:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=glPDdkgy28ft6bPZXYEAIgcEtYEuVNy5yrxjCgISMLo=;
 b=mLV8UuV5Inee/G/+eaSyLhDdGPQpbKi00u6N+AL/HYHPIa2lV/ss8Vjd0sM2M/Lygl
 VPf3GsAhxRWFe8Qr+lZGpT+M8aTjQJYNbSI9dn7AuhktVgb2XKix0A6NVqgozADMd+G8
 gGPZMWXmda9MFL/xmZYh/BsMBqjyWmWFL8u9GCKqaOXdZgKw9qzaApgkIWteFZLU5p00
 F9weP+kl+3LUT7zwIlLWOn49Y0Hty+aP+4pLaw4eYTAvEokqNcly1FoGxaN4O4aFfIPX
 i6oJQXee+xsNHPNdMHaBrByrUxv+58lu4y9Tw6FDHjMnuNRIA/Zn6Gir3Fp0Atedj87d
 7R6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=glPDdkgy28ft6bPZXYEAIgcEtYEuVNy5yrxjCgISMLo=;
 b=noTdpwRcmsUTzdpTAzFz6cVdKG0lylP+Fc4NaSkMzyshT/ofyosOJYZFaUmzb/ew1u
 /01iN9swSnSsfwbHj0K5qvI8py5BrFhdyWD6s2f0JxBz7TrnJbRGRtYIrXHhyaNCOnPK
 c3atedS6/bBsD8bzjmQvWMKsPM+sdu2r0hBmsJbgT9z/YEDJi0YDQXwJk3PahZFhaCCk
 4ke3+ls/MavhB+q10HqD8TKIwaDLB1sbWfPt55B+26P+PNYkZWcM+O3Sb6RyQ/a+qb3a
 J9+F6g9pf5P6qMItfbjwk6hu4jtYfQSmRKNKYcgwseQ/veaYZ52a0TbXbLLhWbUjRCQu
 k+hA==
X-Gm-Message-State: AGi0PuZMvxbw+16twsje48JeXEIxkFEzV70mDRq9e5M84QwZEiBQGNsB
 wbk9wBaH5awGkEEzjsurfcLOP6JxzB4=
X-Google-Smtp-Source: APiQypKdfio5zlavFnrjk2dvaUBMeq/7FI09s6G2wWY0oMnU+Hfk7MUrcqUuPIFyjjOE5mo40ngleg==
X-Received: by 2002:a17:90a:6403:: with SMTP id
 g3mr11051866pjj.99.1588789810161; 
 Wed, 06 May 2020 11:30:10 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id w11sm2572589pfq.100.2020.05.06.11.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 11:30:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] tcg: Use tcg_gen_gvec_dup_imm in logical simplifications
Date: Wed,  6 May 2020 11:29:57 -0700
Message-Id: <20200506183002.3192-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506183002.3192-1-richard.henderson@linaro.org>
References: <20200506183002.3192-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the outgoing interface.

Reviewed-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 593bb4542e..de16c027b3 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -2326,7 +2326,7 @@ void tcg_gen_gvec_xor(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
@@ -2343,7 +2343,7 @@ void tcg_gen_gvec_andc(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, 0);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, 0);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
@@ -2360,7 +2360,7 @@ void tcg_gen_gvec_orc(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
@@ -2411,7 +2411,7 @@ void tcg_gen_gvec_eqv(unsigned vece, uint32_t dofs, uint32_t aofs,
     };
 
     if (aofs == bofs) {
-        tcg_gen_gvec_dup8i(dofs, oprsz, maxsz, -1);
+        tcg_gen_gvec_dup_imm(MO_64, dofs, oprsz, maxsz, -1);
     } else {
         tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g);
     }
-- 
2.20.1


