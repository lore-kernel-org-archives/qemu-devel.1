Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5228BC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 09:18:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DBBA2173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 09:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DBBA2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho2YV-0007Ey-P3
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 05:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1ho2Y4-0005hs-Uw
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ho2Y3-00084d-U9
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 05:18:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48068)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1ho2Y1-00082q-Vt; Thu, 18 Jul 2019 05:17:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9916830872DA;
 Thu, 18 Jul 2019 09:17:56 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 631F15D6A9;
 Thu, 18 Jul 2019 09:17:43 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 18 Jul 2019 11:17:40 +0200
Message-Id: <20190718091740.6834-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Thu, 18 Jul 2019 09:17:56 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1] hw/ide/piix: Mark the PIIX IDE
 interfaces as not user_creatable
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The 'piix3-ide' (and 'piix3-ide-xen') devices are part of the
PIIX3 chipset modelled as TYPE_PIIX3_PCI_DEVICE (respectivelly
TYPE_PIIX3_XEN_DEVICE). The PIIX3 chipset can not be created
in part, it has to be created and used as a whole.

Similarly with the 'piix4-ide' device and the PIIX4 chipset
modelled as TYPE_PIIX4_PCI_DEVICE.

Disable the 'user_creatable' flag.

part of TYPE_PIIX3_PCI_DEVICE (TYPE_PIIX3_XEN_DEVICE)

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ide/piix.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index b97e555072..c02e768668 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -253,6 +253,7 @@ static void piix3_ide_class_init(ObjectClass *klass, =
void *data)
     k->device_id =3D PCI_DEVICE_ID_INTEL_82371SB_1;
     k->class_id =3D PCI_CLASS_STORAGE_IDE;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->user_creatable =3D false;
     dc->hotpluggable =3D false;
 }
=20
@@ -279,6 +280,7 @@ static void piix4_ide_class_init(ObjectClass *klass, =
void *data)
     k->device_id =3D PCI_DEVICE_ID_INTEL_82371AB;
     k->class_id =3D PCI_CLASS_STORAGE_IDE;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->user_creatable =3D false;
     dc->hotpluggable =3D false;
 }
=20
--=20
2.20.1


