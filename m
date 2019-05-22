Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E905CC072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 04:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66E6217D7
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 04:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GXTCkpqU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66E6217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35860 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTJJX-00047H-Qf
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 00:57:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTJ8v-0003NW-9U
	for qemu-devel@nongnu.org; Wed, 22 May 2019 00:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTJ8u-0006hb-7Q
	for qemu-devel@nongnu.org; Wed, 22 May 2019 00:46:21 -0400
Received: from ozlabs.org ([203.11.71.1]:41151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTJ8t-0006fU-Rz; Wed, 22 May 2019 00:46:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 4580Sx42wbz9sP9; Wed, 22 May 2019 14:46:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558500369;
	bh=E0P7ZBTOsd78OXOu944+9bwwwlf8kjjxDpxXnr0T90s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GXTCkpqUKdU7v8nJWCxxzjtn1/MDnP5gL/R/2TTKOHEJe0bJ5TFN3ieYmT/z9gIqu
	PfAxl6gignrl2zEc9RJQAMPu4AZEI9bBbvAoeN+kXS7tjydKd9W8E/b51o+V48mWPI
	QSsr9DfxEBVhSV+yVTD4SUPtuzSUDmXMKmnNtS2g=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Wed, 22 May 2019 14:45:38 +1000
Message-Id: <20190522044600.16534-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190522044600.16534-1-david@gibson.dropbear.id.au>
References: <20190522044600.16534-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 16/38] Fix typo on "info pic" monitor cmd output
 for xive
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
	Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, clg@kaod.org,
	qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

Instead of LISN i.e "Logical Interrupt Source Number" as per
Xive PAPR document "info pic" prints as LSIN, let's fix it.

Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Message-Id: <20190509080750.21999-1-sathnaga@linux.vnet.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/spapr_xive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 58cc6e2b50..62e13ac353 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -141,7 +141,7 @@ void spapr_xive_pic_print_info(SpaprXive *xive, Monit=
or *mon)
     XiveSource *xsrc =3D &xive->source;
     int i;
=20
-    monitor_printf(mon, "  LSIN         PQ    EISN     CPU/PRIO EQ\n");
+    monitor_printf(mon, "  LISN         PQ    EISN     CPU/PRIO EQ\n");
=20
     for (i =3D 0; i < xive->nr_irqs; i++) {
         uint8_t pq =3D xive_source_esb_get(xsrc, i);
--=20
2.21.0


