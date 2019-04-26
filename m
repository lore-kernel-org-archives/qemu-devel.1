Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA879C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:14:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB0B6206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Sr6bYK6B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB0B6206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39975 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJu82-00049p-TC
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:14:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Z-0005U9-Jq
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Y-0004St-6k
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:51 -0400
Received: from ozlabs.org ([203.11.71.1]:32789)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0X-0004Oc-P0; Fri, 26 Apr 2019 02:06:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tm3ll9z9sNR; Fri, 26 Apr 2019 16:06:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258796;
	bh=9WvZ+VQECcATx4JUjFGZZCSnDpliNllpd9YyTPcrgXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sr6bYK6B4X892fOSswPa5tJPT7odhMTKG8JBsZJnXFuSpa0lr9vmwKJCchdLEPrJ/
	g/ibSNz6lOGDZt0GdczmCO4l1UHTEg7mPOwC4OT+m4DrqQn3qxB782j92GA/w/nFan
	vN2HgbuU2u03+x1znhRSGMr9XC/kS789MlyyWOo0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:07 +1000
Message-Id: <20190426060627.18153-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 16/36] target/ppc: Style fixes for
 mfrom_table.inc.c & mfrom_table_gen.c
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
Cc: gkurz@kaod.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060607.gOCasPb6iVXcDX6VzdgSOVH-1bA-J1idj-WzHviO3No@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mfrom_table.inc.c | 3 +--
 target/ppc/mfrom_table_gen.c | 8 +++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/ppc/mfrom_table.inc.c b/target/ppc/mfrom_table.inc.c
index 6a1fa375c9..1653b974a4 100644
--- a/target/ppc/mfrom_table.inc.c
+++ b/target/ppc/mfrom_table.inc.c
@@ -1,5 +1,4 @@
-static const uint8_t mfrom_ROM_table[602] =3D
-{
+static const uint8_t mfrom_ROM_table[602] =3D {
      77,  77,  76,  76,  75,  75,  74,  74,
      73,  73,  72,  72,  71,  71,  70,  70,
      69,  69,  68,  68,  68,  67,  67,  66,
diff --git a/target/ppc/mfrom_table_gen.c b/target/ppc/mfrom_table_gen.c
index 631791808e..f96c4268ba 100644
--- a/target/ppc/mfrom_table_gen.c
+++ b/target/ppc/mfrom_table_gen.c
@@ -2,7 +2,7 @@
 #include "qemu/osdep.h"
 #include <math.h>
=20
-int main (void)
+int main(void)
 {
     double d;
     uint8_t n;
@@ -10,7 +10,8 @@ int main (void)
=20
     printf("static const uint8_t mfrom_ROM_table[602] =3D\n{\n    ");
     for (i =3D 0; i < 602; i++) {
-        /* Extremely decomposed:
+        /*
+         * Extremely decomposed:
          *                    -T0 / 256
          * T0 =3D 256 * log10(10          + 1.0) + 0.5
          */
@@ -23,8 +24,9 @@ int main (void)
         d +=3D 0.5;
         n =3D d;
         printf("%3d, ", n);
-        if ((i & 7) =3D=3D 7)
+        if ((i & 7) =3D=3D 7) {
             printf("\n    ");
+        }
     }
     printf("\n};\n");
=20
--=20
2.20.1


