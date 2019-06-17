Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A8F1C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:10:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE3020863
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 19:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE3020863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcx0y-00053Z-Rj
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 15:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40413)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hcwh1-0001bI-J7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hcwh0-0007s8-Dv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25982)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hcwh0-0007jq-3x
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 14:49:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 27554285B4;
 Mon, 17 Jun 2019 18:49:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-177.ams2.redhat.com
 [10.36.117.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C32E880EB;
 Mon, 17 Jun 2019 18:49:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5358911386A7; Mon, 17 Jun 2019 20:49:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 20:48:48 +0200
Message-Id: <20190617184903.19436-2-armbru@redhat.com>
In-Reply-To: <20190617184903.19436-1-armbru@redhat.com>
References: <20190617184903.19436-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 17 Jun 2019 18:49:05 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 01/16] monitor: Fix return type of
 monitor_fdset_dup_fd_find
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
Cc: Yury Kotov <yury-kotov@yandex-team.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yury Kotov <yury-kotov@yandex-team.ru>

monitor_fdset_dup_fd_find_remove() and monitor_fdset_dup_fd_find()
return mon_fdset->id which is int64_t. Downcasting from int64_t to int
leads to a bug with removing fd from fdset with id >=3D 2^32.
So, fix return types for these function.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190523094433.30297-1-yury-kotov@yandex-team.ru>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/monitor/monitor.h | 2 +-
 monitor.c                 | 4 ++--
 stubs/fdset.c             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 06cfcd8f36..1e1d6d2269 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -44,6 +44,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_=
id, int64_t fdset_id,
 int monitor_fdset_get_fd(int64_t fdset_id, int flags);
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
-int monitor_fdset_dup_fd_find(int dup_fd);
+int64_t monitor_fdset_dup_fd_find(int dup_fd);
=20
 #endif /* MONITOR_H */
diff --git a/monitor.c b/monitor.c
index 5c5cbe254a..dce3496920 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2604,7 +2604,7 @@ err:
     return -1;
 }
=20
-static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
+static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
 {
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;
@@ -2632,7 +2632,7 @@ err:
     return -1;
 }
=20
-int monitor_fdset_dup_fd_find(int dup_fd)
+int64_t monitor_fdset_dup_fd_find(int dup_fd)
 {
     return monitor_fdset_dup_fd_find_remove(dup_fd, false);
 }
diff --git a/stubs/fdset.c b/stubs/fdset.c
index f3d9980b7e..67dd5e1d34 100644
--- a/stubs/fdset.c
+++ b/stubs/fdset.c
@@ -6,7 +6,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd=
)
     return -1;
 }
=20
-int monitor_fdset_dup_fd_find(int dup_fd)
+int64_t monitor_fdset_dup_fd_find(int dup_fd)
 {
     return -1;
 }
--=20
2.21.0


