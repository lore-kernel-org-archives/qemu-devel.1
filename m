Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF5DC43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:51:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C4A72075D
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4A72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40662 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKdei-0003BI-Ic
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 02:51:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdba-0000DE-Dd
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbX-00062e-W9
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbX-000626-8e
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7D4373086203;
	Sun, 28 Apr 2019 06:48:02 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DB90B58821;
	Sun, 28 Apr 2019 06:47:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 08:47:28 +0200
Message-Id: <20190428064731.29913-4-philmd@redhat.com>
In-Reply-To: <20190428064731.29913-1-philmd@redhat.com>
References: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Sun, 28 Apr 2019 06:48:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 3/6] hw/acpi: Simplify the Makefile logic
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190428064728.mUovHuoY1U8liethY-NdhsDaU9qzcNjRVJdLh8yTKJY@z>

Simplify the Makefile logic to ease further modifications/reviews.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/Makefile.objs | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 73eca4f7dff..b5515c626a6 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -1,4 +1,3 @@
-ifeq ($(CONFIG_ACPI),y)
 common-obj-$(CONFIG_ACPI_X86) +=3D core.o piix4.o pcihp.o
 common-obj-$(CONFIG_ACPI_X86_ICH) +=3D ich9.o tco.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu_hotplug.o
@@ -6,10 +5,8 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_hot=
plug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
-
-common-obj-y +=3D acpi_interface.o
-common-obj-y +=3D bios-linker-loader.o
-common-obj-y +=3D aml-build.o
-common-obj-$(CONFIG_TPM) +=3D tpm.o
-common-obj-$(CONFIG_IPMI) +=3D ipmi.o
-endif
+common-obj-$(CONFIG_ACPI) +=3D acpi_interface.o
+common-obj-$(CONFIG_ACPI) +=3D bios-linker-loader.o
+common-obj-$(CONFIG_ACPI) +=3D aml-build.o
+common-obj-$(call land,$(CONFIG_ACPI),$(CONFIG_TPM)) +=3D tpm.o
+common-obj-$(call land,$(CONFIG_ACPI),$(CONFIG_IPMI)) +=3D ipmi.o
--=20
2.20.1


