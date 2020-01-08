Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE36C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 181D820705
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 05:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="pz63e+Of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 181D820705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip3q7-0005iL-Q2
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 00:25:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oX-0003qH-6z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ip3oW-0002cP-1z
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 00:23:28 -0500
Received: from ozlabs.org ([203.11.71.1]:49391)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ip3oV-0002UK-8f; Wed, 08 Jan 2020 00:23:27 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47syM95g2kz9sRl; Wed,  8 Jan 2020 16:23:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578460997;
 bh=lbm8EJRZ7JKETrZE+YNbktjUtLSvJ1kr18xQhBolrpM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pz63e+OfWX+mPzYpOSTGA19vV9f2k9rT4ftqwjXpkOwApsF1kwQxs/CcZm2WYwq/9
 jzmyi5Tg4TopnF8GpDS7g8RZplgND610NrQ6B9B6KQWV96MqrRlTJ4MAtBJzXfWCmy
 MOginqQFg5GsNVvBiX4u5gbCbQSMMSPemN3c4vw0=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 01/26] target/ppc: Remove unused PPC_INPUT_INT defines
Date: Wed,  8 Jan 2020 16:22:47 +1100
Message-Id: <20200108052312.238710-2-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200108052312.238710-1-david@gibson.dropbear.id.au>
References: <20200108052312.238710-1-david@gibson.dropbear.id.au>
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
Cc: lvivier@redhat.com, Fabiano Rosas <farosas@linux.ibm.com>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Fabiano Rosas <farosas@linux.ibm.com>

They were added in "16415335be Use correct input constant" with a
single use in kvm_arch_pre_run but that function's implementation was
removed by "1e8f51e856 ppc: remove idle_timer logic".

Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Message-Id: <20191218014616.686124-1-farosas@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/kvm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d1c334f0e3..5e4f219902 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1325,12 +1325,6 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq,=
 int level)
     return 0;
 }
=20
-#if defined(TARGET_PPC64)
-#define PPC_INPUT_INT PPC970_INPUT_INT
-#else
-#define PPC_INPUT_INT PPC6xx_INPUT_INT
-#endif
-
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 {
     return;
--=20
2.24.1


