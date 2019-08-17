Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0547FC3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 07:38:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD972086C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 07:38:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD972086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hytI1-000074-Jz
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 03:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40991)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hytGT-0006pc-5n
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 03:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hytGR-0006Wu-Gj
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 03:36:41 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:47797)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hytGR-0006VM-7u
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 03:36:39 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id 667A2570BF;
 Sat, 17 Aug 2019 16:36:35 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id F1818240087;
 Sat, 17 Aug 2019 16:36:34 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Sat, 17 Aug 2019 16:36:08 +0900
Message-Id: <20190817073628.94473-3-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190817073628.94473-1-ysato@users.sourceforge.jp>
References: <20190817073628.94473-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.15
Subject: [Qemu-devel] [PATCH v23 02/22] qemu/bitops.h: Add extract8 and
 extract16
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
Cc: peter.maydell@linaro.org, imammedo@redhat.com, richard.henderson@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190607091116.49044-10-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


