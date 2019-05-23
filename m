Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6266C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:46:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C48C20862
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 09:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="fSHGoPNt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C48C20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60875 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTkIW-0006Fe-QS
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 05:46:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hTkHJ-0005a4-68
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hTkHI-0007JN-8l
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:44:49 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:47694)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1hTkHI-0007IN-2k
	for qemu-devel@nongnu.org; Thu, 23 May 2019 05:44:48 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 3029C2E0AF3;
	Thu, 23 May 2019 12:44:44 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
	[2a02:6b8:0:1619::137])
	by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	v7QKV5QSmA-ih5isQT1; Thu, 23 May 2019 12:44:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1558604684; bh=SI0jxpLyVqp6a2uHfKYSeiX7vKJYR+MCO0k9TYvwkno=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=fSHGoPNtiqavFlkTxayfj7Rygy8eXW6cD7KqszxKVL7+dhXshywRSryjaifgJbfOk
	PYjEqnIXHRNSb8amCqHYHN3nY/kreGcsabDpUvPf6tuHyV7SCMHHxTBBFgmkuHbV8V
	mvk2M8/4XDJJC7irT8sgEHF2LxZf0EYoK4LX/Gm0=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:d05b:c3b5:9878:7629])
	by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	a66T7ncC5r-ih80rIK3; Thu, 23 May 2019 12:44:43 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
	qemu-devel@nongnu.org
Date: Thu, 23 May 2019 12:44:33 +0300
Message-Id: <20190523094433.30297-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [PATCH v3] monitor: Fix return type of
 monitor_fdset_dup_fd_find
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

monitor_fdset_dup_fd_find_remove() and monitor_fdset_dup_fd_find()
return mon_fdset->id which is int64_t. Downcasting from int64_t to int
leads to a bug with removing fd from fdset with id >=3D 2^32.
So, fix return types for these function.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 include/monitor/monitor.h | 2 +-
 monitor.c                 | 4 ++--
 stubs/fdset.c             | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 86656297f1..51f048d61f 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -45,6 +45,6 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_=
id, int64_t fdset_id,
 int monitor_fdset_get_fd(int64_t fdset_id, int flags);
 int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
-int monitor_fdset_dup_fd_find(int dup_fd);
+int64_t monitor_fdset_dup_fd_find(int dup_fd);
=20
 #endif /* MONITOR_H */
diff --git a/monitor.c b/monitor.c
index 6428eb3b7e..a0e637f7d6 100644
--- a/monitor.c
+++ b/monitor.c
@@ -2602,7 +2602,7 @@ err:
     return -1;
 }
=20
-static int monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
+static int64_t monitor_fdset_dup_fd_find_remove(int dup_fd, bool remove)
 {
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;
@@ -2630,7 +2630,7 @@ err:
     return -1;
 }
=20
-int monitor_fdset_dup_fd_find(int dup_fd)
+int64_t monitor_fdset_dup_fd_find(int dup_fd)
 {
     return monitor_fdset_dup_fd_find_remove(dup_fd, false);
 }
diff --git a/stubs/fdset.c b/stubs/fdset.c
index 4f3edf2ea4..a1b8f41f62 100644
--- a/stubs/fdset.c
+++ b/stubs/fdset.c
@@ -7,7 +7,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd=
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


