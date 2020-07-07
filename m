Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE93C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:52:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 521E92065D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 16:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 521E92065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqpy-0006lv-I9
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 12:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsqZp-0008ID-CA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35559
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsqZn-0004GR-3a
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:13 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-HzWRs749Ny-axMaXeg9OIw-1; Tue, 07 Jul 2020 12:36:06 -0400
X-MC-Unique: HzWRs749Ny-axMaXeg9OIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C99828B788E;
 Tue,  7 Jul 2020 16:35:59 +0000 (UTC)
Received: from bahia.lan (ovpn-112-37.ams2.redhat.com [10.36.112.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C7B879528;
 Tue,  7 Jul 2020 16:35:58 +0000 (UTC)
Subject: [PATCH] ppc/pnv: Make PSI device types not user creatable
From: Greg Kurz <groug@kaod.org>
To: qemu-devel@nongnu.org
Date: Tue, 07 Jul 2020 18:35:57 +0200
Message-ID: <159413975752.169116.5808968580649255382.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=groug@kaod.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=205.139.110.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

QEMU aborts with -device pnv-psi-POWER8:

$ qemu-system-ppc64 -device pnv-psi-POWER8
qemu-system-ppc64: hw/intc/xics.c:605: ics_realize: Assertion
`ics->xics' failed.
Aborted (core dumped)

The Processor Service Interface Controller is an internal device.
It should only be instantiated by the chip, which takes care of
configuring the link required by the ICS object in the case of
POWER8. It doesn't make sense for a user to specify it on the
command line.

Note that the PSI model for POWER8 was added 3 yrs ago but the
devices weren't available on the command line because of a bug
that was fixed by recent commit 2f35254aa0 ("pnv/psi: Correct
the pnv-psi* devices not to be sysbus devices").

Fixes: 54f59d786c ("ppc/pnv: Add cut down PSI bridge model and hookup exter=
nal interrupt")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv_psi.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 75b8ae9703d0..653b41774c34 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -937,6 +937,7 @@ static void pnv_psi_class_init(ObjectClass *klass, void=
 *data)
     dc->desc =3D "PowerNV PSI Controller";
     device_class_set_props(dc, pnv_psi_properties);
     dc->reset =3D pnv_psi_reset;
+    dc->user_creatable =3D false;
 }
=20
 static const TypeInfo pnv_psi_info =3D {



