Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE017C43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C11022075D
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C11022075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40615 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKdcv-0001AN-0j
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 02:49:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbM-0008RV-IT
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbL-0005fp-9Y
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbK-0005e6-Sz
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:47:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 034D730BCE67;
	Sun, 28 Apr 2019 06:47:50 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3CAC0171EE;
	Sun, 28 Apr 2019 06:47:43 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 08:47:26 +0200
Message-Id: <20190428064731.29913-2-philmd@redhat.com>
In-Reply-To: <20190428064731.29913-1-philmd@redhat.com>
References: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Sun, 28 Apr 2019 06:47:50 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 1/6] hw/acpi: Move the IPMI stub to the
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
Message-ID: <20190428064726.LM0LWIEV00EpwsvhSnBn2OBgnIPcJz3IEpaJp9-Ci1o@z>

Move the IPMI stub file to the stubs/ directory to simplify the
hw/acpi Makefile.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                         | 1 +
 hw/acpi/Makefile.objs               | 3 +--
 stubs/Makefile.objs                 | 1 +
 hw/acpi/ipmi-stub.c =3D> stubs/ipmi.c | 0
 4 files changed, 3 insertions(+), 2 deletions(-)
 rename hw/acpi/ipmi-stub.c =3D> stubs/ipmi.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 23db6f8408a..e1681eca5cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1309,6 +1309,7 @@ S: Maintained
 F: include/hw/ipmi/*
 F: hw/ipmi/*
 F: hw/smbios/smbios_type_38.c
+F: stubs/ipmi.c
 F: tests/ipmi*
 T: git https://github.com/cminyard/qemu.git master-ipmi-rebase
=20
diff --git a/hw/acpi/Makefile.objs b/hw/acpi/Makefile.objs
index 2d46e3789ae..4e302feb885 100644
--- a/hw/acpi/Makefile.objs
+++ b/hw/acpi/Makefile.objs
@@ -14,8 +14,7 @@ common-obj-y +=3D aml-build.o
 common-obj-$(CONFIG_TPM) +=3D tpm.o
=20
 common-obj-$(CONFIG_IPMI) +=3D ipmi.o
-common-obj-$(call lnot,$(CONFIG_IPMI)) +=3D ipmi-stub.o
 else
 common-obj-y +=3D acpi-stub.o
 endif
-common-obj-$(CONFIG_ALL) +=3D acpi-stub.o ipmi-stub.o
+common-obj-$(CONFIG_ALL) +=3D acpi-stub.o
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 269dfa58326..36bb9ff0b1d 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -9,6 +9,7 @@ stub-obj-y +=3D error-printf.o
 stub-obj-y +=3D fdset.o
 stub-obj-y +=3D gdbstub.o
 stub-obj-y +=3D get-vm-name.o
+stub-obj-y +=3D ipmi.o
 stub-obj-y +=3D iothread.o
 stub-obj-y +=3D iothread-lock.o
 stub-obj-y +=3D is-daemonized.o
diff --git a/hw/acpi/ipmi-stub.c b/stubs/ipmi.c
similarity index 100%
rename from hw/acpi/ipmi-stub.c
rename to stubs/ipmi.c
--=20
2.20.1


