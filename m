Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB54C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD6E2072D
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 16:34:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD6E2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVeXp-0000RE-1j
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 11:34:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51947)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iVePA-0007TH-9Y
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iVeP9-0000Zw-3e
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:04 -0500
Received: from 9.mo179.mail-out.ovh.net ([46.105.76.148]:56980)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iVeP8-0000ZH-TU
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 11:25:03 -0500
Received: from player787.ha.ovh.net (unknown [10.109.146.82])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id E88BD14B655
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 17:25:00 +0100 (CET)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player787.ha.ovh.net (Postfix) with ESMTPSA id 388C8C4446D4;
 Fri, 15 Nov 2019 16:24:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH for-5.0 v5 02/23] ppc/xive: Introduce helpers for the NVT id
Date: Fri, 15 Nov 2019 17:24:15 +0100
Message-Id: <20191115162436.30548-3-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191115162436.30548-1-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 15085932855586491366
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudefhedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpledtrdejiedrhedtrddvvdefnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.76.148
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

Each vCPU in the system is identified with an NVT identifier which is
pushed in the OS CAM line (QW1W2) of the HW thread interrupt context
register when the vCPU is dispatched on a HW thread. This identifier
is used by the presenter subengine to find a matching target to notify
of an event. It is also used to fetch the associate NVT structure
which may contain pending interrupts that need a resend.

Add a couple of helpers for the NVT ids. The NVT space is 19 bits
wide, giving a maximum of 512K per chip.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h      |  5 -----
 include/hw/ppc/xive_regs.h | 21 +++++++++++++++++++++
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 8fd439ec9bba..fa7adf87feb2 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -418,11 +418,6 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xr=
tr, Error **errp);
 void xive_tctx_reset(XiveTCTX *tctx);
 void xive_tctx_destroy(XiveTCTX *tctx);
=20
-static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
-{
-    return (nvt_blk << 19) | nvt_idx;
-}
-
 /*
  * KVM XIVE device helpers
  */
diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
index 530f232b04f8..1a5622f8ded8 100644
--- a/include/hw/ppc/xive_regs.h
+++ b/include/hw/ppc/xive_regs.h
@@ -272,4 +272,25 @@ typedef struct XiveNVT {
=20
 #define xive_nvt_is_valid(nvt)    (be32_to_cpu((nvt)->w0) & NVT_W0_VALID=
)
=20
+/*
+ * The VP number space in a block is defined by the END_W6_NVT_INDEX
+ * field of the XIVE END
+ */
+#define XIVE_NVT_SHIFT                19
+
+static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
+{
+    return (nvt_blk << XIVE_NVT_SHIFT) | nvt_idx;
+}
+
+static inline uint32_t xive_nvt_idx(uint32_t cam_line)
+{
+    return cam_line & ((1 << XIVE_NVT_SHIFT) - 1);
+}
+
+static inline uint32_t xive_nvt_blk(uint32_t cam_line)
+{
+    return (cam_line >> XIVE_NVT_SHIFT) & 0xf;
+}
+
 #endif /* PPC_XIVE_REGS_H */
--=20
2.21.0


