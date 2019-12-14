Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE65DC2D0CB
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 22:48:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B762D20724
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 22:48:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B762D20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=infinera.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igGD5-00030h-RE
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 17:48:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41522)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jocke@infinera.com>) id 1igFGk-0002PU-Kh
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:48:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jocke@infinera.com>) id 1igFGj-0008Dc-2H
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:48:09 -0500
Received: from [31.15.61.139] (port=58558 helo=smtp.transmode.se)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <jocke@infinera.com>) id 1igFGi-0007rd-QW
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:48:08 -0500
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com
 [10.210.71.11])
 by smtp.transmode.se (Postfix) with ESMTP id B996B118C7DA;
 Sat, 14 Dec 2019 13:19:11 +0100 (CET)
Received: from gentoo-jocke.infinera.com (gentoo-jocke.infinera.com
 [127.0.0.1])
 by gentoo-jocke.infinera.com (8.15.2/8.14.9) with ESMTP id xBECDnLX017189;
 Sat, 14 Dec 2019 13:13:49 +0100
Received: (from jocke@localhost)
 by gentoo-jocke.infinera.com (8.15.2/8.15.2/Submit) id xBECDnT7017188;
 Sat, 14 Dec 2019 13:13:49 +0100
From: Joakim Tjernlund <joakim.tjernlund@infinera.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] ppc: remove excessive logging
Date: Sat, 14 Dec 2019 13:13:47 +0100
Message-Id: <20191214121347.17071-1-joakim.tjernlund@infinera.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 31.15.61.139
X-Mailman-Approved-At: Sat, 14 Dec 2019 17:47:43 -0500
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
Cc: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>

ppc logs every type of Invalid instruction. This generates a lot
of garbage on console when sshd/ssh_keygen executes as
they try various insn to optimize its performance.
The invalid operation log is still there so an unknown insn
will still be logged.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
---

	As far as I can see, ppc is the only one emiting thsi
	debug msg for Invalid insns.

target/ppc/excp_helper.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 50b004d00d..45c2fa3ff9 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -326,7 +326,6 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
             env->spr[SPR_BOOKE_ESR] =3D ESR_FP;
             break;
         case POWERPC_EXCP_INVAL:
-            LOG_EXCP("Invalid instruction at " TARGET_FMT_lx "\n", env->=
nip);
             msr |=3D 0x00080000;
             env->spr[SPR_BOOKE_ESR] =3D ESR_PIL;
             break;
--=20
2.24.1


