Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C819C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:11:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50F6320863
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dE4y100d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50F6320863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37091 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hToQw-0006HF-HI
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:11:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHb-0006H3-JG
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hToHa-0004X7-Fu
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:23 -0400
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931]:45267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hToHa-0004Wf-AO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:01:22 -0400
Received: by mail-ua1-x931.google.com with SMTP id n7so2198743uap.12
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=cN7HSsTir9LPfFs0tqL8Rk/5kniGhoqrSHsDQ6DZZvw=;
	b=dE4y100dtpMKczXTvrJJVBXBif3jy1bvx73wTA/KPdkJHm7lolCvVrPRnkntqADBOf
	j6OV5t0TgQ1rQrkJ5P1yApNGDdhBB8U3P4p4DjADMHsTSgNVXHL9As8qEQKK4i9MqhX+
	HAtAxyMGxNkxvrZeRl8aIS+54b5jAvHbE+Fzo+lOGpLNs5Z289M7qVVXCniw/oAV8KQZ
	cys482X7KLqLGg9nahgIpsT9oyDegfBs3fBDAio5VpfUcERraafdQu74SQz5R3Zj/s17
	dHuS6k2KPGYDYq2fej7PskmF0mxXZ+0TYG5BY1MJEVkDOeHtKsXBuoS1ar0sdYxWRm+d
	Q0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=cN7HSsTir9LPfFs0tqL8Rk/5kniGhoqrSHsDQ6DZZvw=;
	b=spfAlwzWnYdKwT1ZhdjqcjNxkfVRyxv/p8oenrgz1skDIgNC4FdRLkje3sDB/hIiJC
	c0byyoEmvezk3sGnG8ak2UT0OvMmQWZLatmMvvoCtspwjOgNtT/OmdnKZuu8RX5HgW2h
	hwUydVYv/znSpZEzPWNk3zqDj+deruGHcI7FMcvQRSOK+cOsxCQ9qKmTw+1ZyVsGCW5r
	KVrLVek34ELKJ14vsAUSj/HTh7UWkJqUiLjtovO2UhNtwxtTQr/lB4HLIGTWdNyMwOP1
	gTc9w3rQZ7DoMYM1UyUdTpdNgkiJChtuEBvaWm6laG2n0W5bNzpIyU34o1RuWcNCMcVG
	ildg==
X-Gm-Message-State: APjAAAUlhADRm3Bq5TvMJMx3mMc0m6LGDK6BWuhqF3DojtGI/MX+fPl0
	kClr8uQLNPOENXD3h81leZm6C92zR9nl0A==
X-Google-Smtp-Source: APXvYqwuJ4d2erw479zJzSob5ukdnobdg/AxSgbxuKZt/O8g5Z7rblgFFyxnDQPeLp9/Hz7Y9zcbrw==
X-Received: by 2002:ab0:7802:: with SMTP id x2mr4428653uaq.8.1558620077120;
	Thu, 23 May 2019 07:01:17 -0700 (PDT)
Received: from localhost.localdomain (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	v133sm1984166vkv.5.2019.05.23.07.01.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:01:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 10:00:55 -0400
Message-Id: <20190523140059.18548-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523140059.18548-1-richard.henderson@linaro.org>
References: <20190523140059.18548-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::931
Subject: [Qemu-devel] [PULL 09/13] qemu/bitops.h: Add extract8 and extract16
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190516055244.95559-12-ysato@users.sourceforge.jp>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/bitops.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 3f0926cf40..764f9d1ea0 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -300,6 +300,44 @@ static inline uint32_t extract32(uint32_t value, int start, int length)
     return (value >> start) & (~0U >> (32 - length));
 }
 
+/**
+ * extract8:
+ * @value: the value to extract the bit field from
+ * @start: the lowest bit in the bit field (numbered from 0)
+ * @length: the length of the bit field
+ *
+ * Extract from the 8 bit input @value the bit field specified by the
+ * @start and @length parameters, and return it. The bit field must
+ * lie entirely within the 8 bit word. It is valid to request that
+ * all 8 bits are returned (ie @length 8 and @start 0).
+ *
+ * Returns: the value of the bit field extracted from the input value.
+ */
+static inline uint8_t extract8(uint8_t value, int start, int length)
+{
+    assert(start >= 0 && length > 0 && length <= 8 - start);
+    return extract32(value, start, length);
+}
+
+/**
+ * extract16:
+ * @value: the value to extract the bit field from
+ * @start: the lowest bit in the bit field (numbered from 0)
+ * @length: the length of the bit field
+ *
+ * Extract from the 16 bit input @value the bit field specified by the
+ * @start and @length parameters, and return it. The bit field must
+ * lie entirely within the 16 bit word. It is valid to request that
+ * all 16 bits are returned (ie @length 16 and @start 0).
+ *
+ * Returns: the value of the bit field extracted from the input value.
+ */
+static inline uint16_t extract16(uint16_t value, int start, int length)
+{
+    assert(start >= 0 && length > 0 && length <= 16 - start);
+    return extract32(value, start, length);
+}
+
 /**
  * extract64:
  * @value: the value to extract the bit field from
-- 
2.17.1


