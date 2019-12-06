Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAB00C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9FB2053B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFPrXs6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9FB2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHpQ-0008TL-6A
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:55:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33445)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idHMg-0008I4-Up
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idHMf-0007Fn-2b
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:26:02 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56376
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idHMc-0007BR-Fx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575653157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SEbTH43GGJvjGQgNO86PJFzX5Xp5SPv3KxJ0OAEuU0A=;
 b=CFPrXs6zJMm9HobqxrvaGxIy4g71cY/ARoN4q6fkEe4YOamPVpvMfmLoCi9BjtFPeOakz3
 1qz81/2eAuUy6jmyqemNTIYXiJ4VHUO2vxfvd+y9WlKoVHjzXaKofcLKlgmFs3NtcXrL+X
 tHF89rxTnnvTgDGmCXDUuBukm0LmNjo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-UupczAd4NzCgQKHLE0Q-Hg-1; Fri, 06 Dec 2019 12:25:55 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB7451883523;
 Fri,  6 Dec 2019 17:25:54 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-212.brq.redhat.com [10.40.204.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 796515C1C3;
 Fri,  6 Dec 2019 17:25:52 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.0 v2 6/6] hw/pci-host: Add Kconfig entry to select the
 IGD Passthrough Host Bridge
Date: Fri,  6 Dec 2019 18:25:14 +0100
Message-Id: <20191206172514.21268-7-philmd@redhat.com>
In-Reply-To: <20191206172514.21268-1-philmd@redhat.com>
References: <20191206172514.21268-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: UupczAd4NzCgQKHLE0Q-Hg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add the INTEL_IGD_PASSTHROUGH Kconfig option.

Since it is implied by the PCI_I440FX option, this does not change
the default selection. However users are now able to deselelect it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/pci-host/Kconfig       | 4 ++++
 hw/pci-host/Makefile.objs | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index b0aa8351c4..8c88a7b9dd 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -1,6 +1,9 @@
 config PAM
     bool
=20
+config INTEL_IGD_PASSTHROUGH
+    bool
+
 config PREP_PCI
     bool
     select PCI
@@ -32,6 +35,7 @@ config PCI_I440FX
     bool
     select PCI
     select PAM
+    imply INTEL_IGD_PASSTHROUGH
=20
 config PCI_EXPRESS_Q35
     bool
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index 5affd21899..9dbd0f9042 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -14,7 +14,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
 common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
 common-obj-$(CONFIG_FULONG) +=3D bonito.o
 common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
-common-obj-$(CONFIG_PCI_I440FX) +=3D igd_pt.o
+common-obj-$(CONFIG_INTEL_IGD_PASSTHROUGH) +=3D igd_pt.o
 common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
 common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
 common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o
--=20
2.21.0


