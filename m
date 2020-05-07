Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108B7C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:39:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D954D208CA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 11:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D954D208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWerq-0006IV-0E
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 07:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jWer0-0005Rb-BV
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:38:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:16586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1jWeqy-0003g9-07
 for qemu-devel@nongnu.org; Thu, 07 May 2020 07:38:13 -0400
IronPort-SDR: gCCb12dD7PQa1hhs4Qh2JuVQv/gfdQjNPpP1wDVL+Bcvg2ucXP3wzpbne31IPH6ymUFokFFDn5
 yjaNzlnq4L3w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 04:38:08 -0700
IronPort-SDR: +IrYKKda68P70Xlr9Q6pVI+Ut6mhT2CGqu72g7mRBHYqZxCIuOofaFxhZmhAMdf/00c28Y1HCr
 r1Vn0a5laiPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,363,1583222400"; d="scan'208";a="249262351"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga007.jf.intel.com with ESMTP; 07 May 2020 04:38:07 -0700
Received: from shsmsx602.ccr.corp.intel.com (10.109.6.142) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 May 2020 04:38:07 -0700
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 SHSMSX602.ccr.corp.intel.com (10.109.6.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 7 May 2020 19:38:05 +0800
Received: from shsmsx604.ccr.corp.intel.com ([10.109.6.214]) by
 SHSMSX604.ccr.corp.intel.com ([10.109.6.214]) with mapi id 15.01.1713.004;
 Thu, 7 May 2020 19:38:05 +0800
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Lukas Straub <lukasstraub2@web.de>, qemu-devel <qemu-devel@nongnu.org>
Subject: RE: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
Thread-Topic: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
Thread-Index: AQHWIf7Bx4gi7zaHJ0uJupTsMN62paicgaQQ
Date: Thu, 7 May 2020 11:38:04 +0000
Message-ID: <0380e994e53947cd961cc363d46561d3@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <f6cbde747d78ff080f680c710e2793867a3cf1fa.1588587700.git.lukasstraub2@web.de>
In-Reply-To: <f6cbde747d78ff080f680c710e2793867a3cf1fa.1588587700.git.lukasstraub2@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Received-SPF: pass client-ip=192.55.52.43; envelope-from=chen.zhang@intel.com;
 helo=mga05.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 07:38:08
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> -----Original Message-----
> From: Lukas Straub <lukasstraub2@web.de>
> Sent: Monday, May 4, 2020 6:28 PM
> To: qemu-devel <qemu-devel@nongnu.org>
> Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> <pbonzini@redhat.com>
> Subject: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that colo=
-
> compare is active
>=20
> If the colo-compare object is removed before failover and a checkpoint
> happens, qemu crashes because it tries to lock the destroyed event_mtx in
> colo_notify_compares_event.
>=20
> Fix this by checking if everything is initialized by introducing a new va=
riable
> colo_compare_active which is protected by a new mutex
> colo_compare_mutex. The new mutex also protects against concurrent
> access of the net_compares list and makes sure that
> colo_notify_compares_event isn't active while we destroy event_mtx and
> event_complete_cond.
>=20
> With this it also is again possible to use colo without colo-compare (per=
iodic
> mode) and to use multiple colo-compare for multiple network interfaces.
>=20

Hi Lukas,

For this case I think we don't need to touch vl.c code, we can solve this i=
ssue from another perspective:
How to remove colo-compare?
User will use qemu-monitor or QMP command to disable an object, so we just =
need return operation failed
When user try to remove colo-compare object while COLO is running.

Thanks
Zhang Chen

> Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> ---
>  net/colo-compare.c | 35 +++++++++++++++++++++++++++++------
>  net/colo-compare.h |  1 +
>  softmmu/vl.c       |  2 ++
>  3 files changed, 32 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/colo-compare.c b/net/colo-compare.c index
> 56db3d3bfc..c7572d75e9 100644
> --- a/net/colo-compare.c
> +++ b/net/colo-compare.c
> @@ -54,6 +54,8 @@ static NotifierList colo_compare_notifiers =3D  #define
> REGULAR_PACKET_CHECK_MS 3000  #define DEFAULT_TIME_OUT_MS 3000
>=20
> +static QemuMutex colo_compare_mutex;
> +static bool colo_compare_active;
>  static QemuMutex event_mtx;
>  static QemuCond event_complete_cond;
>  static int event_unhandled_count;
> @@ -906,6 +908,12 @@ static void check_old_packet_regular(void *opaque)
> void colo_notify_compares_event(void *opaque, int event, Error **errp)  {
>      CompareState *s;
> +    qemu_mutex_lock(&colo_compare_mutex);
> +
> +    if (!colo_compare_active) {
> +        qemu_mutex_unlock(&colo_compare_mutex);
> +        return;
> +    }
>=20
>      qemu_mutex_lock(&event_mtx);
>      QTAILQ_FOREACH(s, &net_compares, next) { @@ -919,6 +927,7 @@ void
> colo_notify_compares_event(void *opaque, int event, Error **errp)
>      }
>=20
>      qemu_mutex_unlock(&event_mtx);
> +    qemu_mutex_unlock(&colo_compare_mutex);
>  }
>=20
>  static void colo_compare_timer_init(CompareState *s) @@ -1274,7 +1283,14
> @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
>                             s->vnet_hdr);
>      }
>=20
> +    qemu_mutex_lock(&colo_compare_mutex);
> +    if (!colo_compare_active) {
> +        qemu_mutex_init(&event_mtx);
> +        qemu_cond_init(&event_complete_cond);
> +        colo_compare_active =3D true;
> +    }
>      QTAILQ_INSERT_TAIL(&net_compares, s, next);
> +    qemu_mutex_unlock(&colo_compare_mutex);
>=20
>      s->out_sendco.s =3D s;
>      s->out_sendco.chr =3D &s->chr_out;
> @@ -1290,9 +1306,6 @@ static void colo_compare_complete(UserCreatable
> *uc, Error **errp)
>=20
>      g_queue_init(&s->conn_list);
>=20
> -    qemu_mutex_init(&event_mtx);
> -    qemu_cond_init(&event_complete_cond);
> -
>      s->connection_track_table =3D
> g_hash_table_new_full(connection_key_hash,
>                                                        connection_key_equ=
al,
>                                                        g_free, @@ -1384,1=
2 +1397,19 @@ static void
> colo_compare_finalize(Object *obj)
>=20
>      qemu_bh_delete(s->event_bh);
>=20
> +    qemu_mutex_lock(&colo_compare_mutex);
>      QTAILQ_FOREACH(tmp, &net_compares, next) {
>          if (tmp =3D=3D s) {
>              QTAILQ_REMOVE(&net_compares, s, next);
>              break;
>          }
>      }
> +    if (QTAILQ_EMPTY(&net_compares)) {
> +        colo_compare_active =3D false;
> +        qemu_mutex_destroy(&event_mtx);
> +        qemu_cond_destroy(&event_complete_cond);
> +    }
> +    qemu_mutex_unlock(&colo_compare_mutex);
>=20
>      AioContext *ctx =3D iothread_get_aio_context(s->iothread);
>      aio_context_acquire(ctx);
> @@ -1413,15 +1433,18 @@ static void colo_compare_finalize(Object *obj)
>          object_unref(OBJECT(s->iothread));
>      }
>=20
> -    qemu_mutex_destroy(&event_mtx);
> -    qemu_cond_destroy(&event_complete_cond);
> -
>      g_free(s->pri_indev);
>      g_free(s->sec_indev);
>      g_free(s->outdev);
>      g_free(s->notify_dev);
>  }
>=20
> +void colo_compare_init_globals(void)
> +{
> +    colo_compare_active =3D false;
> +    qemu_mutex_init(&colo_compare_mutex);
> +}
> +
>  static const TypeInfo colo_compare_info =3D {
>      .name =3D TYPE_COLO_COMPARE,
>      .parent =3D TYPE_OBJECT,
> diff --git a/net/colo-compare.h b/net/colo-compare.h index
> 22ddd512e2..eb483ac586 100644
> --- a/net/colo-compare.h
> +++ b/net/colo-compare.h
> @@ -17,6 +17,7 @@
>  #ifndef QEMU_COLO_COMPARE_H
>  #define QEMU_COLO_COMPARE_H
>=20
> +void colo_compare_init_globals(void);
>  void colo_notify_compares_event(void *opaque, int event, Error **errp);
> void colo_compare_register_notifier(Notifier *notify);  void
> colo_compare_unregister_notifier(Notifier *notify); diff --git a/softmmu/=
vl.c
> b/softmmu/vl.c index 32c0047889..a913ed5469 100644
> --- a/softmmu/vl.c
> +++ b/softmmu/vl.c
> @@ -112,6 +112,7 @@
>  #include "qapi/qmp/qerror.h"
>  #include "sysemu/iothread.h"
>  #include "qemu/guest-random.h"
> +#include "net/colo-compare.h"
>=20
>  #define MAX_VIRTIO_CONSOLES 1
>=20
> @@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, char **envp)
>      precopy_infrastructure_init();
>      postcopy_infrastructure_init();
>      monitor_init_globals();
> +    colo_compare_init_globals();
>=20
>      if (qcrypto_init(&err) < 0) {
>          error_reportf_err(err, "cannot initialize crypto: ");
> --
> 2.20.1


