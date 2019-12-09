Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2679C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:53:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D48A2072D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 09:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZcTbs3P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D48A2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieFj7-0003Q1-EG
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 04:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49311)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ieFhH-0000o9-57
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ieFhC-0000uX-9B
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:51:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49542
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ieFhC-0000uN-5q
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 04:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575885073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JyTRNBIq6COiBd2fUeZp5zZWcFeEuRMkF4nfuRBiSRw=;
 b=JZcTbs3PF0xO/xC1dXClOoh7i1EPQ1awNiUBIRkpb6S6T0CVxGRqGLL1/ZjURrvfkf16Wy
 hL2z5O6wVYBiALm91gDSG55Ftc1dGjrJGkCqmPw2ADjtpN2/zn2FSxG+aT3kmh6E9eOfN4
 +0mvtKIKw610iK9I6gykigMLTShAhA0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-LSW49e5NNvasJ4mh1-Fhgw-1; Mon, 09 Dec 2019 04:51:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47580800C74;
 Mon,  9 Dec 2019 09:51:02 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-205-142.brq.redhat.com [10.40.205.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 72AB919C5B;
 Mon,  9 Dec 2019 09:50:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v3 6/6] hw/pci-host: Add Kconfig entry to select the
 IGD Passthrough Host Bridge
Date: Mon,  9 Dec 2019 10:50:02 +0100
Message-Id: <20191209095002.32194-7-philmd@redhat.com>
In-Reply-To: <20191209095002.32194-1-philmd@redhat.com>
References: <20191209095002.32194-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: LSW49e5NNvasJ4mh1-Fhgw-1
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
Cc: Thomas Huth <thuth@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the XEN_IGD_PASSTHROUGH Kconfig option.

Xen build has that option selected by default. Non-Xen builds now
have to select this feature manually.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
v3: Only default with Xen (Alex Williamson)

I did not used 'depends on XEN' as suggested by Alex but
'default y if XEN', so one can build XEN without this feature
(for example, on other ARCH than X86).
---
 hw/pci-host/Kconfig       | 5 +++++
 hw/pci-host/Makefile.objs | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index b0aa8351c4..24ba8ea046 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -1,6 +1,11 @@
 config PAM
     bool
=20
+config XEN_IGD_PASSTHROUGH
+    bool
+    default y if XEN
+    select PCI_I440FX
+
 config PREP_PCI
     bool
     select PCI
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index fa6d1556c0..9c466fab01 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -14,7 +14,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
 common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
 common-obj-$(CONFIG_FULONG) +=3D bonito.o
 common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
-common-obj-$(CONFIG_PCI_I440FX) +=3D xen_igd_pt.o
+common-obj-$(CONFIG_XEN_IGD_PASSTHROUGH) +=3D xen_igd_pt.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
 common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o
--=20
2.21.0


