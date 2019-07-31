Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C025C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 07:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A7E206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 07:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A7E206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsjWf-00087m-9m
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 03:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58814)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hsjUG-0002kk-ID
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 03:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hsjUF-0008LK-3I
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 03:57:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33502)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hsjUC-0008H1-Qu; Wed, 31 Jul 2019 03:57:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2481612BB;
 Wed, 31 Jul 2019 07:57:24 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7ADBA5C1B5;
 Wed, 31 Jul 2019 07:57:21 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 09:56:52 +0200
Message-Id: <20190731075652.17053-9-thuth@redhat.com>
In-Reply-To: <20190731075652.17053-1-thuth@redhat.com>
References: <20190731075652.17053-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 31 Jul 2019 07:57:24 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 8/8] hw/core: Add a config switch for the
 generic loader device
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The generic loader device is completely optional. Let's add a proper
config switch for it so that people can disable it if they don't need
it and want to create a minimalistic QEMU binary.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/core/Kconfig       | 4 ++++
 hw/core/Makefile.objs | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/core/Kconfig b/hw/core/Kconfig
index fffb3d62b2..fdf03514d7 100644
--- a/hw/core/Kconfig
+++ b/hw/core/Kconfig
@@ -7,6 +7,10 @@ config PTIMER
 config FITLOADER
     bool
=20
+config GENERIC_LOADER
+    bool
+    default y
+
 config OR_IRQ
     bool
=20
diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
index bb1afe422a..b49f880a0c 100644
--- a/hw/core/Makefile.objs
+++ b/hw/core/Makefile.objs
@@ -21,7 +21,7 @@ common-obj-$(CONFIG_REGISTER) +=3D register.o
 common-obj-$(CONFIG_OR_IRQ) +=3D or-irq.o
 common-obj-$(CONFIG_SPLIT_IRQ) +=3D split-irq.o
 common-obj-$(CONFIG_PLATFORM_BUS) +=3D platform-bus.o
-common-obj-$(CONFIG_SOFTMMU) +=3D generic-loader.o
+common-obj-$(CONFIG_GENERIC_LOADER) +=3D generic-loader.o
 common-obj-$(CONFIG_SOFTMMU) +=3D null-machine.o
=20
 obj-$(CONFIG_SOFTMMU) +=3D machine-qmp-cmds.o
--=20
2.21.0


