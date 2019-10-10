Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80447C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:47:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 569E8206A1
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 11:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569E8206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIWup-0001p5-SP
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 07:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iIWiH-0003X2-EP
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iIWiG-0005oP-C0
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 07:34:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iIWiG-0005nx-6n; Thu, 10 Oct 2019 07:34:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70F5E307D88C;
 Thu, 10 Oct 2019 11:34:31 +0000 (UTC)
Received: from t460s.redhat.com (ovpn-117-138.ams2.redhat.com [10.36.117.138])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F09BD5C1B5;
 Thu, 10 Oct 2019 11:34:29 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 11/31] s390x/cpumodel: Prepare for changes of QEMU model
Date: Thu, 10 Oct 2019 13:33:36 +0200
Message-Id: <20191010113356.5017-12-david@redhat.com>
In-Reply-To: <20191010113356.5017-1-david@redhat.com>
References: <20191010113356.5017-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 10 Oct 2019 11:34:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Setup the 4.1 compatibility model so we can add new features to the
LATEST model.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c  | 2 ++
 target/s390x/gen-features.c | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 18ad279a00..d3edeef0ad 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -650,7 +650,9 @@ DEFINE_CCW_MACHINE(4_2, "4.2", true);
=20
 static void ccw_machine_4_1_instance_options(MachineState *machine)
 {
+    static const S390FeatInit qemu_cpu_feat =3D { S390_FEAT_LIST_QEMU_V4=
_1 };
     ccw_machine_4_2_instance_options(machine);
+    s390_set_qemu_cpu_model(0x2964, 13, 2, qemu_cpu_feat);
 }
=20
 static void ccw_machine_4_1_class_options(MachineClass *mc)
diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
index 49a650ac52..7e82f2f004 100644
--- a/target/s390x/gen-features.c
+++ b/target/s390x/gen-features.c
@@ -698,11 +698,14 @@ static uint16_t qemu_V4_0[] =3D {
     S390_FEAT_ZPCI,
 };
=20
-static uint16_t qemu_LATEST[] =3D {
+static uint16_t qemu_V4_1[] =3D {
     S390_FEAT_STFLE_53,
     S390_FEAT_VECTOR,
 };
=20
+static uint16_t qemu_LATEST[] =3D {
+};
+
 /* add all new definitions before this point */
 static uint16_t qemu_MAX[] =3D {
     /* generates a dependency warning, leave it out for now */
@@ -824,6 +827,7 @@ static FeatGroupDefSpec QemuFeatDef[] =3D {
     QEMU_FEAT_INITIALIZER(V2_11),
     QEMU_FEAT_INITIALIZER(V3_1),
     QEMU_FEAT_INITIALIZER(V4_0),
+    QEMU_FEAT_INITIALIZER(V4_1),
     QEMU_FEAT_INITIALIZER(LATEST),
     QEMU_FEAT_INITIALIZER(MAX),
 };
--=20
2.21.0


