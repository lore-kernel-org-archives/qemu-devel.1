Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E3AC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5232920863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 14:34:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5232920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTSKL-0003jL-44
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 10:34:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hTSG2-00005v-0g
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hTSFz-0007T7-Ju
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:30:17 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:44387)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hTSFz-00072L-8w
	for qemu-devel@nongnu.org; Wed, 22 May 2019 10:30:15 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail02.asahi-net.or.jp (Postfix) with ESMTPA id 41AE23E19C;
	Wed, 22 May 2019 23:30:05 +0900 (JST)
Received: from yo-satoh-debian.localdomain
	(v045049.dynamic.ppp.asahi-net.or.jp [124.155.45.49])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 0F44A240086; 
	Wed, 22 May 2019 23:30:04 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 23:29:45 +0900
Message-Id: <20190522142956.41916-2-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190522142956.41916-1-ysato@users.sourceforge.jp>
References: <20190522142956.41916-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.14
Subject: [Qemu-devel] [PATCH v15 01/12] qemu/bitops.h: Add extract8 and
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 include/qemu/bitops.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
index 3f0926cf40..764f9d1ea0 100644
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -301,6 +301,44 @@ static inline uint32_t extract32(uint32_t value, int=
 start, int length)
 }
=20
 /**
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
+    assert(start >=3D 0 && length > 0 && length <=3D 8 - start);
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
+    assert(start >=3D 0 && length > 0 && length <=3D 16 - start);
+    return extract32(value, start, length);
+}
+
+/**
  * extract64:
  * @value: the value to extract the bit field from
  * @start: the lowest bit in the bit field (numbered from 0)
--=20
2.11.0


