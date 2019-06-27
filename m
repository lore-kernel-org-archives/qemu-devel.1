Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B71C5B54D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70DB12075E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 21:01:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70DB12075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbWh-0000Fc-AO
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 17:01:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47034)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgb3Q-0004Vc-4T
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:31:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgb3O-0003k4-Mu
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:31:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40484)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgb32-00036Y-1b; Thu, 27 Jun 2019 16:31:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7209330BB54B;
 Thu, 27 Jun 2019 20:31:07 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01734600CC;
 Thu, 27 Jun 2019 20:30:57 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:27:18 +0200
Message-Id: <20190627202719.17739-28-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-1-philmd@redhat.com>
References: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 27 Jun 2019 20:31:07 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 27/28] hw/block/pflash_cfi02: Document
 commands
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Walle <michael@walle.cc>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index e9519cbae8..db9dc7d8fb 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -327,7 +327,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offs=
et, unsigned int width)
         pfl->wcycle =3D 0;
         pfl->cmd =3D 0;
         /* fall through to the read code */
-    case 0x80:
+    case 0x80: /* Erase (unlock) */
         /* We accept reads during second unlock sequence... */
     case 0x00:
         if (pflash_erase_suspend_mode(pfl) &&
@@ -342,8 +342,7 @@ static uint64_t pflash_read(void *opaque, hwaddr offs=
et, unsigned int width)
         /* Flash area read */
         ret =3D pflash_data_read(pfl, offset, width);
         break;
-    case 0x90:
-        /* flash ID read */
+    case 0x90: /* flash ID read */
         switch (boff) {
         case 0x00:
         case 0x01:
@@ -364,11 +363,11 @@ static uint64_t pflash_read(void *opaque, hwaddr of=
fset, unsigned int width)
         }
         DPRINTF("%s: ID " TARGET_FMT_plx " %" PRIx64 "\n", __func__, bof=
f, ret);
         break;
-    case 0x10:
-    case 0x30:
+    case 0x10: /* Chip Erase */
+    case 0x30: /* Sector Erase */
         /* Toggle bit 2 during erase, but not program. */
         toggle_dq2(pfl);
-    case 0xA0:
+    case 0xA0: /* Program */
         /* Toggle bit 6 */
         toggle_dq6(pfl);
         /* Status register read */
@@ -470,7 +469,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
             return;
         }
         /* Handle erase resume in erase suspend mode, otherwise reset. *=
/
-        if (cmd =3D=3D 0x30) {
+        if (cmd =3D=3D 0x30) { /* Erase Resume */
             if (pflash_erase_suspend_mode(pfl)) {
                 /* Resume the erase. */
                 timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRT=
UAL) +
@@ -485,7 +484,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
             goto reset_flash;
         }
         /* Ignore erase suspend. */
-        if (cmd =3D=3D 0xB0) {
+        if (cmd =3D=3D 0xB0) { /* Erase Suspend */
             return;
         }
         if (boff !=3D pfl->unlock_addr0 || cmd !=3D 0xAA) {
@@ -516,9 +515,9 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
         case 0x20:
             pfl->bypass =3D 1;
             goto do_bypass;
-        case 0x80:
-        case 0x90:
-        case 0xA0:
+        case 0x80: /* Erase */
+        case 0x90: /* Autoselect */
+        case 0xA0: /* Program */
             pfl->cmd =3D cmd;
             DPRINTF("%s: starting command %02x\n", __func__, cmd);
             break;
@@ -529,10 +528,10 @@ static void pflash_write(void *opaque, hwaddr offse=
t, uint64_t value,
         break;
     case 3:
         switch (pfl->cmd) {
-        case 0x80:
+        case 0x80: /* Erase */
             /* We need another unlock sequence */
             goto check_unlock0;
-        case 0xA0:
+        case 0xA0: /* Program */
             if (pflash_erase_suspend_mode(pfl) &&
                 pflash_sector_is_erasing(pfl, offset)) {
                 /* Ignore writes to erasing sectors. */
@@ -562,7 +561,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
             if (pfl->bypass)
                 goto do_bypass;
             goto reset_flash;
-        case 0x90:
+        case 0x90: /* Autoselect */
             if (pfl->bypass && cmd =3D=3D 0x00) {
                 /* Unlock bypass reset */
                 goto reset_flash;
@@ -585,11 +584,11 @@ static void pflash_write(void *opaque, hwaddr offse=
t, uint64_t value,
         }
     case 4:
         switch (pfl->cmd) {
-        case 0xA0:
+        case 0xA0: /* Program */
             /* Ignore writes while flash data write is occurring */
             /* As we suppose write is immediate, this should never happe=
n */
             return;
-        case 0x80:
+        case 0x80: /* Erase */
             goto check_unlock1;
         default:
             /* Should never happen */
@@ -604,7 +603,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
             goto reset_flash;
         }
         switch (cmd) {
-        case 0x10:
+        case 0x10: /* Chip Erase */
             if (boff !=3D pfl->unlock_addr0) {
                 DPRINTF("%s: chip erase: invalid address " TARGET_FMT_pl=
x "\n",
                         __func__, offset);
@@ -621,8 +620,7 @@ static void pflash_write(void *opaque, hwaddr offset,=
 uint64_t value,
             timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 +
                       (1ULL << pfl->cfi_table[0x22]) * SCALE_MS);
             break;
-        case 0x30:
-            /* Sector erase */
+        case 0x30: /* Sector erase */
             pflash_sector_erase(pfl, offset);
             break;
         default:
@@ -633,10 +631,10 @@ static void pflash_write(void *opaque, hwaddr offse=
t, uint64_t value,
         break;
     case 6:
         switch (pfl->cmd) {
-        case 0x10:
+        case 0x10: /* Chip Erase */
             /* Ignore writes during chip erase */
             return;
-        case 0x30:
+        case 0x30: /* Sector erase */
             if (cmd =3D=3D 0xB0) {
                 /*
                  * If erase suspend happens during the erase timeout (so=
 DQ3 is
--=20
2.20.1


