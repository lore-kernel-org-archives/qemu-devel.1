Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96F0C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89D7420774
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D7420774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6H2E-0003Vu-PW
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k6H1W-0002wL-TQ
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:28:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43518
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1k6H1U-00082K-Rz
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:28:18 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-7J4FDTsuMsqrsWkj8dTkyQ-1; Thu, 13 Aug 2020 13:28:14 -0400
X-MC-Unique: 7J4FDTsuMsqrsWkj8dTkyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 745FE1005504;
 Thu, 13 Aug 2020 17:28:12 +0000 (UTC)
Received: from bahia.lan (ovpn-113-39.ams2.redhat.com [10.36.113.39])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D68F600E2;
 Thu, 13 Aug 2020 17:28:11 +0000 (UTC)
Subject: [PATCH] spapr/xive: Use xive_source_esb_len()
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 13 Aug 2020 19:28:10 +0200
Message-ID: <159733969034.320580.6571451425779179477.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 03:45:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665, URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

static inline size_t xive_source_esb_len(XiveSource *xsrc)
{
    return (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
}

Signed-off-by: Greg Kurz <groug@kaod.org>
---
Follow-up on "ppc/xive: Rework setup of XiveSource::esb_mmio"
http://patchwork.ozlabs.org/project/qemu-devel/patch/159679992680.876294.75=
20540158586170894.stgit@bahia.lan/
---
 hw/intc/spapr_xive.c     |    2 +-
 hw/intc/spapr_xive_kvm.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 3c84f64dc464..4bd0d606ba17 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -336,7 +336,7 @@ static void spapr_xive_realize(DeviceState *dev, Error =
**errp)
     sysbus_init_mmio(SYS_BUS_DEVICE(xive), &end_xsrc->esb_mmio);
=20
     /* Set the mapping address of the END ESB pages after the source ESBs =
*/
-    xive->end_base =3D xive->vc_base + (1ull << xsrc->esb_shift) * xsrc->n=
r_irqs;
+    xive->end_base =3D xive->vc_base + xive_source_esb_len(xsrc);
=20
     /*
      * Allocate the routing tables
diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
index 82a6f99f022d..3263b982239a 100644
--- a/hw/intc/spapr_xive_kvm.c
+++ b/hw/intc/spapr_xive_kvm.c
@@ -831,7 +831,7 @@ void kvmppc_xive_disconnect(SpaprInterruptController *i=
ntc)
=20
     /* Clear the KVM mapping */
     xsrc =3D &xive->source;
-    esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
+    esb_len =3D xive_source_esb_len(xsrc);
=20
     if (xsrc->esb_mmap) {
         memory_region_del_subregion(&xsrc->esb_mmio, &xsrc->esb_mmio_kvm);



