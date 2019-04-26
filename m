Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92FBC43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:11:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C446206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="arV62c1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C446206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39943 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJu5H-0001Zq-KF
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:11:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0W-0005RR-U6
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0V-0004Nh-Ic
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:48 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:51539 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0V-0004HP-4L; Fri, 26 Apr 2019 02:06:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tk3F80z9s9y; Fri, 26 Apr 2019 16:06:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258794;
	bh=XDsmwXKQA16CWcBgdsMKK7XbptEur2qFvW8ebcZpvN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=arV62c1iE02xfLgC/XOntY3nWe/3bw1ObZQyDO2sbzSsHSmqRD4BEvbaMtQKYS1VM
	fDVSFBQ2tEUxwqudAlVMAuxQwbwhb5Eb5IZXLhYJlAEGpsxeNCAeB7rLCWxVzUGfRA
	XzqLaHorfDJH8QvKynbIEf5IXg4BKLW7RzF73Mts=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:05:56 +1000
Message-Id: <20190426060627.18153-6-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 05/36] target/ppc: Style fixes for
 ppc-models.[ch]
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
Message-ID: <20190426060556.TFtLXFwmbII7qbMK22dEMOcvSLKaLhVn2UrdyS4Nubc@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/cpu-models.c | 2 +-
 target/ppc/cpu-models.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 7c75963e3c..9d7050b5fa 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -740,7 +740,7 @@
     POWERPC_DEF("7457a_v1.2",    CPU_POWERPC_74x7A_v12,              745=
5,
                 "PowerPC 7457A v1.2 (G4)")
     /* 64 bits PowerPC                                                  =
     */
-#if defined (TARGET_PPC64)
+#if defined(TARGET_PPC64)
     POWERPC_DEF("970_v2.2",      CPU_POWERPC_970_v22,                970=
,
                 "PowerPC 970 v2.2")
     POWERPC_DEF("970fx_v1.0",    CPU_POWERPC_970FX_v10,              970=
,
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index efdb2fa53c..4fdb73034d 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -393,7 +393,8 @@ enum {
     CPU_POWERPC_RS64IV             =3D 0x00370000,
 #endif /* defined(TARGET_PPC64) */
     /* Original POWER */
-    /* XXX: should be POWER (RIOS), RSC3308, RSC4608,
+    /*
+     * XXX: should be POWER (RIOS), RSC3308, RSC4608,
      * POWER2 (RIOS2) & RSC2 (P2SC) here
      */
     /* PA Semi core */
--=20
2.20.1


