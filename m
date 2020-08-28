Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5A9C433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9792920776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 17:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lsha6aDU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9792920776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhpZ-0005HK-LB
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 13:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhol-0003eW-5x
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:35 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:37992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBhoj-00030v-Kz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 13:05:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id t11so788419plr.5
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 10:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ITUpbwpJpl5kwHPYTXnaY0I0dsp5Ua5j8HECaAQoi50=;
 b=Lsha6aDUfzLNjD6nDAtn0kKeiG8ihysx7VKq/F+7pnd7fwIOX+Hg2BgfhfWwdlgNd+
 JQF5wMrFLn1H7YmKVB0oElmFu0NxJNtoQEb5o5lUb9ZyiPfTylzgjGvt4bAmlWagR/5K
 KvbOMRJmApVSc+y1ulb6dSgVHNonMlqn44GMxThrfrNgMMkw/NPIMMob9VveHJOjlV5q
 tVVwnUpHWjG5Iw47MGVeyd5URq/l2TWXtaueFf3boPj+S0ZDk4OydNWhzSNML1q7gYmS
 sdK/ojYWRgL6OutRtlNrb3h23Q0KtpZ7JKlFIc3nq9+pbOk0A3iyDjmb5Ei+7hleS2H6
 Bbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ITUpbwpJpl5kwHPYTXnaY0I0dsp5Ua5j8HECaAQoi50=;
 b=W2wkUQYjrF+BeDBjOLLBRf60PGwn7mQ4lU2z1fsamUi8+a+TSRSujvsZKQqm1ykxrR
 s3cH+yMCRPRabq5Qsd5xYUDWPo1ZtYVp8H23OdHp8RaCvuPnkGUyzwqUND2EVDrHaRUt
 apu+kttmMI0b//YU8ThbMdWSTLhSMOOY7wvd7XtNa8KwH5VQYgX8tOq2tpA/J09y1kzn
 N3zrMgNd2wwby3pOf01unRJDtN4aYpcxNiZBjzsqekosCW/CUpV6vCNeg9jz6kZXhRQG
 M/2M8/Zsn4czNcxvTxQ511U46K7toEem7vkVhXgxOg58aYeTqqRV48UTXju6kpGOQjmA
 wKlA==
X-Gm-Message-State: AOAM532+BB0vB42nHftFOEJaa6T9zF3ZyIV7dOiuWjn5DsW2P/5W5uVn
 xz1JD9QgdsxHCihNpSpuiXXVnjW3b+GF2A==
X-Google-Smtp-Source: ABdhPJx8vnsWWJp1TrVQjBsgtRPpRk+aLSGBVKBztDI5PSmA7u3BF3FOLsFIYxGVTvTy8gMQayGo9Q==
X-Received: by 2002:a17:90a:24f:: with SMTP id t15mr46207pje.227.1598634331759; 
 Fri, 28 Aug 2020 10:05:31 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q12sm2277495pff.196.2020.08.28.10.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 10:05:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/16] crypto: Move QCryptoCipherDriver typedef to
 crypto/cipher.h
Date: Fri, 28 Aug 2020 10:05:12 -0700
Message-Id: <20200828170523.418603-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828170523.418603-1-richard.henderson@linaro.org>
References: <20200828170523.418603-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Allow the use in QCryptoCipher to be properly typed with
the opaque struct pointer.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 crypto/cipherpriv.h     | 2 --
 include/crypto/cipher.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/cipherpriv.h b/crypto/cipherpriv.h
index 0823239f41..9228c9fc3a 100644
--- a/crypto/cipherpriv.h
+++ b/crypto/cipherpriv.h
@@ -17,8 +17,6 @@
 
 #include "qapi/qapi-types-crypto.h"
 
-typedef struct QCryptoCipherDriver QCryptoCipherDriver;
-
 struct QCryptoCipherDriver {
     int (*cipher_encrypt)(QCryptoCipher *cipher,
                           const void *in,
diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index 5928e5ecc7..8a42a683a4 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -24,6 +24,7 @@
 #include "qapi/qapi-types-crypto.h"
 
 typedef struct QCryptoCipher QCryptoCipher;
+typedef struct QCryptoCipherDriver QCryptoCipherDriver;
 
 /* See also "QCryptoCipherAlgorithm" and "QCryptoCipherMode"
  * enums defined in qapi/crypto.json */
-- 
2.25.1


