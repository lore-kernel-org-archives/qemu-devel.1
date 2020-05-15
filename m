Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9707BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:25:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 616E920728
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:25:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 616E920728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTmm-0007eW-J6
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59144)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZTli-0006jW-Pu
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:24:26 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2521 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhang.zhanghailiang@huawei.com>)
 id 1jZTlh-00088R-5M
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:24:26 -0400
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 83F6F26322642573A480;
 Fri, 15 May 2020 14:24:18 +0800 (CST)
Received: from dggeme758-chm.china.huawei.com (10.3.19.104) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 15 May 2020 14:24:18 +0800
Received: from dggeme756-chm.china.huawei.com (10.3.19.102) by
 dggeme758-chm.china.huawei.com (10.3.19.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Fri, 15 May 2020 14:24:17 +0800
Received: from dggeme756-chm.china.huawei.com ([10.6.80.68]) by
 dggeme756-chm.china.huawei.com ([10.6.80.68]) with mapi id 15.01.1913.007;
 Fri, 15 May 2020 14:24:17 +0800
From: Zhanghailiang <zhang.zhanghailiang@huawei.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH 4/6] migration/colo.c: Relaunch failover even if there was
 an error
Thread-Topic: [PATCH 4/6] migration/colo.c: Relaunch failover even if there
 was an error
Thread-Index: AQHWJ4Tce1QN/aOVtkCtd2vZitIZjaios41Q
Date: Fri, 15 May 2020 06:24:17 +0000
Message-ID: <f12d900ac4ec43f2bb3350abcf6e2edb@huawei.com>
References: <cover.1589193382.git.lukasstraub2@web.de>
 <f60b0a8e2fadaaec792e04819dfc46951842d6ba.1589193382.git.lukasstraub2@web.de>
In-Reply-To: <f60b0a8e2fadaaec792e04819dfc46951842d6ba.1589193382.git.lukasstraub2@web.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.173.220.30]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.188;
 envelope-from=zhang.zhanghailiang@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 02:24:19
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
> Subject: [PATCH 4/6] migration/colo.c: Relaunch failover even if there wa=
s an
> error
>=20
> If vmstate_loading is true, secondary_vm_do_failover will set failover st=
atus
> to FAILOVER_STATUS_RELAUNCH and return success without initiating
> failover. However, if there is an error during the vmstate_loading sectio=
n,
> failover isn't relaunched. Instead we then wait for failover on
> colo_incoming_sem.
>=20
> Fix this by relaunching failover even if there was an error. Also, to mak=
e this
> work properly, set vmstate_loading to false when returning during the
> vmstate_loading section.
>=20
> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  migration/colo.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>=20
> diff --git a/migration/colo.c b/migration/colo.c index
> 2947363ae5..a69782efc5 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -743,6 +743,7 @@ static void
> colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>      ret =3D qemu_load_device_state(fb);
>      if (ret < 0) {
>          error_setg(errp, "COLO: load device state failed");
> +        vmstate_loading =3D false;
>          qemu_mutex_unlock_iothread();
>          return;
>      }
> @@ -751,6 +752,7 @@ static void
> colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>      replication_get_error_all(&local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> +        vmstate_loading =3D false;
>          qemu_mutex_unlock_iothread();
>          return;
>      }
> @@ -759,6 +761,7 @@ static void
> colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>      replication_do_checkpoint_all(&local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
> +        vmstate_loading =3D false;
>          qemu_mutex_unlock_iothread();
>          return;
>      }
> @@ -770,6 +773,7 @@ static void
> colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>=20
>      if (local_err) {
>          error_propagate(errp, local_err);
> +        vmstate_loading =3D false;
>          qemu_mutex_unlock_iothread();
>          return;
>      }
> @@ -780,9 +784,6 @@ static void
> colo_incoming_process_checkpoint(MigrationIncomingState *mis,
>      qemu_mutex_unlock_iothread();
>=20
>      if (failover_get_state() =3D=3D FAILOVER_STATUS_RELAUNCH) {
> -        failover_set_state(FAILOVER_STATUS_RELAUNCH,
> -                        FAILOVER_STATUS_NONE);
> -        failover_request_active(NULL);
>          return;
>      }
>=20
> @@ -881,6 +882,14 @@ void *colo_process_incoming_thread(void
> *opaque)
>              error_report_err(local_err);
>              break;
>          }
> +
> +        if (failover_get_state() =3D=3D FAILOVER_STATUS_RELAUNCH) {
> +            failover_set_state(FAILOVER_STATUS_RELAUNCH,
> +                            FAILOVER_STATUS_NONE);
> +            failover_request_active(NULL);
> +            break;
> +        }
> +
>          if (failover_get_state() !=3D FAILOVER_STATUS_NONE) {
>              error_report("failover request");
>              break;
> @@ -888,8 +897,6 @@ void *colo_process_incoming_thread(void *opaque)
>      }
>=20
>  out:
> -    vmstate_loading =3D false;
> -
>      /*
>       * There are only two reasons we can get here, some error happened
>       * or the user triggered failover.
> --
> 2.20.1


