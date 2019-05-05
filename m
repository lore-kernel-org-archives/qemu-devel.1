Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65056C004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:31:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BA5E2082F
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BA5E2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNJ7H-0002Aq-Ch
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:31:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNJ4Z-0008Qs-MM
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:29:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hNJ4Y-0003UO-Qf
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:29:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57716)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>)
	id 1hNJ4Y-0003Tx-LA; Sun, 05 May 2019 11:29:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EF34B30054AB;
	Sun,  5 May 2019 15:29:01 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-35.brq.redhat.com [10.40.204.35])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 68F9360C18;
	Sun,  5 May 2019 15:28:59 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Artyom Tarasenko <atar4qemu@gmail.com>, qemu-devel@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Sun,  5 May 2019 17:28:39 +0200
Message-Id: <20190505152839.18650-4-philmd@redhat.com>
In-Reply-To: <20190505152839.18650-1-philmd@redhat.com>
References: <20190505152839.18650-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Sun, 05 May 2019 15:29:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 3/3] hw/ppc/40p: use 1900 as a base year
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
Cc: qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505152839.cKi1HF-iNWbvZDZgRxklMRQVFoKN63kDutn0vEo7Bso@z>

From: Artyom Tarasenko <atar4qemu@gmail.com>

AIX 5.1 expects the base year to be 1900. Adjust accordingly.

Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/prep.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 7a0d311d43c..2a8009e20b4 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -676,7 +676,9 @@ static void ibm_40p_init(MachineState *machine)
     qdev_init_nofail(dev);
=20
     /* RTC */
-    isa_create_simple(isa_bus, TYPE_MC146818_RTC);
+    dev =3D DEVICE(isa_create(isa_bus, TYPE_MC146818_RTC));
+    qdev_prop_set_int32(dev, "base_year", 1900);
+    qdev_init_nofail(dev);
=20
     /* initialize CMOS checksums */
     cmos_checksum =3D 0x6aa9;
--=20
2.20.1


