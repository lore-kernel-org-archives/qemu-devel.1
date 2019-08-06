Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFB5C433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:52:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7368D2070D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 15:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7368D2070D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv1l7-0000i3-QG
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 11:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39543)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hv1ki-0000JF-M6
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:51:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hv1kg-0002K6-AQ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:51:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34688)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hv1kg-0002J8-1M
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 11:51:54 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4421130B9BC3;
 Tue,  6 Aug 2019 15:51:53 +0000 (UTC)
Received: from work-vm (ovpn-117-206.ams2.redhat.com [10.36.117.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B954610016E8;
 Tue,  6 Aug 2019 15:51:51 +0000 (UTC)
Date: Tue, 6 Aug 2019 16:51:49 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Message-ID: <20190806155149.GH3066@work-vm>
References: <20190422103420.15686-1-yury-kotov@yandex-team.ru>
 <20190614163917.GI2785@work-vm>
 <488291563358734@iva5-3ddfc71a5076.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <488291563358734@iva5-3ddfc71a5076.qloud-c.yandex.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Tue, 06 Aug 2019 15:51:53 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: Add error_desc for file channel
 errors
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
Cc: "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> Hi, I'm a bit worried that this patch might have been forgotten.
> Is it queued? Thanks!

I've added it to my list for the pull I'll do as soon as 4.2 opens.

Dave

> 14.06.2019, 19:56, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> > * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
> >> =A0Currently, there is no information about error if outgoing migrat=
ion was failed
> >> =A0because of file channel errors.
> >> =A0Example (QMP session):
> >> =A0-> { "execute": "migrate", "arguments": { "uri": "exec:head -c 1"=
 }}
> >> =A0<- { "return": {} }
> >> =A0...
> >> =A0-> { "execute": "query-migrate" }
> >> =A0<- { "return": { "status": "failed" }} // There is not error's de=
scription
> >>
> >> =A0And even in the QEMU's output there is nothing.
> >>
> >> =A0This patch
> >> =A01) Adds errp for the most of QEMUFileOps
> >> =A02) Adds qemu_file_get_error_obj/qemu_file_set_error_obj
> >> =A03) And finally using of qemu_file_get_error_obj in migration.c
> >>
> >> =A0And now, the status for the mentioned fail will be:
> >> =A0-> { "execute": "query-migrate" }
> >> =A0<- { "return": { "status": "failed",
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0"error-desc": =
"Unable to write to command: Broken pipe" }}
> >>
> >> =A0Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> >> =A0---
> >> =A0=A0migration/migration.c | 10 ++++--
> >> =A0=A0migration/qemu-file-channel.c | 30 +++++++++--------
> >> =A0=A0migration/qemu-file.c | 63 ++++++++++++++++++++++++++++-------
> >> =A0=A0migration/qemu-file.h | 15 ++++++---
> >> =A0=A0migration/savevm.c | 6 ++--
> >> =A0=A05 files changed, 88 insertions(+), 36 deletions(-)
> >>
> >> =A0diff --git a/migration/migration.c b/migration/migration.c
> >> =A0index 609e0df5d0..7bcdc4613b 100644
> >> =A0--- a/migration/migration.c
> >> =A0+++ b/migration/migration.c
> >> =A0@@ -2949,6 +2949,7 @@ static MigThrError migration_detect_error(M=
igrationState *s)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0int ret;
> >> =A0=A0=A0=A0=A0=A0int state =3D s->state;
> >> =A0+ Error *local_error =3D NULL;
> >>
> >> =A0=A0=A0=A0=A0=A0if (state =3D=3D MIGRATION_STATUS_CANCELLING ||
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0state =3D=3D MIGRATION_STATUS_CANCELLE=
D) {
> >> =A0@@ -2957,13 +2958,18 @@ static MigThrError migration_detect_error=
(MigrationState *s)
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0=A0=A0=A0=A0=A0/* Try to detect any file errors */
> >> =A0- ret =3D qemu_file_get_error(s->to_dst_file);
> >> =A0-
> >> =A0+ ret =3D qemu_file_get_error_obj(s->to_dst_file, &local_error);
> >> =A0=A0=A0=A0=A0=A0if (!ret) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/* Everything is fine */
> >> =A0+ assert(!local_error);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return MIG_THR_ERR_NONE;
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0+ if (local_error) {
> >> =A0+ migrate_set_error(s, local_error);
> >> =A0+ error_free(local_error);
> >> =A0+ }
> >> =A0+
> >> =A0=A0=A0=A0=A0=A0if (state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE =
&& ret =3D=3D -EIO) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0/*
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0* For postcopy, we allow the networ=
k to be down for a
> >> =A0diff --git a/migration/qemu-file-channel.c b/migration/qemu-file-=
channel.c
> >> =A0index 8e639eb496..c382ea2d78 100644
> >> =A0--- a/migration/qemu-file-channel.c
> >> =A0+++ b/migration/qemu-file-channel.c
> >> =A0@@ -33,7 +33,8 @@
> >> =A0=A0static ssize_t channel_writev_buffer(void *opaque,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0struct iovec *iov,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int iovcnt,
> >> =A0- int64_t pos)
> >> =A0+ int64_t pos,
> >> =A0+ Error **errp)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> >> =A0=A0=A0=A0=A0=A0ssize_t done =3D 0;
> >> =A0@@ -47,7 +48,7 @@ static ssize_t channel_writev_buffer(void *opaq=
ue,
> >>
> >> =A0=A0=A0=A0=A0=A0while (nlocal_iov > 0) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ssize_t len;
> >> =A0- len =3D qio_channel_writev(ioc, local_iov, nlocal_iov, NULL);
> >> =A0+ len =3D qio_channel_writev(ioc, local_iov, nlocal_iov, errp);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (len =3D=3D QIO_CHANNEL_ERR_BLOCK) =
{
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (qemu_in_coroutine()) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qio_channel_yi=
eld(ioc, G_IO_OUT);
> >> =A0@@ -57,7 +58,6 @@ static ssize_t channel_writev_buffer(void *opaq=
ue,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0continue;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (len < 0) {
> >> =A0- /* XXX handle Error objects */
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0done =3D -EIO;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0goto cleanup;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0@@ -75,13 +75,14 @@ static ssize_t channel_writev_buffer(void *op=
aque,
> >> =A0=A0static ssize_t channel_get_buffer(void *opaque,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0uint8_t *buf,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0int64_t pos,
> >> =A0- size_t size)
> >> =A0+ size_t size,
> >> =A0+ Error **errp)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> >> =A0=A0=A0=A0=A0=A0ssize_t ret;
> >>
> >> =A0=A0=A0=A0=A0=A0do {
> >> =A0- ret =3D qio_channel_read(ioc, (char *)buf, size, NULL);
> >> =A0+ ret =3D qio_channel_read(ioc, (char *)buf, size, errp);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ret < 0) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ret =3D=3D QIO_CHANNEL=
_ERR_BLOCK) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (qemu_in_co=
routine()) {
> >> =A0@@ -90,7 +91,6 @@ static ssize_t channel_get_buffer(void *opaque,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qi=
o_channel_wait(ioc, G_IO_IN);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> >> =A0- /* XXX handle Error * object */
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EIO;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0@@ -100,18 +100,20 @@ static ssize_t channel_get_buffer(void *opa=
que,
> >> =A0=A0}
> >>
> >> =A0-static int channel_close(void *opaque)
> >> =A0+static int channel_close(void *opaque, Error **errp)
> >> =A0=A0{
> >> =A0+ int ret;
> >> =A0=A0=A0=A0=A0=A0QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> >> =A0- qio_channel_close(ioc, NULL);
> >> =A0+ ret =3D qio_channel_close(ioc, errp);
> >> =A0=A0=A0=A0=A0=A0object_unref(OBJECT(ioc));
> >> =A0- return 0;
> >> =A0+ return ret;
> >> =A0=A0}
> >>
> >> =A0=A0static int channel_shutdown(void *opaque,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0bool rd,
> >> =A0- bool wr)
> >> =A0+ bool wr,
> >> =A0+ Error **errp)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> >>
> >> =A0@@ -125,8 +127,7 @@ static int channel_shutdown(void *opaque,
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0} else {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0mode =3D QIO_CHANNEL_SHUTD=
OWN_WRITE;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0- if (qio_channel_shutdown(ioc, mode, NULL) < 0) {
> >> =A0- /* XXX handler Error * object */
> >> =A0+ if (qio_channel_shutdown(ioc, mode, errp) < 0) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EIO;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0@@ -135,11 +136,12 @@ static int channel_shutdown(void *opaque,
> >>
> >> =A0=A0static int channel_set_blocking(void *opaque,
> >> =A0- bool enabled)
> >> =A0+ bool enabled,
> >> =A0+ Error **errp)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0QIOChannel *ioc =3D QIO_CHANNEL(opaque);
> >>
> >> =A0- if (qio_channel_set_blocking(ioc, enabled, NULL) < 0) {
> >> =A0+ if (qio_channel_set_blocking(ioc, enabled, errp) < 0) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -1;
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0return 0;
> >> =A0diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> >> =A0index 977b9ae07c..c52160e08b 100644
> >> =A0--- a/migration/qemu-file.c
> >> =A0+++ b/migration/qemu-file.c
> >> =A0@@ -29,6 +29,7 @@
> >> =A0=A0#include "migration.h"
> >> =A0=A0#include "qemu-file.h"
> >> =A0=A0#include "trace.h"
> >> =A0+#include "qapi/error.h"
> >>
> >> =A0=A0#define IO_BUF_SIZE 32768
> >> =A0=A0#define MAX_IOV_SIZE MIN(IOV_MAX, 64)
> >> =A0@@ -52,6 +53,7 @@ struct QEMUFile {
> >> =A0=A0=A0=A0=A0=A0unsigned int iovcnt;
> >>
> >> =A0=A0=A0=A0=A0=A0int last_error;
> >> =A0+ Error *last_error_obj;
> >> =A0=A0};
> >>
> >> =A0=A0/*
> >> =A0@@ -63,7 +65,7 @@ int qemu_file_shutdown(QEMUFile *f)
> >> =A0=A0=A0=A0=A0=A0if (!f->ops->shut_down) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENOSYS;
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0- return f->ops->shut_down(f->opaque, true, true);
> >> =A0+ return f->ops->shut_down(f->opaque, true, true, NULL);
> >> =A0=A0}
> >>
> >> =A0=A0/*
> >> =A0@@ -108,24 +110,55 @@ void qemu_file_set_hooks(QEMUFile *f, const=
 QEMUFileHooks *hooks)
> >> =A0=A0}
> >>
> >> =A0=A0/*
> >> =A0- * Get last error for stream f
> >> =A0+ * Get last error for stream f with optional Error*
> >> =A0=A0=A0*
> >> =A0=A0=A0* Return negative error value if there has been an error on=
 previous
> >> =A0=A0=A0* operations, return 0 if no error happened.
> >> =A0+ * Optional, it returns Error* in errp, but it may be NULL even =
if return value
> >> =A0+ * is not 0.
> >> =A0=A0=A0*
> >> =A0=A0=A0*/
> >> =A0-int qemu_file_get_error(QEMUFile *f)
> >> =A0+int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
> >> =A0=A0{
> >> =A0+ if (errp) {
> >> =A0+ *errp =3D f->last_error_obj ? error_copy(f->last_error_obj) : N=
ULL;
> >> =A0+ }
> >> =A0=A0=A0=A0=A0=A0return f->last_error;
> >> =A0=A0}
> >>
> >> =A0-void qemu_file_set_error(QEMUFile *f, int ret)
> >> =A0+/*
> >> =A0+ * Set the last error for stream f with optional Error*
> >> =A0+ */
> >> =A0+void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err)
> >> =A0=A0{
> >> =A0- if (f->last_error =3D=3D 0) {
> >> =A0+ if (f->last_error =3D=3D 0 && ret) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0f->last_error =3D ret;
> >> =A0+ error_propagate(&f->last_error_obj, err);
> >> =A0+ } else if (err) {
> >> =A0+ error_report_err(err);
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0=A0}
> >>
> >> =A0+/*
> >> =A0+ * Get last error for stream f
> >> =A0+ *
> >> =A0+ * Return negative error value if there has been an error on pre=
vious
> >> =A0+ * operations, return 0 if no error happened.
> >> =A0+ *
> >> =A0+ */
> >> =A0+int qemu_file_get_error(QEMUFile *f)
> >> =A0+{
> >> =A0+ return qemu_file_get_error_obj(f, NULL);
> >> =A0+}
> >> =A0+
> >> =A0+/*
> >> =A0+ * Set the last error for stream f
> >> =A0+ */
> >> =A0+void qemu_file_set_error(QEMUFile *f, int ret)
> >> =A0+{
> >> =A0+ qemu_file_set_error_obj(f, ret, NULL);
> >> =A0+}
> >> =A0+
> >> =A0=A0bool qemu_file_is_writable(QEMUFile *f)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0return f->ops->writev_buffer;
> >> =A0@@ -177,6 +210,7 @@ void qemu_fflush(QEMUFile *f)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0ssize_t ret =3D 0;
> >> =A0=A0=A0=A0=A0=A0ssize_t expect =3D 0;
> >> =A0+ Error *local_error =3D NULL;
> >>
> >> =A0=A0=A0=A0=A0=A0if (!qemu_file_is_writable(f)) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return;
> >> =A0@@ -184,7 +218,8 @@ void qemu_fflush(QEMUFile *f)
> >>
> >> =A0=A0=A0=A0=A0=A0if (f->iovcnt > 0) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0expect =3D iov_size(f->iov, f->iovcnt)=
;
> >> =A0- ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->=
pos);
> >> =A0+ ret =3D f->ops->writev_buffer(f->opaque, f->iov, f->iovcnt, f->=
pos,
> >> =A0+ &local_error);
> >>
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0qemu_iovec_release_ram(f);
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0@@ -196,7 +231,7 @@ void qemu_fflush(QEMUFile *f)
> >> =A0=A0=A0=A0=A0=A0=A0* data set we requested, so sanity check that.
> >> =A0=A0=A0=A0=A0=A0=A0*/
> >> =A0=A0=A0=A0=A0=A0if (ret !=3D expect) {
> >> =A0- qemu_file_set_error(f, ret < 0 ? ret : -EIO);
> >> =A0+ qemu_file_set_error_obj(f, ret < 0 ? ret : -EIO, local_error);
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0=A0=A0=A0=A0=A0f->buf_index =3D 0;
> >> =A0=A0=A0=A0=A0=A0f->iovcnt =3D 0;
> >> =A0@@ -284,6 +319,7 @@ static ssize_t qemu_fill_buffer(QEMUFile *f)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0int len;
> >> =A0=A0=A0=A0=A0=A0int pending;
> >> =A0+ Error *local_error =3D NULL;
> >>
> >> =A0=A0=A0=A0=A0=A0assert(!qemu_file_is_writable(f));
> >>
> >> =A0@@ -295,14 +331,16 @@ static ssize_t qemu_fill_buffer(QEMUFile *f=
)
> >> =A0=A0=A0=A0=A0=A0f->buf_size =3D pending;
> >>
> >> =A0=A0=A0=A0=A0=A0len =3D f->ops->get_buffer(f->opaque, f->buf + pen=
ding, f->pos,
> >> =A0- IO_BUF_SIZE - pending);
> >> =A0+ IO_BUF_SIZE - pending, &local_error);
> >> =A0=A0=A0=A0=A0=A0if (len > 0) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0f->buf_size +=3D len;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0f->pos +=3D len;
> >> =A0=A0=A0=A0=A0=A0} else if (len =3D=3D 0) {
> >> =A0- qemu_file_set_error(f, -EIO);
> >> =A0+ qemu_file_set_error_obj(f, -EIO, local_error);
> >> =A0=A0=A0=A0=A0=A0} else if (len !=3D -EAGAIN) {
> >> =A0- qemu_file_set_error(f, len);
> >> =A0+ qemu_file_set_error_obj(f, len, local_error);
> >> =A0+ } else {
> >> =A0+ error_free(local_error);
> >> =A0=A0=A0=A0=A0=A0}
> >>
> >> =A0=A0=A0=A0=A0=A0return len;
> >> =A0@@ -328,7 +366,7 @@ int qemu_fclose(QEMUFile *f)
> >> =A0=A0=A0=A0=A0=A0ret =3D qemu_file_get_error(f);
> >>
> >> =A0=A0=A0=A0=A0=A0if (f->ops->close) {
> >> =A0- int ret2 =3D f->ops->close(f->opaque);
> >> =A0+ int ret2 =3D f->ops->close(f->opaque, NULL);
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (ret >=3D 0) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D ret2;
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> >> =A0@@ -339,6 +377,7 @@ int qemu_fclose(QEMUFile *f)
> >> =A0=A0=A0=A0=A0=A0if (f->last_error) {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ret =3D f->last_error;
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0+ error_free(f->last_error_obj);
> >> =A0=A0=A0=A0=A0=A0g_free(f);
> >> =A0=A0=A0=A0=A0=A0trace_qemu_file_fclose();
> >> =A0=A0=A0=A0=A0=A0return ret;
> >> =A0@@ -784,6 +823,6 @@ void qemu_put_counted_string(QEMUFile *f, con=
st char *str)
> >> =A0=A0void qemu_file_set_blocking(QEMUFile *f, bool block)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0if (f->ops->set_blocking) {
> >> =A0- f->ops->set_blocking(f->opaque, block);
> >> =A0+ f->ops->set_blocking(f->opaque, block, NULL);
> >> =A0=A0=A0=A0=A0=A0}
> >> =A0=A0}
> >> =A0diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> >> =A0index 13baf896bd..eb886db65f 100644
> >> =A0--- a/migration/qemu-file.h
> >> =A0+++ b/migration/qemu-file.h
> >> =A0@@ -32,7 +32,8 @@
> >> =A0=A0=A0* bytes actually read should be returned.
> >> =A0=A0=A0*/
> >> =A0=A0typedef ssize_t (QEMUFileGetBufferFunc)(void *opaque, uint8_t =
*buf,
> >> =A0- int64_t pos, size_t size);
> >> =A0+ int64_t pos, size_t size,
> >> =A0+ Error **errp);
> >>
> >> =A0=A0/* Close a file
> >> =A0=A0=A0*
> >> =A0@@ -41,7 +42,7 @@ typedef ssize_t (QEMUFileGetBufferFunc)(void *o=
paque, uint8_t *buf,
> >> =A0=A0=A0* The meaning of return value on success depends on the spe=
cific back-end being
> >> =A0=A0=A0* used.
> >> =A0=A0=A0*/
> >> =A0-typedef int (QEMUFileCloseFunc)(void *opaque);
> >> =A0+typedef int (QEMUFileCloseFunc)(void *opaque, Error **errp);
> >>
> >> =A0=A0/* Called to return the OS file descriptor associated to the Q=
EMUFile.
> >> =A0=A0=A0*/
> >> =A0@@ -49,14 +50,15 @@ typedef int (QEMUFileGetFD)(void *opaque);
> >>
> >> =A0=A0/* Called to change the blocking mode of the file
> >> =A0=A0=A0*/
> >> =A0-typedef int (QEMUFileSetBlocking)(void *opaque, bool enabled);
> >> =A0+typedef int (QEMUFileSetBlocking)(void *opaque, bool enabled, Er=
ror **errp);
> >>
> >> =A0=A0/*
> >> =A0=A0=A0* This function writes an iovec to file. The handler must w=
rite all
> >> =A0=A0=A0* of the data or return a negative errno value.
> >> =A0=A0=A0*/
> >> =A0=A0typedef ssize_t (QEMUFileWritevBufferFunc)(void *opaque, struc=
t iovec *iov,
> >> =A0- int iovcnt, int64_t pos);
> >> =A0+ int iovcnt, int64_t pos,
> >> =A0+ Error **errp);
> >>
> >> =A0=A0/*
> >> =A0=A0=A0* This function provides hooks around different
> >> =A0@@ -97,7 +99,8 @@ typedef QEMUFile *(QEMURetPathFunc)(void *opaqu=
e);
> >> =A0=A0=A0* Existing blocking reads/writes must be woken
> >> =A0=A0=A0* Returns 0 on success, -err on error
> >> =A0=A0=A0*/
> >> =A0-typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool w=
r);
> >> =A0+typedef int (QEMUFileShutdownFunc)(void *opaque, bool rd, bool w=
r,
> >> =A0+ Error **errp);
> >>
> >> =A0=A0typedef struct QEMUFileOps {
> >> =A0=A0=A0=A0=A0=A0QEMUFileGetBufferFunc *get_buffer;
> >> =A0@@ -149,6 +152,8 @@ void qemu_update_position(QEMUFile *f, size_t=
 size);
> >> =A0=A0void qemu_file_reset_rate_limit(QEMUFile *f);
> >> =A0=A0void qemu_file_set_rate_limit(QEMUFile *f, int64_t new_rate);
> >> =A0=A0int64_t qemu_file_get_rate_limit(QEMUFile *f);
> >> =A0+int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
> >> =A0+void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
> >> =A0=A0void qemu_file_set_error(QEMUFile *f, int ret);
> >> =A0=A0int qemu_file_shutdown(QEMUFile *f);
> >> =A0=A0QEMUFile *qemu_file_get_return_path(QEMUFile *f);
> >> =A0diff --git a/migration/savevm.c b/migration/savevm.c
> >> =A0index 34bcad3807..a619af744d 100644
> >> =A0--- a/migration/savevm.c
> >> =A0+++ b/migration/savevm.c
> >> =A0@@ -124,7 +124,7 @@ static struct mig_cmd_args {
> >> =A0=A0/* savevm/loadvm support */
> >>
> >> =A0=A0static ssize_t block_writev_buffer(void *opaque, struct iovec =
*iov, int iovcnt,
> >> =A0- int64_t pos)
> >> =A0+ int64_t pos, Error **errp)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0int ret;
> >> =A0=A0=A0=A0=A0=A0QEMUIOVector qiov;
> >> =A0@@ -139,12 +139,12 @@ static ssize_t block_writev_buffer(void *op=
aque, struct iovec *iov, int iovcnt,
> >> =A0=A0}
> >>
> >> =A0=A0static ssize_t block_get_buffer(void *opaque, uint8_t *buf, in=
t64_t pos,
> >> =A0- size_t size)
> >> =A0+ size_t size, Error **errp)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0return bdrv_load_vmstate(opaque, buf, pos, size);
> >> =A0=A0}
> >>
> >> =A0-static int bdrv_fclose(void *opaque)
> >> =A0+static int bdrv_fclose(void *opaque, Error **errp)
> >> =A0=A0{
> >> =A0=A0=A0=A0=A0=A0return bdrv_flush(opaque);
> >> =A0=A0}
> >> =A0--
> >> =A02.21.0
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
> Regards,
> Yury
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

