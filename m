Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F79C11D24
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4252071E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="niGnvNfc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4252071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zIE-0002wG-5M
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49214)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z81-0002HY-Qq
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7z-0008Os-Kq
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:25 -0500
Received: from ozlabs.org ([203.11.71.1]:37303)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z7x-00087s-JE; Thu, 20 Feb 2020 22:37:22 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwJ0d1yz9sSc; Fri, 21 Feb 2020 14:37:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256224;
 bh=sO097TsS0k3e6xUsegfejRikMYYyBRfhml+i7W1IJd0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=niGnvNfcLKpN7JxBpcQWbbZVyi/OK92YYxpunXpYqQsGb5qVEfTg8NVFPGtZBU6t4
 5GBPjOz/Cy5TVl7NFeqBJTczdfnfkZa+/cpXdpwPbWMIqhozcNPhyBYIKVfvPRa5S2
 nloDNzmqake8QJJTv2r9ORbbuOtaffqsGaQb80yA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 15/20] target/ppc/cpu.h: Move fpu related members closer in cpu
 env
Date: Fri, 21 Feb 2020 14:36:45 +1100
Message-Id: <20200221033650.444386-16-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Move fp_status and fpscr closer to other floating point and vector
related members in cpu env definition so they are in one group.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <5b50e9e7eec2c383ae878b397d0b2927efc9ea43.1581888834.git.bala=
ton@eik.bme.hu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 07dd2b4da7..c3b0a00064 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -997,11 +997,6 @@ struct CPUPPCState {
     /* temporary general purpose registers */
     target_ulong tgpr[4]; /* Used to speed-up TLB assist handlers */
=20
-    /* Floating point execution context */
-    float_status fp_status;
-    /* floating point status and control register */
-    target_ulong fpscr;
-
     /* Next instruction pointer */
     target_ulong nip;
=20
@@ -1060,6 +1055,10 @@ struct CPUPPCState {
      * used simultaneously
      */
     float_status vec_status;
+    /* Floating point execution context */
+    float_status fp_status;
+    /* floating point status and control register */
+    target_ulong fpscr;
=20
     /* Internal devices resources */
     /* Time base and decrementer */
--=20
2.24.1


