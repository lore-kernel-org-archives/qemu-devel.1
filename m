Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F213CC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:53:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C842C2133F
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 10:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C842C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFFmh-0005Lh-Fb
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 06:53:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iFFkI-0003X3-HJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iFFkG-0007M1-Mt
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41556)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iFFkG-0007Ky-F0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 06:51:04 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 548E530842A8;
 Tue,  1 Oct 2019 10:51:03 +0000 (UTC)
Received: from thuth.com (ovpn-116-70.ams2.redhat.com [10.36.116.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7872819D70;
 Tue,  1 Oct 2019 10:51:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 1/5] tests: fix usb-hcd-ehci-test compilation
Date: Tue,  1 Oct 2019 12:50:53 +0200
Message-Id: <20191001105057.3949-2-thuth@redhat.com>
In-Reply-To: <20191001105057.3949-1-thuth@redhat.com>
References: <20191001105057.3949-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 01 Oct 2019 10:51:03 +0000 (UTC)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Fixes commit
e5758de4e836c3b2edc2befd904651fc6967d74f ("tests/libqtest: Make
qtest_qmp_device_add/del independent from global_qtest")

and commit
dd210749727530cdef7c335040edbf81c3c5d041 ("tests/libqtest: Use
libqtest-single.h in tests that require global_qtest").

Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20190926111955.17276-2-marcandre.lureau@redhat.com>
Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.18.1


