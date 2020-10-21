Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1544C561F8
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:56:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F996207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 04:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XXVdG05Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F996207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kV6Ab-0005Us-E7
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 00:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66V-0000SC-0c
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:03 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:52192)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kV66T-0005h8-6m
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 00:52:02 -0400
Received: by mail-pj1-x1044.google.com with SMTP id a17so519297pju.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 21:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vw1fpXxTPO16yzgwqOIWW38UgkU5WY9AeukvYjNGLyM=;
 b=XXVdG05YrAHAL8Kb+NXJvdEPFZbftuzEdprKf7UVzAVuF++sAhs57QlyAWUjX5fUF7
 C7BcXncs2Hf1q8C8Fzb7CXiQQTxJIxeHYCaw2ONSWBbfPPU2AaWi51fYUOhsdtmZkq8b
 VXzypYMUL80QbAkeRg8mD1zkrgf/Lz9HNbiUfRX7VNC4T1OExkFkJz7K9rzjdlJoTNo8
 3amryEosk/fQy+ePsVtNgdXs9Bs2O3QiuDF99Ze3PYT89iovoO8wATQnwBgyie01lRtG
 UI4GGCpj+ZKSDnrKdzoQdH+5ukjP+mxPMnlk5lwCEH7YxwVIG8MkHGrASUym1PF+nNgu
 wzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vw1fpXxTPO16yzgwqOIWW38UgkU5WY9AeukvYjNGLyM=;
 b=rPzSGT5Q4E6xqo5WwuIx9Pn87Nu8nmLNCRtKUO5gogPHmzSSY3BtBq68Jq9kpLEP6C
 s0ViOtQ7t0O1JHfGam80cyA5PMkK1dJbdiBSgS+P7gifhoI2jYheAmwLhXCuShAcBQLh
 gIhH5U81BgA52Fn6ShXsDiYG4t39kwsdytkm+jykOSzGOHOSMxozZXWRoLDTjjP8CF7C
 JOzhUP8YuMHX1V2ql89X/1Klag/U6/3by99OwX8sGJaQ9W/j9U3E4ctLBsKzxfyOKbLz
 95LhKpMBHi1SHbMtLYH/kVA8evj3QIHQALeKbZRIsqKNYAIgGhovPQUunjajDGy4eo5z
 /fUQ==
X-Gm-Message-State: AOAM5308Tiq5H1m91T9TpIkX5VfOdjxn4rn9uC5X+fIp0alsGz32lWPf
 /4Lrk51PCSoFJjg8GNkg7hWlXui6y1dnkw==
X-Google-Smtp-Source: ABdhPJzgNMLtCfE2wDiDc7atddrfiKsab9k0Wq5JmiYp+9/XHMN6PflPoqABQ/nE84oiURg3f8yE7A==
X-Received: by 2002:a17:90a:9504:: with SMTP id
 t4mr1548903pjo.82.1603255919475; 
 Tue, 20 Oct 2020 21:51:59 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm620070pfh.143.2020.10.20.21.51.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 21:51:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 06/15] softfloat: Use mulu64 for mul64To128
Date: Tue, 20 Oct 2020 21:51:40 -0700
Message-Id: <20201021045149.1582203-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021045149.1582203-1-richard.henderson@linaro.org>
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Cc: alex.bennee@linaro.org, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Via host-utils.h, we use a host widening multiply for
64-bit hosts, and a common subroutine for 32-bit hosts.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/fpu/softfloat-macros.h | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/include/fpu/softfloat-macros.h b/include/fpu/softfloat-macros.h
index a35ec2893a..57845f8af0 100644
--- a/include/fpu/softfloat-macros.h
+++ b/include/fpu/softfloat-macros.h
@@ -83,6 +83,7 @@ this code that are retained.
 #define FPU_SOFTFLOAT_MACROS_H
 
 #include "fpu/softfloat-types.h"
+#include "qemu/host-utils.h"
 
 /*----------------------------------------------------------------------------
 | Shifts `a' right by the number of bits given in `count'.  If any nonzero
@@ -515,27 +516,10 @@ static inline void
 | `z0Ptr' and `z1Ptr'.
 *----------------------------------------------------------------------------*/
 
-static inline void mul64To128( uint64_t a, uint64_t b, uint64_t *z0Ptr, uint64_t *z1Ptr )
+static inline void
+mul64To128(uint64_t a, uint64_t b, uint64_t *z0Ptr, uint64_t *z1Ptr)
 {
-    uint32_t aHigh, aLow, bHigh, bLow;
-    uint64_t z0, zMiddleA, zMiddleB, z1;
-
-    aLow = a;
-    aHigh = a>>32;
-    bLow = b;
-    bHigh = b>>32;
-    z1 = ( (uint64_t) aLow ) * bLow;
-    zMiddleA = ( (uint64_t) aLow ) * bHigh;
-    zMiddleB = ( (uint64_t) aHigh ) * bLow;
-    z0 = ( (uint64_t) aHigh ) * bHigh;
-    zMiddleA += zMiddleB;
-    z0 += ( ( (uint64_t) ( zMiddleA < zMiddleB ) )<<32 ) + ( zMiddleA>>32 );
-    zMiddleA <<= 32;
-    z1 += zMiddleA;
-    z0 += ( z1 < zMiddleA );
-    *z1Ptr = z1;
-    *z0Ptr = z0;
-
+    mulu64(z1Ptr, z0Ptr, a, b);
 }
 
 /*----------------------------------------------------------------------------
-- 
2.25.1


