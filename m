Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4769C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:58:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD772543D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 06:58:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD772543D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnGPY-0007QA-TR
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 02:58:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jnGOh-000705-Ie
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 02:57:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43042
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jnGOg-0003Z6-0M
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 02:57:39 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-ZBPEIf9cMi-YTRN5FrbMbg-1; Mon, 22 Jun 2020 02:57:22 -0400
X-MC-Unique: ZBPEIf9cMi-YTRN5FrbMbg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A607319057A0;
 Mon, 22 Jun 2020 06:57:20 +0000 (UTC)
Received: from bahia.lan (ovpn-113-133.ams2.redhat.com [10.36.113.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 280F771676;
 Mon, 22 Jun 2020 06:57:19 +0000 (UTC)
Subject: [PATCH] ppc/pnv: Silence missing BMC warning with qtest
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 22 Jun 2020 08:57:18 +0200
Message-ID: <159280903824.485572.831378159272329707.stgit@bahia.lan>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kaod.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: softfail client-ip=207.211.31.120; envelope-from=groug@kaod.org;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The device introspect test in qtest emits some warnings with the
the pnv machine types during the "nodefaults" phase:

TEST check-qtest-ppc64: tests/qtest/device-introspect-test
qemu-system-ppc64: warning: machine has no BMC device. Use '-device
ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define
one
qemu-system-ppc64: warning: machine has no BMC device. Use '-device
ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define
one
qemu-system-ppc64: warning: machine has no BMC device. Use '-device
ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to define
one

This is expected since the pnv machine doesn't create the internal
BMC simulator fallback when "-nodefaults" is passed on the command
line, but these warnings appear in ci logs and confuse people.

Not having a BMC isn't recommended but it is still a supported
configuration, so a straightforward fix is to just silent this
warning when qtest is enabled.

Fixes: 25f3170b0654 ("ppc/pnv: Create BMC devices only when defaults are en=
abled")
Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/pnv.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 806a5d9a8d34..1622d29b4ba7 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -21,6 +21,7 @@
 #include "qemu-common.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "sysemu/qtest.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
@@ -587,9 +588,11 @@ static void pnv_reset(MachineState *machine)
     bmc =3D pnv_bmc_find(&error_fatal);
     if (!pnv->bmc) {
         if (!bmc) {
-            warn_report("machine has no BMC device. Use '-device "
-                        "ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3D=
bmc0,irq=3D10' "
-                        "to define one");
+            if (!qtest_enabled()) {
+                warn_report("machine has no BMC device. Use '-device "
+                            "ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bm=
c=3Dbmc0,irq=3D10' "
+                            "to define one");
+            }
         } else {
             pnv_bmc_set_pnor(bmc, pnv->pnor);
             pnv->bmc =3D bmc;



