Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81FEC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:13:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81DC420873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 10:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jvcaa4uX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DC420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2BV2-0002af-NS
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 05:13:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1j2BUP-00025N-P3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1j2BUO-0000V0-E6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:12:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56636
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1j2BUO-0000Ue-9p
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 05:12:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581588775;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qSLc0fGe7ke9tR1cBG0s9ZwPE0OTKEq1LZnLz5hAy1g=;
 b=Jvcaa4uXeRhnErTpi79yNEDTJFUvF+HGJMeMyOJWUfeMKgnErYO9p2dcN9trs/+E5lOC/k
 GGmKuiytAcSUG1LC5DGrnTtZn9/gQIQztJBSTGY+cQHAv7AKBDwOElu9MgocIQyc3WsLFd
 JQ2unWOtqQRtYs4X7J4v77nA/QYOdwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-6UyHREkCMUu2CWwZX8dGww-1; Thu, 13 Feb 2020 05:12:50 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A91F6100550E;
 Thu, 13 Feb 2020 10:12:49 +0000 (UTC)
Received: from redhat.com (ovpn-116-40.ams2.redhat.com [10.36.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07E061001B23;
 Thu, 13 Feb 2020 10:12:49 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Zhimin Feng <fengzhimin1@huawei.com>
Subject: Re: [PATCH RFC 03/14] migration/rdma: Create multiFd migration threads
In-Reply-To: <20200213093755.370-4-fengzhimin1@huawei.com> (Zhimin Feng's
 message of "Thu, 13 Feb 2020 17:37:44 +0800")
References: <20200213093755.370-1-fengzhimin1@huawei.com>
 <20200213093755.370-4-fengzhimin1@huawei.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Thu, 13 Feb 2020 11:12:43 +0100
Message-ID: <878sl694o4.fsf@secure.laptop>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 6UyHREkCMUu2CWwZX8dGww-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Reply-To: quintela@redhat.com
Cc: zhang.zhanghailiang@huawei.com, armbru@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, jemmy858585@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zhimin Feng <fengzhimin1@huawei.com> wrote:
> Creation of the multifd send threads for RDMA migration,
> nothing inside yet.
>
> Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
> ---
>  migration/multifd.c   | 33 +++++++++++++---
>  migration/multifd.h   |  2 +
>  migration/qemu-file.c |  5 +++
>  migration/qemu-file.h |  1 +
>  migration/rdma.c      | 88 ++++++++++++++++++++++++++++++++++++++++++-
>  migration/rdma.h      |  3 ++
>  6 files changed, 125 insertions(+), 7 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index b3e8ae9bcc..63678d7fdd 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -424,7 +424,7 @@ void multifd_send_sync_main(QEMUFile *f)
>  {
>      int i;
> =20
> -    if (!migrate_use_multifd()) {
> +    if (!migrate_use_multifd() || migrate_use_rdma()) {

You don't need sync with main channel on rdma?

> +static void rdma_send_channel_create(MultiFDSendParams *p)
> +{
> +    Error *local_err =3D NULL;
> +
> +    if (p->quit) {
> +        error_setg(&local_err, "multifd: send id %d already quit", p->id=
);
> +        return ;
> +    }
> +    p->running =3D true;
> +
> +    qemu_thread_create(&p->thread, p->name, multifd_rdma_send_thread, p,
> +                       QEMU_THREAD_JOINABLE);
> +}
> +
>  static void multifd_new_send_channel_async(QIOTask *task, gpointer opaqu=
e)
>  {
>      MultiFDSendParams *p =3D opaque;
> @@ -621,7 +635,11 @@ int multifd_save_setup(Error **errp)
>          p->packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
>          p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
>          p->name =3D g_strdup_printf("multifdsend_%d", i);
> -        socket_send_channel_create(multifd_new_send_channel_async, p);
> +        if (!migrate_use_rdma()) {
> +            socket_send_channel_create(multifd_new_send_channel_async, p=
);
> +        } else {
> +            rdma_send_channel_create(p);
> +        }

This is what we are trying to avoid.  Just create a struct ops, where we
have a

ops->create_channel(new_channel_async, p)

or whatever, and fill it differently for rdma and for tcp.


>      }
>      return 0;
>  }
> @@ -720,7 +738,7 @@ void multifd_recv_sync_main(void)
>  {
>      int i;
> =20
> -    if (!migrate_use_multifd()) {
> +    if (!migrate_use_multifd() || migrate_use_rdma()) {
>          return;
>      }

Ok. you can just put an empty function for you here.

>      for (i =3D 0; i < migrate_multifd_channels(); i++) {
> @@ -890,8 +908,13 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error=
 **errp)
>      p->num_packets =3D 1;
> =20
>      p->running =3D true;
> -    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
> -                       QEMU_THREAD_JOINABLE);
> +    if (!migrate_use_rdma()) {
> +        qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
> +                           QEMU_THREAD_JOINABLE);
> +    } else {
> +        qemu_thread_create(&p->thread, p->name, multifd_rdma_recv_thread=
, p,
> +                           QEMU_THREAD_JOINABLE);
> +    }

new_recv_chanel() member function.

>      atomic_inc(&multifd_recv_state->count);
>      return atomic_read(&multifd_recv_state->count) =3D=3D
>             migrate_multifd_channels();
> diff --git a/migration/multifd.h b/migration/multifd.h
> index d8b0205977..c9c11ad140 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -13,6 +13,8 @@
>  #ifndef QEMU_MIGRATION_MULTIFD_H
>  #define QEMU_MIGRATION_MULTIFD_H
> =20
> +#include "migration/rdma.h"
> +
>  int multifd_save_setup(Error **errp);
>  void multifd_save_cleanup(void);
>  int multifd_load_setup(Error **errp);

You are not exporting anything rdma related from here, are you?

> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 1c3a358a14..f0ed8f1381 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -248,6 +248,11 @@ void qemu_fflush(QEMUFile *f)
>      f->iovcnt =3D 0;
>  }
> =20
> +void *getQIOChannel(QEMUFile *f)
> +{
> +    return f->opaque;
> +}
> +

We really want this to return a void?  and not a better type?
> +static void migration_rdma_process_incoming(QEMUFile *f, Error **errp)
> +{
> +    MigrationIncomingState *mis =3D migration_incoming_get_current();
> +    Error *local_err =3D NULL;
> +    QIOChannel *ioc =3D NULL;
> +    bool start_migration;
> +
> +    if (!mis->from_src_file) {
> +        mis->from_src_file =3D f;
> +        qemu_file_set_blocking(f, false);
> +
> +        start_migration =3D migrate_use_multifd();
> +    } else {
> +        ioc =3D QIO_CHANNEL(getQIOChannel(f));
> +        /* Multiple connections */
> +        assert(migrate_use_multifd());

I am not sure that you can make this incompatible change.
You need to have *both*, old method and new multifd one.

I would have been happy to remove old precopy tcp method, but we
*assure* backwards compatibility.

> @@ -4003,8 +4032,12 @@ static void rdma_accept_incoming_migration(void *o=
paque)
>          return;
>      }
> =20
> -    rdma->migration_started_on_destination =3D 1;
> -    migration_fd_process_incoming(f, errp);
> +    if (migrate_use_multifd()) {
> +        migration_rdma_process_incoming(f, errp);
> +    } else {
> +        rdma->migration_started_on_destination =3D 1;
> +        migration_fd_process_incoming(f, errp);
> +    }

But here you allow that multifd is not defined?




> +
> +void *multifd_rdma_recv_thread(void *opaque)
> +{

Why can't you use the multifd_recv_thread() directly, just creating
different ops when you need them?

Later, Juan.


