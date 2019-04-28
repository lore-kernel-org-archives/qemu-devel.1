Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0F2C43219
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:53:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1846F206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1846F206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40674 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKdgR-0004K4-CI
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 02:53:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbj-0000OR-Q9
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbi-0006Nf-TI
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbi-0006KE-NK
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EE77C81F35;
	Sun, 28 Apr 2019 06:48:13 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 430EC171EE;
	Sun, 28 Apr 2019 06:48:09 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 08:47:31 +0200
Message-Id: <20190428064731.29913-7-philmd@redhat.com>
In-Reply-To: <20190428064731.29913-1-philmd@redhat.com>
References: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Sun, 28 Apr 2019 06:48:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 6/6] vl: Do not set acpi_enabled when ACPI
 is disabled at build time
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
Message-ID: <20190428064731.EXAwxOQnbu9Mbd8iqXnE9gB7LH-f7Y0YpEKJTkju7eo@z>

When building with CONFIG_ACPI disabled, the 'acpi_enabled' is
still initialized to '1' (enabled).

Remove the confusion by moving the variable to hw/core/acpi.c,
and adding a similar stub.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/acpi/core.c | 1 +
 stubs/acpi.c   | 2 ++
 vl.c           | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index 9ed1629f367..b2730aec8a0 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -59,6 +59,7 @@ static const char unsigned dfl_hdr[ACPI_TABLE_HDR_SIZE =
- ACPI_TABLE_PFX_SIZE] =3D
     "QEMU\1\0\0\0"           /* ASL compiler ID (4), version (4) */
     ;
=20
+int acpi_enabled =3D 1;
 char unsigned *acpi_tables;
 size_t acpi_tables_len;
=20
diff --git a/stubs/acpi.c b/stubs/acpi.c
index cd0119f9fb1..f1ef6b8e795 100644
--- a/stubs/acpi.c
+++ b/stubs/acpi.c
@@ -23,6 +23,8 @@
 #include "qapi/qmp/qerror.h"
 #include "hw/acpi/acpi.h"
=20
+int acpi_enabled;
+
 size_t acpi_tables_len;
=20
 char unsigned *acpi_tables;
diff --git a/vl.c b/vl.c
index ff5dfb6fbc3..c9364b4ec10 100644
--- a/vl.c
+++ b/vl.c
@@ -166,7 +166,6 @@ int smp_cpus;
 unsigned int max_cpus;
 int smp_cores =3D 1;
 int smp_threads =3D 1;
-int acpi_enabled =3D 1;
 int no_hpet =3D 0;
 int fd_bootchk =3D 1;
 static int no_reboot;
--=20
2.20.1


