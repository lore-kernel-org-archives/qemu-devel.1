Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E560C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:20:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC1D621473
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 15:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="uJIsUaFZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC1D621473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49781 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQZEE-0000e9-3j
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 11:20:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hQZCz-0008Ui-F2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:19:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hQZCs-0008Sx-Og
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:19:11 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:34834)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hQZCp-00080a-0a
	for qemu-devel@nongnu.org; Tue, 14 May 2019 11:19:05 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
	[IPv6:2a02:6b8:0:1619::119])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 20F012E14E7;
	Tue, 14 May 2019 18:18:54 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
	[2a02:6b8:0:1619::137])
	by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	W7hxY25CZm-Ir0i5hkb; Tue, 14 May 2019 18:18:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1557847134; bh=JIYxTU1jDERjZWfK/o/WdpkuNGNajsaRMO13A7vk8QI=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=uJIsUaFZRauHT7EaJaQT4fzO9pqs4uNYeaywQXC0AeSBOUzQ3FfDzUqlQOZrpJb2Y
	D5Jp2oeiruNv+g0vYUWofG2aC7RoHtLdCK3QOwgwyOS7Ppkklyrmt8Obbl8xOMFZ+S
	3ns6u7NZlobIdVHZC+YsNnutHWdPOqs+7xuADTgU=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:40c:fc64:e1ab:53e6:4177])
	by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	3bDde6lpLR-Ir8q9MYn; Tue, 14 May 2019 18:18:53 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue, 14 May 2019 18:18:48 +0300
Message-Id: <20190514151848.5677-1-yury-kotov@yandex-team.ru>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 5.45.199.163
Subject: [Qemu-devel] [PATCH v2] monitor: Fix fdset_id & fd types for
 corresponding QMP commands
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

Now, fdset_id is int64, but in some places we work with it as int.
It seems that there is no sense to use int64 for fdset_id, so it's
better to fix inconsistency by changing fdset_id type to int and by
fixing the reference of corresponding QMP commands: add-fd, remove-fd,
query-fdsets.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 include/monitor/monitor.h |  6 +++---
 monitor.c                 | 18 +++++++++---------
 qapi/misc.json            | 10 +++++-----
 stubs/fdset.c             |  4 ++--
 util/osdep.c              |  4 ++--
 vl.c                      |  2 +-
 6 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 86656297f1..06f9b6c217 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -39,11 +39,11 @@ void monitor_read_command(Monitor *mon, int show_prom=
pt);
 int monitor_read_password(Monitor *mon, ReadLineFunc *readline_func,
                           void *opaque);
=20
-AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset=
_id,
+AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int fdset_id,
                                 bool has_opaque, const char *opaque,
                                 Error **errp);
-int monitor_fdset_get_fd(int64_t fdset_id, int flags);
-int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
+int monitor_fdset_get_fd(int fdset_id, int flags);
+int monitor_fdset_dup_fd_add(int fdset_id, int dup_fd);
 void monitor_fdset_dup_fd_remove(int dup_fd);
 int monitor_fdset_dup_fd_find(int dup_fd);
=20
diff --git a/monitor.c b/monitor.c
index bb48997913..b71ce816bc 100644
--- a/monitor.c
+++ b/monitor.c
@@ -160,7 +160,7 @@ struct MonFdsetFd {
 /* file descriptor set containing fds passed via SCM_RIGHTS */
 typedef struct MonFdset MonFdset;
 struct MonFdset {
-    int64_t id;
+    int id;
     QLIST_HEAD(, MonFdsetFd) fds;
     QLIST_HEAD(, MonFdsetFd) dup_fds;
     QLIST_ENTRY(MonFdset) next;
@@ -2346,7 +2346,7 @@ static void monitor_fdsets_cleanup(void)
     qemu_mutex_unlock(&mon_fdsets_lock);
 }
=20
-AddfdInfo *qmp_add_fd(bool has_fdset_id, int64_t fdset_id, bool has_opaq=
ue,
+AddfdInfo *qmp_add_fd(bool has_fdset_id, int32_t fdset_id, bool has_opaq=
ue,
                       const char *opaque, Error **errp)
 {
     int fd;
@@ -2372,7 +2372,7 @@ error:
     return NULL;
 }
=20
-void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **er=
rp)
+void qmp_remove_fd(int32_t fdset_id, bool has_fd, int fd, Error **errp)
 {
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd;
@@ -2405,10 +2405,10 @@ void qmp_remove_fd(int64_t fdset_id, bool has_fd,=
 int64_t fd, Error **errp)
 error:
     qemu_mutex_unlock(&mon_fdsets_lock);
     if (has_fd) {
-        snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId64 ", fd:%" PR=
Id64,
+        snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId32 ", fd:%" PR=
Id32,
                  fdset_id, fd);
     } else {
-        snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId64, fdset_id);
+        snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId32, fdset_id);
     }
     error_setg(errp, QERR_FD_NOT_FOUND, fd_str);
 }
@@ -2454,7 +2454,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
     return fdset_list;
 }
