Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68106C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 07:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CE562086C
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 07:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE562086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=users.sourceforge.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hytKZ-0003nT-TQ
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 03:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40990)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hytGT-0006pb-4g
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 03:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hytGR-0006X1-IV
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 03:36:41 -0400
Received: from mail03.asahi-net.or.jp ([202.224.55.15]:47798)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <ysato@users.sourceforge.jp>) id 1hytGR-0006VO-9g
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 03:36:39 -0400
Received: from h61-195-96-97.vps.ablenet.jp (h61-195-96-97.ablenetvps.ne.jp
 [61.195.96.97]) (Authenticated sender: PQ4Y-STU)
 by mail03.asahi-net.or.jp (Postfix) with ESMTPA id A77825711D;
 Sat, 17 Aug 2019 16:36:35 +0900 (JST)
Received: from yo-satoh-debian.localdomain (ZM005235.ppp.dion.ne.jp
 [222.8.5.235])
 by h61-195-96-97.vps.ablenet.jp (Postfix) with ESMTPSA id 3F5D6240088;
 Sat, 17 Aug 2019 16:36:35 +0900 (JST)
From: Yoshinori Sato <ysato@users.sourceforge.jp>
To: qemu-devel@nongnu.org
Date: Sat, 17 Aug 2019 16:36:09 +0900
Message-Id: <20190817073628.94473-4-ysato@users.sourceforge.jp>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190817073628.94473-1-ysato@users.sourceforge.jp>
References: <20190817073628.94473-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 202.224.55.15
Subject: [Qemu-devel] [PATCH v23 03/22] hw/registerfields.h: Add 8bit and
 16bit register macros
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Some RX peripheral using 8bit and 16bit registers.
Added 8bit and 16bit APIs.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-Id: <20190607091116.49044-11-ysato@users.sourceforge.jp>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/hw/registerfields.h | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/hw/registerfields.h b/include/hw/registerfields.h
index 2659a58737..a0bb0654d6 100644
--- a/include/hw/registerfields.h
+++ b/include/hw/registerfields.h
@@ -22,6 +22,14 @@
     enum { A_ ## reg =3D (addr) };                                      =
    \
     enum { R_ ## reg =3D (addr) / 4 };
=20
+#define REG8(reg, addr)                                                 =
 \
+    enum { A_ ## reg =3D (addr) };                                      =
    \
+    enum { R_ ## reg =3D (addr) };
+
+#define REG16(reg, addr)                                                =
  \
+    enum { A_ ## reg =3D (addr) };                                      =
    \
+    enum { R_ ## reg =3D (addr) / 2 };
+
 /* Define SHIFT, LENGTH and MASK constants for a field within a register=
 */
=20
 /* This macro will define R_FOO_BAR_MASK, R_FOO_BAR_SHIFT and R_FOO_BAR_=
LENGTH
@@ -34,6 +42,12 @@
                                         MAKE_64BIT_MASK(shift, length)};
=20
 /* Extract a field from a register */
+#define FIELD_EX8(storage, reg, field)                                  =
  \
+    extract8((storage), R_ ## reg ## _ ## field ## _SHIFT,              =
  \
+              R_ ## reg ## _ ## field ## _LENGTH)
+#define FIELD_EX16(storage, reg, field)                                 =
  \
+    extract16((storage), R_ ## reg ## _ ## field ## _SHIFT,             =
  \
+              R_ ## reg ## _ ## field ## _LENGTH)
 #define FIELD_EX32(storage, reg, field)                                 =
  \
     extract32((storage), R_ ## reg ## _ ## field ## _SHIFT,             =
  \
               R_ ## reg ## _ ## field ## _LENGTH)
@@ -49,6 +63,22 @@
  * Assigning values larger then the target field will result in
  * compilation warnings.
  */
+#define FIELD_DP8(storage, reg, field, val) ({                          =
  \
+    struct {                                                            =
  \
+        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
+    } v =3D { .v =3D val };                                             =
      \
+    uint8_t d;                                                          =
  \
+    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
+                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
+    d; })
+#define FIELD_DP16(storage, reg, field, val) ({                         =
  \
+    struct {                                                            =
  \
+        unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
+    } v =3D { .v =3D val };                                             =
      \
+    uint16_t d;                                                         =
  \
+    d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
+                  R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
+    d; })
 #define FIELD_DP32(storage, reg, field, val) ({                         =
  \
     struct {                                                            =
  \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
@@ -57,7 +87,7 @@
     d =3D deposit32((storage), R_ ## reg ## _ ## field ## _SHIFT,       =
    \
                   R_ ## reg ## _ ## field ## _LENGTH, v.v);             =
  \
     d; })
-#define FIELD_DP64(storage, reg, field, val) ({                         =
  \
+#define FIELD_DP64(storage, reg, field, val) ({                         =
\
     struct {                                                            =
  \
         unsigned int v:R_ ## reg ## _ ## field ## _LENGTH;              =
  \
     } v =3D { .v =3D val };                                             =
      \
--=20
2.11.0


