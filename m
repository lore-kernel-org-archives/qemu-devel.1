Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2D2C2BA83
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2ED32187F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 09:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2ED32187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Xds-0004il-43
	for qemu-devel@archiver.kernel.org; Fri, 14 Feb 2020 04:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2XdI-0004HX-6s
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2XdG-0000BC-R2
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:51:36 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:50306 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2XdG-0008R4-G3
 for qemu-devel@nongnu.org; Fri, 14 Feb 2020 04:51:34 -0500
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id AFE6890642BC204002E2;
 Fri, 14 Feb 2020 17:51:25 +0800 (CST)
Received: from DGGEMI529-MBX.china.huawei.com ([169.254.6.74]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0439.000;
 Fri, 14 Feb 2020 17:51:18 +0800
From: fengzhimin <fengzhimin1@huawei.com>
To: "quintela@redhat.com" <quintela@redhat.com>
Subject: RE: [PATCH RFC 03/14] migration/rdma: Create multiFd migration threads
Thread-Topic: [PATCH RFC 03/14] migration/rdma: Create multiFd migration
 threads
Thread-Index: AQHV4lYhD0inBWY4SEq6cynXWh9LoqgaX9IA
Date: Fri, 14 Feb 2020 09:51:18 +0000
Message-ID: <03C2A65461456D4EBE9E6D4D0D96C583FD2DF8@DGGEMI529-MBX.china.huawei.com>
References: <20200213093755.370-1-fengzhimin1@huawei.com>
 <20200213093755.370-4-fengzhimin1@huawei.com> <878sl694o4.fsf@secure.laptop>
In-Reply-To: <878sl694o4.fsf@secure.laptop>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.198]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.255
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
Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "jemmy858585@gmail.com" <jemmy858585@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for your review. I will fix these errors in the next version(V3).

Due to migration data transfer using RDMA WRITE operation, we don't need to=
 receive data in the destination.
We only need to poll the CQE in the destination, so multifd_recv_thread() c=
an't be used directly.

-----Original Message-----
From: Juan Quintela [mailto:quintela@redhat.com]=20
Sent: Thursday, February 13, 2020 6:13 PM
To: fengzhimin <fengzhimin1@huawei.com>
Cc: dgilbert@redhat.com; armbru@redhat.com; eblake@redhat.com; qemu-devel@n=
ongnu.org; Zhanghailiang <zhang.zhanghailiang@huawei.com>; jemmy858585@gmai=
l.com
Subject: Re: [PATCH RFC 03/14] migration/rdma: Create multiFd migration thr=
eads

Zhimin Feng <fengzhimin1@huawei.com> wrote:
> Creation of the multifd send threads for RDMA migration, nothing=20
> inside yet.
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
> diff --git a/migration/multifd.c b/migration/multifd.c index=20
> b3e8ae9bcc..63678d7fdd 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -424,7 +424,7 @@ void multifd_send_sync_main(QEMUFile *f)  {
>      int i;
> =20
> -    if (!migrate_use_multifd()) {
> +    if (!migrate_use_multifd() || migrate_use_rdma()) {

You don't need sync with main channel on rdma?

> +static void rdma_send_channel_create(MultiFDSendParams *p) {
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
> +                       QEMU_THREAD_JOINABLE); }
> +
>  static void multifd_new_send_channel_async(QIOTask *task, gpointer=20
> opaque)  {
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

This is what we are trying to avoid.  Just create a struct ops, where we ha=
ve a

ops->create_channel(new_channel_async, p)

or whatever, and fill it differently for rdma and for tcp.


>      }
>      return 0;
>  }
> @@ -720,7 +738,7 @@ void multifd_recv_sync_main(void)  {
>      int i;
> =20
> -    if (!migrate_use_multifd()) {
> +    if (!migrate_use_multifd() || migrate_use_rdma()) {
>          return;
>      }

Ok. you can just put an empty function for you here.

>      for (i =3D 0; i < migrate_multifd_channels(); i++) { @@ -890,8=20
> +908,13 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
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
>             migrate_multifd_channels(); diff --git=20
> a/migration/multifd.h b/migration/multifd.h index=20
> d8b0205977..c9c11ad140 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -13,6 +13,8 @@
>  #ifndef QEMU_MIGRATION_MULTIFD_H
>  #define QEMU_MIGRATION_MULTIFD_H
> =20
> +#include "migration/rdma.h"
> +
>  int multifd_save_setup(Error **errp);  void=20
> multifd_save_cleanup(void);  int multifd_load_setup(Error **errp);

You are not exporting anything rdma related from here, are you?

> diff --git a/migration/qemu-file.c b/migration/qemu-file.c index=20
> 1c3a358a14..f0ed8f1381 100644
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
> +static void migration_rdma_process_incoming(QEMUFile *f, Error=20
> +**errp) {
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
> +void *multifd_rdma_recv_thread(void *opaque) {

Why can't you use the multifd_recv_thread() directly, just creating differe=
nt ops when you need them?

Later, Juan.


