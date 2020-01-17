Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C5EC33CB6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 01:33:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB7A20728
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 01:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB7A20728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isGVt-0004RE-Rq
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 20:33:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1isGV8-00040r-HY
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:32:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1isGV7-0003dM-Fk
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:32:42 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2489 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1isGV7-0003Vx-5Q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 20:32:41 -0500
Received: from dggemi405-hub.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 5C0981E403782D5E67FA;
 Fri, 17 Jan 2020 09:32:38 +0800 (CST)
Received: from DGGEMI529-MBX.china.huawei.com ([169.254.6.126]) by
 dggemi405-hub.china.huawei.com ([10.3.17.143]) with mapi id 14.03.0439.000;
 Fri, 17 Jan 2020 09:32:31 +0800
From: fengzhimin <fengzhimin1@huawei.com>
To: "quintela@redhat.com" <quintela@redhat.com>
Subject: RE: [PATCH RFC 04/12] migration/rdma: Create multiRDMA migration
 threads
Thread-Topic: [PATCH RFC 04/12] migration/rdma: Create multiRDMA migration
 threads
Thread-Index: AQHVzHBw2u69YrMCiUK29XN3EKy9JKfuErHg
Date: Fri, 17 Jan 2020 01:32:30 +0000
Message-ID: <03C2A65461456D4EBE9E6D4D0D96C583FBCAA4@DGGEMI529-MBX.china.huawei.com>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
 <20200109045922.904-5-fengzhimin1@huawei.com> <87eevz8ren.fsf@secure.laptop>
In-Reply-To: <87eevz8ren.fsf@secure.laptop>
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
X-Received-From: 45.249.212.188
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

Thanks for your review. I will merge this with multifd.

-----Original Message-----
From: Juan Quintela [mailto:quintela@redhat.com]=20
Sent: Thursday, January 16, 2020 9:25 PM
To: fengzhimin <fengzhimin1@huawei.com>
Cc: dgilbert@redhat.com; armbru@redhat.com; eblake@redhat.com; qemu-devel@n=
ongnu.org; Zhanghailiang <zhang.zhanghailiang@huawei.com>; jemmy858585@gmai=
l.com
Subject: Re: [PATCH RFC 04/12] migration/rdma: Create multiRDMA migration t=
hreads

Zhimin Feng <fengzhimin1@huawei.com> wrote:
> From: fengzhimin <fengzhimin1@huawei.com>
>
> Creation of the RDMA threads, nothing inside yet.
>
> Signed-off-by: fengzhimin <fengzhimin1@huawei.com>

> ---
>  migration/migration.c |   1 +
>  migration/migration.h |   2 +
>  migration/rdma.c      | 283 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 286 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c index=20
> 5756a4806e..f8d4eb657e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1546,6 +1546,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>          qemu_mutex_lock_iothread();
> =20
>          multifd_save_cleanup();
> +        multiRDMA_save_cleanup();

Can we merge this with multifd?


> +typedef struct {
> +    /* this fields are not changed once the thread is created */
> +    /* channel number */
> +    uint8_t id;
> +    /* channel thread name */
> +    char *name;
> +    /* channel thread id */
> +    QemuThread thread;
> +    /* sem where to wait for more work */
> +    QemuSemaphore sem;
> +    /* this mutex protects the following parameters */
> +    QemuMutex mutex;
> +    /* is this channel thread running */
> +    bool running;
> +    /* should this thread finish */
> +    bool quit;
> +}  MultiRDMASendParams;

This is basically the same than MultiFBSendParams, same for the rest.

I would very much preffer not to have two sets of threads that are really e=
quivalent.

Thanks, Juan.


