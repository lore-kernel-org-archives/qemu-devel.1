Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99C0C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:04:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E91206EC
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 19:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BGfglrrd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E91206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEHWF-0003bf-Nz
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 15:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jEHRx-0007G1-5m
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jEHRw-0004iv-1w
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:25 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:35567)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jEHRv-0004eO-RO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 15:00:23 -0400
Received: by mail-pf1-x42e.google.com with SMTP id u68so12461172pfb.2
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2020 12:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cjiEN6evoksJ22gJdgVrmGMglErN9l7nWJMK6r0f5rQ=;
 b=BGfglrrdGEDaRy8KlNhNP5WNVPSYFSqebEGhUJXsQRGcgeLX7WtOHjk4NPiJ0TLJ2J
 02eQrrlbwUBKAVBKnnT6mx4OmlCShgO2tVDB6gXaIs3ak2Z92Uvp999dhDfp0pY/kH9H
 +meosza+IBTpfZpi6xZJQ/fAf5vJAiGHZRJn1G7GGtyPqpweg9iwi+38qxasbQHsgLeu
 eOsWhrKSTTA0kZw7QVxfTvH0XIGAEWjevX9I5HE/NsY16cdks+eH/zvmKy99swGD9wUC
 JNgbsIxU6zvQOezC8nN/aLQsQQ4+7BV+cTvzDT/2JEKdyxCAWcbVOkP/YZ6+6ElmDagr
 2okQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cjiEN6evoksJ22gJdgVrmGMglErN9l7nWJMK6r0f5rQ=;
 b=arbKbuuUQZRLpLSUjOspvsijWAZDbsfwETp1zH470z9kE+NxberdW1aK1lryUHzL/B
 QJ30ruDOz63qnWTq4I8w6jl7QMbbEYUNi7Ric8FOjPH0MoVB989rFZGqOq/F0etMj1RV
 W/HWQM0iFyHgFIX3ZP+3D08hr2kNboyptT+szu47dn8JSXtAa9eAgnIfyZ70l56/PHuK
 4tqsYI89S2Nz7NMw9gqdqPJ+jKVKnZDQIoVF4qUcJgTOCglem8n+i8klIeGQrhC0M/kH
 b4sm6iRO/+YQhO551yDWYvi0f9y0mLjpfoEd3iz+MMEmP1n1q9oQ5l9NNuc/uiReZLPd
 fcGA==
X-Gm-Message-State: ANhLgQ2JI/mDfK8RlzeoIxl2uYaGInzis15ji/DNLffXWL+SUPtWnQ6b
 CDNiY5x/mtYYi4tdyIctf6mdYuPKuIU=
X-Google-Smtp-Source: ADFU+vucuS4CkbmYWgpOYKlwz8NBYryHna1r7ybHokMcFicNYEb0O5KKB1ij2YV862OxUR5egJAx4w==
X-Received: by 2002:a62:7ad7:: with SMTP id v206mr169673pfc.181.1584471622374; 
 Tue, 17 Mar 2020 12:00:22 -0700 (PDT)
Received: from localhost.localdomain (97-126-123-70.tukw.qwest.net.
 [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id y13sm3738411pfp.88.2020.03.17.12.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2020 12:00:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] tcg: Remove tcg-runtime-gvec.c DO_CMP0
Date: Tue, 17 Mar 2020 12:00:13 -0700
Message-Id: <20200317190013.25036-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317190013.25036-1-richard.henderson@linaro.org>
References: <20200317190013.25036-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42e
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

Partial cleanup from the CONFIG_VECTOR16 removal.
Replace DO_CMP0 with its scalar expansion, a simple negation.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime-gvec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index f2199f14b4..ca449702e6 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -860,15 +860,13 @@ void HELPER(gvec_sar64v)(void *d, void *a, void *b, uint32_t desc)
     clear_high(d, oprsz, desc);
 }
 
-#define DO_CMP0(X)  -(X)
-
 #define DO_CMP1(NAME, TYPE, OP)                                            \
 void HELPER(NAME)(void *d, void *a, void *b, uint32_t desc)                \
 {                                                                          \
     intptr_t oprsz = simd_oprsz(desc);                                     \
     intptr_t i;                                                            \
     for (i = 0; i < oprsz; i += sizeof(TYPE)) {                            \
-        *(TYPE *)(d + i) = DO_CMP0(*(TYPE *)(a + i) OP *(TYPE *)(b + i));  \
+        *(TYPE *)(d + i) = -(*(TYPE *)(a + i) OP *(TYPE *)(b + i));        \
     }                                                                      \
     clear_high(d, oprsz, desc);                                            \
 }
@@ -886,7 +884,6 @@ DO_CMP2(16)
 DO_CMP2(32)
 DO_CMP2(64)
 
-#undef DO_CMP0
 #undef DO_CMP1
 #undef DO_CMP2
 
-- 
2.20.1


