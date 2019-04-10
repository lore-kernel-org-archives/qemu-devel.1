Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AA8C10F14
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:17:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF1B20850
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 14:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="axX3AXTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF1B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60534 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEE2o-0000Vs-Q5
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 10:17:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEE1q-0000Bh-TA
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:16:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEE1p-000383-M0
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:16:42 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:45872)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hEE1p-000368-0D
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:16:41 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net
	[IPv6:2a02:6b8:0:1402::301])
	by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id B0D192E0988;
	Wed, 10 Apr 2019 17:16:36 +0300 (MSK)
Received: from localhost (localhost [::1])
	by mxbackcorp1g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	7s1sfVvPka-GaoC05Ll; Wed, 10 Apr 2019 17:16:36 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1554905796; bh=pLCblJK7JMtkP/ZJdQUH3E78OTZKxUVb5Luv7WeYwbo=;
	h=Subject:In-Reply-To:Cc:Date:References:To:From:Message-Id;
	b=axX3AXTaJLsx0XEYJ/mMO61ku1FvBXlFa64vUQKHx9Kl6Fgt4K5uUtd36iKtrZ2U6
	jTCMXVBcqm5f1Xbtk+O/U+OGoYem0rm6XBbg/HuI7j0NFuJRCHS6BOH0/7c3Oyjczi
	ZbP1slB2VDEfM7WTaPD40kzCPgBm0FrOwHozWrTM=
Authentication-Results: mxbackcorp1g.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
X-Yandex-Sender-Uid: 1120000000071945
X-Yandex-Avir: 1
Received: from mxbackcorp1g.mail.yandex.net ([::1])
	by mxbackcorp1g.mail.yandex.net with LMTP id EbidXToZ
	for <yury-kotov@yandex-team.ru>; Wed, 10 Apr 2019 17:16:31 +0300
Received: by vla1-1374b6242101.qloud-c.yandex.net with HTTP;
	Wed, 10 Apr 2019 17:16:31 +0300
From: Yury Kotov <yury-kotov@yandex-team.ru>
To: Dr. David Alan Gilbert <dgilbert@redhat.com>,
	"armbru@redhat.com" <armbru@redhat.com>,
	"berrange@redhat.com" <berrange@redhat.com>
In-Reply-To: <20190410135725.GE2980@work-vm>
References: <20190410092652.22616-1-yury-kotov@yandex-team.ru>
	<20190410135725.GE2980@work-vm>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Wed, 10 Apr 2019 17:16:36 +0300
Message-Id: <8551554905791@vla1-1374b6242101.qloud-c.yandex.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 5.45.199.163
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
	Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410141636.j2YDqTcO-8GhcVLDubcYiwB96PHtZJSGrBun1_U4Uj0@z>

Hi,

10.04.2019, 16:58, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0Currently such case is possible for incoming:
>> =C2=A0QMP: add-fd (fdset =3D 0, fd of some file):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0adds fd to fdset 0 and returns QEMU's fd=
 (e.g. 33)
>> =C2=A0QMP: migrate-incoming (uri =3D "fd:33"): fd is stored in QIOChan=
nel *ioc
>> =C2=A0...
>> =C2=A0Incoming migration completes and unrefs ioc -> close(33)
>> =C2=A0QMP: remove-fd (fdset =3D 0, fd =3D 33):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0removes fd from fdset 0 and qemu_close()=
 -> close(33) =3D> double close
>
> Well spotted! That would very rarely cause a problem, but is a race.
>

Actually, it hits for incoming case on 2 of 50 VMs on our production...

>> =C2=A0For outgoing migration the case is the same but getfd instead of=
 add-fd.
>> =C2=A0Fix it by duping client's fd.
>>
>> =C2=A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
>
> Note your patch hit a problem building on windows; I don't think we hav=
e
> a qemu_dup for windows.
>

Oh, I see... I'll add an ifdef for this in v2.

> However, I think this problem is wider than just migration.
> For example, I see that dump.c also uses monitor_get_fd, and it's
> dump_cleanup also does a close on the fd. So I guess it hits the same
> problem?
> Also, qmp.c in qmp_add_client does a close on the fd in some error case=
s
> (I've not followed the normal case).
>
> So perhaps all the users of monitor_get_fd are hitting this problem.
>
> Should we be doing the dup in monitor_get_fd?
>

Hmm, it sounds reasonable but Windows's case will remain broken.
And also using fd from fdset without qemu_open will remain broken.

Another way to fix them:
1) Add searching of monitor's fds and not duped fdset's fds to qemu_close
2) Replace broken closes to qemu_close

Regards,
Yury Kotov

