Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87507C31E5C
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 03:20:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CC002084B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 03:20:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CC002084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53388 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd4g4-0003Dq-HI
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 23:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hd4fB-0002Vn-Mc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 23:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hd4fA-00019i-6u
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 23:20:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hd4f9-00018y-Um
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 23:20:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 347634ACDF
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 03:19:58 +0000 (UTC)
Received: from [10.72.12.155] (ovpn-12-155.pek2.redhat.com [10.72.12.155])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 201C978437;
 Tue, 18 Jun 2019 03:19:52 +0000 (UTC)
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, laine@redhat.com
References: <20190613095924.21908-1-dgilbert@redhat.com>
 <20190613095924.21908-4-dgilbert@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e2369f5c-5d68-ff3c-1f09-81646eb86279@redhat.com>
Date: Tue, 18 Jun 2019 11:19:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613095924.21908-4-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 18 Jun 2019 03:19:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v4 3/5] net/announce: Add optional ID
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/6/13 =E4=B8=8B=E5=8D=885:59, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Previously there was a single instance of the timer used by
> monitor triggered announces, that's OK, but when combined with the
> previous change that lets you have announces for subsets of interfaces
> it's a bit restrictive if you want to do different things to different
> interfaces.
>
> Add an 'id' field to the announce, and maintain a list of the
> timers based on id.
>
> This allows you to for example:
>      a) Start an announce going on interface eth0 for a long time
>      b) Start an announce going on interface eth1 for a long time
>      c) Kill the announce on eth0 while leaving eth1 going.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>   hw/net/virtio-net.c    |  4 ++--
>   include/net/announce.h |  8 ++++++--
>   net/announce.c         | 46 +++++++++++++++++++++++++++++++++++------=
-
>   net/trace-events       |  3 ++-
>   qapi/net.json          |  9 +++++++--
>   5 files changed, 56 insertions(+), 14 deletions(-)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index c3f5fccfd1..b9e1cd71cf 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2360,7 +2360,7 @@ static int virtio_net_post_load_device(void *opaq=
ue, int version_id)
>               timer_mod(n->announce_timer.tm,
>                         qemu_clock_get_ms(n->announce_timer.type));
>           } else {
> -            qemu_announce_timer_del(&n->announce_timer);
> +            qemu_announce_timer_del(&n->announce_timer, false);
>           }
>       }
>  =20
> @@ -2784,7 +2784,7 @@ static void virtio_net_device_unrealize(DeviceSta=
te *dev, Error **errp)
>           virtio_net_del_queue(n, i);
>       }
>  =20
> -    qemu_announce_timer_del(&n->announce_timer);
> +    qemu_announce_timer_del(&n->announce_timer, false);
>       g_free(n->vqs);
>       qemu_del_nic(n->nic);
>       virtio_net_rsc_cleanup(n);
> diff --git a/include/net/announce.h b/include/net/announce.h
> index 773470428b..3d90c83c23 100644
> --- a/include/net/announce.h
> +++ b/include/net/announce.h
> @@ -22,8 +22,12 @@ struct AnnounceTimer {
>   /* Returns: update the timer to the next time point */
>   int64_t qemu_announce_timer_step(AnnounceTimer *timer);
>  =20
> -/* Delete the underlying timer and other data */
> -void qemu_announce_timer_del(AnnounceTimer *timer);
> +/*
> + * Delete the underlying timer and other data
> + * If 'free_named' true and the timer is a named timer, then remove
> + * it from the list of named timers and free the AnnounceTimer itself.
> + */
> +void qemu_announce_timer_del(AnnounceTimer *timer, bool free_named);
>  =20
>   /*
>    * Under BQL/main thread
> diff --git a/net/announce.c b/net/announce.c
> index 1ce42b571d..4d4e2c22a1 100644
> --- a/net/announce.c
> +++ b/net/announce.c
> @@ -15,6 +15,8 @@
>   #include "qapi/qapi-commands-net.h"
>   #include "trace.h"
>  =20
> +static GData *named_timers;
> +
>   int64_t qemu_announce_timer_step(AnnounceTimer *timer)
>   {
>       int64_t step;
> @@ -31,8 +33,13 @@ int64_t qemu_announce_timer_step(AnnounceTimer *time=
r)
>       return step;
>   }
>  =20
> -void qemu_announce_timer_del(AnnounceTimer *timer)
> +/*
> + * If 'free_named' is true, then remove the timer from the list
> + * and free the timer itself.
> + */
> +void qemu_announce_timer_del(AnnounceTimer *timer, bool free_named)
>   {
> +    bool free_timer =3D false;
>       if (timer->tm) {
>           timer_del(timer->tm);
>           timer_free(timer->tm);
> @@ -40,6 +47,18 @@ void qemu_announce_timer_del(AnnounceTimer *timer)
>       }
>       qapi_free_strList(timer->params.interfaces);
>       timer->params.interfaces =3D NULL;
> +    if (free_named && timer->params.has_id) {
> +        free_timer =3D timer =3D=3D
> +                     g_datalist_get_data(&named_timers, timer->params.=
id);


Any chance that the timer get from datalist is different from the one=20
that caller passed to us?

Thanks


> +        g_datalist_remove_data(&named_timers, timer->params.id);
> +    }
> +    trace_qemu_announce_timer_del(free_named, free_timer, timer->param=
s.id);
> +    g_free(timer->params.id);
> +    timer->params.id =3D NULL;
> +
> +    if (free_timer) {
> +        g_free(timer);
> +    }
>   }
>  =20
>   /*
> @@ -56,7 +75,7 @@ void qemu_announce_timer_reset(AnnounceTimer *timer,
>        * We're under the BQL, so the current timer can't
>        * be firing, so we should be able to delete it.
>        */
> -    qemu_announce_timer_del(timer);
> +    qemu_announce_timer_del(timer, false);
>  =20
>       QAPI_CLONE_MEMBERS(AnnounceParameters, &timer->params, params);
>       timer->round =3D params->rounds;
> @@ -120,7 +139,8 @@ static void qemu_announce_self_iter(NICState *nic, =
void *opaque)
>           skip =3D false;
>       }
>  =20
> -    trace_qemu_announce_self_iter(nic->ncs->name,
> +    trace_qemu_announce_self_iter(timer->params.has_id ? timer->params=
.id : "_",
> +                                  nic->ncs->name,
>                                     qemu_ether_ntoa(&nic->conf->macaddr=
), skip);
>  =20
>       if (!skip) {
> @@ -143,7 +163,7 @@ static void qemu_announce_self_once(void *opaque)
>       if (--timer->round) {
>           qemu_announce_timer_step(timer);
>       } else {
> -        qemu_announce_timer_del(timer);
> +        qemu_announce_timer_del(timer, true);
>       }
>   }
>  =20
> @@ -154,12 +174,24 @@ void qemu_announce_self(AnnounceTimer *timer, Ann=
ounceParameters *params)
>       if (params->rounds) {
>           qemu_announce_self_once(timer);
>       } else {
> -        qemu_announce_timer_del(timer);
> +        qemu_announce_timer_del(timer, true);
>       }
>   }
>  =20
>   void qmp_announce_self(AnnounceParameters *params, Error **errp)
>   {
> -    static AnnounceTimer announce_timer;
> -    qemu_announce_self(&announce_timer, params);
> +    AnnounceTimer *named_timer;
> +    if (!params->has_id) {
> +        params->id =3D g_strdup("");
> +        params->has_id =3D true;
> +    }
> +
> +    named_timer =3D g_datalist_get_data(&named_timers, params->id);
> +
> +    if (!named_timer) {
> +        named_timer =3D g_new0(AnnounceTimer, 1);
> +        g_datalist_set_data(&named_timers, params->id, named_timer);
> +    }
> +
> +    qemu_announce_self(named_timer, params);
>   }
> diff --git a/net/trace-events b/net/trace-events
> index 875ef2a0f3..ac57056497 100644
> --- a/net/trace-events
> +++ b/net/trace-events
> @@ -1,7 +1,8 @@
>   # See docs/devel/tracing.txt for syntax documentation.
>  =20
>   # announce.c
> -qemu_announce_self_iter(const char *name, const char *mac, int skip) "=
%s:%s skip: %d"
> +qemu_announce_self_iter(const char *id, const char *name, const char *=
mac, int skip) "%s:%s:%s skip: %d"
> +qemu_announce_timer_del(bool free_named, bool free_timer, char *id) "f=
ree named: %d free timer: %d id: %s"
>  =20
>   # vhost-user.c
>   vhost_user_event(const char *chr, int event) "chr: %s got event: %d"
> diff --git a/qapi/net.json b/qapi/net.json
> index 6f2cd4f530..728990f4fb 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -702,6 +702,10 @@
>   # @interfaces: An optional list of interface names, which restricts t=
he
>   #        announcement to the listed interfaces. (Since 4.1)
>   #
> +# @id: A name to be used to identify an instance of announce-timers
> +#        and to allow it to modified later.  Not for use as
> +#        part of the migration parameters. (Since 4.1)
> +#
>   # Since: 4.0
>   ##
>  =20
> @@ -710,7 +714,8 @@
>               'max': 'int',
>               'rounds': 'int',
>               'step': 'int',
> -            '*interfaces': ['str'] } }
> +            '*interfaces': ['str'],
> +            '*id' : 'str' } }
>  =20
>   ##
>   # @announce-self:
> @@ -725,7 +730,7 @@
>   # -> { "execute": "announce-self",
>   #      "arguments": {
>   #          "initial": 50, "max": 550, "rounds": 10, "step": 50,
> -#          "interfaces": ["vn2", "vn3"] } }
> +#          "interfaces": ["vn2", "vn3"], "id": "bob" } }
>   # <- { "return": {} }
>   #
>   # Since: 4.0

