Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F314C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3166120714
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 09:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3166120714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jE90N-0001wV-Bs
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 05:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jE8yw-0008Ip-Qc
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:57:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jE8yu-0006Wr-S3
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 05:57:54 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:31342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jE8ys-0005zv-95; Tue, 17 Mar 2020 05:57:50 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 847BA747E15;
 Tue, 17 Mar 2020 10:57:44 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3B8A4747E0F; Tue, 17 Mar 2020 10:57:44 +0100 (CET)
Message-Id: <59c6743ce76b1b0fc36d048968760f130ebcf5a3.1584437958.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1584437957.git.balaton@eik.bme.hu>
References: <cover.1584437957.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 4/7] hw/ide/pci.c: Coding style update to fix checkpatch
 errors
Date: Tue, 17 Mar 2020 10:39:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org,
    qemu-block@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, hpoussin@reactos.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Spaces are required around a + operator and if statements should have
braces even for single line. Also make it simpler by reversing the
condition instead of breaking the loop.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 hw/ide/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 4fc76c5225..e0c84392e2 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -485,9 +485,9 @@ void pci_ide_create_devs(PCIDevice *dev, DriveInfo **=
hd_table)
     int i;
=20
     for (i =3D 0; i < 4; i++) {
-        if (hd_table[i] =3D=3D NULL)
-            continue;
-        ide_create_drive(d->bus+bus[i], unit[i], hd_table[i]);
+        if (hd_table[i]) {
+            ide_create_drive(d->bus + bus[i], unit[i], hd_table[i]);
+        }
     }
 }
=20
--=20
2.21.1


