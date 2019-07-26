Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBB1C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:51:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F246E22BF5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oXKkjU8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F246E22BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr4NC-0003dQ-8R
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56905)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4MY-0001ks-Ry
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hr4MX-0007Aa-Pd
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:38 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:37653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hr4MX-00076A-KW
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:50:37 -0400
Received: by mail-pf1-x444.google.com with SMTP id 19so24852619pfa.4
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 10:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ynwokCS+Kqgt3LfDdzexRygGm/TpfqdWtRJ/K6TofxQ=;
 b=oXKkjU8fglSAI1Jty8wDUH65ezOiFiflanv1iU7NYrrwB/qUNs7CJHIvK3eHLc6yJh
 vvfKYGb5XJCTgGneoT8ZzCTyuCWTywlHOcGOgGfxyHrGMeYP9YNN5ZJZ9lYxS+UikDKN
 x6NaBqJ2fTIeCKyhV8N6PJ/4AzT8lRR2oVtoOPT1rzONK4nBYbOPdHbTko7VQzmwYlQ4
 tA4UwkjLpwjIQp6YQ8eYt5FNLZUlX3Dk3jnptgCokx/9J1CWJdbewYYCXKK6jg/YeDQb
 n8Ia07lzEC9oS+n+RvYVNor2nRRqHhxIto7TFlUl8myyIKiBDTn+hSPVBmlC7eRWvu11
 fL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ynwokCS+Kqgt3LfDdzexRygGm/TpfqdWtRJ/K6TofxQ=;
 b=tdXzd95eI10P3EqYQf7ZDm7lxcx+GjWi2knYxeHu5zGjDr+FuvMgQYbCa5WN4paanq
 bvu1dyjBVYAW1tDzBd3Ypea+MqaykJPERzAxIz85iFaIU1fTsiWz3dUCj2ZAemPlHILN
 wL/8ppXpK1DTTVVz/2QHDEQvK8DndLTWchFFY4dZrySUk6buuxRE3QwSXlrrWMFaLr7n
 u57fZ8/wPqZYTw47TU/JilDl15c0+F/KflNzFiYRBg4aktRsILMSNH5wbiKBy7Ux5KJ+
 ototNItibZlEMKimACBin8EeNZeexMOZBHLkR9ru8SLoSWXcrw3rVu1cVj8IqO1fGB5E
 9NIA==
X-Gm-Message-State: APjAAAXk7FhcfSNdysMF6wX1BSpm6zHmUP0O/wZwB4yTwwIzz9NfQCPF
 iTRa9GeVpvAewbJNWUdNR0NwzY1B8kc=
X-Google-Smtp-Source: APXvYqwAwKsgKWEbkDiKv1mE75OLMvidr1nR1Qvo/H0WjENG7z2eImN92v3XwWvyFTCymQ+lADDZGg==
X-Received: by 2002:a63:2c8:: with SMTP id 191mr91125178pgc.139.1564163435378; 
 Fri, 26 Jul 2019 10:50:35 -0700 (PDT)
Received: from localhost.localdomain (97-126-117-207.tukw.qwest.net.
 [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id o24sm104287919pfp.135.2019.07.26.10.50.34
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 26 Jul 2019 10:50:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 26 Jul 2019 10:49:26 -0700
Message-Id: <20190726175032.6769-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190726175032.6769-1-richard.henderson@linaro.org>
References: <20190726175032.6769-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: [Qemu-devel] [PATCH 01/67] decodetree: Allow !function with no
 input bits
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

With this, we can have the function return a value from the DisasContext.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/decodetree.py             | 5 ++++-
 tests/decode/succ_function.decode | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100644 tests/decode/succ_function.decode

diff --git a/scripts/decodetree.py b/scripts/decodetree.py
index d7a59d63ac..4259d87a95 100755
--- a/scripts/decodetree.py
+++ b/scripts/decodetree.py
@@ -195,7 +195,10 @@ class MultiField:
     """Class representing a compound instruction field"""
     def __init__(self, subs, mask):
         self.subs = subs
-        self.sign = subs[0].sign
+        if len(subs):
+            self.sign = subs[0].sign
+        else:
+            self.sign = 0
         self.mask = mask
 
     def __str__(self):
diff --git a/tests/decode/succ_function.decode b/tests/decode/succ_function.decode
new file mode 100644
index 0000000000..632a9de252
--- /dev/null
+++ b/tests/decode/succ_function.decode
@@ -0,0 +1,2 @@
+%foo  !function=foo
+foo   00000000000000000000000000000000 %foo
-- 
2.17.1