> Dave
>
>> =C2=A0---
>> =C2=A0=C2=A0migration/fd.c | 39 +++++++++++++++++++++++++++++++-------=
-
>> =C2=A0=C2=A0migration/trace-events | 4 ++--
>> =C2=A0=C2=A02 files changed, 33 insertions(+), 10 deletions(-)
>>
>> =C2=A0diff --git a/migration/fd.c b/migration/fd.c
>> =C2=A0index a7c13df4ad..c9ff07ac41 100644
>> =C2=A0--- a/migration/fd.c
>> =C2=A0+++ b/migration/fd.c
>> =C2=A0@@ -15,6 +15,7 @@
>> =C2=A0=C2=A0=C2=A0*/
>>
>> =C2=A0=C2=A0#include "qemu/osdep.h"
>> =C2=A0+#include "qapi/error.h"
>> =C2=A0=C2=A0#include "channel.h"
>> =C2=A0=C2=A0#include "fd.h"
>> =C2=A0=C2=A0#include "migration.h"
>> =C2=A0@@ -26,15 +27,27 @@
>> =C2=A0=C2=A0void fd_start_outgoing_migration(MigrationState *s, const =
char *fdname, Error **errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc;
>> =C2=A0- int fd =3D monitor_get_fd(cur_mon, fdname, errp);
>> =C2=A0+ int fd, dup_fd;
>> =C2=A0+
>> =C2=A0+ fd =3D monitor_get_fd(cur_mon, fdname, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (fd =3D=3D -1) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0- trace_migration_fd_outgoing(fd);
>> =C2=A0- ioc =3D qio_channel_new_fd(fd, errp);
>> =C2=A0+ /* fd is previously created by qmp command 'getfd',
>> =C2=A0+ * so client is responsible to close it. Dup it to save origina=
l value from
>> =C2=A0+ * QIOChannel's destructor */
>> =C2=A0+ dup_fd =3D qemu_dup(fd);
>> =C2=A0+ if (dup_fd =3D=3D -1) {
>> =C2=A0+ error_setg(errp, "Cannot dup fd %s: %s (%d)", fdname, strerror=
(errno),
>> =C2=A0+ errno);
>> =C2=A0+ return;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ trace_migration_fd_outgoing(fd, dup_fd);
>> =C2=A0+ ioc =3D qio_channel_new_fd(dup_fd, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ioc) {
>> =C2=A0- close(fd);
>> =C2=A0+ close(dup_fd);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0@@ -55,14 +68,24 @@ static gboolean fd_accept_incoming_migration=
(QIOChannel *ioc,
>> =C2=A0=C2=A0void fd_start_incoming_migration(const char *infd, Error *=
*errp)
>> =C2=A0=C2=A0{
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0QIOChannel *ioc;
>> =C2=A0- int fd;
>> =C2=A0+ int fd, dup_fd;
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fd =3D strtol(infd, NULL, 0);
>> =C2=A0- trace_migration_fd_incoming(fd);
>>
>> =C2=A0- ioc =3D qio_channel_new_fd(fd, errp);
>> =C2=A0+ /* fd is previously created by qmp command 'add-fd' or somethi=
ng else,
>> =C2=A0+ * so client is responsible to close it. Dup it to save origina=
l value from
>> =C2=A0+ * QIOChannel's destructor */
>> =C2=A0+ dup_fd =3D qemu_dup(fd);
>> =C2=A0+ if (dup_fd =3D=3D -1) {
>> =C2=A0+ error_setg(errp, "Cannot dup fd %d: %s (%d)", fd, strerror(err=
no),
>> =C2=A0+ errno);
>> =C2=A0+ return;
>> =C2=A0+ }
>> =C2=A0+
>> =C2=A0+ trace_migration_fd_incoming(fd, dup_fd);
>> =C2=A0+ ioc =3D qio_channel_new_fd(dup_fd, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ioc) {
>> =C2=A0- close(fd);
>> =C2=A0+ close(dup_fd);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>>
>> =C2=A0diff --git a/migration/trace-events b/migration/trace-events
>> =C2=A0index de2e136e57..d2d30a6b3c 100644
>> =C2=A0--- a/migration/trace-events
>> =C2=A0+++ b/migration/trace-events
>> =C2=A0@@ -258,8 +258,8 @@ migration_exec_outgoing(const char *cmd) "cm=
d=3D%s"
>> =C2=A0=C2=A0migration_exec_incoming(const char *cmd) "cmd=3D%s"
>>
>> =C2=A0=C2=A0# fd.c
>> =C2=A0-migration_fd_outgoing(int fd) "fd=3D%d"
>> =C2=A0-migration_fd_incoming(int fd) "fd=3D%d"
>> =C2=A0+migration_fd_outgoing(int fd, int dup_fd) "fd=3D%d dup_fd=3D%d"
>> =C2=A0+migration_fd_incoming(int fd, int dup_fd) "fd=3D%d dup_fd=3D%d"
>>
>> =C2=A0=C2=A0# socket.c
>> =C2=A0=C2=A0migration_socket_incoming_accepted(void) ""
>> =C2=A0--
>> =C2=A02.21.0
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

