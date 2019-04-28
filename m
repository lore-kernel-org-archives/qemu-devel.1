Return-Path: <SRS0=GiFh=S6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02FEC43218
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:53:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF49206E0
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2019 06:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF49206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40676 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKdge-0004VU-Hi
	for qemu-devel@archiver.kernel.org; Sun, 28 Apr 2019 02:53:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbf-0000K2-94
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hKdbe-0006Aj-Bl
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hKdbe-0006AH-6W
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 02:48:10 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 731B73082E8F;
	Sun, 28 Apr 2019 06:48:09 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-62.brq.redhat.com [10.40.204.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 10E1A171EE;
	Sun, 28 Apr 2019 06:48:06 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Sun, 28 Apr 2019 08:47:30 +0200
Message-Id: <20190428064731.29913-6-philmd@redhat.com>
In-Reply-To: <20190428064731.29913-1-philmd@redhat.com>
References: <20190428064731.29913-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Sun, 28 Apr 2019 06:48:09 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 5/6] stubs: Add missing ACPI symbols
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
Message-ID: <20190428064730.VL_jEo43ht-sUCLChTZ8WqNMH9aZ_WlYUBBPaFNSNpo@z>

When building with ACPI disabled, we get:

  /usr/bin/ld: hw/i386/pc.o: in function `bochs_bios_init':
  /source/qemu/hw/i386/pc.c:1017: undefined reference to `acpi_tables_len=
'
  /usr/bin/ld: /source/qemu/hw/i386/pc.c:1017: undefined reference to `ac=
pi_tables'
  collect2: error: ld returned 1 exit status
  make[1]: *** [Makefile:204: qemu-system-x86_64] Error 1

These symbols are indeed declared as extern in "hw/acpi/acpi.h".
Add them as stub to satisfy the linker.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 stubs/acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/stubs/acpi.c b/stubs/acpi.c
index 4c9d081ed48..cd0119f9fb1 100644
--- a/stubs/acpi.c
+++ b/stubs/acpi.c
@@ -23,6 +23,10 @@
 #include "qapi/qmp/qerror.h"
 #include "hw/acpi/acpi.h"
=20
+size_t acpi_tables_len;
+
+char unsigned *acpi_tables;
+
 void acpi_table_add(const QemuOpts *opts, Error **errp)
 {
     error_setg(errp, QERR_UNSUPPORTED);
--=20
2.20.1


