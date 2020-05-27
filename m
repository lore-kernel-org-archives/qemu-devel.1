Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D47AC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 18:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 319CD2089D
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 18:36:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c3RtnbX2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 319CD2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1je0uW-0005ME-BW
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 14:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1je0tP-0004DY-2S
 for qemu-devel@nongnu.org; Wed, 27 May 2020 14:35:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:7837)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=40961fbaf=alistair.francis@wdc.com>)
 id 1je0tK-0005Pf-Ga
 for qemu-devel@nongnu.org; Wed, 27 May 2020 14:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590604503; x=1622140503;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=JA9963faAupyrUAcMzxlBsFABBC9qlPO5iGI61Pd/SE=;
 b=c3RtnbX2TL462T7vtXO95JFbFkMDJxOnNEaYvm63kw72uFHP8MBl8A4X
 3laepyFqVYrhhJnyvzeNQfA9Sp3/JfC/3Vp9yFdptUDQaTQxfr/am39C6
 PIUhWRSKVjbPzvzKueMYAdTZPrYLb3N5x8d69rrHYwO6hANifxKSTj9qb
 sORl7/2wVhHP9ithq7Z669lc4QnaVy21wbJlNwNYd62i3P1gDOW3ro6Tw
 b57MHZCq20eW+MEse2dT/QTQ/GXMztzKzUv9jS3pyO7u/0T5SgRvFH8UL
 HSZWZWtqJsH6dN+odaKPXqWB4WqUSAXLyjaofSXrQrkZR91M5QdVw39Xc Q==;
IronPort-SDR: CXk/qXqSJUoesUXe9xVwgKwefXIIDJRjksTgaKfN3D0NuNnBobO8gnunRhKU36quRnndDzDzR8
 wfCJpUJ4znu+i/DICJT//Zn04ksXz57IXV1GSChrcLbbUxcoDMqIUxUbFtecBOu5O5HN0Z6P7w
 4uXzw3Qr6D2FiDo5b4fc4+G09DWXTuitbeDVnrz/I4LtJvL+3ECBtQy13U8f3MlAQAi8vlAOcy
 FRMWjRr6jwHxo2GLK5/qrajjgGozE5qyfL88rTkvORZISOruLYhpH8Q1NZWrLPAXoNV6l6yPMc
 YgA=
X-IronPort-AV: E=Sophos;i="5.73,442,1583164800"; d="scan'208";a="140069856"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 May 2020 02:35:00 +0800
IronPort-SDR: 7rABdzp0dYxgSQHqSUC+pqQp7rP4FQgDttJ1aVy0Sxq3AxX0qVHTodHUVm0xvuSri1/xRTPolT
 Wbb/m8eXln2HR3dfDqb+4F3btI0ZLg4m4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2020 11:24:50 -0700
IronPort-SDR: 5BP0NHiDLp4eF611xr4vkeG5dhaxSjcXo6E5xXdqaCwPeovMO0xjoMKm8ktKU1iQeYqi1R7+fW
 k2a6O8fCVlnQ==
WDCIronportException: Internal
Received: from 71vjjc2.ad.shared (HELO risc6-mainframe.hgst.com)
 ([10.86.57.96])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 May 2020 11:34:59 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 1/1] hw/registerfields: Prefix local variables with underscore
 in macros
Date: Wed, 27 May 2020 11:26:17 -0700
Message-Id: <20200527182617.1979018-2-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527182617.1979018-1-alistair.francis@wdc.com>
References: <20200527182617.1979018-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.71.154.45;
 envelope-from=prvs=40961fbaf=alistair.francis@wdc.com;
 helo=esa6.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 12:58:55
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

One can name a local variable holding a value as 'v', but it
currently clashes with the registerfields macros. To save others
to debug the same mistake, prefix the macro's local variables
with an underscore.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200510203457.10546-1-f4bug@amsat.org
Message-Id: <20200510203457.10546-1-f4bug@amsat.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/hw/registerfields.h | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index 0407edb7ec..93fa4a84c2 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -66,35 +66,35 @@
 #define FIELD_DP8(storage, reg, field, val) ({                            \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
-    } v = { .v = val };                                                   \
-    uint8_t d;                                                            \
-    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
-                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
-    d; })
+    } _v = { .v = val };                                                  \
+    uint8_t _d;                                                           \
+    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
+                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
+    _d; })
 #define FIELD_DP16(storage, reg, field, val) ({                           \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
-    } v = { .v = val };                                                   \
-    uint16_t d;                                                           \
-    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
-                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
-    d; })
+    } _v = { .v = val };                                                  \
+    uint16_t _d;                                                          \
+    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
+                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
+    _d; })
 #define FIELD_DP32(storage, reg, field, val) ({                           \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
-    } v = { .v = val };                                                   \
-    uint32_t d;                                                           \
-    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
-                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
-    d; })
+    } _v = { .v = val };                                                  \
+    uint32_t _d;                                                          \
+    _d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
+                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
+    _d; })
 #define FIELD_DP64(storage, reg, field, val) ({                           \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
-    } v = { .v = val };                                                   \
-    uint64_t d;                                                           \
-    d = deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
-                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
-    d; })
+    } _v = { .v = val };                                                  \
+    uint64_t _d;                                                          \
+    _d = deposit64((storage), R_ ## reg ## _ ## field ## _SHIFT,          \
+                  R_ ## reg ## _ ## field ## _LENGTH, _v.v);              \
+    _d; })
 
 /* Deposit a field to array of registers.  */
 #define ARRAY_FIELD_DP32(regs, reg, field, val)                           \
-- 
2.26.2


