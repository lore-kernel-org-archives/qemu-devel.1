Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DA3C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D03E23955
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:05:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D03E23955
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzytj-0001jp-9C
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hzys8-0007yF-Dn
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hzys7-0004Ru-9X
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:48:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37006)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hzys7-0004RU-4I
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:48:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 64325106E96E;
 Tue, 20 Aug 2019 07:48:02 +0000 (UTC)
Received: from thuth.com (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 502F21001B09;
 Tue, 20 Aug 2019 07:48:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 09:47:45 +0200
Message-Id: <20190820074749.25208-5-thuth@redhat.com>
In-Reply-To: <20190820074749.25208-1-thuth@redhat.com>
References: <20190820074749.25208-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 20 Aug 2019 07:48:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 4/8] hw/core: Add a config switch for the
 "register" device
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The "register" device is only used by certain machines. Let's add
a proper config switch for it so that it only gets compiled when we
really need it.

Message-Id: <20190817101931.28386-5-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/Kconfig            | 1 +
 hw/core/Kconfig       | 3 +++
 hw/core/Makefile.objs | 2 +-
 hw/dma/Kconfig        | 1 +
 4 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/Kconfig b/hw/Kconfig
index dbae1c0852..b45db3c813 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -76,3 +76,4 @@ config XILINX_AXI
=20
 config XLNX_ZYNQMP
     bool
+    select REGISTER
diff --git a/hw/core/Kconfig b/hw/core/Kconfig
index c2a1ae8122..d11920fcb3 100644
--- a/hw/core/Kconfig
+++ b/hw/core/Kconfig
@@ -9,3 +9,6 @@ config FITLOADER
=20
 config PLATFORM_BUS
     bool
+
+config REGISTER
+    bool
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index f8481d959f..d6cfb2a81b 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -17,7 +17,7 @@ common-obj-$(CONFIG_SOFTMMU) +=3D machine.o
 common-obj-$(CONFIG_SOFTMMU) +=3D loader.o
 common-obj-$(CONFIG_FITLOADER) +=3D loader-fit.o
 common-obj-$(CONFIG_SOFTMMU) +=3D qdev-properties-system.o
-common-obj-$(CONFIG_SOFTMMU) +=3D register.o
+common-obj-$(CONFIG_REGISTER) +=3D register.o
 common-obj-$(CONFIG_SOFTMMU) +=3D or-irq.o
 common-obj-$(CONFIG_SOFTMMU) +=3D split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
diff --git a/hw/dma/Kconfig b/hw/dma/Kconfig
index 751dec5426..5c61b67bc0 100644
--- a/hw/dma/Kconfig
+++ b/hw/dma/Kconfig
@@ -16,6 +16,7 @@ config I8257
=20
 config ZYNQ_DEVCFG
     bool
+    select REGISTER
=20
 config STP2000
     bool
--=20
2.18.1


