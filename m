Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A53C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:12:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A34F206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="YXF4lD2S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A34F206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39945 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJu5a-0001p8-FK
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:12:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Z-0005UU-Vp
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Y-0004TT-IW
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:51 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:54761 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0Y-0004Of-4W; Fri, 26 Apr 2019 02:06:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tm2Gf8z9sNC; Fri, 26 Apr 2019 16:06:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258796;
	bh=6Bi/FEKdFLeLFSqWxVnBjr69I/R0vsKiuX5lnlTia8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXF4lD2SZeODoq4PyWfXEmVGSwEisz1sZ74vvgJz/j0D+9qu9Nffnm+JYtdezo3VG
	1u6zeWHadkiHN5EuVdKLDmUQUFKBqXdQwcoSaaPb1IcklyJqeDS7pcNg3I+sphlli8
	UqC3K8HZIq9jPGczl8tyv0Np7pb8nsV5Ci7uoPyY=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:08 +1000
Message-Id: <20190426060627.18153-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 17/36] target/ppc: Style fixes for misc_helper.c
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
Message-ID: <20190426060608.H2_HVgwn4K9PuuecSHqDU6X7SJgxoIz7sKtjDMVx5Q0@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/misc_helper.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
index c65d1ade15..0a81e98ee9 100644
--- a/target/ppc/misc_helper.c
+++ b/target/ppc/misc_helper.c
@@ -210,10 +210,11 @@ void ppc_store_msr(CPUPPCState *env, target_ulong v=
alue)
     hreg_store_msr(env, value, 0);
 }
=20
-/* This code is lifted from MacOnLinux. It is called whenever
- * THRM1,2 or 3 is read an fixes up the values in such a way
- * that will make MacOS not hang. These registers exist on some
- * 75x and 74xx processors.
+/*
+ * This code is lifted from MacOnLinux. It is called whenever THRM1,2
+ * or 3 is read an fixes up the values in such a way that will make
+ * MacOS not hang. These registers exist on some 75x and 74xx
+ * processors.
  */
 void helper_fixup_thrm(CPUPPCState *env)
 {
--=20
2.20.1


