Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5B4C4321A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2595E2075E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2595E2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgbQI-0002hs-Fa
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46079)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hgb1c-0002NW-JU
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hgb1b-00011x-EI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:29:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hgb1T-0000pz-OG; Thu, 27 Jun 2019 16:29:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 277C737F46;
 Thu, 27 Jun 2019 20:29:33 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-69.brq.redhat.com [10.40.204.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F3BE6600CC;
 Thu, 27 Jun 2019 20:29:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>,
	qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 22:27:06 +0200
Message-Id: <20190627202719.17739-16-philmd@redhat.com>
In-Reply-To: <20190627202719.17739-1-philmd@redhat.com>
References: <20190627202719.17739-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 27 Jun 2019 20:29:33 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v5 15/28] hw/block/pflash_cfi02: Document the
 current CFI values
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

Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <20190426162624.55977-6-stephen.checkoway@oberlin.edu>
[PMD: Extracted from bigger patch]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi02.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
index 1a794fa83c..f1bac480f5 100644
--- a/hw/block/pflash_cfi02.c
+++ b/hw/block/pflash_cfi02.c
@@ -550,6 +550,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
     pfl->wcycle =3D 0;
     pfl->cmd =3D 0;
     pfl->status =3D 0;
+
     /* Hardcoded CFI table (mostly from SG29 Spansion flash) */
     /* Standard "QRY" string */
     pfl->cfi_table[0x10] =3D 'Q';
@@ -575,7 +576,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Er=
ror **errp)
     pfl->cfi_table[0x1D] =3D 0x00;
     /* Vpp max (no Vpp pin) */
     pfl->cfi_table[0x1E] =3D 0x00;
-    /* Reserved */
+    /* Timeout per single byte/word write (128 ms) */
     pfl->cfi_table[0x1F] =3D 0x07;
     /* Timeout for min size buffer write (NA) */
     pfl->cfi_table[0x20] =3D 0x00;
@@ -614,17 +615,25 @@ static void pflash_cfi02_realize(DeviceState *dev, =
Error **errp)
     pfl->cfi_table[0x32] =3D 'R';
     pfl->cfi_table[0x33] =3D 'I';
=20
+    /* Extended version 1.0 */
     pfl->cfi_table[0x34] =3D '1';
     pfl->cfi_table[0x35] =3D '0';
=20
+    /* Address sensitive unlock required. */
     pfl->cfi_table[0x36] =3D 0x00;
+    /* Erase suspend not supported. */
     pfl->cfi_table[0x37] =3D 0x00;
+    /* Sector protect not supported. */
     pfl->cfi_table[0x38] =3D 0x00;
+    /* Temporary sector unprotect not supported. */
     pfl->cfi_table[0x39] =3D 0x00;
=20
+    /* Sector protect/unprotect scheme. */
     pfl->cfi_table[0x3a] =3D 0x00;
=20
+    /* Simultaneous operation not supported. */
     pfl->cfi_table[0x3b] =3D 0x00;
+    /* Burst mode not supported. */
     pfl->cfi_table[0x3c] =3D 0x00;
 }
=20
--=20
2.20.1


