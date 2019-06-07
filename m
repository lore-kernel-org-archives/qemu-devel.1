Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBA1C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AF0F208C0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 19:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EpffRNTJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AF0F208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51792 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZKb3-00077a-1P
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 15:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51324)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZJdG-0004wn-5o
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZJdD-00078G-CT
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:30:30 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41157)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZJdA-0006yF-9I
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:30:26 -0400
Received: by mail-oi1-x244.google.com with SMTP id b21so2090958oic.8
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 11:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=Gaowb1UdRjBy2Ja/xxobvWr0UDUJEDRhjYpKLZza8bQ=;
 b=EpffRNTJmjm1nFQ+NbkhcECJkPaytAKweaSVl+Ng5mF0SnvePnHNfHpr//dT3d/IVJ
 s0TFjMVn/Mfr9P6OPR6zTYQr/T6uy2qBv4X9oYD41Uv/bCLu74Lc5F+NekBJxM4nPILN
 jLvowT7QiYvIU4a87zLh/MXClhpBk3tyVVvcCljzr6WyZj+06th8BLBkR+VSwgIH6MDZ
 taukUefd2qz+FoYNK4EYYJuD3/8Mh2R9dW3ShxDlsQko93RN/LxHpYNNEjKIklxOT9dU
 5JqB3I5YgD1xVtGdkVO5Zev+L9yIckuK1/dtZCQX0URSEvS3WeB7WgXOZwmeQjROXt1o
 mPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Gaowb1UdRjBy2Ja/xxobvWr0UDUJEDRhjYpKLZza8bQ=;
 b=ssdq1ZBFgRCCNbKVQlPCKjtV/vRbAXtKrhm2/ciFr0Kg6JyWIZRnvWfgDPoApQY8ZA
 ltBreN4HMrXZ3IigaVrGQ5iHmi1lQ7qAQ98KsmDw+bWJtPu6FCnWIHrKpeE/Tdj27G/G
 Lp7V9nMCDwUNwAGwLPW7oNuLSUuA8ABtRfMV868Fy/o/gIQcGl/RLedppZo1rnw9BS6a
 9AdX6PUuh9wMP6Oq4GbdDTguwi8AvA/fivjb5lwrVgGHjVXLHRCi7NppQB0tyFJ7bsFC
 kx/HRvUKLx8qgh6vuDz+A3QXhadgIk3ps0OVN58ypZdgL/BW22rITijE0BEWLDMzgnwN
 ee2w==
X-Gm-Message-State: APjAAAWlqDSPacHKmuYfWA8nEb7wQ1FCmSFtDvU+7XVuLWNrijbmSsj/
 LzyDSJMAEwxVo0hfA2YFyYh70hDonveDPg==
X-Google-Smtp-Source: APXvYqy/Iwc/kb+mvzSkPjA7wxD5VKy2Dgv1uv7nZtg1nficDab73Zm8fIk1oncTL08C3/7tWCzEKw==
X-Received: by 2002:aca:4b96:: with SMTP id y144mr4722893oia.34.1559932220484; 
 Fri, 07 Jun 2019 11:30:20 -0700 (PDT)
Received: from localhost.localdomain (200-56-192-86-cable.cybercable.net.mx.
 [200.56.192.86])
 by smtp.gmail.com with ESMTPSA id s4sm995043otp.3.2019.06.07.11.30.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Jun 2019 11:30:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri,  7 Jun 2019 13:30:16 -0500
Message-Id: <20190607183016.8285-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Subject: [Qemu-devel] [PATCH] tcg: Fix typos in helper_gvec_sar{8,32,64}v
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
Cc: lvivier@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The loop is written with scalars, not vectors.
Use the correct type when incrementing.

Fixes: 5ee5c14cacd
Reported-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime-gvec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
index 3b6052fe97..51cb29ca79 100644
--- a/accel/tcg/tcg-runtime-gvec.c
+++ b/accel/tcg/tcg-runtime-gvec.c
@@ -874,7 +874,7 @@ void HELPER(gvec_sar8v)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec8)) {
+    for (i = 0; i < oprsz; i += sizeof(int8_t)) {
         uint8_t sh = *(uint8_t *)(b + i) & 7;
         *(int8_t *)(d + i) = *(int8_t *)(a + i) >> sh;
     }
@@ -898,7 +898,7 @@ void HELPER(gvec_sar32v)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec32)) {
+    for (i = 0; i < oprsz; i += sizeof(int32_t)) {
         uint8_t sh = *(uint32_t *)(b + i) & 31;
         *(int32_t *)(d + i) = *(int32_t *)(a + i) >> sh;
     }
@@ -910,7 +910,7 @@ void HELPER(gvec_sar64v)(void *d, void *a, void *b, uint32_t desc)
     intptr_t oprsz = simd_oprsz(desc);
     intptr_t i;
 
-    for (i = 0; i < oprsz; i += sizeof(vec64)) {
+    for (i = 0; i < oprsz; i += sizeof(int64_t)) {
         uint8_t sh = *(uint64_t *)(b + i) & 63;
         *(int64_t *)(d + i) = *(int64_t *)(a + i) >> sh;
     }
-- 
2.17.1


