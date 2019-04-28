Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66768C43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3982B2075D
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3982B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKdd0-0001FP-Cm
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 02:49:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbS-0008WS-Fn
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbQ-0005sm-Vb
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbP-0005jH-2p
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4D5638666B;
	Sun, 28 Apr 2019 06:47:54 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C8B96171EE;
	Sun, 28 Apr 2019 06:47:50 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 08:47:27 +0200
Message-Id: <20190428064731.29913-3-philmd@redhat.com>
In-Reply-To: <20190428064731.29913-1-philmd@redhat.com>
References: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Sun, 28 Apr 2019 06:47:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/6] hw/acpi: Move the ACPI stub to the
 stubs/ directory
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
Message-ID: <20190428064727.9DDxiQvb_9c_WBmrBmNTBIw4BNUzzXbT2UL8hKtQR5k@z>

Move the ACPI stub file to the stubs/ directory to greatly simplify
the hw/acpi Makefile.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                         | 1 +
 hw/acpi/Makefile.objs               | 5 -----
 stubs/Makefile.objs                 | 1 +
 hw/acpi/acpi-stub.c =3D> stubs/acpi.c | 0
 4 files changed, 2 insertions(+), 5 deletions(-)
 rename hw/acpi/acpi-stub.c =3D> stubs/acpi.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index e1681eca5cb..d05a3d36511 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1357,6 +1357,7 @@ F: hw/acpi/*
 F: hw/smbios/*
 F: hw/i386/acpi-build.[hc]
 F: hw/arm/virt-acpi-build.c
+F: stubs/acpi.c
 F: tests/bios-tables-test.c
 F: tests/acpi-utils.[hc]
 F: tests/data/acpi/
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 4e302feb885..73eca4f7dff 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -6,15 +6,10 @@ common-obj-$(CONFIG_ACPI_MEMORY_HOTPLUG) +=3D memory_ho=
tplug.o
 common-obj-$(CONFIG_ACPI_CPU_HOTPLUG) +=3D cpu.o
 common-obj-$(CONFIG_ACPI_NVDIMM) +=3D nvdimm.o
 common-obj-$(CONFIG_ACPI_VMGENID) +=3D vmgenid.o
-common-obj-$(call lnot,$(CONFIG_ACPI_X86)) +=3D acpi-stub.o
=20
 common-obj-y +=3D acpi_interface.o
 common-obj-y +=3D bios-linker-loader.o
 common-obj-y +=3D aml-build.o
 common-obj-$(CONFIG_TPM) +=3D tpm.o
-
 common-obj-$(CONFIG_IPMI) +=3D ipmi.o
-else
-common-obj-y +=3D acpi-stub.o
 endif
-common-obj-$(CONFIG_ALL) +=3D acpi-stub.o
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 36bb9ff0b1d..47ee66a71f2 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -1,3 +1,4 @@
+stub-obj-y +=3D acpi.o
 stub-obj-y +=3D bdrv-next-monitor-owned.o
 stub-obj-y +=3D blk-commit-all.o
 stub-obj-y +=3D blockdev-close-all-bdrv-states.o
diff --git a/hw/acpi/acpi-stub.c b/stubs/acpi.c
similarity index 100%
rename from hw/acpi/acpi-stub.c
rename to stubs/acpi.c
--=20
2.20.1


