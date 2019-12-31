Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4280C2D0DC
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 20:26:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 744BA206DA
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 20:26:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="URXb58c3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 744BA206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imO5d-0001vo-KM
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 15:26:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1imO4s-0001Tl-7E
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 15:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1imO4r-0002Tl-2f
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 15:25:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47703
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1imO4q-0002Da-Q6
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 15:25:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577822853;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Azf6l05r1GbAVegiICyFOH+qFZT1sALnKP93sjW0wzg=;
 b=URXb58c33jssiLl1hUOJKf+8bezASKcZjD8g4qPFJjXXQVoHJlmSHf7juqHUPt4SW3VPeX
 xJLknPW0OmwRMlBMPBTR7Le312kGs1W9YR5IY/AyMlDNCJ5qpUFvzErToQGOzOSXxSdI7M
 GD3IYgmNZmsbQ79GjtH6U/gzXrtFvDA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-WrSc4scSOfi-3Eh5CxDi5w-1; Tue, 31 Dec 2019 13:35:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5DC410054E3;
 Tue, 31 Dec 2019 18:34:28 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-116-30.ams2.redhat.com [10.36.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 665F667673;
 Tue, 31 Dec 2019 18:34:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 12/14] hw/nvram/Kconfig: Add an entry for the NMC93xx EEPROM
Date: Tue, 31 Dec 2019 19:32:14 +0100
Message-Id: <20191231183216.6781-13-philmd@redhat.com>
In-Reply-To: <20191231183216.6781-1-philmd@redhat.com>
References: <20191231183216.6781-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: WrSc4scSOfi-3Eh5CxDi5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The NMC93xx EEPROM is only used by few NIC cards and the
Am53C974 SCSI controller.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Stefan Weil <sw@weilnetz.de>
---
 hw/net/Kconfig         | 2 ++
 hw/nvram/Kconfig       | 4 ++++
 hw/nvram/Makefile.objs | 2 +-
 hw/scsi/Kconfig        | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 3856417d42..af6a11baf3 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -14,6 +14,7 @@ config EEPRO100_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select NMC93XX_EEPROM
=20
 config PCNET_PCI
     bool
@@ -28,6 +29,7 @@ config TULIP
     bool
     default y if PCI_DEVICES
     depends on PCI
+    select NMC93XX_EEPROM
=20
 config E1000_PCI
     bool
diff --git a/hw/nvram/Kconfig b/hw/nvram/Kconfig
index ebaa749ce9..e082a5610c 100644
--- a/hw/nvram/Kconfig
+++ b/hw/nvram/Kconfig
@@ -7,3 +7,7 @@ config AT24C
=20
 config MAC_NVRAM
     bool
+
+# NMC93XX uses the NS =CE=BCWire interface (similar to SPI but less config=
urable)
+config NMC93XX_EEPROM
+    bool
diff --git a/hw/nvram/Makefile.objs b/hw/nvram/Makefile.objs
index 26f7b4ca35..a4bdfbf187 100644
--- a/hw/nvram/Makefile.objs
+++ b/hw/nvram/Makefile.objs
@@ -1,5 +1,5 @@
 common-obj-$(CONFIG_DS1225Y) +=3D ds1225y.o
-common-obj-y +=3D eeprom93xx.o
+common-obj-$(CONFIG_NMC93XX_EEPROM) +=3D eeprom93xx.o
 common-obj-$(CONFIG_AT24C) +=3D eeprom_at24c.o
 common-obj-y +=3D fw_cfg.o
 common-obj-y +=3D chrp_nvram.o
diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index b3ba540c17..77d397c949 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -34,6 +34,7 @@ config ESP_PCI
     default y if PCI_DEVICES
     depends on PCI
     select ESP
+    select NMC93XX_EEPROM
=20
 config SPAPR_VSCSI
     bool
--=20
2.21.0


