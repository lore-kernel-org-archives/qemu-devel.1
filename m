Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26F8C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6C7D20663
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 22:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KTVt+CYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C7D20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJmXb-0006CV-Vg
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 18:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJa-000749-OO
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iJmJZ-00013L-EY
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:14 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:40957)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iJmJZ-00012f-9L
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 18:26:13 -0400
Received: by mail-pf1-x430.google.com with SMTP id x127so9259650pfb.7
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 15:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=TP3AGBJHylcwVuHBsF2tuldK7PZ1RLZ5nrABMW1HnLc=;
 b=KTVt+CYePvbhTj9Xu/MEfannvdLUtWmznAGd2rxGCRf/QAJ0MKy75Py+IxKSltbg1G
 VSB1h4T0GyU65pwsBL+yMPxKGWwS9AHrqXhTCKozBsVV6cOyPRBuRDLS86PlB0+Dkezh
 phrpATOMHKT4CiWx152vywGyO/qwWj7hrM/nL1IMIr9U6o5nyZT4c4paKH9R60+Qm6k5
 j2biesOQ4jUP5ObHRl256a6UciJIF9rLiOO1gWa6EC4AtkgJDrRi2LjnYTSOTzyf+7Jq
 O4/P5JPb7Yl9jqoI/TE8GAZD77mkVFj062FlLW+4cv8MtvWBzzDyXyDazvd3agJ4XIPL
 Ntpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=TP3AGBJHylcwVuHBsF2tuldK7PZ1RLZ5nrABMW1HnLc=;
 b=tGt2zR1za7ur+hS1o3J8PTtN9yeQH/a5etgFqL/JEr7r8o+xsuVD6dfToHxzXSbjAV
 J2D6mUx/vUZmfaBPbYPdlGKhxsa6l2vCyrqkoFwE1VWwTkaXqDyOY+mw4uhK5tznCQpJ
 Fwis56DfNmN8tl+sZI4jwUvFQe6vuN+ofTdPsmBMNtKwqvW7VLa76EupoPH4uu/YHnRi
 FBtC+PZDPM59doiT2puIjnGe5XuCDdHAjajBsyjUVDIRDmu5sPAejs1CRA31cRw9Slc2
 fvPjqTLnUaNh1WIjoQq3fTxJenl2ptuBeRZkJbyo/acUMC7Ca8aLzeDKZSAJU/GL/i0W
 OmHQ==
X-Gm-Message-State: APjAAAW10mxBMk4P/CQusOkFKerDH9rZs7ylkofEor4K0+1jhh5qEzlS
 zRVBYB2t5eYgmUrrPhATlCasEXsLz2o=
X-Google-Smtp-Source: APXvYqzkFHXdx5v47afG5kw0m9VMB9F0f1AzRrQ03GQSA4UGD0NVkQdcv1dxMZdTK1uQee4rp4N1Kw==
X-Received: by 2002:a63:4525:: with SMTP id s37mr27676174pga.148.1571005571322; 
 Sun, 13 Oct 2019 15:26:11 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id d76sm15940571pfd.185.2019.10.13.15.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 15:26:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/23] tcg/ppc: Update vector support for v2.07 FP
Date: Sun, 13 Oct 2019 15:25:40 -0700
Message-Id: <20191013222544.3679-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191013222544.3679-1-richard.henderson@linaro.org>
References: <20191013222544.3679-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These new instructions are conditional on MSR.FP when TX=0 and
MSR.VEC when TX=1.  Since we only care about the Altivec registers,
and force TX=1, we can consider these to be Altivec instructions.
Since Altivec is true for any use of vector types, we only need
test have_isa_2_07.

This includes moves to and from the integer registers.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target.inc.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tcg/ppc/tcg-target.inc.c b/tcg/ppc/tcg-target.inc.c
index 6321e0767f..840464aab5 100644
--- a/tcg/ppc/tcg-target.inc.c
+++ b/tcg/ppc/tcg-target.inc.c
@@ -586,6 +586,11 @@ static int tcg_target_const_match(tcg_target_long val, TCGType type,
 #define XXPERMDI   (OPCD(60) | (10 << 3) | 7)  /* v2.06, force ax=bx=tx=1 */
 #define XXSEL      (OPCD(60) | (3 << 4) | 0xf) /* v2.06, force ax=bx=cx=tx=1 */
 
+#define MFVSRD     (XO31(51) | 1)   /* v2.07, force sx=1 */
+#define MFVSRWZ    (XO31(115) | 1)  /* v2.07, force sx=1 */
+#define MTVSRD     (XO31(179) | 1)  /* v2.07, force tx=1 */
+#define MTVSRWZ    (XO31(243) | 1)  /* v2.07, force tx=1 */
+
 #define RT(r) ((r)<<21)
 #define RS(r) ((r)<<21)
 #define RA(r) ((r)<<16)
@@ -715,12 +720,27 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
         tcg_debug_assert(TCG_TARGET_REG_BITS == 64);
         /* fallthru */
     case TCG_TYPE_I32:
-        if (ret < TCG_REG_V0 && arg < TCG_REG_V0) {
-            tcg_out32(s, OR | SAB(arg, ret, arg));
-            break;
-        } else if (ret < TCG_REG_V0 || arg < TCG_REG_V0) {
-            /* Altivec does not support vector/integer moves.  */
-            return false;
+        if (ret < TCG_REG_V0) {
+            if (arg < TCG_REG_V0) {
+                tcg_out32(s, OR | SAB(arg, ret, arg));
+                break;
+            } else if (have_isa_2_07) {
+                tcg_out32(s, (type == TCG_TYPE_I32 ? MFVSRWZ : MFVSRD)
+                          | VRT(arg) | RA(ret));
+                break;
+            } else {
+                /* Altivec does not support vector->integer moves.  */
+                return false;
+            }
+        } else if (arg < TCG_REG_V0) {
+            if (have_isa_2_07) {
+                tcg_out32(s, (type == TCG_TYPE_I32 ? MTVSRWZ : MTVSRD)
+                          | VRT(ret) | RA(arg));
+                break;
+            } else {
+                /* Altivec does not support integer->vector moves.  */
+                return false;
+            }
         }
         /* fallthru */
     case TCG_TYPE_V64:
-- 
2.17.1


