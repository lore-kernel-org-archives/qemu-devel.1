Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A22DC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:21:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DE3D2083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 18:21:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DE3D2083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36483 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYx0e-0003vG-CC
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 14:21:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hYwUL-0004nE-Gl
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hYwUJ-0004f2-TQ
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:45 -0400
Received: from 5.mo179.mail-out.ovh.net ([46.105.43.140]:34991)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hYwUJ-0004bC-Le
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:47:43 -0400
Received: from player750.ha.ovh.net (unknown [10.109.159.157])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 1E4D813519D
	for <qemu-devel@nongnu.org>; Thu,  6 Jun 2019 19:47:40 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player750.ha.ovh.net (Postfix) with ESMTPSA id 5104B6ADB01A;
	Thu,  6 Jun 2019 17:47:36 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu,  6 Jun 2019 19:47:32 +0200
Message-Id: <20190606174732.13051-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 5889582416243297254
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeggedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.43.140
Subject: [Qemu-devel] [PATCH] ppc/pnv: activate the "dumpdtb" option on the
 powernv machine
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a good way to debug the DT creation for current PowerNV
machines and new ones to come.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 046f0a83c8e5..ed6892466793 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -23,6 +23,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "sysemu/cpus.h"
+#include "sysemu/device_tree.h"
 #include "hw/hw.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
@@ -554,6 +555,7 @@ static void pnv_reset(void)
     /* Pack resulting tree */
     _FDT((fdt_pack(fdt)));
=20
+    qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
     cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
 }
=20
--=20
2.21.0


