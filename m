Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FA6C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20513216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 15:54:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20513216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjQXk-0002C1-9x
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 11:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36675)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hjQQs-0003UE-PD
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hjQQm-0007Hf-U7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 11:47:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hjQQh-0006oI-V2; Fri, 05 Jul 2019 11:47:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3F63930C3192;
 Fri,  5 Jul 2019 15:47:17 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-45.brq.redhat.com [10.40.204.45])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2EF741001B30;
 Fri,  5 Jul 2019 15:47:14 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri,  5 Jul 2019 17:46:37 +0200
Message-Id: <20190705154639.16591-8-philmd@redhat.com>
In-Reply-To: <20190705154639.16591-1-philmd@redhat.com>
References: <20190705154639.16591-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Fri, 05 Jul 2019 15:47:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 7/9] hw/block/pflash_cfi01: Improve command
 comments
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Regression-tested-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index e097d9260d..ba00e52923 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -208,11 +208,11 @@ static uint32_t pflash_devid_query(PFlashCFI01 *pfl=
, hwaddr offset)
      * Offsets 2/3 are block lock status, is not emulated.
      */
     switch (boff & 0xFF) {
-    case 0:
+    case 0: /* Manufacturer ID */
         resp =3D pfl->ident0;
         trace_pflash_manufacturer_id(resp);
         break;
-    case 1:
+    case 1: /* Device ID */
         resp =3D pfl->ident1;
         trace_pflash_device_id(resp);
         break;
@@ -455,11 +455,11 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr o=
ffset,
     case 0:
         /* read mode */
         switch (cmd) {
-        case 0x10: /* Single Byte Program */
-        case 0x40: /* Single Byte Program */
+        case 0x10: /* Single Byte Program (setup) */
+        case 0x40: /* Single Byte Program (setup) [Intel] */
             DPRINTF("%s: Single Byte Program\n", __func__);
             break;
-        case 0x20: /* Block erase */
+        case 0x20: /* Block erase (setup) */
             p =3D pfl->storage;
             offset &=3D ~(pfl->sector_len - 1);
=20
@@ -515,8 +515,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
         break;
     case 1:
         switch (pfl->cmd) {
-        case 0x10: /* Single Byte Program */
-        case 0x40: /* Single Byte Program */
+        case 0x10: /* Single Byte Program (confirm) */
+        case 0x40: /* Single Byte Program (confirm) [Intel] */
             DPRINTF("%s: Single Byte Program\n", __func__);
             if (!pfl->ro) {
                 pflash_data_write(pfl, offset, value, width, be);
@@ -527,7 +527,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr off=
set,
             pfl->status |=3D 0x80; /* Ready! */
             pfl->wcycle =3D 0;
         break;
-        case 0x20: /* Block erase */
+        case 0x20: /* Block erase (confirm) */
         case 0x28:
             if (cmd =3D=3D 0xd0) { /* confirm */
                 pfl->wcycle =3D 0;
--=20
2.20.1


