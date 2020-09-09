Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EA7C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E1D2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSx3WBEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E1D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnpr-00055k-PR
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnT-0008BV-GQ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:11 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:51069)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnR-0002EC-Pz
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:11 -0400
Received: by mail-pj1-x1041.google.com with SMTP id b16so437218pjp.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=oNAn0opw3juAzKtNOLvu3FWPGR8vu8k8ubiNRQeOiqo=;
 b=eSx3WBEmuK1OhvC0FjiBJktjMgMjUpY+7eof26l+18q8p+dLQlzeAGwidb5YItGAwz
 XVRCO/8pfNHMiwU6xTyax0gtAAvgorPHco0ORwRLL1KP/MADpDvkbTsgeMAtlGy1oyKr
 WiRV4lCySzjwPosBMxTvrq52gtJB9tgAqRKhreF7gntIZ7fyagDueo1Rpi6T45UBc+P8
 M7yhSuBcx/9hpe05kO7niqDKDMXQCplf+tLIDtRbNIqz0c60Kw1u7hOSvuz8korgfSXh
 1xmnHQVct/+RZZC+fut6kfOwM7LC6yMwTVej08qDB0jyeuQ1Ur6ih6W3u2OjNWsMi8fz
 LcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=oNAn0opw3juAzKtNOLvu3FWPGR8vu8k8ubiNRQeOiqo=;
 b=WQ9a8uHO3KivqGTIb2Eh0sTIjOPbsWGTKYxb5PeyqG68PR69hp/Okgxgfr2Y0Ej9TF
 Kfu0D3lu1YsAFOs79Kkcm8rOSw89aUCcs9nuJovamoNxGpZ3cqCLQ3DWZLYw9QHgifAR
 1zYsoTOsyWu/LpnKLLqKAGkl/bi2eJ17EXhc5Vy4HuiWTlFk6M4r1lJ8Xn1dc8vLWb+F
 nF8puUNCg2M8ExwKFJSfzMOQtgTl/rz8/c73ON7jRPtcw88pNAwK8vmmqMeGSZWTkodc
 TKQHCIxVpz4u1wbUS5dIejDG5kjPJb4zGNl3Jm3lzELWMZhZT/2LZtJoTLVx/RiCSC/D
 1fpg==
X-Gm-Message-State: AOAM531xTPcmJAPYPRqja5Tt0Pnwu9VUvdpkTiOeaBR58Ums/HVuwMxN
 B8aYp/Ogd4Rr6CGjky+xBRsSvhlpTn0YBw==
X-Google-Smtp-Source: ABdhPJyPkkG7OMl5RCenWoa+V6jcRyuOeK8EWOUKNcRqT0f1qfdKX6FUxtm9udwniaYPHbvz+7B8BA==
X-Received: by 2002:a17:90a:474c:: with SMTP id
 y12mr1133272pjg.150.1599610628069; 
 Tue, 08 Sep 2020 17:17:08 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 15/43] tcg: Expand TCGTemp.val to 64-bits
Date: Tue,  8 Sep 2020 17:16:19 -0700
Message-Id: <20200909001647.532249-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This will reduce the differences between 32-bit and 64-bit hosts,
allowing full 64-bit constants to be created with the same interface.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 2 +-
 tcg/tcg.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 44ca8845cf..f3eca6feb0 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -506,7 +506,7 @@ typedef struct TCGTemp {
     unsigned int mem_allocated:1;
     unsigned int temp_allocated:1;
 
-    tcg_target_long val;
+    int64_t val;
     struct TCGTemp *mem_base;
     intptr_t mem_offset;
     const char *name;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 577bfec202..1650c5a9db 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3094,7 +3094,7 @@ static void dump_regs(TCGContext *s)
                    tcg_target_reg_names[ts->mem_base->reg]);
             break;
         case TEMP_VAL_CONST:
-            printf("$0x%" TCG_PRIlx, ts->val);
+            printf("$0x%" PRIx64, ts->val);
             break;
         case TEMP_VAL_DEAD:
             printf("D");
-- 
2.25.1


