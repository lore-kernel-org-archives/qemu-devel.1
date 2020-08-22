Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E91C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 08:40:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3C04214F1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 08:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3C04214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9P4W-0005Ra-0p
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 04:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k9P3o-00051M-PO; Sat, 22 Aug 2020 04:39:36 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:52959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k9P3m-0001VB-LA; Sat, 22 Aug 2020 04:39:36 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.5])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id DFD765992077;
 Sat, 22 Aug 2020 10:39:22 +0200 (CEST)
Received: from kaod.org (37.59.142.95) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sat, 22 Aug
 2020 10:39:21 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001e4e1dd34-eeac-4d0a-8a24-9ed1a3b659d4,
 3BE414691F1E901D170BBC22D222B03988F0DEFC) smtp.auth=clg@kaod.org
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH] ppc/pnv: Fix TypeInfo of PnvLpcController abstract class
Date: Sat, 22 Aug 2020 10:39:20 +0200
Message-ID: <20200822083920.2668930-1-clg@kaod.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 4a7b76dd-5a0d-49d2-90fa-9727d1c74bd6
X-Ovh-Tracer-Id: 15688852252534148003
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddugedgtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffogggtgfhisehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepfedvuedtvdeikeekuefhkedujeejgffggffhtefglefgveevfeeghfdvgedtleevnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/22 04:39:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It was missing the instance_size field.

Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv_lpc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index b5ffa48dac71..23f1e09492b1 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -646,7 +646,6 @@ static void pnv_lpc_power8_class_init(ObjectClass *klass, void *data)
 static const TypeInfo pnv_lpc_power8_info = {
     .name          = TYPE_PNV8_LPC,
     .parent        = TYPE_PNV_LPC,
-    .instance_size = sizeof(PnvLpcController),
     .class_init    = pnv_lpc_power8_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
@@ -687,7 +686,6 @@ static void pnv_lpc_power9_class_init(ObjectClass *klass, void *data)
 static const TypeInfo pnv_lpc_power9_info = {
     .name          = TYPE_PNV9_LPC,
     .parent        = TYPE_PNV_LPC,
-    .instance_size = sizeof(PnvLpcController),
     .class_init    = pnv_lpc_power9_class_init,
 };
 
@@ -768,6 +766,7 @@ static void pnv_lpc_class_init(ObjectClass *klass, void *data)
 static const TypeInfo pnv_lpc_info = {
     .name          = TYPE_PNV_LPC,
     .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(PnvLpcController),
     .class_init    = pnv_lpc_class_init,
     .class_size    = sizeof(PnvLpcClass),
     .abstract      = true,
-- 
2.25.4


