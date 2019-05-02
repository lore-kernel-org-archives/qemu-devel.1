Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C3CAC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:53:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB5C20652
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 14:53:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB5C20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52487 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMD53-0005S5-I7
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 10:53:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hMCnD-0003Wq-F9
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hMCnB-0008QK-My
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:34:35 -0400
Received: from mail02.asahi-net.or.jp ([202.224.55.14]:41262)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ysato@users.sourceforge.jp>) id 1hMCnB-0008PO-C6
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:34:33 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.vps.ablenet.jp
	[61.195.96.97]) (Authenticated sender: PQ4Y-STU)
	by mail02.asahi-net.or.jp (Postfix) with ESMTPA id ED0EB3BC86;
	Thu,  2 May 2019 23:34:27 +0900 (JST)
Received: from ysato.dip.jp (ZM005235.ppp.dion.ne.jp [222.8.5.235])
	by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id ABDBF240086; 
	Thu,  2 May 2019 23:34:27 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 23:34:09 +0900
Message-Id: <20190502143409.59600-13-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190502143409.59600-1-ysato@users.sourceforge.jp>
References: <20190502143409.59600-1-ysato@users.sourceforge.jp>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 202.224.55.14
Subject: [Qemu-devel] [PATCH RFC v8 12/12] hw/registerfields.h: Add 8bit and
 16bit register macros.
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
	Yoshinori Sato <ysato@users.sourceforge.jp>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190502143409.54qfpG8c2WRLkWulmnP32DAwSekk9qWWVXnnK33O2cg@z>

Some RX peripheral using 8bit and 16bit registers.
Added 8bit and 16bit APIs.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 include/hw/registerfields.h | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index 2659a58737..51bfd0cf67 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -22,6 +22,14 @@
     enum { A_ ## reg = (addr) };                                          \
     enum { R_ ## reg = (addr) / 4 };
 
+#define REG8(reg, addr)                                                  \
+    enum { A_ ## reg = (addr) };                                          \
+    enum { R_ ## reg = (addr) };
+
+#define REG16(reg, addr)                                                  \
+    enum { A_ ## reg = (addr) };                                          \
+    enum { R_ ## reg = (addr) / 2 };
+
 /* Define SHIFT, LENGTH and MASK constants for a field within a register */
 
 /* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_LENGTH
@@ -40,6 +48,8 @@
 #define FIELD_EX64(storage, reg, field)                                   \
     extract64((storage), R_ ## reg ## _ ## field ## _SHIFT,               \
               R_ ## reg ## _ ## field ## _LENGTH)
+#define FIELD_EX8  FIELD_EX32
+#define FIELD_EX16 FIELD_EX32
 
 /* Extract a field from an array of registers */
 #define ARRAY_FIELD_EX32(regs, reg, field)                                \
@@ -49,6 +59,22 @@
  * Assigning values larger then the target field will result in
  * compilation warnings.
  */
+#define FIELD_DP8(storage, reg, field, val) ({                            \
+    struct {                                                              \
+        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
+    } v = { .v = val };                                                   \
+    uint8_t d;                                                            \
+    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
+                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
+    d; })
+#define FIELD_DP16(storage, reg, field, val) ({                           \
+    struct {                                                              \
+        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
+    } v = { .v = val };                                                   \
+    uint16_t d;                                                           \
+    d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
+                  R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
+    d; })
 #define FIELD_DP32(storage, reg, field, val) ({                           \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
@@ -57,7 +83,7 @@
     d = deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,           \
                   R_ ## reg ## _ ## field ## _LENGTH, v.v);               \
     d; })
-#define FIELD_DP64(storage, reg, field, val) ({                           \
+#define FIELD_DP64(storage, reg, field, val) ({                         \
     struct {                                                              \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;                \
     } v = { .v = val };                                                   \
-- 
2.11.0


