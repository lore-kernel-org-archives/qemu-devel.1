Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8C78C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:21:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924BA217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 11:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924BA217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDRpp-0006BI-P9
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 07:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iDRoo-00057B-1V
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@redhat.com>) id 1iDRon-0004Zz-4i
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:20:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
 id 1iDRom-0004ZK-Vb
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 07:20:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3DE95307D91F
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:20:16 +0000 (UTC)
Received: from localhost (ovpn-112-55.ams2.redhat.com [10.36.112.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB8666012C;
 Thu, 26 Sep 2019 11:20:09 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] tests: fix usb-hcd-ehci-test compilation
Date: Thu, 26 Sep 2019 15:19:54 +0400
Message-Id: <20190926111955.17276-2-marcandre.lureau@redhat.com>
In-Reply-To: <20190926111955.17276-1-marcandre.lureau@redhat.com>
References: <20190926111955.17276-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 26 Sep 2019 11:20:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes commit
e5758de4e836c3b2edc2befd904651fc6967d74f ("tests/libqtest: Make
qtest_qmp_device_add/del independent from global_qtest")

and commit
dd210749727530cdef7c335040edbf81c3c5d041 ("tests/libqtest: Use
libqtest-single.h in tests that require global_qtest").

Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 tests/usb-hcd-ehci-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/usb-hcd-ehci-test.c b/tests/usb-hcd-ehci-test.c
index 8bc3e44189..5251d539e9 100644
--- a/tests/usb-hcd-ehci-test.c
+++ b/tests/usb-hcd-ehci-test.c
@@ -8,7 +8,7 @@
  */
=20
 #include "qemu/osdep.h"
-#include "libqtest.h"
+#include "libqtest-single.h"
 #include "libqos/pci-pc.h"
 #include "hw/usb/uhci-regs.h"
 #include "hw/usb/ehci-regs.h"
@@ -139,7 +139,7 @@ static void pci_ehci_port_3_hotplug(void)
=20
 static void pci_ehci_port_hotplug(void)
 {
-    usb_test_hotplug("ich9-ehci-1", "3", pci_ehci_port_3_hotplug);
+    usb_test_hotplug(global_qtest, "ich9-ehci-1", "3", pci_ehci_port_3_h=
otplug);
 }
=20
=20
--=20
2.23.0


