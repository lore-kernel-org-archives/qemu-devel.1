Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70252C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C2820B1F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 15:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C2820B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJfbT-0002X4-AP
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 11:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jJfZ0-0000IX-9u
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jJfYz-0004lu-3x
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:45:58 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:57592)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jJfYx-0004jY-8M
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 11:45:55 -0400
Received: from player691.ha.ovh.net (unknown [10.108.42.192])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 288F912B25C
 for <qemu-devel@nongnu.org>; Wed,  1 Apr 2020 17:45:52 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player691.ha.ovh.net (Postfix) with ESMTPSA id 901071119C65F;
 Wed,  1 Apr 2020 15:45:45 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/2] ppc/xive: export PQ routines
Date: Wed,  1 Apr 2020 17:45:35 +0200
Message-Id: <20200401154536.3750-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200401154536.3750-1-clg@kaod.org>
References: <20200401154536.3750-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 13200050512010251238
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtddvgdeludcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeevrogurhhitgcunfgvucfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeluddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.39.154
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

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h    | 4 ++++
 hw/intc/spapr_xive_kvm.c | 8 ++++----
 hw/intc/xive.c           | 6 +++---
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 59ac075db080..d4e7c1f9217f 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -255,6 +255,10 @@ static inline hwaddr xive_source_esb_mgmt(XiveSource=
 *xsrc, int srcno)
 #define XIVE_ESB_QUEUED       (XIVE_ESB_VAL_P | XIVE_ESB_VAL_Q)
 #define XIVE_ESB_OFF          XIVE_ESB_VAL_Q
=20
+bool xive_esb_trigger(uint8_t *pq);
+bool xive_esb_eoi(uint8_t *pq);
+uint8_t xive_esb_set(uint8_t *pq, uint8_t value);
+
 /*
  * "magic" Event State Buffer (ESB) MMIO offsets.
  *
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index edb7ee0e74f1..43f4d56b958c 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -308,7 +308,7 @@ static uint8_t xive_esb_read(XiveSource *xsrc, int sr=
cno, uint32_t offset)
     return xive_esb_rw(xsrc, srcno, offset, 0, 0) & 0x3;
 }
=20
-static void xive_esb_trigger(XiveSource *xsrc, int srcno)
+static void kvmppc_xive_esb_trigger(XiveSource *xsrc, int srcno)
 {
     uint64_t *addr =3D xsrc->esb_mmap + xive_source_esb_page(xsrc, srcno=
);
=20
@@ -331,7 +331,7 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int src=
no, uint32_t offset,
         offset =3D=3D XIVE_ESB_LOAD_EOI) {
         xive_esb_read(xsrc, srcno, XIVE_ESB_SET_PQ_00);
         if (xsrc->status[srcno] & XIVE_STATUS_ASSERTED) {
-            xive_esb_trigger(xsrc, srcno);
+            kvmppc_xive_esb_trigger(xsrc, srcno);
         }
         return 0;
     } else {
@@ -375,7 +375,7 @@ void kvmppc_xive_source_set_irq(void *opaque, int src=
no, int val)
         }
     }
=20
-    xive_esb_trigger(xsrc, srcno);
+    kvmppc_xive_esb_trigger(xsrc, srcno);
 }
=20
 /*
@@ -544,7 +544,7 @@ static void kvmppc_xive_change_state_handler(void *op=
aque, int running,
              * generate a trigger.
              */
             if (pq =3D=3D XIVE_ESB_RESET && old_pq =3D=3D XIVE_ESB_QUEUE=
D) {
-                xive_esb_trigger(xsrc, i);
+                kvmppc_xive_esb_trigger(xsrc, i);
             }
         }
=20
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b9656cd7556c..56ce3ed93e29 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -811,7 +811,7 @@ void xive_tctx_destroy(XiveTCTX *tctx)
  * XIVE ESB helpers
  */
=20
-static uint8_t xive_esb_set(uint8_t *pq, uint8_t value)
+uint8_t xive_esb_set(uint8_t *pq, uint8_t value)
 {
     uint8_t old_pq =3D *pq & 0x3;
=20
@@ -821,7 +821,7 @@ static uint8_t xive_esb_set(uint8_t *pq, uint8_t valu=
e)
     return old_pq;
 }
=20
-static bool xive_esb_trigger(uint8_t *pq)
+bool xive_esb_trigger(uint8_t *pq)
 {
     uint8_t old_pq =3D *pq & 0x3;
=20
@@ -841,7 +841,7 @@ static bool xive_esb_trigger(uint8_t *pq)
     }
 }
=20
-static bool xive_esb_eoi(uint8_t *pq)
+bool xive_esb_eoi(uint8_t *pq)
 {
     uint8_t old_pq =3D *pq & 0x3;
=20
--=20
2.21.1


