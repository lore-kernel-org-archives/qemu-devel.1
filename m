Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E6CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:08:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036C422B48
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 04:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6gnXQDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036C422B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifFlh-0001AK-KE
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 23:08:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48956)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFew-0000u1-VC
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifFeu-00049A-Hp
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:01:02 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:32869)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifFes-00041v-75
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 23:00:59 -0500
Received: by mail-pj1-x1042.google.com with SMTP id r67so455608pjb.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 20:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZD30K4OON5Rr10XGqonKOfQz8NelurszVZDAGc9w8Wk=;
 b=U6gnXQDCoFZRlrDlONBYgIkAgK0vkhnhezYgiGPKKovxpkBTF8gVVhFHluYgsVNzuG
 oyHtwX1erKF5wn3pHvZLEnUim2aA90c2tpSzacS5aSo1DNaPWhS5GN0X63YMEtccdG/R
 g5uDMQ+o9pJKq6qSc6kT8DGqwYV81OJVCRE35YwKw/YbSN6lmkIPPP505JY4Nfur/9uu
 bnfpF9m7JG2rLeLPL7IAuwIRiXXtE2k9XdJsewiI2aoNNu2iEreO8c0yaucriBo7/osG
 xUfuV91EX+2f3ev4a+B26NpIBKw8Y6q8rXYFpt8RQwGVmT4c2JoRvLAokp/YKO6rUFxA
 jPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZD30K4OON5Rr10XGqonKOfQz8NelurszVZDAGc9w8Wk=;
 b=IEIeTDPAo5uBZ77y+QhAWAv1tglFo7GXwEO108GMWAqqIhQGxyqyHdYwp3YxFubH/l
 p3TLaVTz02pqL75thzDoy2Nhd86VEw3zljaE8oYaOJse5A1XjCnT/imDLZPaO3v0rW0p
 COtnUteBRr/vK/JUXa2JZ2+JxivZ4x2797a7yMWe7rmjcn0EDcS04p6HUZW8NKJuHflv
 57G4ue6O9TF/7vPgubB2VCPmtmoWFd/utTBQ++RepWO3w8yJIRU5pTGfq+z+gUOt5XO9
 Xi4GHTpPuFrYC+TVD2UMmYA7CJLEaQNEvEvSJWwzcCi0tngMh6PorJYGdvOc1YJH1HtH
 Ts0w==
X-Gm-Message-State: APjAAAWR6EX4FrY2iA2xwvdh/dx9qrZ39pydMjQ0xshhsvSw69JH4a/n
 dWRriJhOtVfC4tJ57cyjlXpt+a+42fI=
X-Google-Smtp-Source: APXvYqy2VUA0MEAce9VT5V8lYNFbbhtfqEozRckpft4oUrtCuPBjI5lSvbUa6VNgkFVGqg7RQtXlnQ==
X-Received: by 2002:a17:902:59cd:: with SMTP id
 d13mr7356108plj.146.1576123253525; 
 Wed, 11 Dec 2019 20:00:53 -0800 (PST)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id z130sm4666391pgz.6.2019.12.11.20.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2019 20:00:52 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/28] target/arm: Include tcg.h in sve_helper.c
Date: Wed, 11 Dec 2019 20:00:21 -0800
Message-Id: <20191212040039.26546-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212040039.26546-1-richard.henderson@linaro.org>
References: <20191212040039.26546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code movement in an upcoming patch will show that this file
was implicitly depending on tcg.h being included indirectly.

Cc: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/sve_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
index fc0c1755d2..83cc7f5bb5 100644
--- a/target/arm/sve_helper.c
+++ b/target/arm/sve_helper.c
@@ -25,6 +25,7 @@
 #include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
+#include "tcg.h"
 
 
 /* Note that vector data is stored in host-endian 64-bit chunks,
-- 
2.20.1


