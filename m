Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B191C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 14:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2ED320865
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 14:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2ED320865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG2EI-0004kN-U0
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 10:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iG2DW-0004F6-3x
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iG2DU-0001Kv-Lq
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:36:29 -0400
Received: from 10.mo177.mail-out.ovh.net ([46.105.73.133]:57445)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iG2DU-0001Jr-FL
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 10:36:28 -0400
Received: from player693.ha.ovh.net (unknown [10.108.42.168])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 1165C10CE6E
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 16:36:25 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player693.ha.ovh.net (Postfix) with ESMTPSA id F3A26A8428FA;
 Thu,  3 Oct 2019 14:36:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] ppc/pnv: Remove the XICSFabric Interface from the POWER9
 machine
Date: Thu,  3 Oct 2019 16:36:17 +0200
Message-Id: <20191003143617.21682-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 533958034936073190
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdektdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.73.133
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The POWER8 PowerNV machine needs to implement a XICSFabric interface
as this is the POWER8 interrupt controller model. But the POWER9
machine uselessly inherits of XICSFabric from the common PowerNV
machine definition.

Open code machine definitions to have a better control on the
different interfaces each machine should define.

Fixes: f30c843ced50 ("ppc/pnv: Introduce PowerNV machines with fixed CPU =
models")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 77a86c6a2301..7cf64b6d2533 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1485,23 +1485,21 @@ static void pnv_machine_class_init(ObjectClass *o=
c, void *data)
         .parent        =3D TYPE_PNV9_CHIP,          \
     }
=20
-#define DEFINE_PNV_MACHINE_TYPE(cpu, class_initfn)      \
-    {                                                   \
-        .name          =3D MACHINE_TYPE_NAME(cpu),        \
-        .parent        =3D TYPE_PNV_MACHINE,              \
-        .instance_size =3D sizeof(PnvMachineState),       \
-        .instance_init =3D pnv_machine_instance_init,     \
-        .class_init    =3D class_initfn,                  \
-        .interfaces =3D (InterfaceInfo[]) {               \
-            { TYPE_XICS_FABRIC },                       \
-            { TYPE_INTERRUPT_STATS_PROVIDER },          \
-            { },                                        \
-        },                                              \
-    }
-
 static const TypeInfo types[] =3D {
-    DEFINE_PNV_MACHINE_TYPE("powernv8", pnv_machine_power8_class_init),
-    DEFINE_PNV_MACHINE_TYPE("powernv9", pnv_machine_power9_class_init),
+    {
+        .name          =3D MACHINE_TYPE_NAME("powernv9"),
+        .parent        =3D TYPE_PNV_MACHINE,
+        .class_init    =3D pnv_machine_power9_class_init,
+    },
+    {
+        .name          =3D MACHINE_TYPE_NAME("powernv8"),
+        .parent        =3D TYPE_PNV_MACHINE,
+        .class_init    =3D pnv_machine_power8_class_init,
+        .interfaces =3D (InterfaceInfo[]) {
+            { TYPE_XICS_FABRIC },
+            { },
+        },
+    },
     {
         .name          =3D TYPE_PNV_MACHINE,
         .parent        =3D TYPE_MACHINE,
@@ -1510,7 +1508,6 @@ static const TypeInfo types[] =3D {
         .instance_init =3D pnv_machine_instance_init,
         .class_init    =3D pnv_machine_class_init,
         .interfaces =3D (InterfaceInfo[]) {
-            { TYPE_XICS_FABRIC },
             { TYPE_INTERRUPT_STATS_PROVIDER },
             { },
         },
--=20
2.21.0


