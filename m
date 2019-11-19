Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1C1C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A88B6208CC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="k0pGrV5t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A88B6208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX1N0-0001bU-SR
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 06:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1iX1Lw-0008QE-Iq
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:07:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yury-kotov@yandex-team.ru>) id 1iX1Lt-0006Z4-E5
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:07:22 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:42962)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
 id 1iX1Lr-0006VF-Mi; Tue, 19 Nov 2019 06:07:21 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 3597A2E14AB;
 Tue, 19 Nov 2019 14:07:14 +0300 (MSK)
Received: from iva4-c987840161f8.qloud-c.yandex.net
 (iva4-c987840161f8.qloud-c.yandex.net [2a02:6b8:c0c:3da5:0:640:c987:8401])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 VO2TDAzMyt-7DJqCYZQ; Tue, 19 Nov 2019 14:07:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1574161634; bh=HrCcSpLJG9L8gXmV5hNBmH/yRn0z5OXCyYhqzp8ItS0=;
 h=Message-Id:Date:Subject:To:From:Cc;
 b=k0pGrV5tS39Xb6YzVgZ4T30m7ZNbBmgx5/vL/J9hGr/3PrXtkDcVIgh6spfrkIjHc
 P4pTcBf76yfAAPGjaROS4h1UUSGyaP+HrXTOT2Fsx9goKQXnjjiZjNSZ7HJHduTWGm
 BDCSO5TV7UElkK+qVtu0hVBo9sad2Nlv/jbeBWiE=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:408:a563:bec5:6346:ec71])
 by iva4-c987840161f8.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 92QNE4iRjf-7DWqLRrr; Tue, 19 Nov 2019 14:07:13 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH] monitor: Remove unused define
Date: Tue, 19 Nov 2019 14:07:09 +0300
Message-Id: <20191119110709.13827-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.45.199.163
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
Cc: qemu-trivial@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Remove the definition of QMP_ACCEPT_UNKNOWNS as it is unused since
refactoring 5c678ee8d940

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 monitor/misc.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/monitor/misc.c b/monitor/misc.c
index 3baa15f3bf..6680734ea1 100644
--- a/monitor/misc.c
+++ b/monitor/misc.c
@@ -106,9 +106,6 @@ struct MonFdset {
     QLIST_ENTRY(MonFdset) next;
 };
=20
-/* QMP checker flags */
-#define QMP_ACCEPT_UNKNOWNS 1
-
 /* Protects mon_fdsets */
 static QemuMutex mon_fdsets_lock;
 static QLIST_HEAD(, MonFdset) mon_fdsets;
--=20
2.24.0


