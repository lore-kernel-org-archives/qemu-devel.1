Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24757C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:41:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E482C20787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W9qn7RHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E482C20787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdooX-00071Q-1L
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:41:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdoll-0001AZ-VB; Wed, 27 May 2020 01:38:25 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:47895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdoll-0001eS-0N; Wed, 27 May 2020 01:38:25 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49X03r0Y7Dz9sT0; Wed, 27 May 2020 15:38:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590557896;
 bh=KhokEOK/GurpUpa/QEkymwIvT39eY7CJwIkBx5sD8gs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W9qn7RHq5SmA99apPajBH/e0SptHCvefoRS3fXNd9g+WlOmCeadub5fBKQUxH2sEv
 pWT7oTvzzDLpnFd8KaBvIF3fYfNiZ4TqppDoCnWP3CLW9v6vWpBb+IvNenI3EoEQWa
 EYjfr+el2BHRoLDpEKHJugxSX/DsVVTog3UN6Gzg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 08/15] target/ppc: Don't initialize some local variables in
 ppc_radix64_xlate()
Date: Wed, 27 May 2020 15:38:02 +1000
Message-Id: <20200527053809.356168-9-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527053809.356168-1-david@gibson.dropbear.id.au>
References: <20200527053809.356168-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: lvivier@redhat.com, qemu-devel@nongnu.org, groug@kaod.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 philmd@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

It is the job of the ppc_radix64_get_fully_qualified_addr() function
which is called at the beginning of ppc_radix64_xlate() to set both
lpid *and* pid. It doesn't buy us anything to initialize them first.

Worse, a bug in ppc_radix64_get_fully_qualified_addr(), eg. failing to
set either lpid or pid, would be undetectable by static analysis tools
like coverity.

Some recent versions of gcc (eg. gcc-9.3.1-2.fc30) may still think
that lpid or pid is used uninitialized though, so this also adds
default cases in the switch statements to make it clear this cannot
happen.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <158941062048.240484.9693581559252337111.stgit@bahia.lan>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-radix64.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index c76879f65b..07f956c986 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -50,6 +50,8 @@ static bool ppc_radix64_get_fully_qualified_addr(const CPUPPCState *env,
             *lpid = 0;
             *pid = 0;
             break;
+        default:
+            g_assert_not_reached();
         }
     } else {  /* !MSR[HV] -> Guest */
         switch (eaddr & R_EADDR_QUADRANT) {
@@ -64,6 +66,8 @@ static bool ppc_radix64_get_fully_qualified_addr(const CPUPPCState *env,
             *lpid = env->spr[SPR_LPIDR];
             *pid = 0; /* pid set to 0 -> addresses guest operating system */
             break;
+        default:
+            g_assert_not_reached();
         }
     }
 
@@ -433,7 +437,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
                              bool cause_excp)
 {
     CPUPPCState *env = &cpu->env;
-    uint64_t lpid = 0, pid = 0;
+    uint64_t lpid, pid;
     ppc_v3_pate_t pate;
     int psize, prot;
     hwaddr g_raddr;
-- 
2.26.2


