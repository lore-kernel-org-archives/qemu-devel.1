Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CF6C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:26:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB561206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 03:26:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVXlmHiU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB561206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k63tD-0006JC-Vb
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 23:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63s8-0004jL-Tg
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:44 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k63s7-0008UC-BS
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 23:25:44 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ep8so2101180pjb.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 20:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A5uJbNu7KhMXozinpokK4dHKz2PI9j6DphdzziNCjIw=;
 b=CVXlmHiUSZ1o1UuKBH6qTEGG55bIak/MLaxqN37o8tl6g8s+ko0r0O7tUjD6K3bg17
 yQ+DD57GuaG9ZeZguoQlU+omlTAColokyF1nxH+fpWg2/99AcoqkNdJfuYtqqgok8k/k
 MgclWTev6z01uRLRtQjn//ZE9CM7WMqPNMcLd4/9CJbPI14pQxUiqiLxhA3xr3gdYiSz
 fXWas2osKONBpp8rLmJL+zLmTGG+BXnLewYLLBjju1g0aVZTF1WRj07HfnMlW4V0AR09
 wya7FUE+pv3nBRJLW1wQdwhaoPGYuIxcw4WQdwlE8e9yt+z6+eoWb+WWntKyJ0RrmjXt
 cfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A5uJbNu7KhMXozinpokK4dHKz2PI9j6DphdzziNCjIw=;
 b=JjwnQSjpDPrmb8eqwVWLEkzaz3FnZe+mYoXIXRqbtQMtPcUoJorAlvv3ausxtQfvFT
 U5dHj8Acv9NIQWETLaYTI5A2z981OyqmLHxN/tzJregEjHGsYY2thzNQmgrPrLeoCQqA
 OybAiL+0962BtM8/rwDyv5IgWqXRCOxS28gxrZFcMffDwq25h3DNzWsEh4lG1r1+XBVO
 F24xbyP3TdjACyLqlhD6eP0+QmIUONCoQsi29HlubcQ6FfGV+tuz/CvzF2cKCQl8Ps3P
 MdYEllpCeioSlccHbJV+sH5jWwJLbNurwCGiXkMHXlXXKNvdyHForRdcaNZEy3cqi94b
 PGqw==
X-Gm-Message-State: AOAM532fQd4fRAlhho/8g3ry/7ClT9S+Up71QGMmyGgTeaa+L1oloGYv
 8K/DOePsu54H8sfgRaIn0MZT8IzSPwA=
X-Google-Smtp-Source: ABdhPJxxsr0gY4eFpdWGMy51BGEzGM+mHfij1tnnvRcU7aQuDyDnju0OMq7CYjEmFAF63fWT8//Ipw==
X-Received: by 2002:a17:902:82c2:: with SMTP id
 u2mr2176851plz.239.1597289141727; 
 Wed, 12 Aug 2020 20:25:41 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m19sm3633164pgd.21.2020.08.12.20.25.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2020 20:25:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/17] crypto: Move QCryptoCipher typedef to qemu/typedefs.h
Date: Wed, 12 Aug 2020 20:25:21 -0700
Message-Id: <20200813032537.2888593-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813032537.2888593-1-richard.henderson@linaro.org>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

This allows header files to declare pointers without pulling
in the entire crypto subsystem.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/crypto/cipher.h | 2 --
 include/qemu/typedefs.h | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/crypto/cipher.h b/include/crypto/cipher.h
index 5928e5ecc7..95a0412911 100644
--- a/include/crypto/cipher.h
+++ b/include/crypto/cipher.h
@@ -23,8 +23,6 @@
 
 #include "qapi/qapi-types-crypto.h"
 
-typedef struct QCryptoCipher QCryptoCipher;
-
 /* See also "QCryptoCipherAlgorithm" and "QCryptoCipherMode"
  * enums defined in qapi/crypto.json */
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 427027a970..45b9c57717 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -95,6 +95,7 @@ typedef struct PostcopyDiscardState PostcopyDiscardState;
 typedef struct Property Property;
 typedef struct PropertyInfo PropertyInfo;
 typedef struct QBool QBool;
+typedef struct QCryptoCipher QCryptoCipher;
 typedef struct QDict QDict;
 typedef struct QEMUBH QEMUBH;
 typedef struct QemuConsole QemuConsole;
-- 
2.25.1


