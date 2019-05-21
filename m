Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF0AC04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:09:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B2FD2173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="bVZVl2hL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B2FD2173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56350 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT7KN-0001di-JR
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 12:09:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hT7JY-0001KS-1s
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hT7JW-00067Y-LH
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:08:32 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1hT7JV-00065h-SC
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:08:30 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::301])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 9853C2E14A8;
	Tue, 21 May 2019 19:08:25 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	VW4U5Cw7gO-8PTOXLQ4; Tue, 21 May 2019 19:08:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1558454905; bh=tLytgOnH4vl11syyMWhejkrHe9vsVtChuW6zP1Y+8xQ=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=bVZVl2hL6CR970YB8SwIDGoZkeOEBnRVweqpqrSuduDOOHcqVjEWlqcUJlOAu5t8t
	+JE57biA4BSRWzyqfjngAJDM625J1lVLswFhpWIOern08D6oesWCjGRLwCGee6h5hW
	G7uVYaIEMHV21QWAoQ7qesF0xGBd31+ZoI8U9nDk=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
	[2a02:6b8:0:1a2d::301])
	by dlvcorp1j.mail.yandex.net with LMTP id ZBETsImKiD-mMpmYXH0
	for <yury-kotov@yandex-team.ru>; Tue, 21 May 2019 19:08:14 +0300
Received: by iva6-8a76e93b6298.qloud-c.yandex.net with HTTP;
	Tue, 21 May 2019 19:08:14 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
In-Reply-To: <20190514151848.5677-1-yury-kotov@yandex-team.ru>
References: <20190514151848.5677-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Tue, 21 May 2019 19:08:24 +0300
Message-Id: <221851558454894@iva6-8a76e93b6298.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 77.88.29.217
Subject: Re: [Qemu-devel] [PATCH v2] monitor: Fix fdset_id & fd types for
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

Ping

14.05.2019, 18:20, "Yury Kotov" <yury-kotov@yandex-team.ru>:
> Now, fdset_id is int64, but in some places we work with it as int.
> It seems that there is no sense to use int64 for fdset_id, so it's
> better to fix inconsistency by changing fdset_id type to int and by
> fixing the reference of corresponding QMP commands: add-fd, remove-fd,
> query-fdsets.
>
> Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> ---
> =C2=A0include/monitor/monitor.h | 6 +++---
> =C2=A0monitor.c | 18 +++++++++---------
> =C2=A0qapi/misc.json | 10 +++++-----
> =C2=A0stubs/fdset.c | 4 ++--
> =C2=A0util/osdep.c | 4 ++--
> =C2=A0vl.c | 2 +-
> =C2=A06 files changed, 22 insertions(+), 22 deletions(-)
>
> diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
> index 86656297f1..06f9b6c217 100644
> --- a/include/monitor/monitor.h
> +++ b/include/monitor/monitor.h
> @@ -39,11 +39,11 @@ void monitor_read_command(Monitor *mon, int show_pr=
ompt);
> =C2=A0int monitor_read_password(Monitor *mon, ReadLineFunc *readline_fu=
nc,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0void *opaque);
>
> -AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fds=
et_id,
> +AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int fdset_i=
d,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool has_opaque, const=
 char *opaque,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error **errp);
> -int monitor_fdset_get_fd(int64_t fdset_id, int flags);
> -int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
> +int monitor_fdset_get_fd(int fdset_id, int flags);
> +int monitor_fdset_dup_fd_add(int fdset_id, int dup_fd);
> =C2=A0void monitor_fdset_dup_fd_remove(int dup_fd);
> =C2=A0int monitor_fdset_dup_fd_find(int dup_fd);
>
> diff --git a/monitor.c b/monitor.c
> index bb48997913..b71ce816bc 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -160,7 +160,7 @@ struct MonFdsetFd {
> =C2=A0/* file descriptor set containing fds passed via SCM_RIGHTS */
> =C2=A0typedef struct MonFdset MonFdset;
> =C2=A0struct MonFdset {
> - int64_t id;
> + int id;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QLIST_HEAD(, MonFdsetFd) fds;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QLIST_HEAD(, MonFdsetFd) dup_fds;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QLIST_ENTRY(MonFdset) next;
> @@ -2346,7 +2346,7 @@ static void monitor_fdsets_cleanup(void)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_unlock(&mon_fdsets_lock);
> =C2=A0}
>
> -AddfdInfo *qmp_add_fd(bool has_fdset_id, int64_t fdset_id, bool has_op=
aque,
> +AddfdInfo *qmp_add_fd(bool has_fdset_id, int32_t fdset_id, bool has_op=
aque,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const c=
har *opaque, Error **errp)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int fd;
> @@ -2372,7 +2372,7 @@ error:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return NULL;
> =C2=A0}
>
> -void qmp_remove_fd(int64_t fdset_id, bool has_fd, int64_t fd, Error **=
errp)
> +void qmp_remove_fd(int32_t fdset_id, bool has_fd, int fd, Error **errp=
)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdset *mon_fdset;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdsetFd *mon_fdset_fd;
> @@ -2405,10 +2405,10 @@ void qmp_remove_fd(int64_t fdset_id, bool has_f=
d, int64_t fd, Error **errp)
> =C2=A0error:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qemu_mutex_unlock(&mon_fdsets_lock);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (has_fd) {
> - snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId64 ", fd:%" PRId64,
> + snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId32 ", fd:%" PRId32,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fdset_id, fd);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> - snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId64, fdset_id);
> + snprintf(fd_str, sizeof(fd_str), "fdset-id:%" PRId32, fdset_id);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_setg(errp, QERR_FD_NOT_FOUND, fd_st=
r);
> =C2=A0}
> @@ -2454,7 +2454,7 @@ FdsetInfoList *qmp_query_fdsets(Error **errp)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return fdset_list;
> =C2=A0}
>
> -AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdset_id, int64_t fds=
et_id,
> +AddfdInfo *monitor_fdset_add_fd(int32_t fd, bool has_fdset_id, int32_t=
 fdset_id,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool has_opaque, const=
 char *opaque,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Error **errp)
