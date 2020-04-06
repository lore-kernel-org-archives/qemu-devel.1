Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875D6C2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 543802054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkeuX7xP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 543802054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOth-0007bz-Gw
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjm-0006gw-1h
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjl-0002jK-44
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:35193)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOjk-0002i8-UH
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id i19so15182442wmb.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=1os58X9O5B3YRJFqijwCBzsCpTekZV0iyTSPE0tYIm8=;
 b=DkeuX7xPkK4Pjilv/41VGb+kbIxoYiIstUwqIVxpCJCDu47Yf+zutZcQ3MVDs2ljrD
 GcXSxHFFGwwSz4+GDClh1q+mHSwNreyOV/DeLl/LB6KU5xjKmsGPhRxFgH1Zg4n1JUVb
 jKpTIIjLyR/dTQrFhbauuBma/g9317VTmOtpfulzsNvRTjSKYNrOFbd+Qf1bpD9d9iLy
 MgcbnoRZ8HMc7dQ+NmQD+dJsg/Le/CKY6vFiUHS9M2lppmn/s4T61dM0VYw7NqQVqZ2V
 uMaVDdRr2vjz4sG1y5yfxpyCUoA+91HGnxxH5jkyciVOrrdXa5paloorhoRcEx8k8UUp
 nypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1os58X9O5B3YRJFqijwCBzsCpTekZV0iyTSPE0tYIm8=;
 b=WNaEBPdWGIKptmtOKI+xcLiBfzodmaLAxFM6aBMPZcBxBtH+POxf1SwbK8yD3+vMk2
 EOrdcE3GA+3T+YKSIPF6qUPckNNLJCzqX37uBWTuLKqjkuGWsBTAqIXgSIBY9aXO995Z
 PsfY9V6KR+KrlynKVT/MLlLuj7v+d1TT5hVPufezO+46IgAoQpQ21Bd+HPh2LWmh492I
 /pkgHE48UEqnKFL27vM6cXMd24S9HfJFJkDqkupidcUO3Dho1d09LpGK4MzinlIwvus6
 BYQd0XVucvGeNb89WyHqhr5A2nndDi8wO69HCz+gfc7RJu/dFUyFh0J8ZsfkzRHk7qss
 fWwg==
X-Gm-Message-State: AGi0PubfvISCrXaYrXKaqW2+ihHQ3sMpoCP/9BRUax4HngAjUFn3YXmH
 qbCIiqfPgZO9m7MN0MvkmyXxcTkA2uBFJQ==
X-Google-Smtp-Source: APiQypJsPkDiWsWmHSLfbwlzzhoRHeTMoGAZG5p4/g1RxIvQ8XZWkomxpenIdIikvd2Fs/nQshHG0g==
X-Received: by 2002:a1c:dfc2:: with SMTP id w185mr5161151wmg.1.1586167931645; 
 Mon, 06 Apr 2020 03:12:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] target/arm: Remove obsolete TODO note from
 get_phys_addr_lpae()
Date: Mon,  6 Apr 2020 11:11:58 +0100
Message-Id: <20200406101205.23027-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32c
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

An old comment in get_phys_addr_lpae() claims that the code does not
support the different format TCR for VTCR_EL2.  This used to be true
but it is not true now (in particular the aa64_va_parameters() and
aa32_va_parameters() functions correctly handle the different
register format by checking whether the mmu_idx is Stage2).
Remove the out of date parts of the comment.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200331143407.3186-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index ed7eb8ab54e..7e9ea5d20fa 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10753,12 +10753,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
     bool aarch64 = arm_el_is_aa64(env, el);
     bool guarded = false;
 
-    /* TODO:
-     * This code does not handle the different format TCR for VTCR_EL2.
-     * This code also does not support shareability levels.
-     * Attribute and permission bit handling should also be checked when adding
-     * support for those page table walks.
-     */
+    /* TODO: This code does not support shareability levels. */
     if (aarch64) {
         param = aa64_va_parameters(env, address, mmu_idx,
                                    access_type != MMU_INST_FETCH);
-- 
2.20.1