=20
-AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fdset=
_id,
+AddfdInfo *monitor_fdset_add_fd(int32_t fd, bool has_fdset_id, int32_t f=
dset_id,
                                 bool has_opaque, const char *opaque,
                                 Error **errp)
 {
@@ -2476,7 +2476,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fd=
set_id, int64_t fdset_id,
     }
=20
     if (mon_fdset =3D=3D NULL) {
-        int64_t fdset_id_prev =3D -1;
+        int fdset_id_prev =3D -1;
         MonFdset *mon_fdset_cur =3D QLIST_FIRST(&mon_fdsets);
=20
         if (has_fdset_id) {
@@ -2538,7 +2538,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fd=
set_id, int64_t fdset_id,
     return fdinfo;
 }
=20
-int monitor_fdset_get_fd(int64_t fdset_id, int flags)
+int monitor_fdset_get_fd(int fdset_id, int flags)
 {
 #ifdef _WIN32
     return -ENOENT;
@@ -2576,7 +2576,7 @@ out:
 #endif
 }
=20
-int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
+int monitor_fdset_dup_fd_add(int fdset_id, int dup_fd)
 {
     MonFdset *mon_fdset;
     MonFdsetFd *mon_fdset_fd_dup;
diff --git a/qapi/misc.json b/qapi/misc.json
index 8b3ca4fdd3..b345e1458b 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2179,7 +2179,7 @@
 #
 # Since: 1.2.0
 ##
-{ 'struct': 'AddfdInfo', 'data': {'fdset-id': 'int', 'fd': 'int'} }
+{ 'struct': 'AddfdInfo', 'data': {'fdset-id': 'int32', 'fd': 'int32'} }
=20
 ##
 # @add-fd:
@@ -2209,7 +2209,7 @@
 #
 ##
 { 'command': 'add-fd',
-  'data': { '*fdset-id': 'int',
+  'data': { '*fdset-id': 'int32',
             '*opaque': 'str' },
   'returns': 'AddfdInfo' }
=20
@@ -2238,7 +2238,7 @@
 # <- { "return": {} }
 #
 ##
-{ 'command': 'remove-fd', 'data': {'fdset-id': 'int', '*fd': 'int'} }
+{ 'command': 'remove-fd', 'data': {'fdset-id': 'int32', '*fd': 'int32'} =
}
=20
 ##
 # @FdsetFdInfo:
@@ -2252,7 +2252,7 @@
 # Since: 1.2.0
 ##
 { 'struct': 'FdsetFdInfo',
-  'data': {'fd': 'int', '*opaque': 'str'} }
+  'data': {'fd': 'int32', '*opaque': 'str'} }
=20
 ##
 # @FdsetInfo:
@@ -2266,7 +2266,7 @@
 # Since: 1.2.0
 ##
 { 'struct': 'FdsetInfo',
-  'data': {'fdset-id': 'int', 'fds': ['FdsetFdInfo']} }
+  'data': {'fdset-id': 'int32', 'fds': ['FdsetFdInfo']} }
=20
 ##
 # @query-fdsets:
diff --git a/stubs/fdset.c b/stubs/fdset.c
index 4f3edf2ea4..1504624c19 100644
--- a/stubs/fdset.c
+++ b/stubs/fdset.c
@@ -2,7 +2,7 @@
 #include "qemu-common.h"
 #include "monitor/monitor.h"
=20
-int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
+int monitor_fdset_dup_fd_add(int fdset_id, int dup_fd)
 {
     return -1;
 }
@@ -12,7 +12,7 @@ int monitor_fdset_dup_fd_find(int dup_fd)
     return -1;
 }
=20
-int monitor_fdset_get_fd(int64_t fdset_id, int flags)
+int monitor_fdset_get_fd(int fdset_id, int flags)
 {
     return -ENOENT;
 }
diff --git a/util/osdep.c b/util/osdep.c
index 3f04326040..9e2d3768e0 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -292,7 +292,7 @@ int qemu_open(const char *name, int flags, ...)
=20
     /* Attempt dup of fd from fd set */
     if (strstart(name, "/dev/fdset/", &fdset_id_str)) {
-        int64_t fdset_id;
+        int fdset_id;
         int fd, dupfd;
=20
         fdset_id =3D qemu_parse_fdset(fdset_id_str);
@@ -352,7 +352,7 @@ int qemu_open(const char *name, int flags, ...)
=20
 int qemu_close(int fd)
 {
-    int64_t fdset_id;
+    int fdset_id;
=20
     /* Close fd that was dup'd from an fdset */
     fdset_id =3D monitor_fdset_dup_fd_find(fd);
diff --git a/vl.c b/vl.c
index b6709514c1..0f5622496c 100644
--- a/vl.c
+++ b/vl.c
@@ -1081,7 +1081,7 @@ bool defaults_enabled(void)
 static int parse_add_fd(void *opaque, QemuOpts *opts, Error **errp)
 {
     int fd, dupfd, flags;
-    int64_t fdset_id;
+    int fdset_id;
     const char *fd_opaque =3D NULL;
     AddfdInfo *fdinfo;
=20
--=20
2.21.0


