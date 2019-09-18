Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0246AC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1DEA208C0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:21:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1DEA208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdeJ-0008N4-V3
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55510)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iAcUI-0003LI-TC
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iAcUH-0002o3-Kt
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:26 -0400
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:36343)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iAcUH-0002mZ-FA
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 12:07:25 -0400
Received: from player799.ha.ovh.net (unknown [10.109.160.46])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id E63A6207926
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 18:07:23 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player799.ha.ovh.net (Postfix) with ESMTPSA id C96B49F0E4CD;
 Wed, 18 Sep 2019 16:07:17 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 18 Sep 2019 18:06:25 +0200
Message-Id: <20190918160645.25126-6-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190918160645.25126-1-clg@kaod.org>
References: <20190918160645.25126-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6213560114297998310
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudekgdeljecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.36.253
Subject: [Qemu-devel] [PATCH v4 05/25] ppc/xive: Introduce a XiveFabric
 interface
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
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XiveFabric QOM interface should be implemented by the machine. It
acts as the PowerBUS interface between the interrupt controller and
the system. On HW, the XIVE sub-engine is responsible for the
communication with the other chip is the Common Queue (CQ) bridge
unit.

This interface offers a 'match_nvt' handler to perform the CAM line
matching when looking for a XIVE Presenter with a dispatched NVT.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 22 ++++++++++++++++++++++
 hw/intc/xive.c        | 10 ++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 39de45b87cb9..3c2910e10e25 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -399,6 +399,28 @@ int xive_presenter_tctx_match(XivePresenter *xptr, X=
iveTCTX *tctx,
                               uint8_t nvt_blk, uint32_t nvt_idx,
                               bool cam_ignore, uint32_t logic_serv);
=20
+/*
+ * XIVE Fabric (Interface between Interrupt Controller and Machine)
+ */
+
+typedef struct XiveFabric XiveFabric;
+
+#define TYPE_XIVE_FABRIC "xive-fabric"
+#define XIVE_FABRIC(obj)                                     \
+    INTERFACE_CHECK(XiveFabric, (obj), TYPE_XIVE_FABRIC)
+#define XIVE_FABRIC_CLASS(klass)                                     \
+    OBJECT_CLASS_CHECK(XiveFabricClass, (klass), TYPE_XIVE_FABRIC)
+#define XIVE_FABRIC_GET_CLASS(obj)                                   \
+    OBJECT_GET_CLASS(XiveFabricClass, (obj), TYPE_XIVE_FABRIC)
+
+typedef struct XiveFabricClass {
+    InterfaceClass parent;
+    int (*match_nvt)(XiveFabric *xfb, uint8_t format,
+                     uint8_t nvt_blk, uint32_t nvt_idx,
+                     bool cam_ignore, uint8_t priority,
+                     uint32_t logic_serv, XiveTCTXMatch *match);
+} XiveFabricClass;
+
 /*
  * XIVE END ESBs
  */
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index fff50429f8ac..7a15a64ed7fe 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1841,8 +1841,18 @@ static const TypeInfo xive_presenter_info =3D {
     .class_size =3D sizeof(XivePresenterClass),
 };
=20
+/*
+ * XIVE Fabric
+ */
+static const TypeInfo xive_fabric_info =3D {
+    .name =3D TYPE_XIVE_FABRIC,
+    .parent =3D TYPE_INTERFACE,
+    .class_size =3D sizeof(XiveFabricClass),
+};
+
 static void xive_register_types(void)
 {
+    type_register_static(&xive_fabric_info);
     type_register_static(&xive_source_info);
     type_register_static(&xive_notifier_info);
     type_register_static(&xive_presenter_info);
--=20
2.21.0


