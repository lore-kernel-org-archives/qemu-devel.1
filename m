Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 535C9C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268DD20675
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 15:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268DD20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3i3e-00043h-DG
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 10:11:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvL-000440-M3
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j3hvK-0007NB-7E
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 10:03:03 -0500
Received: from relay.sw.ru ([185.231.240.75]:47434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvJ-0007LE-Uy; Mon, 17 Feb 2020 10:03:02 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j3hvF-0007Zt-RG; Mon, 17 Feb 2020 18:02:57 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 13/22] qemu-iotests/199: drop extra constraints
Date: Mon, 17 Feb 2020 18:02:37 +0300
Message-Id: <20200217150246.29180-14-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200217150246.29180-1-vsementsov@virtuozzo.com>
References: <20200217150246.29180-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com,
 Max Reitz <mreitz@redhat.com>, andrey.shinkevich@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We don't need any specific format constraints here. Still keep qcow2
for two reasons:
1. No extra calls of format-unrelated test
2. Add some check around persistent bitmap in future (require qcow2)

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/199 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/199 b/tests/qemu-iotests/199
index de9ba8d94c..dda918450a 100755
--- a/tests/qemu-iotests/199
+++ b/tests/qemu-iotests/199
@@ -116,5 +116,4 @@ class TestDirtyBitmapPostcopyMigration(iotests.QMPTestCase):
 
 
 if __name__ == '__main__':
-    iotests.main(supported_fmts=['qcow2'], supported_cache_modes=['none'],
-                 supported_protocols=['file'])
+    iotests.main(supported_fmts=['qcow2'])
-- 
2.21.0


