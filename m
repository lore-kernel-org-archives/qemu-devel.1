Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2F8C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:21:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D094216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 06:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="VDngy8d+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D094216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCAi-0006y4-HE
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 02:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByj-0004vC-Ae
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiByi-0002tz-2w
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:21 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:47553 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiByh-0002px-Mc; Tue, 02 Jul 2019 02:09:20 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMj0b85z9sPb; Tue,  2 Jul 2019 16:09:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047745;
 bh=mGOKe2dFUOM7xuaI3Xp5TX8JDd6ScAH8SGGHgbx7Rmo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VDngy8d+mqcforKKAHlxvvYQSdsxVGmoxj5LpF9vTAuUoaKid3r5Je2JGAXtUoRwo
 bAivWqsTV4XBZ8KJLiXvpoaFcrJGpQZ1urQh+SfltjDzlAjNwfD6D7wwHlYn49YghB
 jklunR2KWWuS9McdGsTRw2e1Bu7adp/fQPzWvBHA=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:25 +1000
Message-Id: <20190702060857.3926-18-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: [Qemu-devel] [PULL 17/49] hw/ppc/mac_oldworld: Drop useless
 CONFIG_KVM ifdefery
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

kvm_enabled() expands to (0) when CONFIG_KVM is not defined. It is
likely that the compiler will optimize the code out. And even if
it doesn't, we have a stub for kvmppc_get_hypercall().

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <156051053529.224162.3489943067148134636.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/mac_oldworld.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index eddd005a7c..da751addc4 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -345,14 +345,12 @@ static void ppc_heathrow_init(MachineState *machine=
)
=20
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
     if (kvm_enabled()) {
-#ifdef CONFIG_KVM
         uint8_t *hypercall;
=20
         hypercall =3D g_malloc(16);
         kvmppc_get_hypercall(env, hypercall, 16);
         fw_cfg_add_bytes(fw_cfg, FW_CFG_PPC_KVM_HC, hypercall, 16);
         fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_KVM_PID, getpid());
-#endif
     }
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_TBFREQ, tbfreq);
     /* Mac OS X requires a "known good" clock-frequency value; pass it o=
ne. */
--=20
2.21.0


