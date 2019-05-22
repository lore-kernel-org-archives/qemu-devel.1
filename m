Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB704C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C07DD20868
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C07DD20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47234 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTom-0003QC-0D
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:10:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTms-00028S-2N
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hTTmr-0003kH-80
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:08:18 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:54831)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hTTmh-0003CK-It; Wed, 22 May 2019 12:08:08 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MsZ3N-1gfEN10tKN-00u1Um; Wed, 22 May 2019 18:07:36 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:07:18 +0200
Message-Id: <20190522160723.31484-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190522160723.31484-1-laurent@vivier.eu>
References: <20190522160723.31484-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pelZVAYvf6bAcdi/TzvnuphvuJvZb8gP2K002+yyYudFzfaUbKN
	PwWHwqQUXmDumrsI2Tz+ssQVte5zBpCzw6gDComtbsQazy+0RhgN80zi5fc7hwbAaxPef40
	qQ0lYlZ/6sVhAcRPfzp3pXB8bX3she3Eg5vtRsLK57Noj+i/V4CitY+d0+2WTLM8Oix6I2I
	gZxerAYGYcGdC6KfvhPIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nmtVPSIdWAk=:gsrEu+6Bw1rRqXegeJ+yuY
	h0CJuDBwncxJNG9/de+in6VHsbXoaMtkSgyRLgPEQNaFeP52Tt5x4lWLKSnP9OeprYu9MURXz
	G6WPYA1OtPrQH62GtQSbfNoRVMfIryqFPRh2XxndgUzKrlqJFidsXh2RtkC258lLiKFIscdBo
	0zMf7734C5cJ6RGpi3zfoaszbUl4fgO0N/4diZ35soCdjbXYtDtBjXr2gAz4avGs88STGR7YV
	yOul0/5wdTYevvaZL3mVa+pgAf39zsAzZ4ikeuvxDoUmj14ji8QYn/haLdtcZycSuzMv+DxzZ
	dXtoLud28UGx4cgJWeotT7BlMJMvrqqWuzvegzRj8sU43ZP7rdoo1tTJETnhAc64xssW71dt+
	Gurry32bCRUEck0QGRf357rX+vp4uXVU3N9v/OIqJaCfOLHGiWj5IylhP8YpmMa08f+DgXhrl
	Vu9uWPmzsmfcusWOn4bND3v31MFjU9MuKaBOmFjlTO/JreuX5Jt3jA1qmZphcRHIREGpnFxuP
	k16+twS5nazxaMrx/CtCn4YUhzU1aKwSLxuu6OyMETWO1tSevD5bh8XE9g/WRwixK6ACgH21k
	x6BcaWwrcA85SmfeHTRGqLJuCvimfIaOy+XQ5FxXzP5/pAuKL51oT99OxIp22iLFPdUtkwoso
	mn/1qWqWyAYeHwcbjn35+RfcjRjYVL2J0lDTTlyXZT8YGIRAOkNjnJIoJXd5lW2efKgeHAmDm
	3Ew/MFL4mIfnTBSHJ+qHrUIAWB+ZynCr9/bw2g==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 4/9] migration: Fix typo in
 migrate_add_blocker() error message
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>,
	Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Alex Williamson <alex.williamson@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <155800428514.543845.17558475870097990036.stgit@bahia.lan>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index d0a0f68f11ea..2865ae3fa948 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1728,7 +1728,7 @@ int migrate_add_blocker(Error *reason, Error **errp)
     if (only_migratable) {
         error_propagate_prepend(errp, error_copy(reason),
                                 "disallowing migration blocker "
-                                "(--only_migratable) for: ");
+                                "(--only-migratable) for: ");
         return -EACCES;
     }
 
-- 
2.20.1


