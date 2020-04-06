Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64769C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:20:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EC862054F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:20:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vcxb52Gk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EC862054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOrd-000449-7G
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjl-0006gf-Ax
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLOjk-0002i1-57
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:13 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:37830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLOjj-0002hK-Vb
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 06:12:12 -0400
Received: by mail-wr1-x431.google.com with SMTP id w10so16771017wrm.4
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 03:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=XHntAqqIp1yfMbfyBLD5YWm//CZBIX/1MEhVYEjrpFs=;
 b=Vcxb52GkSpRKJAWaiDHF/Bd+fmqJVXzGbyy4dxsyA2b7kvNfnXsi2yYcb+a3Trycus
 Y7wye9MkQzSGe6io6uTQOpslQaP0W6CkgZIdKw8uGXBWNgcNCkEedRtl9djXBh06Ci0G
 RBjUqTpxzHbU2xUO43PxDzTejKC7qBBmnU5w/EGlX4/TamY39XnIMObN41o8miarqwDp
 E8AsH1uie6cZ+xL1ZrXfqs968Y1T+fV4hiO+xV7HvMwfSwM6PGhpjwA4pA4gwD6/OMGj
 3l9FPdR44PbMtH2NeitXmS+v9F88gD6151ENOegK3HMvlxOi8ph9T8nulxGKhqjXcLhu
 7mQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XHntAqqIp1yfMbfyBLD5YWm//CZBIX/1MEhVYEjrpFs=;
 b=KWCyPUoy0scpu7bzVRghqB+U6unG09D6qiXfNbG3N2izODVQQg4n27JrQlQKiWcKyi
 rGAFMqewuiQiIFNDgnkzlbIXdfr6ZSx/kTmC9dD6kxgcV6ugOIXDO3USbXx1wEI1KW42
 6I4PV/2e3yWDDEmXAifaiO01PBldX77VpbceSDEbn2P5BCMUjunVW5RRXwOL27g3JT6G
 AJlTdGe2qwfuAO067FDVSf2R2V/YAjpttkJ08cE/VSTkFUeIvXy4R48/SWwr0SFsIiL1
 DOHWahYiBEBN+Tji/QGWVvSm63IYy3U1I4baIsiAHFgigO88jY0q9ZlQXhnEWOExf8gv
 IE9A==
X-Gm-Message-State: AGi0PuZT1CwOmN3nok4pWMVyx00XJ0qSMes+THUgx+XmP2Cfu8CAvhhA
 k1GkbmZ0UGBIWnJU61jfgY5tqdltv59rEA==
X-Google-Smtp-Source: APiQypJEbgcdvqTYjrRfS6/cN73CIWnVKpVhNpbKylDZo2eeArZhS7I7ZiZ7xrpHqzhu6eV0kYGGJg==
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr22302128wrs.13.1586167930689; 
 Mon, 06 Apr 2020 03:12:10 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id f187sm25163765wme.9.2020.04.06.03.12.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 03:12:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] target/arm: PSTATE.PAN should not clear exec bits
Date: Mon,  6 Apr 2020 11:11:57 +0100
Message-Id: <20200406101205.23027-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200406101205.23027-1-peter.maydell@linaro.org>
References: <20200406101205.23027-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

Our implementation of the PSTATE.PAN bit incorrectly cleared all
access permission bits for privileged access to memory which is
user-accessible.  It should only affect the privileged read and write
permissions; execute permission is dealt with via XN/PXN instead.

Fixes: 81636b70c226dc27d7ebc8d
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200330170651.20901-1-peter.maydell@linaro.org
---
 target/arm/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 163c91a1ccd..ed7eb8ab54e 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10025,9 +10025,11 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
         prot_rw = user_rw;
     } else {
         if (user_rw && regime_is_pan(env, mmu_idx)) {
-            return 0;
+            /* PAN forbids data accesses but doesn't affect insn fetch */
+            prot_rw = 0;
+        } else {
+            prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
         }
-        prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
     }
 
     if (ns && arm_is_secure(env) && (env->cp15.scr_el3 & SCR_SIF)) {
-- 
2.20.1


