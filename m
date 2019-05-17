Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A69C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E2120833
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pIaRtA4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E2120833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42338 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRUxR-0003wT-QC
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 00:59:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqV-0006Dr-F0
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hRUqU-0007lv-6E
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:51 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:45235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hRUqT-0007lP-Vn
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:51:50 -0400
Received: by mail-pl1-x641.google.com with SMTP id a5so2720452pls.12
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 21:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=cN7HSsTir9LPfFs0tqL8Rk/5kniGhoqrSHsDQ6DZZvw=;
	b=pIaRtA4qvbeSiGPTGFA/MJugbq0Bd6ZTWwoii1QRgfQ7hDU00qFqWd7XvvinDwOEQI
	HdBT2MZ2Q+y/CLI4NrOA9v1Z0UK+EOfIIODayCkd7m+Fjt4pMBumrwZNS0Ziu2WD0C4A
	K2K7XgN3epof0Owh7WxiFGn2TsZf2AN0W7pVgu/NcHtqDimTWNYa/bvwnqY8Tqrtt4C/
	tuTFRbM/YnE/1qBo2L4ukctONlGhsjLA/hz2BSg7l/iV0t0lWKFbx5Tj/+83MIvlzeH6
	A1d6JaEHLQvgxOSg6kSKGDagvoPHhq4vNmhJASoz1hgIs4AOgMObXdTpENPecw1OMTLq
	u/lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=cN7HSsTir9LPfFs0tqL8Rk/5kniGhoqrSHsDQ6DZZvw=;
	b=p3IYrK9HGyrUtdVANvCxmbj0gSABcaRrzcj1KOXl6wO82/+sExcOW9okplAvcW7TJ/
	w4BSartPYp+5Z8C4bUKem7AyoNz9MG8BKJRmkAqYGEkkW6UdhZIY0Hjn+zUPH2HFxGBZ
	q/XQVSl0dR2V2IMwc70E3QWP0V8TQo8VJwAAItmdTGZx2sE0fgR0jBkODdiuP1RKjtkx
	uq6scrfEw9aQ7DO4BCyoySoqBr1aLG4f0wq+z22EXsh4n6ioeyORX12z2aCEozyDQ2TU
	LXwkpChEFdTCn8bm+EF+GxuTH83vtNIvBWe2GGlMeCDYEpCS54Hu8eFMCwxUpfvkqB6D
	x47g==
X-Gm-Message-State: APjAAAUzkn/ufQuUfIdXtlVAQ+y/Ub5WixrcL+1dJK/IP/YAa+sAjfyr
	0YJNXsTBSDyKZ5xy9F6ebfDR89RjtEU=
X-Google-Smtp-Source: APXvYqw+UhXB+eqZAu5KfeZmixA40JzcD0EFhtLlaOpnVCSfkhxWJ844KgPDNBcoasSBaaLAdYZFAw==
X-Received: by 2002:a17:902:1126:: with SMTP id
	d35mr18803100pla.82.1558068708774; 
	Thu, 16 May 2019 21:51:48 -0700 (PDT)
Received: from localhost.localdomain (97-113-13-231.tukw.qwest.net.
	[97.113.13.231]) by smtp.gmail.com with ESMTPSA id
	132sm7709625pga.79.2019.05.16.21.51.47
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 21:51:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 16 May 2019 21:51:32 -0700
Message-Id: <20190517045136.3509-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517045136.3509-1-richard.henderson@linaro.org>
References: <20190517045136.3509-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: [Qemu-devel] [PATCH v14 09/13] qemu/bitops.h: Add extract8 and
 extract16
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
Cc: philmd@redhat.com, ysato@users.sourceforge.jp
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


