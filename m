Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D77FC742BE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:19:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC192080A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC192080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=weilnetz.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlvSs-0001VD-T6
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51391)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan@weilnetz.de>) id 1hlvSi-0000zh-Dw
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan@weilnetz.de>) id 1hlvSh-0001w1-Gk
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:19:44 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:40766
 helo=v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan@weilnetz.de>)
 id 1hlvSh-0001qL-A2; Fri, 12 Jul 2019 09:19:43 -0400
Received: from localhost (localhost [127.0.0.1])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id 456ACDB8610;
 Fri, 12 Jul 2019 15:19:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at v2201612906741603.powersrv.de
Received: from v2201612906741603.powersrv.de ([127.0.0.1])
 by localhost (v2201612906741603.powersrv.de [127.0.0.1]) (amavisd-new,
 port 10024)
 with ESMTP id n-s2BzO9AzIU; Fri, 12 Jul 2019 15:19:38 +0200 (CEST)
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by v2201612906741603.powersrv.de (Postfix) with ESMTP id 9AB3BDB8602;
 Fri, 12 Jul 2019 15:19:38 +0200 (CEST)
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id 93A5946004F; Fri, 12 Jul 2019 15:19:38 +0200 (CEST)
From: Stefan Weil <sw@weilnetz.de>
To: qemu-devel@nongnu.org
Date: Fri, 12 Jul 2019 15:19:27 +0200
Message-Id: <20190712131927.15091-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 37.120.169.71
Subject: [Qemu-devel] [PATCH] Remove old global variable smp_cpus
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
Cc: qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 include/sysemu/sysemu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 984c439ac9..9b849cb770 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -103,7 +103,6 @@ extern const char *keyboard_layout;
 extern int win2k_install_hack;
 extern int alt_grab;
 extern int ctrl_grab;
-extern int smp_cpus;
 extern unsigned int max_cpus;
 extern int cursor_hide;
 extern int graphic_rotate;
--=20
2.20.1


