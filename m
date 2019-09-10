Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D17C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A5A2089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A5A2089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kamp.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7iI6-0003XE-05
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pl@kamp.de>) id 1i7iGZ-0002FR-O2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:41:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pl@kamp.de>) id 1i7iGY-0004RD-H4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:41:15 -0400
Received: from kerio.kamp.de ([195.62.97.192]:60396)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pl@kamp.de>) id 1i7iGY-0004Po-3W
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:41:14 -0400
X-Footer: a2FtcC5kZQ==
Received: from submission.kamp.de ([195.62.97.28]) by kerio.kamp.de with ESMTPS
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256 bits))
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 17:41:08 +0200
Received: (qmail 7082 invoked from network); 10 Sep 2019 15:41:11 -0000
Received: from lieven-pc.kamp-intra.net (HELO lieven-pc)
 (relay@kamp.de@::ffff:172.21.12.60)
 by submission.kamp.de with ESMTPS (DHE-RSA-AES256-GCM-SHA384 encrypted) ESMTPA;
 10 Sep 2019 15:41:11 -0000
Received: by lieven-pc (Postfix, from userid 1060)
 id 7CF2813D878; Tue, 10 Sep 2019 17:41:11 +0200 (CEST)
From: Peter Lieven <pl@kamp.de>
To: qemu-block@nongnu.org
Date: Tue, 10 Sep 2019 17:41:10 +0200
Message-Id: <20190910154110.6905-3-pl@kamp.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190910154110.6905-1-pl@kamp.de>
References: <20190910154110.6905-1-pl@kamp.de>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 195.62.97.192
Subject: [Qemu-devel] [PATCH V2 2/2] block/nfs: add support for nfs_umount
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
Cc: kwolf@redhat.com, Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 ronniesahlberg@gmail.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

libnfs recently added support for unmounting. Add support
in Qemu too.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/nfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/nfs.c b/block/nfs.c
index 2c98508275..f39acfdb28 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -398,6 +398,9 @@ static void nfs_client_close(NFSClient *client)
             nfs_close(client->context, client->fh);
             client->fh = NULL;
         }
+#ifdef LIBNFS_FEATURE_UMOUNT
+        nfs_umount(client->context);
+#endif
         nfs_destroy_context(client->context);
         client->context = NULL;
     }
-- 
2.17.1



