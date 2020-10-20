Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49766C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:49:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81BB206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 16:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWZ24J1x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81BB206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUuos-0005SO-Dr
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 12:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUudt-0007hg-Fo
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kUudr-0000xC-LJ
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 12:37:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so2988283wrq.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QWLXVwtDu65vCD1CaNwfFzInaZDsuzIveGR3ZrqO5Rg=;
 b=aWZ24J1xg7NBdDXmrSIHd6kfQbwttHNJW9m6jAo316wJAlpsL0wYM/TC08jCRUsIU0
 1PrJApvp6g7xadoMT3o7XPzu5oe8Igkp8XeTtZl/ez0MAEU2y8AA5zZ8q0LjvCh07tHp
 hzli0oeBB8InEJKffyj0B2IwzNBPwJv0t+aJfmlXiql4T+sxMTlsijdfijjBz7SnOZr0
 EMezFUo05YHyk2thYQ7j2gvZMo/EocbXsMSok/C0snSsb+7Y1UYEegs/F3bCCz91R2bC
 nT2PunFSs9mSK5A9ofHVWwMRAqovLwaLFrPw8K47UCbVkRRJlCITz6V/aq5gpH6KLKIz
 +IgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QWLXVwtDu65vCD1CaNwfFzInaZDsuzIveGR3ZrqO5Rg=;
 b=BERygg1fpQiNa7vMhVLh5QmRqyfdjLUJ+WDkIFWHB4FB2TYMrXyNgsmaTx3ocVHcEG
 fR719ukoaQx8YKI56sIUXjhfiShi14/6HaBFKEB0DGDBjJ4U9IfIhv4URw0z3KET5VuS
 Bpa4S/ShWVwsCF4BZ2fzOmW5Ftjs+02dx8DSwks9MsQrBL/U3DMpy6FwPWGDWhiOS3HH
 e6yBQB6YfxXxyPOsadW1zsN9L9sR+niyP773B8NwnpJkUDoGBdlHSDQBMiRtDDPRZxS6
 XGLF5wxCL3Z7new+OIQtYtxc5NJZbNQsETGCZOtuSCDkOYCy9rO4pBSuWMQz6c10ZOaY
 WQ7A==
X-Gm-Message-State: AOAM530F3l50sw6jTTW+kXujsEvwwREpMWNnfXSYnOnNN/U5yRW+B1ws
 PTnDrhwFDeURb4zcN8wD246laA==
X-Google-Smtp-Source: ABdhPJy9QQyIOasnj4ql6wfai/PU4IGSJ8xggHaOzMidzqaxsdW7htE0k/3aTteIQYwR98jKpfM29w==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr4745812wrs.115.1603211861770; 
 Tue, 20 Oct 2020 09:37:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j17sm3636816wrw.68.2020.10.20.09.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 09:37:39 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1AFFB1FF87;
 Tue, 20 Oct 2020 17:37:39 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  1/8] softfloat: Use mulu64 for mul64To128
Date: Tue, 20 Oct 2020 17:37:31 +0100
Message-Id: <20201020163738.27700-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201020163738.27700-1-alex.bennee@linaro.org>
References: <20201020163738.27700-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Via host-utils.h, we use a host widening multiply for
64-bit hosts, and a common subroutine for 32-bit hosts.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200925152047.709901-2-richard.henderson@linaro.org>
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
2.20.1


