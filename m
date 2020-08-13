Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06681C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:32:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C60AD20756
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cg4ac55V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C60AD20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63yL-00069u-1y
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:32:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sD-0004qR-VW
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:49 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:54847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63sC-0008WP-Ax
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:49 -0400
Received: by mail-pj1-x1042.google.com with SMTP id mt12so2106369pjb.4
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+PHy/gloogLnc28zgcQGUBXNqWvFE+M2jDPSBgeFXVw=;
 b=Cg4ac55VOl6kLG6fic3H9HB5l4VzY9rGl54+Rl1RorwJzACXlKGm4NP3KvN2dDNh4A
 9rQvKJCrJB5hrE027HCLq5249+uPxEzAfTymhyb8AYEomVCEvY/BLL3vcf67IL6Rtsil
 zaK/pD50x2ZfJT8kH/ku8F0B1gNXPvbe8jEjDsua4YifndQcMFR4F/UHJCXBQM4Y04nZ
 0i/QX0D1IlUuQCJgrHkgSTbOWe/PVAsqNg6wy8mNcSxWTc3cKiR1Ptr+sEJvDqcj58dU
 BUYnOyo9D23zCHXKMFkHedlQ6S/KTnUrlqWA0P/AEELtbU7BkGL8J735eFWPvzp/AhCW
 ODnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+PHy/gloogLnc28zgcQGUBXNqWvFE+M2jDPSBgeFXVw=;
 b=IMNdVmtlSv0SzyEXk1cmacmelUAbX8Eiqttr/qlVfX3TqwJf+spMIyYBhkdzUmehDD
 TU4GR8se/u3Rc6+YK8s5tP3ojPyS//aJL+UobrPY6CboDoW4NlYJmFAxN6UZs4hOjcg3
 Gl7PMXzc4YgoK2BFuY8PYT84j1iBgkT+yBUk6MS9kefJGaw1oafpTyk4cKF1Le6dwYUP
 UGpuxSAz6M1elRpkQIpQb2PWOxbyH/84yPXouDqmfugf0zsVYtPsE0qczIQliKapTIOQ
 k8gALNzwIUet7K83vfCtDjhQTOZfLeU02zPdldxpf1dckvWu8rYuPb009UhGTKACpR1L
 K19A==
X-Gm-Message-State: AOAM531HzZ6GMIP8Q8AwvV5ib3VSVZwm4lkJxKAF6fwqF6WnEMaOYu6C
 rFIOfgSIyZWkt2eU5T/FEHoGp9GAaTE=
X-Google-Smtp-Source: ABdhPJw13HoxQojF8PJZQtsKUyFgoQFGVl3tzVPZg+Ga389XkLxmdLZon63PqU7BZRPDqNidpvOYAg==
X-Received: by 2002:a17:90a:e687:: with SMTP id
 s7mr3075521pjy.48.1597289146628; 
 Wed, 12 Aug 2020 20:25:46 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/17] crypto: Remove redundant includes
Date: Wed, 12 Aug 2020 20:25:25 -0700
Message-Id: <20200813032537.2888593-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Both qemu/osdep.h and cipherpriv.h have already been
included by the parent cipher.c.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipher-builtin.inc.c | 2 --
 crypto/cipher-gcrypt.inc.c  | 2 --
 crypto/cipher-nettle.inc.c  | 2 --
 3 files changed, 6 deletions(-)

diff --git a/crypto/cipher-builtin.inc.c b/crypto/cipher-builtin.inc.c
index 6eafd39da0..56d45b0227 100644
--- a/crypto/cipher-builtin.inc.c
+++ b/crypto/cipher-builtin.inc.c
@@ -18,11 +18,9 @@
  *
  */
 
-#include "qemu/osdep.h"
 #include "crypto/aes.h"
 #include "crypto/desrfb.h"
 #include "crypto/xts.h"
-#include "cipherpriv.h"
 
 typedef struct QCryptoCipherBuiltinAESContext QCryptoCipherBuiltinAESContext;
 struct QCryptoCipherBuiltinAESContext {
diff --git a/crypto/cipher-gcrypt.inc.c b/crypto/cipher-gcrypt.inc.c
index 81e4745bff..a62839914b 100644
--- a/crypto/cipher-gcrypt.inc.c
+++ b/crypto/cipher-gcrypt.inc.c
@@ -18,11 +18,9 @@
  *
  */
 
-#include "qemu/osdep.h"
 #ifdef CONFIG_QEMU_PRIVATE_XTS
 #include "crypto/xts.h"
 #endif
-#include "cipherpriv.h"
 
 #include <gcrypt.h>
 
diff --git a/crypto/cipher-nettle.inc.c b/crypto/cipher-nettle.inc.c
index 0677fdfd33..256931a823 100644
--- a/crypto/cipher-nettle.inc.c
+++ b/crypto/cipher-nettle.inc.c
@@ -18,11 +18,9 @@
  *
  */
 
-#include "qemu/osdep.h"
 #ifdef CONFIG_QEMU_PRIVATE_XTS
 #include "crypto/xts.h"
 #endif
-#include "cipherpriv.h"
 
 #include <nettle/nettle-types.h>
 #include <nettle/aes.h>
-- 
2.25.1


