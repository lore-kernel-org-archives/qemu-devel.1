Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA5FCA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FDF20663
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 18:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZpSimjb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FDF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOQWs-0005sC-NW
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 14:11:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iOQRH-0003mY-9F
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iOQRF-0008TV-U5
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:05:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39673
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iOQRF-0008TK-QO
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 14:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572113121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j8Ov6K9gjAmVTeZvfxxVP3jRwrZORnzk/ILSZphq89g=;
 b=OZpSimjbQyeAAKcZdpu+g84Xi8tWwcuq7gkeFjRVi5rDfDLlLYKvej0UnrbLdz3z/hFvem
 M21AA7tB+1RM0ajBjcEIJOPHGRFp8OwzZCv0eyJv8ZmDYBgauCh9v8j5uOCzhBaMvmpqe2
 NmjKLG4xJaaW+1WZcEC4RUXWTKzOZ1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-3CIxaGxPOjetHYqQ8eIT6A-1; Sat, 26 Oct 2019 14:05:19 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DE5E1800E00;
 Sat, 26 Oct 2019 18:05:17 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-39.brq.redhat.com [10.40.204.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C12AD60F8A;
 Sat, 26 Oct 2019 18:05:03 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 19/20] hw/pci-host: Rename incorrectly named 'piix' as
 'i440fx'
Date: Sat, 26 Oct 2019 20:01:42 +0200
Message-Id: <20191026180143.7369-20-philmd@redhat.com>
In-Reply-To: <20191026180143.7369-1-philmd@redhat.com>
References: <20191026180143.7369-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3CIxaGxPOjetHYqQ8eIT6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 xen-devel@lists.xenproject.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

We moved all the PIIX3 southbridge code out of hw/pci-host/piix.c,
it now only contains i440FX northbridge code.
Rename it to match the chipset modelled.

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                      | 2 +-
 hw/i386/Kconfig                  | 2 +-
 hw/pci-host/Kconfig              | 2 +-
 hw/pci-host/Makefile.objs        | 2 +-
 hw/pci-host/{piix.c =3D> i440fx.c} | 0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename hw/pci-host/{piix.c =3D> i440fx.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e7e7bfc890..87e7fb1a65 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1225,7 +1225,7 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: include/hw/i386/
 F: hw/i386/
-F: hw/pci-host/piix.c
+F: hw/pci-host/i440fx.c
 F: hw/pci-host/q35.c
 F: hw/pci-host/pam.c
 F: include/hw/pci-host/i440fx.h
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d420b35548..5a494342ea 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -60,7 +60,7 @@ config I440FX
     select PC_PCI
     select PC_ACPI
     select ACPI_SMBUS
-    select PCI_PIIX
+    select PCI_I440FX
     select PIIX3
     select IDE_PIIX
     select DIMM
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 397043b289..b0aa8351c4 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -28,7 +28,7 @@ config PCI_SABRE
     select PCI
     bool
=20
-config PCI_PIIX
+config PCI_I440FX
     bool
     select PCI
     select PAM
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index a9cd3e022d..efd752b766 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -13,7 +13,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
=20
 common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
 common-obj-$(CONFIG_FULONG) +=3D bonito.o
-common-obj-$(CONFIG_PCI_PIIX) +=3D piix.o
+common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
 common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o
diff --git a/hw/pci-host/piix.c b/hw/pci-host/i440fx.c
similarity index 100%
rename from hw/pci-host/piix.c
rename to hw/pci-host/i440fx.c
--=20
2.21.0


