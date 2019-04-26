Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17383C43218
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:16:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3082206E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 06:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="oU4uuH3g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3082206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40013 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJu9Q-0005OT-Tr
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 02:16:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0a-0005Uk-7D
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0Y-0004Tj-Lh
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:52 -0400
Received: from ozlabs.org ([203.11.71.1]:50607)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hJu0Y-0004Pf-8t; Fri, 26 Apr 2019 02:06:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 44r3Tn1NdQz9sNM; Fri, 26 Apr 2019 16:06:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1556258797;
	bh=kDfYjlvVQdJieRr+Nh8b7xVvL3ct73J87Iz8hXJMJNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oU4uuH3gfyTgT/HGaQVCem7+8Fp+MWNxwwJ3buPOf9QQWtoqYkMeOKoKqZqdMUldZ
	zJnmknbxc0xz/+B4o57UcpV6kxoHViVEs5w4cFAwIbL5aJQRmX4qUl8TQL6nzN3b0B
	kLD2Qfv9ofeDHmx3JhqnBlc2p6dHvjafSem9qK7o=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Fri, 26 Apr 2019 16:06:09 +1000
Message-Id: <20190426060627.18153-19-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 18/36] target/ppc: Style fixes for
 mmu-hash32.[ch]
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
Message-ID: <20190426060609.wRQ245S7lbzUSq0SBsS_7LvZurt3IquVTVXIPObjgmo@z>

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-hash32.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
index e8562a7c87..3f4dee835e 100644
--- a/target/ppc/mmu-hash32.c
+++ b/target/ppc/mmu-hash32.c
@@ -27,7 +27,7 @@
 #include "mmu-hash32.h"
 #include "exec/log.h"
=20
-//#define DEBUG_BAT
+/* #define DEBUG_BAT */
=20
 #ifdef DEBUG_BATS
 #  define LOG_BATS(...) qemu_log_mask(CPU_LOG_MMU, __VA_ARGS__)
@@ -228,8 +228,10 @@ static int ppc_hash32_direct_store(PowerPCCPU *cpu, =
target_ulong sr,
     qemu_log_mask(CPU_LOG_MMU, "direct store...\n");
=20
     if ((sr & 0x1FF00000) >> 20 =3D=3D 0x07f) {
-        /* Memory-forced I/O controller interface access */
-        /* If T=3D1 and BUID=3Dx'07F', the 601 performs a memory access
+        /*
+         * Memory-forced I/O controller interface access
+         *
+         * If T=3D1 and BUID=3Dx'07F', the 601 performs a memory access
          * to SR[28-31] LA[4-31], bypassing all protection mechanisms.
          */
         *raddr =3D ((sr & 0xF) << 28) | (eaddr & 0x0FFFFFFF);
@@ -265,9 +267,11 @@ static int ppc_hash32_direct_store(PowerPCCPU *cpu, =
target_ulong sr,
         }
         return 1;
     case ACCESS_CACHE:
-        /* dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi */
-        /* Should make the instruction do no-op.
-         * As it already do no-op, it's quite easy :-)
+        /*
+         * dcba, dcbt, dcbtst, dcbf, dcbi, dcbst, dcbz, or icbi
+         *
+         * Should make the instruction do no-op.  As it already do
+         * no-op, it's quite easy :-)
          */
         *raddr =3D eaddr;
         return 0;
@@ -519,8 +523,10 @@ int ppc_hash32_handle_mmu_fault(PowerPCCPU *cpu, vad=
dr eaddr, int rwx,
     if (rwx =3D=3D 1) {
         new_pte1 |=3D HPTE32_R_C; /* set changed (dirty) bit */
     } else {
-        /* Treat the page as read-only for now, so that a later write
-         * will pass through this function again to set the C bit */
+        /*
+         * Treat the page as read-only for now, so that a later write
+         * will pass through this function again to set the C bit
+         */
         prot &=3D ~PAGE_WRITE;
     }
=20
--=20
2.20.1


