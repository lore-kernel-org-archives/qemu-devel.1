Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DE0C43141
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:47:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BB220728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BB220728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVel2-0007VJ-F4
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:47:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52364)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVeQ2-0000SX-IK
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVeQ1-0000yy-9N
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:58 -0500
Received: from 11.mo6.mail-out.ovh.net ([188.165.38.119]:37428)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVeQ0-0000yP-VK
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:57 -0500
Received: from player787.ha.ovh.net (unknown [10.108.54.94])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 17DA31EC944
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 17:25:55 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id A26E3C444B26;
 Fri, 15 Nov 2019 16:25:49 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH for-5.0 v5 12/23] ppc/xive: Introduce a XiveFabric interface
Date: Fri, 15 Nov 2019 17:24:25 +0100
Message-Id: <20191115162436.30548-13-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115162436.30548-1-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 15101132504234494950
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpeef
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.38.119
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
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The XiveFabric QOM interface acts as the PowerBUS interface between
the interrupt controller and the system and should be implemented by
the QEMU machine. On HW, the XIVE sub-engine is responsible for the
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
index f9aa0fa0dac3..b00af988779b 100644
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
index da6196ca958f..1c9e58f8deac 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1893,8 +1893,18 @@ static const TypeInfo xive_presenter_info =3D {
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


