Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E9C35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3215420726
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 13:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Imk4u4Wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3215420726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6aVd-00016P-Dj
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 08:44:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcZ-0005eu-LB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6ZcY-0007Hx-E5
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:31 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6ZcY-0007HO-7d
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 07:47:30 -0500
Received: by mail-wr1-x444.google.com with SMTP id v4so1718409wrs.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 04:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pTDgnQcfNCGcBS0F93StqkN1izWdDQLZMDSB8zlG3xk=;
 b=Imk4u4Wc32o+iCTKJ7UwXjcmaeocL5hw3ixbEtirkawjc8IAecLUHp7O7zVnbo14Zc
 K71H/4vPuohge6KJD9h5KvMu/oE9RYLE7+ybKL3PE9dXfqbuRbvxEdYvCl3RdVqi709V
 w2nlqBRUxFDMfkQQl0dor1v0a+IZZ+uF354mDT8mjGSF+YztedBgcYyFTfGmsywFdK/G
 F27mujrMq0PM8Ky5HrGw+VNu1SczXUuXRjHAgDnINLYSD9yfnNza3D/E7uyIUBLElOFb
 Xzzm1qTHKgmCPzT2S+6+eqb8hC8YdPpotiIK6tGKFaNyQfRu7bemIAGzyTN5Mu2d3HzE
 Xyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pTDgnQcfNCGcBS0F93StqkN1izWdDQLZMDSB8zlG3xk=;
 b=mLpQZkEU7lRzoNOmKBlkaTkcx2xnc9x9wz/zSYUlMLETWLJmJCIbIEf9q2IRtdIMm3
 8vW1kT/ZHcagsLOVDy9y045tP0rzJ9RGdDCBwnypvFY0/xnOH+9nghQQltfTFvQZGCnL
 hR3H/bHJM0nSYkD/sK1xOalZwRyRIUs1FaKDMcQkrWmzEYw90RuhCgdoEDdVGx5onL6B
 nqZD+TgSivx8yh1yAkN9B8495cnPvbdBDiryKF3rI4XP00L66v423r/7jibcFZ+Gdrv1
 7HGFrKNvOZoMg55IrWhBHgj6Kv2tjrSj48vfx9zhFSKxFWkBHTInzAVc331caE92pYHo
 vVYg==
X-Gm-Message-State: APjAAAWN9R80MSvanxEzOZmTLCuHXqVI3jCKZDuf0jQZD/pT6ThNOIkd
 AD/k7IacQ+xSab4+yeF+BZqPxw==
X-Google-Smtp-Source: APXvYqwXlhlAk1DpqSNo6Oq+j63MJ5OL0/xpWMa/bWRCNQVFzSMpzIdariVmsGaXVZzIXUw8mhBkjw==
X-Received: by 2002:adf:e949:: with SMTP id m9mr9185217wrn.342.1582634848552; 
 Tue, 25 Feb 2020 04:47:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a9sm25082882wrn.3.2020.02.25.04.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 04:47:22 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 709411FF9D;
 Tue, 25 Feb 2020 12:47:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 13/19] qemu/bitops.h: Add extract8 and extract16
Date: Tue, 25 Feb 2020 12:47:04 +0000
Message-Id: <20200225124710.14152-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200225124710.14152-1-alex.bennee@linaro.org>
References: <20200225124710.14152-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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


