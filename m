Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54073C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:20:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A97520684
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A97520684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Pxg-0006OV-BQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUz-0007PI-TD
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:51:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8PUy-0003Jd-Ul
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:51:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47964)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8PUy-0003ID-Pe
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:51:00 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 205112A09B3;
 Thu, 12 Sep 2019 13:51:00 +0000 (UTC)
Received: from dgilbert-t580.localhost (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BC7935D704;
 Thu, 12 Sep 2019 13:50:58 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, ivanren@tencent.com, peterx@redhat.com,
 richardw.yang@linux.intel.com, yury-kotov@yandex-team.ru,
 quintela@redhat.com
Date: Thu, 12 Sep 2019 14:50:06 +0100
Message-Id: <20190912135006.14820-13-dgilbert@redhat.com>
In-Reply-To: <20190912135006.14820-1-dgilbert@redhat.com>
References: <20190912135006.14820-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 12 Sep 2019 13:51:00 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 12/12] migration: fix one typo in comment of
 function migration_total_bytes()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190912024957.11780-1-richardw.yang@linux.intel.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index e45270c23b..01863a95f5 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3025,7 +3025,7 @@ static MigThrError migration_detect_error(Migration=
State *s)
     }
 }
=20
-/* How many bytes have we transferred since the beggining of the migrati=
on */
+/* How many bytes have we transferred since the beginning of the migrati=
on */
 static uint64_t migration_total_bytes(MigrationState *s)
 {
     return qemu_ftell(s->to_dst_file) + ram_counters.multifd_bytes;
--=20
2.21.0


