Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A49AC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:38:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 355822064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 13:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ks9nZFBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 355822064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hycQc-0001cn-QX
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 09:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35479)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc77-0003cn-Cc
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hyc76-0005pv-4r
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42691)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hyc75-0005p5-VA
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 09:17:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id b16so1514273wrq.9
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 06:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=iOrN1oDy4mtnFyYdncXyASGVOIbsAR/8nt+jgVKFbKw=;
 b=Ks9nZFBi4Pzda7C5dxarSAxaW3oQKC9CVh7PMdE05oT94hB58T1gW70bHy0neEq266
 rNpcp4IUWEI6j1/66eRjdbm28/I0+LDVpa0FEBBYqd7QT2z/WO4d6CY0ZEO+gWfKLHx2
 ZmTIEoiYSGBzu2rdv7ce2rb0v5WDYLpt9PO88dlWm9+uBDpdHxv31v/B8UdwT7K4teAS
 swq25/B47vp2qSDox/34Knc1JLe2NuQ97bYQ+xzJ7+jICig1wPt/it/N+l/+K9nFjkcK
 O1LemtFmAW2dgBW4dM2tzYyP9J1gLnKRGDeKsnH5L6TVB28n+hN08pnKNhK1WRYDT9ze
 p7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iOrN1oDy4mtnFyYdncXyASGVOIbsAR/8nt+jgVKFbKw=;
 b=ELTN25wcVn4dRCfK2GkCJ6wtgYaRot6cMGjIEqrix8q4sSaj8rDG71c3ZWA3ruh62h
 v5Nzo2zGeClEE14kSoCjwXM4WfFyXef3XgrY2yOsi/4Am6uY7+F5HgMxpJbizRFCVUeJ
 8pT1Y9oBB+ISv+CG91DaCxlUxvuFNFAfmptPIjcN3dMuoNqwWcbZfl1pYRoh6wweKYP4
 vqR1lpeSoF/BXzuTFIXk8M+DNKTdyqmoLZN5O1t5QmDDmIvfj2fRJse2qpoG6kN88Koa
 rIN5RsiaV6kYVo0gaim5jiCdQJ6DXyPtXq54PQDMbLnRJUz78+Z10uskrXsC3dMvb23n
 Jt0A==
X-Gm-Message-State: APjAAAX/EprMv4pDPDeYfb8idA8AMU0gIVj50ntA6r2mqFf2sqouEJYp
 xM53332BT7pPi82eAB2LeshzrdYO4kP4LQ==
X-Google-Smtp-Source: APXvYqwY9fBuYLnm99fyZGBMu0VRwjFhE1BM4/vTV+frtNMtmPaj//glN+ZiP/e7C5iVJW6X1rAGaQ==
X-Received: by 2002:adf:f088:: with SMTP id n8mr11033293wro.58.1565961470893; 
 Fri, 16 Aug 2019 06:17:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 4sm8705796wro.78.2019.08.16.06.17.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2019 06:17:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 16 Aug 2019 14:17:16 +0100
Message-Id: <20190816131719.28244-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816131719.28244-1-peter.maydell@linaro.org>
References: <20190816131719.28244-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
Subject: [Qemu-devel] [PULL 26/29] target/arm: Use ror32 instead of
 open-coding the operation
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The helper function is more documentary, and also already
handles the case of rotate by zero.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190808202616.13782-5-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index ebc7c67f025..02ce8d44fa1 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -7964,8 +7964,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                 /* CPSR = immediate */
                 val = insn & 0xff;
                 shift = ((insn >> 8) & 0xf) * 2;
-                if (shift)
-                    val = (val >> shift) | (val << (32 - shift));
+                val = ror32(val, shift);
                 i = ((insn & (1 << 22)) != 0);
                 if (gen_set_psr_im(s, msr_mask(s, (insn >> 16) & 0xf, i),
                                    i, val)) {
@@ -8228,9 +8227,7 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
             /* immediate operand */
             val = insn & 0xff;
             shift = ((insn >> 8) & 0xf) * 2;
-            if (shift) {
-                val = (val >> shift) | (val << (32 - shift));
-            }
+            val = ror32(val, shift);
             tmp2 = tcg_temp_new_i32();
             tcg_gen_movi_i32(tmp2, val);
             if (logic_cc && shift) {
-- 
2.20.1


