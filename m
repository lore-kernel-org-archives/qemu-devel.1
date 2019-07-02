Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B21C5B57D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32094216C8
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 07:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Wn9f2A94"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32094216C8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiCt5-0002xE-FX
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 03:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58817)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzK-0005Nd-Es
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hiBzI-0003Fr-HU
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 02:09:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52781 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hiBzG-0002wQ-9d; Tue, 02 Jul 2019 02:09:54 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45dDMk64Vyz9sQn; Tue,  2 Jul 2019 16:09:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562047746;
 bh=4OfOKU12GkM2X1JZIDT5t+MpQT4M03VMpgCTQx5cXzE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wn9f2A94Nx3wy/Rz/BcS0pTSaX6r6HIwRyzSJdZNqS2tcjr4qsyZxQBuxBaPETZwS
 hlGT6/YHJ+58UlamazVIVlfgUAnWDfziHFVT8YRDF9CXuM3CFGV5gY36zyayh5Ad/W
 Axco4Ppqk2YOjmq3Uy5B+aS0Kn8gk63s4weWfAjE=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Date: Tue,  2 Jul 2019 16:08:27 +1000
Message-Id: <20190702060857.3926-20-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190702060857.3926-1-david@gibson.dropbear.id.au>
References: <20190702060857.3926-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: [Qemu-devel] [PULL 19/49] hw/ppc/prep: Drop useless CONFIG_KVM
 ifdefery
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
Message-Id: <156051054630.224162.6140707722034383410.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 2a8009e20b..a248ce480d 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -780,7 +780,6 @@ static void ibm_40p_init(MachineState *machine)
=20
     fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_IS_KVM, kvm_enabled());
     if (kvm_enabled()) {
-#ifdef CONFIG_KVM
         uint8_t *hypercall;
=20
         fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_TBFREQ, kvmppc_get_tbfreq());
@@ -788,7 +787,6 @@ static void ibm_40p_init(MachineState *machine)
         kvmppc_get_hypercall(env, hypercall, 16);
         fw_cfg_add_bytes(fw_cfg, FW_CFG_PPC_KVM_HC, hypercall, 16);
         fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_KVM_PID, getpid());
-#endif
     } else {
         fw_cfg_add_i32(fw_cfg, FW_CFG_PPC_TBFREQ, NANOSECONDS_PER_SECOND=
);
     }
--=20
2.21.0


