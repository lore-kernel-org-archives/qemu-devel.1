Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07D2C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DF692146F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="GLylheld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DF692146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49719 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCnK-0006jy-O6
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58696)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzA-0005Fn-M8
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBz9-0003CG-NY
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:48 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:60097 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBz9-0002we-5o; Tue, 02 Jul 2019 02:09:47 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMl0bYlz9sPp; Tue,  2 Jul 2019 16:09:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047747;
 bh=k/VCHgUx420OuGcdBlZhmytU4BqFbxXJioyXdnNQCnI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GLylheldE5YZkLNHigxhBhiI3MTxw0jcs5YYJUyLbsRA4XehJX5eIREjJxhxeLRp4
 UOnHa6arGQUwhUeWgDUMjBfRUowOT0vfaZCN5v9xcSPunq1Q4CX3Im5wtJhY0SuaF+
 9JoYKvLPsazoQ/LEi6yRGEkERauZTGi25oUXDrRg=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:28 +1000
Message-Id: <20190702060857.3926-21-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 20/49] hw/ppc: Drop useless CONFIG_KVM ifdefery
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
 qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

kvmppc_set_interrupt() has a stub that does nothing when CONFIG_KVM is
not defined.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156051055182.224162.15842560287892241124.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/ppc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 9d91e8481b..288196dfa6 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -80,9 +80,7 @@ void ppc_set_irq(PowerPCCPU *cpu, int n_IRQ, int level)
     }
=20
     if (old_pending !=3D env->pending_interrupts) {
-#ifdef CONFIG_KVM
         kvmppc_set_interrupt(cpu, n_IRQ, level);
-#endif
     }
=20
=20
--=20
2.21.0


