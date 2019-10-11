Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1F2C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE310206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 21:43:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE310206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ2h3-0001lQ-If
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 17:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1iJ2Ro-0003no-H7
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1iJ2Rn-0001T3-88
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 17:27:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46388)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1iJ2Rk-0001RK-2u; Fri, 11 Oct 2019 17:27:36 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4C40418C428E;
 Fri, 11 Oct 2019 21:27:35 +0000 (UTC)
Received: from probe.bos.redhat.com (dhcp-17-173.bos.redhat.com [10.18.17.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E71631EC;
 Fri, 11 Oct 2019 21:27:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 18/19] MAINTAINERS: Add Vladimir as a reviewer for bitmaps
Date: Fri, 11 Oct 2019 17:25:49 -0400
Message-Id: <20191011212550.27269-19-jsnow@redhat.com>
In-Reply-To: <20191011212550.27269-1-jsnow@redhat.com>
References: <20191011212550.27269-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Fri, 11 Oct 2019 21:27:35 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 John Snow <jsnow@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I already try to make sure all bitmaps patches have been reviewed by both
Red Hat and Virtuozzo anyway, so this formalizes the arrangement.

Fam meanwhile is no longer as active, so I am removing him as a co-mainta=
iner
simply to reflect the current practice.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20191005194448.16629-2-jsnow@redhat.com
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3ca814850e0..a08c92a4162 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1816,8 +1816,8 @@ F: qapi/transaction.json
 T: git https://repo.or.cz/qemu/armbru.git block-next
=20
 Dirty Bitmaps
-M: Fam Zheng <fam@euphon.net>
 M: John Snow <jsnow@redhat.com>
+R: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: util/hbitmap.c
@@ -1826,7 +1826,6 @@ F: include/qemu/hbitmap.h
 F: include/block/dirty-bitmap.h
 F: tests/test-hbitmap.c
 F: docs/interop/bitmaps.rst
-T: git https://github.com/famz/qemu.git bitmaps
 T: git https://github.com/jnsnow/qemu.git bitmaps
=20
 Character device backends
--=20
2.21.0


