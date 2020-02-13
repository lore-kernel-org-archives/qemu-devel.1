Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4389BC352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAF320873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 22:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wAupu899"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAF320873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2NRa-0007I8-7I
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 17:58:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKP-0004uO-7e
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j2NKO-0003vM-24
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:25 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j2NKN-0003tQ-Ri
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 17:51:23 -0500
Received: by mail-wm1-x343.google.com with SMTP id t14so8602003wmi.5
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 14:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pTDgnQcfNCGcBS0F93StqkN1izWdDQLZMDSB8zlG3xk=;
 b=wAupu8999iU8ZRq1G6J3JcmKXOduih0GNkOBGU3ni68xoP8+uPPS5+YSa8E3zPgXnm
 otIcsd1RLkFtjO/WQgTGFQ87JgkQKDON13YYXpWczg4flAvw6siU2do8bIaK0pvzyd+H
 eE4qnH6HBb+26NabTWniFZtwsuc0GHBXEocjvVrvZKKv4LynsAKHEWi39slHJva7JX9p
 PukP2w9xK/vhMBzTY6kUK3fLKdAJfb92dtyufGPSSi7bwsVJYfTKescrR66MzuFK2+gV
 CvXRry5q2gtf/P2+nWZKJLRMQcYIhdPKAvxx8avZMgWCGfyMd6uaYR8eS8IqePKYkqA3
 Mbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pTDgnQcfNCGcBS0F93StqkN1izWdDQLZMDSB8zlG3xk=;
 b=rWNItzBjqvBWAYl425myw6qG8v8ZSbQB2BRT9G43UUVm7nqmY6qe/61kY5v5LyK4S3
 MI6dq5ZpkTdTDfyya20KXxZvqAXEpsTNIaJGX/5Ca/6q3CpWURhj7KTTe4XcDCe772Zs
 khZFKkf7t7KeVNdBQua7qzAi7THTIe/jfauSZpVsXQr8vp4Q/Jkl4r5UWDW5k4XhJiRn
 NEUPpru2CZPiqbhDacHQ1Je4qybZEKkScqiYQWKGPnLNH31esg9n43tMC+kLvow9M/bK
 xn0SKwNFSSPcbW6eJY4eGFYH6CfyldaN7nxCiBW7DT7KRTLFx5slSAEar8GbJUUYlNFf
 OVYg==
X-Gm-Message-State: APjAAAXoO5YQ3znXTaPpLc3nd0OLGFefDqB0q7GaCCdEsU+Uc8Nz5d31
 5dWdJwAwRGXQ8JN1RkaEHyxG/g==
X-Google-Smtp-Source: APXvYqwgtsD4C/qMAzlD6Qq+4hHlQGwZzNIJhFqoau0B7jU+a9htWXmkqS8AvidQJfBKutSotbzq9w==
X-Received: by 2002:a1c:688a:: with SMTP id d132mr304265wmc.189.1581634282829; 
 Thu, 13 Feb 2020 14:51:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 133sm5011722wme.32.2020.02.13.14.51.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2020 14:51:20 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C1CC41FF9D;
 Thu, 13 Feb 2020 22:51:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 13/19] qemu/bitops.h: Add extract8 and extract16
Date: Thu, 13 Feb 2020 22:51:03 +0000
Message-Id: <20200213225109.13120-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200213225109.13120-1-alex.bennee@linaro.org>
References: <20200213225109.13120-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 pbonzini@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 richard.henderson@linaro.org, f4bug@amsat.org, robhenry@microsoft.com,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 marcandre.lureau@redhat.com, aaron@os.amperecomputing.com, cota@braap.org,
 stefanha@redhat.com, kuhn.chenqun@huawei.com, peter.puhov@linaro.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190607091116.49044-10-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20200212130311.127515-3-ysato@users.sourceforge.jp>
---
 include/qemu/bitops.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 02c1ce6a5d4..f55ce8b320b 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -301,6 +301,44 @@ static inline uint32_t extract32(uint32_t value, int start, int length)
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
2.20.1