> =C2=A0{
> @@ -2476,7 +2476,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_=
fdset_id, int64_t fdset_id,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mon_fdset =3D=3D NULL) {
> - int64_t fdset_id_prev =3D -1;
> + int fdset_id_prev =3D -1;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdset *mon_fds=
et_cur =3D QLIST_FIRST(&mon_fdsets);
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (has_fdset_id)=
 {
> @@ -2538,7 +2538,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_=
fdset_id, int64_t fdset_id,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return fdinfo;
> =C2=A0}
>
> -int monitor_fdset_get_fd(int64_t fdset_id, int flags)
> +int monitor_fdset_get_fd(int fdset_id, int flags)
> =C2=A0{
> =C2=A0#ifdef _WIN32
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOENT;
> @@ -2576,7 +2576,7 @@ out:
> =C2=A0#endif
> =C2=A0}
>
> -int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
> +int monitor_fdset_dup_fd_add(int fdset_id, int dup_fd)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdset *mon_fdset;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0MonFdsetFd *mon_fdset_fd_dup;
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 8b3ca4fdd3..b345e1458b 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2179,7 +2179,7 @@
> =C2=A0#
> =C2=A0# Since: 1.2.0
> =C2=A0##
> -{ 'struct': 'AddfdInfo', 'data': {'fdset-id': 'int', 'fd': 'int'} }
> +{ 'struct': 'AddfdInfo', 'data': {'fdset-id': 'int32', 'fd': 'int32'} =
}
>
> =C2=A0##
> =C2=A0# @add-fd:
> @@ -2209,7 +2209,7 @@
> =C2=A0#
> =C2=A0##
> =C2=A0{ 'command': 'add-fd',
> - 'data': { '*fdset-id': 'int',
> + 'data': { '*fdset-id': 'int32',
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0'*opaque': 'str' },
> =C2=A0=C2=A0=C2=A0'returns': 'AddfdInfo' }
>
> @@ -2238,7 +2238,7 @@
> =C2=A0# <- { "return": {} }
> =C2=A0#
> =C2=A0##
> -{ 'command': 'remove-fd', 'data': {'fdset-id': 'int', '*fd': 'int'} }
> +{ 'command': 'remove-fd', 'data': {'fdset-id': 'int32', '*fd': 'int32'=
} }
>
> =C2=A0##
> =C2=A0# @FdsetFdInfo:
> @@ -2252,7 +2252,7 @@
> =C2=A0# Since: 1.2.0
> =C2=A0##
> =C2=A0{ 'struct': 'FdsetFdInfo',
> - 'data': {'fd': 'int', '*opaque': 'str'} }
> + 'data': {'fd': 'int32', '*opaque': 'str'} }
>
> =C2=A0##
> =C2=A0# @FdsetInfo:
> @@ -2266,7 +2266,7 @@
> =C2=A0# Since: 1.2.0
> =C2=A0##
> =C2=A0{ 'struct': 'FdsetInfo',
> - 'data': {'fdset-id': 'int', 'fds': ['FdsetFdInfo']} }
> + 'data': {'fdset-id': 'int32', 'fds': ['FdsetFdInfo']} }
>
> =C2=A0##
> =C2=A0# @query-fdsets:
> diff --git a/stubs/fdset.c b/stubs/fdset.c
> index 4f3edf2ea4..1504624c19 100644
> --- a/stubs/fdset.c
> +++ b/stubs/fdset.c
> @@ -2,7 +2,7 @@
> =C2=A0#include "qemu-common.h"
> =C2=A0#include "monitor/monitor.h"
>
> -int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd)
> +int monitor_fdset_dup_fd_add(int fdset_id, int dup_fd)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> =C2=A0}
> @@ -12,7 +12,7 @@ int monitor_fdset_dup_fd_find(int dup_fd)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -1;
> =C2=A0}
>
> -int monitor_fdset_get_fd(int64_t fdset_id, int flags)
> +int monitor_fdset_get_fd(int fdset_id, int flags)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOENT;
> =C2=A0}
> diff --git a/util/osdep.c b/util/osdep.c
> index 3f04326040..9e2d3768e0 100644
> --- a/util/osdep.c
> +++ b/util/osdep.c
> @@ -292,7 +292,7 @@ int qemu_open(const char *name, int flags, ...)
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Attempt dup of fd from fd set */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (strstart(name, "/dev/fdset/", &fdset_=
id_str)) {
> - int64_t fdset_id;
> + int fdset_id;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int fd, dupfd;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fdset_id =3D qemu=
_parse_fdset(fdset_id_str);
> @@ -352,7 +352,7 @@ int qemu_open(const char *name, int flags, ...)
>
> =C2=A0int qemu_close(int fd)
> =C2=A0{
> - int64_t fdset_id;
> + int fdset_id;
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Close fd that was dup'd from an fdset =
*/
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fdset_id =3D monitor_fdset_dup_fd_find(fd=
);
> diff --git a/vl.c b/vl.c
> index b6709514c1..0f5622496c 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1081,7 +1081,7 @@ bool defaults_enabled(void)
> =C2=A0static int parse_add_fd(void *opaque, QemuOpts *opts, Error **err=
p)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int fd, dupfd, flags;
> - int64_t fdset_id;
> + int fdset_id;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0const char *fd_opaque =3D NULL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0AddfdInfo *fdinfo;
>
> --
> 2.21.0

