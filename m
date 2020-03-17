Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A984C1975A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2643320674
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 23:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nl2sfdY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2643320674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jELaO-0001Sn-8P
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 19:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jELYw-0007hf-W8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jELYv-00089t-Ro
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:23:54 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22547)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jELYv-00083B-MU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 19:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584487433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6OhLvRnONmfPlM0KOWLPzOcZgZstYjnSkF7/d4ZNRM=;
 b=Nl2sfdY69nMaujrBfcCpmy2aEIz0MgunqUbiAI/h4LtqELPiwciXl6yjNpzP5nDGNbVrzo
 xa9M4knkR18UypNVKePHhd8gHOV0NlMcR8yD8NymAOTkAH57c1xOYgVltR4u+ILNmFpJFc
 0F1Vy6ngVwCoW8MxFLUe8zr6BadEBO8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-dB0VtiV2OduyZk3xVtxbVg-1; Tue, 17 Mar 2020 19:23:49 -0400
X-MC-Unique: dB0VtiV2OduyZk3xVtxbVg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4BC18DB60;
 Tue, 17 Mar 2020 23:23:47 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E9AA60BF3;
 Tue, 17 Mar 2020 23:23:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/20] cmd646: register cmd646_reset() function in DeviceClass
Date: Tue, 17 Mar 2020 19:23:10 -0400
Message-Id: <20200317232329.22362-2-jsnow@redhat.com>
In-Reply-To: <20200317232329.22362-1-jsnow@redhat.com>
References: <20200317232329.22362-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Helge Deller <deller@gmx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>, John Snow <jsnow@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20200307151536.32709-2-mark.cave-ayland@ilande.co.uk
Signed-off-by: John Snow <jsnow@redhat.com>
---
 hw/ide/cmd646.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 335c060673..2f11d8de24 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -207,9 +207,9 @@ static void cmd646_set_irq(void *opaque, int channel, i=
nt level)
     cmd646_update_irq(pd);
 }
=20
-static void cmd646_reset(void *opaque)
+static void cmd646_reset(DeviceState *dev)
 {
-    PCIIDEState *d =3D opaque;
+    PCIIDEState *d =3D PCI_IDE(dev);
     unsigned int i;
=20
     for (i =3D 0; i < 2; i++) {
@@ -303,7 +303,6 @@ static void pci_cmd646_ide_realize(PCIDevice *dev, Erro=
r **errp)
     g_free(irq);
=20
     vmstate_register(VMSTATE_IF(dev), 0, &vmstate_ide_pci, d);
-    qemu_register_reset(cmd646_reset, d);
 }
=20
 static void pci_cmd646_ide_exitfn(PCIDevice *dev)
@@ -339,6 +338,7 @@ static void cmd646_ide_class_init(ObjectClass *klass, v=
oid *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
=20
+    dc->reset =3D cmd646_reset;
     k->realize =3D pci_cmd646_ide_realize;
     k->exit =3D pci_cmd646_ide_exitfn;
     k->vendor_id =3D PCI_VENDOR_ID_CMD;
--=20
2.21.1


