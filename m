Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF9AC04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:55:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 246D8269DD
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 13:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPDEOcIQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 246D8269DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43960 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWi0L-0007vN-DQ
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 09:55:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhom-0007Tl-1X
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWhok-0000HJ-SN
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:35 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:36234)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWhok-0000FU-Mh
	for qemu-devel@nongnu.org; Fri, 31 May 2019 09:43:34 -0400
Received: by mail-oi1-x243.google.com with SMTP id y124so7752210oiy.3
	for <qemu-devel@nongnu.org>; Fri, 31 May 2019 06:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=cN7HSsTir9LPfFs0tqL8Rk/5kniGhoqrSHsDQ6DZZvw=;
	b=DPDEOcIQZsvsE3Agtlz272WzH7Upsh/iMUqZTXtAdyG3dVnE0Rx1Bl9Zgg5I5XDSRB
	QwXfEgPV+i/IqPGs07yul+xBXzPdr/p/pnAlP8tx9FnZOm/o7Q8+WT1gEpSIsov29IbT
	JUQSdpGX73Id/8Uc3DZG0s9WPd1f/GQDrqxF4nRRIncTTWWh+jDWf9FFi5e7Uxdc1OsI
	ncnlbYB6zuuPz/uw7+kyzJZkgEFlAy82FFnAv2CSt1n9602QlaqQY6uI4iSGoK0RdXRa
	g6bKwNQprF83lTwZ5wvbr4Al9ScDn95la+ISHL3pJVY7YM6xd+9RDqliFPvkmYPOhuAT
	mpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=cN7HSsTir9LPfFs0tqL8Rk/5kniGhoqrSHsDQ6DZZvw=;
	b=pmfuRMtt2iAmf2TYQORCCp4QQhCz/iEwrgXJUo05kVK1Mfbzj1M0pbyqv4YaNRXBye
	reo9Bhtar6hmRAYoTFPGoMJbykp9Gon9vCcJ6vmtIakhUZT7kfo+Na6DY+DwdIsGnhd9
	9lp7f2Xnm6/aM0/cFLj7WHv4MrATJ1Ga05Jxt+4XW/CaOocKn6/RiGeZkCOFKzLWj9Vw
	uFh1gFmd1Kv1GqOHqmzjux9nM0rsiKrsDsnGd+vZpqjWTEmFdVYA9XaB6plq/qP4M2BD
	hXSO6lEmC4PEriSv5idiBhUXLN93gOchZIQvKN0XhQSxbA1OhmD8YPvx4sYFuYE5MUJ3
	WbGg==
X-Gm-Message-State: APjAAAVwh8coMZMwBX+ExX1GbYOBoRd2eXUD9uf/lc+IImzd4Zunbrym
	fuaezG9ln+RNb45rlrO+X1CNFj3T8l94FA==
X-Google-Smtp-Source: APXvYqxg0Zb/G54tQ/KXwUNKB771Qn+AU+xOOSqkhmQUCCzlI8T33lZbtps2AuAKBiuALwEbCxQPbg==
X-Received: by 2002:aca:d607:: with SMTP id n7mr51941oig.150.1559310213745;
	Fri, 31 May 2019 06:43:33 -0700 (PDT)
Received: from localhost.localdomain (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	r23sm2391176otg.49.2019.05.31.06.43.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 31 May 2019 06:43:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 31 May 2019 08:43:01 -0500
Message-Id: <20190531134315.4109-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531134315.4109-1-richard.henderson@linaro.org>
References: <20190531134315.4109-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: [Qemu-devel] [PATCH v16 09/23] qemu/bitops.h: Add extract8 and
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


