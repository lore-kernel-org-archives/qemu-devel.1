Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C01C54EEB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C71A20722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 17:41:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lNkaiIsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C71A20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGR59-0005zy-WE
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 13:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3h-0004OJ-KZ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGR3g-0003hU-In
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40433)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGR3g-0003gR-AA
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 13:40:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id f3so18165960wrw.7
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=RITZnDTDn/38AGh+VF4YqFkEzRJU1Dvi8yVVJIkiyIw=;
 b=lNkaiIsVZhLVcfdrXM4QCWv+fiqLXAVpWEFSgeHNunyKPwaNWSjxEdhEcEF5Fe+Y94
 j3MwJx/6lw2BWdkpGTeTid2999JpgNZBiz/hpCsJI4RxxsLE+GX+XYSBX9kp54ciXy4L
 3vkPHoMdPJThMiJZYF/OOk7P4LIv5/mpxkTmUwCRmW35p9cUwhPHbXZHRA4PrahETYOk
 Y/cfX50oE+N0ZmGxmkMvyWjQ9FDpBjxKSuKJanX+HVOJz70GCv6N8uxntPh5KT0Ghntq
 /Xr/9qhN0OB6LgbBIxUbQnZvvRP1qYXNorK2RNIpqfb55qqQy/ICHZ4tvEDwdgP6usrT
 rEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RITZnDTDn/38AGh+VF4YqFkEzRJU1Dvi8yVVJIkiyIw=;
 b=R6La5c63tk31zb/Pn3jP4vCnJOJjIn0lnTQCU78NQFjkgkS0VYDL5GE6/lZoB4eTKD
 QSZjGLKsbSoOTH3nnHOLrdH5tlQeyJEASLiK1WjF7hIHwT9jLBqfQKS57PzQ54A0gxdn
 bKnc4xBF4sG+1F8f9EfUzOelo+2lfd9iahWWcJS0RMsCMVa9SoBef+mLrOHRPos6yheF
 yyg5DOi9eKstLovTjA8/8H1lqAmFTPk+P460WHy+GJktzp/7Ts0ENbO0qvJeB+83R7qh
 p3+zCYVKok0K66hYBJvnUgxAz/SyI1rs3UCgJW64Ri7nSw0m/qbLttfLYaIHpsY86cFq
 9z3w==
X-Gm-Message-State: ANhLgQ0hvkMaHZfbCuVGAarf1PrkR3Fi00WACFdoxGKoENVE+7GuKUmB
 +BDPHnD9n5lUzh+4RJQTL77CMRwngh5kAg==
X-Google-Smtp-Source: ADFU+vsmZGxFB5z5Uiu9MVKsO2O71aEuPDYr7aiXhSBFs26P679sf7zIMwgvek9tgqaXz+ui62MyQA==
X-Received: by 2002:adf:80cb:: with SMTP id 69mr29927986wrl.320.1584985215054; 
 Mon, 23 Mar 2020 10:40:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id o9sm25145282wrw.20.2020.03.23.10.40.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 10:40:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 5/5] target/arm: Move computation of index in handle_simd_dupe
Date: Mon, 23 Mar 2020 17:40:06 +0000
Message-Id: <20200323174006.8468-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200323174006.8468-1-peter.maydell@linaro.org>
References: <20200323174006.8468-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Coverity reports a BAD_SHIFT with ctz32(imm5), with imm5 == 0.
This is an invalid encoding, but we diagnose that just below
by rejecting size > 3.  Avoid the warning by sinking the
computation of index below the check.

Reported-by: Coverity (CID 1421965)
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200320160622.8040-4-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 032478614c4..7580e463674 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -7422,7 +7422,7 @@ static void handle_simd_dupe(DisasContext *s, int is_q, int rd, int rn,
                              int imm5)
 {
     int size = ctz32(imm5);
-    int index = imm5 >> (size + 1);
+    int index;
 
     if (size > 3 || (size == 3 && !is_q)) {
         unallocated_encoding(s);
@@ -7433,6 +7433,7 @@ static void handle_simd_dupe(DisasContext *s, int is_q, int rd, int rn,
         return;
     }
 
+    index = imm5 >> (size + 1);
     tcg_gen_gvec_dup_mem(size, vec_full_reg_offset(s, rd),
                          vec_reg_offset(s, rn, index, size),
                          is_q ? 16 : 8, vec_full_reg_size(s));
-- 
2.20.1


