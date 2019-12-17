Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079B4C2D0C8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:46:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6FC6206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 04:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pIudIm2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6FC6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih4kD-0001aR-49
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 23:46:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hq-0007uc-IN
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih4hp-0005BR-AA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 23:43:34 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:46007 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih4ho-00059G-BO; Mon, 16 Dec 2019 23:43:33 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cQWN1j2Vz9sRl; Tue, 17 Dec 2019 15:43:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576557808;
 bh=QvZsbPbPTXJgbugyS+JXPXYYFX2UHblPzgJxd95tWIQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pIudIm2EW9b2PY9LE9wj407nP1c29ArCaz371V9KT3NSmlLQC4OXkKUEcUNiS4IVn
 CgSnd143JXXrUHpxPet9NkFM/qOinxGPb/HC9+ArEvwa1YLGzQCfY0DhHN6mN9SL43
 7y+Z15WxlQ2Q4k7T8FJn0DW6uKue41m4o0Q20l/c=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 02/88] ppc/pnv: Add a "/qemu" device tree node
Date: Tue, 17 Dec 2019 15:41:56 +1100
Message-Id: <20191217044322.351838-3-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191217044322.351838-1-david@gibson.dropbear.id.au>
References: <20191217044322.351838-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: C=C3=A9dric Le Goater <clg@kaod.org>

It helps skiboot identifying that is running on a QEMU platform. The
compatible string will define the POWERPC processor version.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20191106142129.4908-1-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d0c1d42277..416caab6f6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -480,6 +480,9 @@ static void *pnv_dt_create(MachineState *machine)
     fdt =3D g_malloc0(FDT_MAX_SIZE);
     _FDT((fdt_create_empty_tree(fdt, FDT_MAX_SIZE)));
=20
+    /* /qemu node */
+    _FDT((fdt_add_subnode(fdt, 0, "qemu")));
+
     /* Root node */
     _FDT((fdt_setprop_cell(fdt, 0, "#address-cells", 0x2)));
     _FDT((fdt_setprop_cell(fdt, 0, "#size-cells", 0x2)));
--=20
2.23.0


