Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4522BC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15466206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="IZFv0pRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15466206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40069 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJuDx-0002Na-8Y
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:20:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0d-0005aE-6Z
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0b-0004YP-B3
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:55 -0400
Received: from ozlabs.org ([203.11.71.1]:60495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0a-0004Uj-RV; Fri, 26 Apr 2019 02:06:53 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tp2qxfz9sNp; Fri, 26 Apr 2019 16:06:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258798;
	bh=67lUhJOkF+kaNKYUQ3C7NYOWQl/IDjKx+6R9ClWRpe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IZFv0pRfiPBnTkopyVdZ7t+bROVR9TE9OCyRAKK0c+OJ5T/RV/8HPk+f8lKXLLC7v
	oErzY5Z2QHhw0FYH0Dmhs0wRulQBRP0CCjvdeI2uPgVcPOXnufvRf2hAJR+prddgG2
	xPBs8dKGONGdiVKOWszVFMiBwjy5HrzGy3oNkcuY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:12 +1000
Message-Id: <20190426060627.18153-22-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 21/36] target/ppc: Style fixes for monitor.c
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
Cc: gkurz@kaod.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org, clg@kaod.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426060612.4KuHyS_QrW8g3Bjrx4e70MdNe2pO8h1JAEK3awEqYIA@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/monitor.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 42e58163fc..ee9d6e81d2 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -27,32 +27,33 @@
 #include "monitor/hmp-target.h"
 #include "hmp.h"
=20
-static target_long monitor_get_ccr (const struct MonitorDef *md, int val=
)
+static target_long monitor_get_ccr(const struct MonitorDef *md, int val)
 {
     CPUArchState *env =3D mon_get_cpu_env();
     unsigned int u;
     int i;
=20
     u =3D 0;
-    for (i =3D 0; i < 8; i++)
+    for (i =3D 0; i < 8; i++) {
         u |=3D env->crf[i] << (32 - (4 * (i + 1)));
+    }
=20
     return u;
 }
=20
-static target_long monitor_get_decr (const struct MonitorDef *md, int va=
l)
+static target_long monitor_get_decr(const struct MonitorDef *md, int val=
)
 {
     CPUArchState *env =3D mon_get_cpu_env();
     return cpu_ppc_load_decr(env);
 }
=20
-static target_long monitor_get_tbu (const struct MonitorDef *md, int val=
)
+static target_long monitor_get_tbu(const struct MonitorDef *md, int val)
 {
     CPUArchState *env =3D mon_get_cpu_env();
     return cpu_ppc_load_tbu(env);
 }
=20
-static target_long monitor_get_tbl (const struct MonitorDef *md, int val=
)
+static target_long monitor_get_tbl(const struct MonitorDef *md, int val)
 {
     CPUArchState *env =3D mon_get_cpu_env();
     return cpu_ppc_load_tbl(env);
--=20
2.20.1


