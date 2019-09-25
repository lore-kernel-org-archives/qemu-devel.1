Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB119C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92664222CC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="fe0cKCE4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92664222CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD1cN-0006pU-0q
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38868)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13r-0008O6-3p
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iD13o-0003cD-QP
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 02:46:02 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48221)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iD13n-0003WD-UU; Wed, 25 Sep 2019 02:46:00 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46dT8r5YHWz9sRC; Wed, 25 Sep 2019 16:45:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1569393948;
 bh=oOHf3Ok6mT3niH+4eQHB15aHwOyP7EicV3r2obz9UAE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=fe0cKCE427tphSrzrvlfi66K50YuZ3mMThWROQiTc2KSGDb9HQcwGzOwOYyCnCrvw
 P1oxYhzd8Cuo9Zb/A1sCkl0VDhYRSQnIHt4guXzbujr4BZc8E2TOUJzzAE//nMyEV/
 B+NdfOped3nUwx/1DQp+/+rxscWhy7Ccde/+NKTI=
From: David Gibson <david@gibson.dropbear.id.au>
To: qemu-ppc@nongnu.org,
	clg@kaod.org,
	qemu-devel@nongnu.org
Subject: [PATCH 17/20] spapr: Remove unused return value in claim path
Date: Wed, 25 Sep 2019 16:45:31 +1000
Message-Id: <20190925064534.19155-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925064534.19155-1-david@gibson.dropbear.id.au>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 groug@kaod.org, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

spapr_irq_claim() and the hooks it is based on return an integer error co=
de
as well as taking an Error ** parameter.  But none of the callers check t=
he
integer, so we can remove it and just use the richer Error **.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c         | 32 +++++++++++++-------------------
 include/hw/ppc/spapr_irq.h |  4 ++--
 2 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 261d66ba17..2673a90604 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -112,8 +112,8 @@ static void spapr_irq_init_xics(SpaprMachineState *sp=
apr, Error **errp)
     spapr->ics =3D ICS_SPAPR(obj);
 }
=20
-static int spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool =
lsi,
-                                Error **errp)
+static void spapr_irq_claim_xics(SpaprMachineState *spapr, int irq, bool=
 lsi,
+                                 Error **errp)
 {
     ICSState *ics =3D spapr->ics;
=20
@@ -122,11 +122,10 @@ static int spapr_irq_claim_xics(SpaprMachineState *=
spapr, int irq, bool lsi,
=20
     if (!ics_irq_free(ics, irq - ics->offset)) {
         error_setg(errp, "IRQ %d is not free", irq);
-        return -1;
+        return;
     }
=20
     ics_set_irq_type(ics, irq - ics->offset, lsi);
-    return 0;
 }
=20
 static void spapr_irq_free_xics(SpaprMachineState *spapr, int irq)
@@ -252,14 +251,12 @@ static void spapr_irq_init_xive(SpaprMachineState *=
spapr, Error **errp)
     spapr_xive_hcall_init(spapr);
 }
=20
-static int spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool =
lsi,
-                                Error **errp)
+static void spapr_irq_claim_xive(SpaprMachineState *spapr, int irq, bool=
 lsi,
+                                 Error **errp)
 {
     if (!spapr_xive_irq_claim(spapr->xive, irq, lsi)) {
         error_setg(errp, "IRQ %d is invalid", irq);
-        return -1;
     }
-    return 0;
 }
=20
 static void spapr_irq_free_xive(SpaprMachineState *spapr, int irq)
@@ -406,25 +403,22 @@ static void spapr_irq_init_dual(SpaprMachineState *=
spapr, Error **errp)
     }
 }
=20
-static int spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bool =
lsi,
-                                Error **errp)
+static void spapr_irq_claim_dual(SpaprMachineState *spapr, int irq, bool=
 lsi,
+                                 Error **errp)
 {
     Error *local_err =3D NULL;
-    int ret;
=20
-    ret =3D spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
+    spapr_irq_xics.claim(spapr, irq, lsi, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return ret;
+        return;
     }
=20
-    ret =3D spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
+    spapr_irq_xive.claim(spapr, irq, lsi, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
-        return ret;
+        return;
     }
-
-    return ret;
 }
=20
 static void spapr_irq_free_dual(SpaprMachineState *spapr, int irq)
@@ -622,12 +616,12 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
                                       spapr->irq->nr_xirqs + SPAPR_XIRQ_=
BASE);
 }
=20
-int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp)
+void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error =
**errp)
 {
     assert(irq >=3D SPAPR_XIRQ_BASE);
     assert(irq < (spapr->irq->nr_xirqs + SPAPR_XIRQ_BASE));
=20
-    return spapr->irq->claim(spapr, irq, lsi, errp);
+    spapr->irq->claim(spapr, irq, lsi, errp);
 }
=20
 void spapr_irq_free(SpaprMachineState *spapr, int irq, int num)
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index ed88b4599a..75279ca137 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -42,7 +42,7 @@ typedef struct SpaprIrq {
     uint8_t     ov5;
=20
     void (*init)(SpaprMachineState *spapr, Error **errp);
-    int (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **er=
rp);
+    void (*claim)(SpaprMachineState *spapr, int irq, bool lsi, Error **e=
rrp);
     void (*free)(SpaprMachineState *spapr, int irq);
     void (*print_info)(SpaprMachineState *spapr, Monitor *mon);
     void (*dt_populate)(SpaprMachineState *spapr, uint32_t nr_servers,
@@ -61,7 +61,7 @@ extern SpaprIrq spapr_irq_xive;
 extern SpaprIrq spapr_irq_dual;
=20
 void spapr_irq_init(SpaprMachineState *spapr, Error **errp);
-int spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error *=
*errp);
+void spapr_irq_claim(SpaprMachineState *spapr, int irq, bool lsi, Error =
**errp);
 void spapr_irq_free(SpaprMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(SpaprMachineState *spapr, int irq);
 int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
--=20
2.21.0


