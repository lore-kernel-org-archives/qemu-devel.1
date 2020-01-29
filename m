Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86901C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:13:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE3E206F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 00:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Me1sOCIM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE3E206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwxSx-0007Iu-FE
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 19:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45375)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCO-0003vo-3h
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iwxCK-0007rh-1Z
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:41 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iwxCJ-0007nz-RJ
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 18:56:39 -0500
Received: by mail-pg1-x542.google.com with SMTP id b9so628026pgk.12
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 15:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PqA4gXrQw/YgIe/VLIqODWM57tw/29enNMJA95PXJps=;
 b=Me1sOCIM1NVj2VKw6rilc4T6ZURM6a1sLm5No1PQYPMUgcxmMB2ED3RLgNwPv2SOWn
 phNvC6aBPYSWqje3tu+Vn2qH0qPq2bTadW+z8F6sFQRPHsBksWtaBR6+JqhbJFSpfxAi
 MtF+jIsu6qy+JKywoXtpxpAPCD/cZoH34hjQ7ikqP17LKZCPsiej/Ogi0nPWfMhraokY
 D315NDI5KRsvCaTRjh5Yuk+2VDUcJhnP002meOGbzbs+5fSe5f16/BVuei6InZUzWrIk
 chc7tYDYaYEuT1X9IyOgWRMX7cmp8hwQfaKM6opvMX1i5151vH1KeRRwyCW4AKuwWOfp
 Nx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PqA4gXrQw/YgIe/VLIqODWM57tw/29enNMJA95PXJps=;
 b=co5mYFit2mdy7kn1y+OpzD7vWfRN7kqB73Jv3Q4WcdKL+sT9gYKwpI2C3MdtUiWp4I
 Whv4sa6P3zHcKLGfcmAo9pRS9T3DKWfToP24pzN0bcJCpl7qUP3EJ/49Yw3hb/eU44TN
 WuVistni+KdMsO+86xu93+w4waOT5ZMQqEETP1p4FdfhBK//tVwhYQRHz7e/QvSeWUme
 r26l9pWaje2StaYX+2nb1BrHxm2G5jWyYLEhx5LPqhoWiG+n9uHxmQxXr/kFBktPwaCs
 JI+CtCLvt4q7KgiJuXWR/kQHpTcZ02g7oLwpekduZxnieIerwlsovKf40WECOt+LwH/q
 vd4w==
X-Gm-Message-State: APjAAAU7+ZXYdef+zsOgOvjqkDYDsoClg1zw+R6FvmWWxBEx1GsV2sHx
 IJfjO1S1ji9ioz0P/R9IacvrE3adyeY=
X-Google-Smtp-Source: APXvYqwBEsOiRWf4Lq0R44VjQ1vFtqS8A6rTWyeJP1yNUxLJI9KrxNPUneKRp0HanrelU4dNgyvfjQ==
X-Received: by 2002:a65:66da:: with SMTP id c26mr1720633pgw.354.1580342198588; 
 Wed, 29 Jan 2020 15:56:38 -0800 (PST)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id r3sm3953626pfg.145.2020.01.29.15.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 15:56:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 18/41] target/arm: Tidy ARMMMUIdx m-profile definitions
Date: Wed, 29 Jan 2020 15:55:51 -0800
Message-Id: <20200129235614.29829-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200129235614.29829-1-richard.henderson@linaro.org>
References: <20200129235614.29829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the magic numbers with the relevant ARM_MMU_IDX_M_* constants.
Keep the definitions short by referencing previous symbols.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 68ad96f8e8..3525b6425b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2905,14 +2905,14 @@ typedef enum ARMMMUIdx {
     ARMMMUIdx_SE10_0 = 4 | ARM_MMU_IDX_A,
     ARMMMUIdx_SE10_1 = 5 | ARM_MMU_IDX_A,
     ARMMMUIdx_Stage2 = 6 | ARM_MMU_IDX_A,
-    ARMMMUIdx_MUser = 0 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MPriv = 1 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MUserNegPri = 2 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MPrivNegPri = 3 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSUser = 4 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSPriv = 5 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSUserNegPri = 6 | ARM_MMU_IDX_M,
-    ARMMMUIdx_MSPrivNegPri = 7 | ARM_MMU_IDX_M,
+    ARMMMUIdx_MUser = ARM_MMU_IDX_M,
+    ARMMMUIdx_MPriv = ARM_MMU_IDX_M | ARM_MMU_IDX_M_PRIV,
+    ARMMMUIdx_MUserNegPri = ARMMMUIdx_MUser | ARM_MMU_IDX_M_NEGPRI,
+    ARMMMUIdx_MPrivNegPri = ARMMMUIdx_MPriv | ARM_MMU_IDX_M_NEGPRI,
+    ARMMMUIdx_MSUser = ARMMMUIdx_MUser | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSPriv = ARMMMUIdx_MPriv | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSUserNegPri = ARMMMUIdx_MUserNegPri | ARM_MMU_IDX_M_S,
+    ARMMMUIdx_MSPrivNegPri = ARMMMUIdx_MPrivNegPri | ARM_MMU_IDX_M_S,
     /* Indexes below here don't have TLBs and are used only for AT system
      * instructions or for the first stage of an S12 page table walk.
      */
-- 
2.20.1


