Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA8EC31E47
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 08:14:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 866D42084D
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 08:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 866D42084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hc3pF-0006Yd-KU
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 04:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49618)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hc3oE-00060B-Es
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 04:13:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hc3oD-0006O7-Ee
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 04:13:10 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:34806)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hc3oD-0006MV-7J
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 04:13:09 -0400
Received: from player738.ha.ovh.net (unknown [10.109.146.19])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 5DBF9135878
 for <qemu-devel@nongnu.org>; Sat, 15 Jun 2019 10:13:06 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id CB4886FD0F74;
 Sat, 15 Jun 2019 08:13:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Sat, 15 Jun 2019 10:12:52 +0200
Message-Id: <20190615081252.28602-1-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 12146208196532866022
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeifecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.56.76
Subject: [Qemu-devel] [PATCH] target/ppc: fix compile error in
 kvmppc_define_rtas_kernel_token()
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

gcc9 reports :

In file included from /usr/include/string.h:494,
                 from ./include/qemu/osdep.h:101,
                 from ./target/ppc/kvm.c:17:
In function =E2=80=98strncpy=E2=80=99,
    inlined from =E2=80=98kvmppc_define_rtas_kernel_token=E2=80=99 at ./t=
arget/ppc/kvm.c:2648:5:
/usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin_st=
rncpy=E2=80=99 specified bound 120 equals destination size [-Werror=3Dstr=
ingop-truncation]
  106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos (__=
dest));
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 target/ppc/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d4107dd70d21..9edf4abeaae7 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2645,7 +2645,7 @@ int kvmppc_define_rtas_kernel_token(uint32_t token,=
 const char *function)
         return -ENOENT;
     }
=20
-    strncpy(args.name, function, sizeof(args.name));
+    strncpy(args.name, function, sizeof(args.name) - 1);
=20
     return kvm_vm_ioctl(kvm_state, KVM_PPC_RTAS_DEFINE_TOKEN, &args);
 }
--=20
2.21.0


