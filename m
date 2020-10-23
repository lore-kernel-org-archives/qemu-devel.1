Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E143C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:35:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3ADE2085B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbmLufS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3ADE2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwIB-0008EP-Im
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwGP-0006Wd-NJ; Fri, 23 Oct 2020 08:33:45 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:41877)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwGN-00038V-OL; Fri, 23 Oct 2020 08:33:45 -0400
Received: by mail-pl1-x641.google.com with SMTP id w11so777172pll.8;
 Fri, 23 Oct 2020 05:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=vtt9DS+NfFepvL9pjvJZ/5oqWTKEvgx4l8QCHtst2SE=;
 b=fbmLufS3W18iQzAzS1Wm97DyIwAtFAeJReegq1nBN08CD99rFLSNq0yBiqstMayUk+
 2hA3GD9hQCLlfjTOXzNvsuSdDnKJngTnXL16g8TLEvu7uG3ZwtmmGjkKsayYIL8p7qlX
 Gdi6xTiBZyenBQBrkEcVLE9a+oiu53igVrskdzqxKPK0z80UNf9buYC8+uk3mR96z4Lj
 SbvBhz36uPupJopSw4PkfidgejbZ59gv5YB6t2gbopD6oUiyRNFfGPAAlKt2ZupYsY5V
 6xOndpu/TwypGu58Wst6m7pH0OA0Cd++TqNxVtMgUuNbgHwoED145M8d+oS9n52jMyC3
 emxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=vtt9DS+NfFepvL9pjvJZ/5oqWTKEvgx4l8QCHtst2SE=;
 b=R6A7ZAUkypHh4MwDdjadCl7ElNqeyg1MV3h+DolJBi7P4hF99swdvmR8y9CAYwbqdU
 P8fBhEejwsdUD4+6yUbAkFuAC2NYFuyqrI1JBaOEdoZP5sdmYQQsSIStVXKEvsgh2OWW
 DmOCNOdu7A87+4skHJQx9rFK/zqWiyg8zYVjaemdUi1d4kZWTDJu0leuvI8CEuj6Jm/j
 i0oVipZwFKSq6p21cG2C4vYDsbLB95bHSebHd56i+Haj6Oqv2pRJDqS3+1N9Ubztw4Ld
 DTDeRn9qbhY/222q9HjmAmEmgSw58LzSzmqJfOPkI6rhVW8wgOnn/GcJqSgdqvA5glEQ
 FifQ==
X-Gm-Message-State: AOAM532TgeQPNtAG93JGoQgEybiz4DGUBM4gETkv8gpk0dS4gvxGNq8z
 nV8nuuZOfu16BmokR0jLYyq+qkmTicsoRL2+
X-Google-Smtp-Source: ABdhPJz42zICYClGwHBtA4pv4an8DhCrexbLwCW39R49t5fhRELxmXOg/YDdnUpyPDNrxengqkPTfQ==
X-Received: by 2002:a17:902:8493:b029:d2:42a6:238 with SMTP id
 c19-20020a1709028493b02900d242a60238mr2067775plo.4.1603456420563; 
 Fri, 23 Oct 2020 05:33:40 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id h13sm1799778pgs.66.2020.10.23.05.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:33:39 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 21/30] overall usermode...: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:32:58 +0000
Message-Id: <20201023123258.19749-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=chetan4windows@gmail.com; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: riku.voipio@iki.fi, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 thunk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/thunk.c b/thunk.c
index 0718325..fc5be1a 100644
--- a/thunk.c
+++ b/thunk.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


