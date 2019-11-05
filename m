Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB78C5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:20:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C4D214D8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 18:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C4D214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS3R2-00074t-QF
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 13:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS3It-00061K-Ud
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS3Is-0004jN-MG
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:43 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:60255)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iS3Is-0004i4-C4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 13:11:42 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdNHa-1hsiY51wJ6-00ZRvt; Tue, 05 Nov 2019 19:11:29 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/13] target/sparc: Define an enumeration for accessing
 env->regwptr
Date: Tue,  5 Nov 2019 19:11:10 +0100
Message-Id: <20191105181119.26779-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105181119.26779-1-laurent@vivier.eu>
References: <20191105181119.26779-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bi2y0XCclKSXkLno3NhKccQ1iRsLgjLWD+Lke1xU57HFW/eXj/q
 O5mzEQ3JLwj+WXtL2zcZnihcNSBKUHdu6gdr2s0PCJ7mfqlyTko3JC31+vSeNbd4x/oGJge
 DL09/n55xdNzraUyIe9FmSzGO6FJC6SO3bq6UBhxx9Uy2hsxObJ7fv/zsW6gUNFi3hLIPCn
 H8ySu1Si0BxGW1GDKiBbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:G1m2rGcYx+8=:KBMxrc2wdILnvSGlC+B5CI
 CZkSVzJNBO3Mw/d7ZJaCZYSb772TfWFxTfMWxStKBuSWpnpn1tmzG+zpIMLRkcp/PROe16q+v
 E2avjPje09T8/wgHnR1SnnhDEa1nA+u2hlcK3oCmEDdnxoO5trXZHik16C8ZFbxtwWdiCJ7v4
 AkQMzBqpYHG8vn1YRwnhA3yjB17FmSL6FyNddpU4ZAKmmTtYl28+L1zLD+xu9Qb2SSTLO5MDm
 oOdasOhhaYnpgSUMKbQS2Y1fzpmwAk7EnuAwpevgtUEmv2JI9n5ui96PYrSx4t5SYy48ipydo
 4/2jXFz2ogK+LzSq1n3LXMSJCEwT9t6k8wCaewpzDy6YxbSLnK9rrYWEtFjDxf5IBBkm3oM6f
 o+WTPEC9Uax6KVTrBuly7kKQgxT0x3jmUrZ1aIIPGcao+jUW9HgAahK/6Z7Z3wAimC0qFsIVD
 kVX+AKIfNSRGGu/V0C/LhuNVgM1GExQxfbhXVsjkV48F8gytIGsZz/WG7jHAyZnIAUzBwfhI2
 55PDqyOUJE+tdIeFUp4A7sFNiRlsHOYYXMryBbBAtkCke8fuIRHcgX93cc7/y5Dw33s0iVP4A
 iFZzWH4Vcxv0AWrc1Rt4WpBy2qxM7WH6EHjCXNA4bLN40F3iPJUWpJ5Afe3y7seR9HOxJHwMG
 /jFbsOcRvqnvF5UmAjQuh+MEtX0ADeLAi4syHPNuDk0yCcGkyOQsYoS+P0mtkZRvk0i+0e89k
 wyS6hT+jMh/Gnxs6RxALUzX3KvtUsEBeYbGBrcytuDeXxYPpkjThM3pikmLoyJhG5LCdLxIFf
 C3c5TbMxtRPMiS6imyhTo7xhlfaFTtPmLuoSi17DtiyjkdakfYDH57ad7+Zq4I5gpcuIqNHw6
 1FV4LlWYRo3dK8CCRCyg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20191025113921.9412-4-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 target/sparc/cpu.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index 778aa8e073c7..ae97c7d9f799 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -13,6 +13,39 @@
 
 /*#define EXCP_INTERRUPT 0x100*/
 
+/* Windowed register indexes.  */
+enum {
+    WREG_O0,
+    WREG_O1,
+    WREG_O2,
+    WREG_O3,
+    WREG_O4,
+    WREG_O5,
+    WREG_O6,
+    WREG_O7,
+
+    WREG_L0,
+    WREG_L1,
+    WREG_L2,
+    WREG_L3,
+    WREG_L4,
+    WREG_L5,
+    WREG_L6,
+    WREG_L7,
+
+    WREG_I0,
+    WREG_I1,
+    WREG_I2,
+    WREG_I3,
+    WREG_I4,
+    WREG_I5,
+    WREG_I6,
+    WREG_I7,
+
+    WREG_SP = WREG_O6,
+    WREG_FP = WREG_I6,
+};
+
 /* trap definitions */
 #ifndef TARGET_SPARC64
 #define TT_TFAULT   0x01
-- 
2.21.0


