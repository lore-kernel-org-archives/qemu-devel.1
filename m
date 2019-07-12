Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D519AC742BE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:41:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A953420863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:41:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A953420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvnt-0002gu-TJ
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57953)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlvnY-0001Nj-Km
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:41:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlvnX-0007c5-NQ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:41:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42614)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hlvnV-0007aM-FK; Fri, 12 Jul 2019 09:41:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B813B87630;
 Fri, 12 Jul 2019 13:41:12 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-150.brq.redhat.com [10.40.204.150])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 37BC826FC1;
 Fri, 12 Jul 2019 13:41:08 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 15:39:28 +0200
Message-Id: <20190712133928.21394-8-philmd@redhat.com>
In-Reply-To: <20190712133928.21394-1-philmd@redhat.com>
References: <20190712133928.21394-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 12 Jul 2019 13:41:12 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH-for-4.1? 7/7] hw/bt: Allow building with
 CONFIG_BLUETOOTH disabled
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Miroslav Rezanina <mrezanin@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 Makefile.objs       |  3 ++-
 bt-stubs.c          | 18 ++++++++++++++++++
 hw/bt/Makefile.objs |  4 ++--
 3 files changed, 22 insertions(+), 3 deletions(-)
 create mode 100644 bt-stubs.c

diff --git a/Makefile.objs b/Makefile.objs
index c2845a0efc..98269e393a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -65,8 +65,9 @@ common-obj-y +=3D replay/
=20
 common-obj-y +=3D ui/
 common-obj-m +=3D ui/
-common-obj-y +=3D bt-host.o bt-vhci.o bt-opts.o
 bt-host.o-cflags :=3D $(BLUEZ_CFLAGS)
+common-obj-$(CONFIG_BLUETOOTH) +=3D bt-host.o bt-vhci.o bt-opts.o
+common-obj-$(call lnot,$(CONFIG_BLUETOOTH)) +=3D bt-stubs.o
=20
 common-obj-y +=3D dma-helpers.o
 common-obj-y +=3D vl.o
diff --git a/bt-stubs.c b/bt-stubs.c
new file mode 100644
index 0000000000..d3f5158d3b
--- /dev/null
+++ b/bt-stubs.c
@@ -0,0 +1,18 @@
+/*
+ * Bluetooth stubs.
+ *
+ * Copyright (c) 2019 Red Hat, Inc.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "sysemu/bt.h"
+
+int bt_parse(const char *opt)
+{
+    error_report("Bluetooth support is disabled");
+
+    return 1;
+}
diff --git a/hw/bt/Makefile.objs b/hw/bt/Makefile.objs
index 867a7d2e8a..46aec8e38e 100644
--- a/hw/bt/Makefile.objs
+++ b/hw/bt/Makefile.objs
@@ -1,3 +1,3 @@
-common-obj-y +=3D core.o l2cap.o sdp.o hci.o hid.o
-common-obj-y +=3D hci-csr.o
+common-obj-$(CONFIG_BLUETOOTH) +=3D core.o l2cap.o sdp.o hci.o hid.o
+common-obj-$(CONFIG_BLUETOOTH) +=3D hci-csr.o
=20
--=20
2.20.1


