Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CF7C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 01:56:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FCE920643
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 01:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCE920643
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZPai-0007ph-AX
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 21:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZPXu-0005LW-TM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 21:53:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2464 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZPXs-0002Br-Nt
 for qemu-devel@nongnu.org; Thu, 14 May 2020 21:53:54 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 56A93B4B24A8271EB811;
 Fri, 15 May 2020 09:53:46 +0800 (CST)
Received: from dggeme707-chm.china.huawei.com (10.1.199.103) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 15 May 2020 09:53:45 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme707-chm.china.huawei.com (10.1.199.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 15 May 2020 09:53:45 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Fri, 15 May 2020 09:53:45 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH 6/6] migration/colo.c: Move colo_notify_compares_event to
 the right place
Thread-Topic: [PATCH 6/6] migration/colo.c: Move colo_notify_compares_event to
 the right place
Thread-Index: AQHWJ4TiQj+MPkHLC0679rdb0mOVNaioaEFg
Date: Fri, 15 May 2020 01:53:45 +0000
Message-ID: <83f2527cd875414cb7529a210e87a4be@huawei.com>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <d4555dd5146a54518c4d9d4efd996b7c745c6687.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <d4555dd5146a54518c4d9d4efd996b7c745c6687.1589193382.git.lukasstraub2@web.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.187;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 21:45:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: zhanghailiang <zhang.zhanghailiang@huawei.com>

> -----Original Message-----
> From: Lukas Straub [mailto:lukasstraub2@web.de]
> Sent: Monday, May 11, 2020 7:11 PM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhanghailiang <zhang.zhanghailiang@huawei.com>; Juan Quintela
> <quintela@redhat.com>; Dr. David Alan Gilbert <dgilbert@redhat.com>
> Subject: [PATCH 6/6] migration/colo.c: Move colo_notify_compares_event
> to the right place
>=20
> If the secondary has to failover during checkpointing, it still is in the=
 old state
> (i.e. different state than primary). Thus we can't expose the primary sta=
te
> until after the checkpoint is sent.
>=20
> This fixes sporadic connection reset of client connections during failove=
r.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  migration/colo.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c index
> a69782efc5..a3fc21e86e 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -430,12 +430,6 @@ static int
> colo_do_checkpoint_transaction(MigrationState *s,
>          goto out;
>      }
>=20
> -    qemu_event_reset(&s->colo_checkpoint_event);
> -    colo_notify_compares_event(NULL, COLO_EVENT_CHECKPOINT,
> &local_err);
> -    if (local_err) {
> -        goto out;
> -    }
> -
>      /* Disable block migration */
>      migrate_set_block_enabled(false, &local_err);
>      qemu_mutex_lock_iothread();
> @@ -494,6 +488,12 @@ static int
> colo_do_checkpoint_transaction(MigrationState *s,
>          goto out;
>      }
>=20
> +    qemu_event_reset(&s->colo_checkpoint_event);
> +    colo_notify_compares_event(NULL, COLO_EVENT_CHECKPOINT,
> &local_err);
> +    if (local_err) {
> +        goto out;
> +    }
> +
>      colo_receive_check_message(s->rp_state.from_dst_file,
>                         COLO_MESSAGE_VMSTATE_LOADED, &local_err);
>      if (local_err) {
> --
> 2.20.1

