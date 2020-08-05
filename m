Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE419C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A822312B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 15:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A822312B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3LeD-0001IU-To
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 11:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k3Ldc-0000mb-Kj
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 11:47:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31293
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k3Lda-0004rV-HK
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 11:47:32 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-6Ex9XWPnMhmFtzCc59JbqQ-1; Wed, 05 Aug 2020 11:47:20 -0400
X-MC-Unique: 6Ex9XWPnMhmFtzCc59JbqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1DAD57;
 Wed,  5 Aug 2020 15:47:18 +0000 (UTC)
Received: from bahia.lan (ovpn-112-38.ams2.redhat.com [10.36.112.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2B66788D78;
 Wed,  5 Aug 2020 15:47:16 +0000 (UTC)
Subject: [PATCH] spapr: Clarify error and documentation for broken KVM XICS
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 05 Aug 2020 17:47:16 +0200
Message-ID: <159664243614.622889.18307368735989783528.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: Satheesh Rajendran <sathnaga@linux.ibm.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When starting an L2 KVM guest with `ic-mode=3Ddual,kernel-irqchip=3Don`,
QEMU fails with:

KVM is too old to support ic-mode=3Ddual,kernel-irqchip=3Don

This error message was introduced to detect older KVM versions that
didn't allow destruction and re-creation of the XICS KVM device that
we do at reboot. But it is actually the same issue that we get with
nested guests : when running under pseries, KVM currently provides
a genuine XICS device (not the XICS-on-XIVE device that we get
under powernv) which doesn't support destruction/re-creation.

This will eventually be fixed in KVM but in the meantime, update
the error message and documentation to mention the nested case.
While here, mention that in "No XIVE support in KVM" section that
this can also happen with "guest OSes supporting XIVE" since
we check this at init time before starting the guest.

Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Buglink: https://bugs.launchpad.net/qemu/+bug/1890290
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 docs/specs/ppc-spapr-xive.rst |    5 ++++-
 hw/ppc/spapr_irq.c            |   12 +++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
index 7199db730b82..7144347560f1 100644
--- a/docs/specs/ppc-spapr-xive.rst
+++ b/docs/specs/ppc-spapr-xive.rst
@@ -126,6 +126,9 @@ xics            XICS KVM       XICS emul.     XICS KVM
=20
 (1) QEMU warns with ``warning: kernel_irqchip requested but unavailable:
     IRQ_XIVE capability must be present for KVM``
+    In some cases (old host kernels or KVM nested guests), one may hit a
+    QEMU/KVM incompatibility due to device destruction in reset. QEMU fail=
s
+    with ``KVM is incompatible with ic-mode=3Ddual,kernel-irqchip=3Don``
 (2) QEMU fails with ``kernel_irqchip requested but unavailable:
     IRQ_XIVE capability must be present for KVM``
=20
@@ -148,7 +151,7 @@ xics            XICS KVM       XICS emul.     XICS KVM
     mode (XICS), either don't set the ic-mode machine property or try
     ic-mode=3Dxics or ic-mode=3Ddual``
 (4) QEMU/KVM incompatibility due to device destruction in reset. QEMU fail=
s
-    with ``KVM is too old to support ic-mode=3Ddual,kernel-irqchip=3Don``
+    with ``KVM is incompatible with ic-mode=3Ddual,kernel-irqchip=3Don``
=20
=20
 XIVE Device tree properties
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 2f8f7d62f875..72bb938375ef 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -139,6 +139,7 @@ SpaprIrq spapr_irq_dual =3D {
=20
 static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
 {
+    ERRP_GUARD();
     MachineState *machine =3D MACHINE(spapr);
=20
     /*
@@ -179,14 +180,19 @@ static int spapr_irq_check(SpaprMachineState *spapr, =
Error **errp)
=20
     /*
      * On a POWER9 host, some older KVM XICS devices cannot be destroyed a=
nd
-     * re-created. Detect that early to avoid QEMU to exit later when the
-     * guest reboots.
+     * re-created. Same happens with KVM nested guests. Detect that early =
to
+     * avoid QEMU to exit later when the guest reboots.
      */
     if (kvm_enabled() &&
         spapr->irq =3D=3D &spapr_irq_dual &&
         kvm_kernel_irqchip_required() &&
         xics_kvm_has_broken_disconnect(spapr)) {
-        error_setg(errp, "KVM is too old to support ic-mode=3Ddual,kernel-=
irqchip=3Don");
+        error_setg(errp,
+            "KVM is incompatible with ic-mode=3Ddual,kernel-irqchip=3Don")=
;
+        error_append_hint(errp,
+            "This can happen with an old KVM or in a KVM nested guest.\n")=
;
+        error_append_hint(errp,
+            "Try without kernel-irqchip or with kernel-irqchip=3Doff.\n");
         return -1;
     }
=20



