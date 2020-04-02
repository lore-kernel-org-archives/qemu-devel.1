Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76046C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:03:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2DD206F6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 18:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbu75Kuk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2DD206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK4BE-0001ar-2o
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 14:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jK4AM-00013J-Cz
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:02:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jK4AK-0005LF-Lm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:02:09 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50163
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jK4AK-0005J3-CR
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 14:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585850527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tjp557QoSwX1zXO0Qt6n7kWqUIk7/59D04dmkiPODOE=;
 b=bbu75KukY0+WDO5Sb4UqSPMNfTWykKZ2uzm1YgLefeNoL9tOQDfsBRc421tuSwb/e3oYX7
 Cxcp/RjG2M1n8jx+nJlIoG9+67vVuBYoZieqqnCQvnzpFQ6ctSkUqbG2pNFbp3+q6x7Ih7
 vNtcklCOp180V2e4H9NqLSaWKThgdn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-PBDxcm1jN-qIMcFRkyICVA-1; Thu, 02 Apr 2020 14:02:05 -0400
X-MC-Unique: PBDxcm1jN-qIMcFRkyICVA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D257B13F6;
 Thu,  2 Apr 2020 18:01:57 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E3CBD118F22;
 Thu,  2 Apr 2020 18:01:50 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, maz@kernel.org,
 kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Subject: [PATCH kvm-unit-tests] fixup! arm/arm64: ITS: pending table migration
 test
Date: Thu,  2 Apr 2020 20:01:48 +0200
Message-Id: <20200402180148.490026-1-drjones@redhat.com>
In-Reply-To: <20200402145227.20109-1-eric.auger@redhat.com>
References: <20200402145227.20109-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: yuzenghui@huawei.com, peter.maydell@linaro.org, thuth@redhat.com,
 alexandru.elisei@arm.com, andre.przywara@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

[ Without the fix this test would hang, as timeouts don't work with
  the migration scripts (yet). Use errata to skip instead of hang. ]
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 arm/gic.c  | 18 ++++++++++++++++--
 errata.txt |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arm/gic.c b/arm/gic.c
index ddf0f9d09b14..c0781f8c2c80 100644
--- a/arm/gic.c
+++ b/arm/gic.c
@@ -12,6 +12,7 @@
  * This work is licensed under the terms of the GNU LGPL, version 2.
  */
 #include <libcflat.h>
+#include <errata.h>
 #include <asm/setup.h>
 #include <asm/processor.h>
 #include <asm/delay.h>
@@ -812,13 +813,23 @@ static void test_its_migration(void)
 	check_lpi_stats("dev7/eventid=3D255 triggers LPI 8196 on PE #2 after mi=
gration");
 }
=20
+#define ERRATA_UNMAPPED_COLLECTIONS "ERRATA_8c58be34494b"
+
 static void test_migrate_unmapped_collection(void)
 {
-	struct its_collection *col;
-	struct its_device *dev2, *dev7;
+	struct its_collection *col =3D NULL;
+	struct its_device *dev2 =3D NULL, *dev7 =3D NULL;
+	bool test_skipped =3D false;
 	int pe0 =3D 0;
 	u8 config;
=20
+	if (!errata(ERRATA_UNMAPPED_COLLECTIONS)) {
+		report_skip("Skipping test, as this test hangs without the fix. "
+			    "Set %s=3Dy to enable.", ERRATA_UNMAPPED_COLLECTIONS);
+		test_skipped =3D true;
+		goto do_migrate;
+	}
+
 	if (its_setup1())
 		return;
=20
@@ -830,9 +841,12 @@ static void test_migrate_unmapped_collection(void)
 	its_send_mapti(dev2, 8192, 0, col);
 	gicv3_lpi_set_config(8192, LPI_PROP_DEFAULT);
=20
+do_migrate:
 	puts("Now migrate the VM, then press a key to continue...\n");
 	(void)getchar();
 	report_info("Migration complete");
+	if (test_skipped)
+		return;
=20
 	/* on the destination, map the collection */
 	its_send_mapc(col, true);
diff --git a/errata.txt b/errata.txt
index 7d6abc2a7bf6..b66afaa9c079 100644
--- a/errata.txt
+++ b/errata.txt
@@ -5,4 +5,5 @@
 9e3f7a296940    : 4.9                           : arm64: KVM: pmu: Fix A=
Arch32 cycle counter access
 7b6b46311a85    : 4.11                          : KVM: arm/arm64: Emulat=
e the EL1 phys timer registers
 6c7a5dce22b3    : 4.12                          : KVM: arm/arm64: fix ra=
ces in kvm_psci_vcpu_on
+8c58be34494b    : 5.6                           : KVM: arm/arm64: vgic-i=
ts: Fix restoration of unmapped collections
 #---------------:-------------------------------:-----------------------=
----------------------------
--=20
2.25.1


