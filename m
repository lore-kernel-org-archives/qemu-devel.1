Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BCEC606A1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:25:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A726620651
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 09:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A726620651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkPtt-0005un-AK
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 05:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45727)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <imammedo@redhat.com>) id 1hkPsk-0004sT-Ru
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:24:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1hkPsk-0000rq-0U
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:24:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45690)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hkPsj-0000rT-Ry
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 05:24:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 920A781E0D
 for <qemu-devel@nongnu.org>; Mon,  8 Jul 2019 09:24:18 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E468D4FF26;
 Mon,  8 Jul 2019 09:24:16 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon,  8 Jul 2019 05:24:09 -0400
Message-Id: <20190708092410.11167-2-imammedo@redhat.com>
In-Reply-To: <20190708092410.11167-1-imammedo@redhat.com>
References: <20190708092410.11167-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 08 Jul 2019 09:24:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v3 1/2] tests: acpi: do not require IASL for
 dumping AML blobs
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

IASL isn't needed when dumping ACPI tables from guest for
rebuild purposes. So move this part out from IASL branch.

Makes rebuild-expected-aml.sh work without IASL installed
on host.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 tests/bios-tables-test.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index d863233fe9..13bd166b81 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -597,12 +597,10 @@ static void test_acpi_one(const char *params, test_=
data *data)
     test_acpi_rxsdt_table(data);
     test_acpi_fadt_table(data);
=20
-    if (iasl) {
-        if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
-            dump_aml_files(data, true);
-        } else {
-            test_acpi_asl(data);
-        }
+    if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
+        dump_aml_files(data, true);
+    } else if (iasl) {
+        test_acpi_asl(data);
     }
=20
     /*
--=20
2.18.1


