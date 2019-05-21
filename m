Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F20C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1759720863
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 06:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="eNEOqZhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1759720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47705 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSyff-0002uw-8d
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 02:54:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyHt-0006QF-SN
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:30:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hSyHs-0008Jg-1d
	for qemu-devel@nongnu.org; Tue, 21 May 2019 02:30:13 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53523)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hSyHq-0007nd-P3; Tue, 21 May 2019 02:30:11 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 457Qph10y2z9sPJ; Tue, 21 May 2019 16:29:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558420172;
	bh=E0P7ZBTOsd78OXOu944+9bwwwlf8kjjxDpxXnr0T90s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNEOqZhAYR4u+MHW1AAWRIxYXM48NZ69ulqEpdUjeFpkuIwPM+UiXDePYzSTZ5bys
	Z9n3OiJeAubdiqehfh0e/A2YSAD6pR+Z4li9UVJx6Z+wA5VbJ7Kt5+ft+OFQQQe9+5
	NI74eny8NG0S7xqsRMTGwNDQMgTe/a8IMnqADQi0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue, 21 May 2019 16:29:02 +1000
Message-Id: <20190521062924.6930-17-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190521062924.6930-1-david@gibson.dropbear.id.au>
References: <20190521062924.6930-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: lvivier@redhat.com, gkurz@kaod.org, qemu-devel@nongnu.org,
	Greg Kurz <groug@kaod.org>,
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


