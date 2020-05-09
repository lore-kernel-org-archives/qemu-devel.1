Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634D9C28CBC
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 12:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1848D21775
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 12:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="RsAe+BxQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1848D21775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXOY7-0004eF-06
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 08:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jXOUX-0001Hb-9J
 for qemu-devel@nongnu.org; Sat, 09 May 2020 08:22:05 -0400
Received: from mout.web.de ([217.72.192.78]:42003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jXOUS-0001pk-LD
 for qemu-devel@nongnu.org; Sat, 09 May 2020 08:22:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589026891;
 bh=Y78J5fW2WHhbApFJQd2DZniA3lLMIJ/0SdAgDGga2fY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=RsAe+BxQ8C0g6XgjME9PmlhoTkFAisqam0LBkim9x6iIGVf6ulW1ZifK3XzKj/341
 Shl0Av9Z4mI3xzY44WvoFkfGe7MA9QGS8rVH+W9cEnCp99ce4V+TpmZ8EksrozHZjZ
 7Ojyjp8yXv1EDZ0xFaORlSTH+TT6pRaCxTAx8wPw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.119]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MTPit-1jerOO2WrX-00SKet; Sat, 09
 May 2020 14:21:31 +0200
Date: Sat, 9 May 2020 14:21:18 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
Message-ID: <20200509142118.1a77d40d@luklap>
In-Reply-To: <9cacfbefef504b94b2b3c19b2bffaff0@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <f6cbde747d78ff080f680c710e2793867a3cf1fa.1588587700.git.lukasstraub2@web.de>
 <0380e994e53947cd961cc363d46561d3@intel.com>
 <20200507175421.185b48f8@luklap>
 <59eea784a36643b4b1fe32b0700f57f7@intel.com>
 <20200508081057.7f1db99b@luklap>
 <9cacfbefef504b94b2b3c19b2bffaff0@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n2zJZAgFZwzgWSYb6zgU7zD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:TzmbnrpbiANWdj//4W0Y/Zj5wkN90eH+CinysJzcW0D4dgN7VT5
 jKH0k1sh86/BvYohvqBuPW75sZkDYf0yj8iIyiojLZ3cgehQDEWNkApDSciybl/ldycXSa6
 FcDlWTykcahOmjzEnUlQtcgGHKmFXQbDfLxANHcLtTLTDmMiJ9Kcsj9MYAr6D1eLoTu6H2M
 KTEbEo5jo4qHAmbxe8f9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aT1JVCRf32A=:rm/W6KtTfAgxCnFXJCoFby
 vKrO6Raige29CqcPZnooTC4V/GYvGBuxP0wKd09X10pv3+bcBQhgmUVs5EvngS4INQ/veuYJ6
 Dg2yPTYcXyMvxU9KCmU1WGNpmYsLZoPSvSCNJu8QYivLSzgBzeE6ngya/koma8R19bKxPWAUf
 Z4qosjQQMFjH1IhgL1/5OOuhwv0+MCdP8kKNrrWY0kalU5xBkRy3fFdrGsOMQRMuRUWfqjZF6
 gK5GQd6okI9DWtRAUxRQaX4EfR8+IFkHZaSpFijAMM5/JQ5ePQSFy8yw/HX1T7h/vB82N5GOx
 2jchbbzku5avtDi5iQA+zHnjmIB5EDOec1cCzF2HEE6mkrT1yR1Nkv8uDL+gB0Zzg/0Z+6Yhb
 /uC8xoDnCKnth7aRQGCWtt8JkU4qlQC0U1CWwwch/KvWIXxc5MqDUzksoiKi/DqIRmjJcrGtH
 cCbXMp2JGfBwhwfJD0m4k7YussIheZyvJw3wbB++iD2Bl38e4nQPJ1I4HqsX9YsD4H+pZgFtV
 eVE4ip67ZzV3ZHn69EmS2j+FA6YjkLRdnqBqcRh2k1PyYriiCZsndJ8sDnjiNK20shPHNDH3Y
 Jnmad3+oPWBgAkf3/8QDLI31nsCEXSEpdeEdLsBgYwVJfqHpKJjcXiWWsiM+KfmoIgv3x/lqH
 2JuIXle1cZm0kDVtErwrHAzxrguFurymR7O0HbU7L7/M/eJalssfuICa4q1LNqegILkxb3pev
 nQq8yr6O16iS2XdYWKNrglb5qxaKZ5tF0zcmjIxWQ44jmgOuIYPPzAMYaYFbtCgP4MbK4tKSQ
 BIbGFmQghNk1cyIkP5FKMd4bfsesFVrnl0aSAW3Q2L2i6y+B1c7I7uzN0hKcpc3SD26BP3vZt
 4CeD8ZqfyU9dHgKOTyvlYpX76BB/+EQ+vTywdo3kjSMAxjruHc8+GS6F2uBjFNC4hrHAEuPJ3
 qdiSzWF1CbMWuMB9W5VTskVhB/AaTtP3Kx/v4jsctJ9nAFZX1pOkgVs9GZjFy06JJ9iJ6MEQs
 SckZTWBhYF6VfLRII5sgP5B9vIrHsKZd9eDAYp4z02bIUnnXK4pQ2GEKUBslOQSo1CiIk0lJQ
 JCw5pPb1UTO79f/w8Uza66MYA3HZL+ie7ANhVLTcwHhsTbbTE0HwXMYEPauZeumci2c+YJ1cO
 22yBKYcVsS8KyWAO6GeTBi1Xxr9jbkBLF9p3G+46oC88CwmZlVxD+9tk9MmKnr6XoulVSQrf7
 BigDC7t8iVoY5Bozy
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 08:21:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/n2zJZAgFZwzgWSYb6zgU7zD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2020 06:50:39 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Friday, May 8, 2020 2:11 PM
> > To: Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
> > colo-compare is active
> >=20
> > On Fri, 8 May 2020 02:26:21 +0000
> > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> >  =20
> > > > -----Original Message-----
> > > > From: Lukas Straub <lukasstraub2@web.de>
> > > > Sent: Thursday, May 7, 2020 11:54 PM
> > > > To: Zhang, Chen <chen.zhang@intel.com>
> > > > Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
> > > > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > > > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > > > <pbonzini@redhat.com>
> > > > Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check
> > > > that colo-compare is active
> > > >
> > > > On Thu, 7 May 2020 11:38:04 +0000
> > > > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> > > > =20
> > > > > > -----Original Message-----
> > > > > > From: Lukas Straub <lukasstraub2@web.de>
> > > > > > Sent: Monday, May 4, 2020 6:28 PM
> > > > > > To: qemu-devel <qemu-devel@nongnu.org>
> > > > > > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > > > > > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>;
> > > > > > Marc- Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bo=
nzini
> > > > > > <pbonzini@redhat.com>
> > > > > > Subject: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check
> > > > > > that
> > > > > > colo- compare is active
> > > > > >
> > > > > > If the colo-compare object is removed before failover and a
> > > > > > checkpoint happens, qemu crashes because it tries to lock the
> > > > > > destroyed event_mtx in colo_notify_compares_event.
> > > > > >
> > > > > > Fix this by checking if everything is initialized by introducing
> > > > > > a new variable colo_compare_active which is protected by a new
> > > > > > mutex colo_compare_mutex. The new mutex also protects against
> > > > > > concurrent access of the net_compares list and makes sure that
> > > > > > colo_notify_compares_event isn't active while we destroy
> > > > > > event_mtx and event_complete_cond.
> > > > > >
> > > > > > With this it also is again possible to use colo without
> > > > > > colo-compare (periodic
> > > > > > mode) and to use multiple colo-compare for multiple network =20
> > interfaces. =20
> > > > > > =20
> > > > >
> > > > > Hi Lukas,
> > > > >
> > > > > For this case I think we don't need to touch vl.c code, we can
> > > > > solve this =20
> > > > issue from another perspective: =20
> > > > > How to remove colo-compare?
> > > > > User will use qemu-monitor or QMP command to disable an object, so
> > > > > we just need return operation failed When user try to remove
> > > > > colo-compare =20
> > > > object while COLO is running.
> > > >
> > > > Yeah, but that still leaves the other problem that colo can't be
> > > > used without colo-compare (qemu crashes then). =20
> > >
> > > Yes, the COLO-compare is necessary module in COLO original design.
> > > At most cases, user need it do dynamic sync.
> > > For rare cases, maybe we can add a new colo-compare parameter to =20
> > bypass all the network workload.
> >=20
> > I think such an parameter would only be a workaround instead of a real
> > solution like this patch. =20
>=20
> The root problem is why COLO-compare is necessary.
> Yes, maybe someone want to use pure periodic synchronization mode,
> But it means it will lost all guest network support(without colo-compare/=
filter-mirror/filter-redirector/filter-rewriter).
> The secondary guest just a solid backup for the primary guest, when occur=
 failover the new build stateful connection (like TCP)
> will crashed, need userspace to handle this status. It lost the original =
meaning for COLO FT/HA solution, no need use do HA in application layer.
> it looks like normal/remote periodic VM snapshot here.=20

Sure, but maybe the user doesn't need (reliable) network on failover. Also =
proper network support with periodic mode can easily be implemented by modi=
fying filter-buffer to buffer packets until checkpoint. Being able to use c=
olo without colo-compare gives more flexibility to the user.

Regards,
Lukas Straub

> Dave or Jason have any comments here?=20
>=20
> Thanks
> Zhang Chen
>=20
> >=20
> > Regards,
> > Lukas Straub
> >  =20
> > > Thanks
> > > Zhang Chen
> > > =20
> > > >
> > > > Regards,
> > > > Lukas Straub
> > > > =20
> > > > > Thanks
> > > > > Zhang Chen
> > > > > =20
> > > > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > > > ---
> > > > > >  net/colo-compare.c | 35 +++++++++++++++++++++++++++++------
> > > > > >  net/colo-compare.h |  1 +
> > > > > >  softmmu/vl.c       |  2 ++
> > > > > >  3 files changed, 32 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > > > > > 56db3d3bfc..c7572d75e9 100644
> > > > > > --- a/net/colo-compare.c
> > > > > > +++ b/net/colo-compare.c
> > > > > > @@ -54,6 +54,8 @@ static NotifierList colo_compare_notifiers =3D
> > > > > > #define REGULAR_PACKET_CHECK_MS 3000  #define =20
> > > > DEFAULT_TIME_OUT_MS =20
> > > > > > 3000
> > > > > >
> > > > > > +static QemuMutex colo_compare_mutex; static bool
> > > > > > +colo_compare_active;
> > > > > >  static QemuMutex event_mtx;
> > > > > >  static QemuCond event_complete_cond;  static int
> > > > > > event_unhandled_count; @@ -906,6 +908,12 @@ static void
> > > > > > check_old_packet_regular(void *opaque) void
> > > > > > colo_notify_compares_event(void *opaque, int event, Error **err=
p) =20
> > { =20
> > > > > >      CompareState *s;
> > > > > > +    qemu_mutex_lock(&colo_compare_mutex);
> > > > > > +
> > > > > > +    if (!colo_compare_active) {
> > > > > > +        qemu_mutex_unlock(&colo_compare_mutex);
> > > > > > +        return;
> > > > > > +    }
> > > > > >
> > > > > >      qemu_mutex_lock(&event_mtx);
> > > > > >      QTAILQ_FOREACH(s, &net_compares, next) { @@ -919,6 +927,7
> > > > > > @@ void colo_notify_compares_event(void *opaque, int event, =20
> > Error **errp) =20
> > > > > >      }
> > > > > >
> > > > > >      qemu_mutex_unlock(&event_mtx);
> > > > > > +    qemu_mutex_unlock(&colo_compare_mutex);
> > > > > >  }
> > > > > >
> > > > > >  static void colo_compare_timer_init(CompareState *s) @@ -1274,7
> > > > > > +1283,14 @@ static void colo_compare_complete(UserCreatable *uc=
, =20
> > > > Error **errp) =20
> > > > > >                             s->vnet_hdr);
> > > > > >      }
> > > > > >
> > > > > > +    qemu_mutex_lock(&colo_compare_mutex);
> > > > > > +    if (!colo_compare_active) {
> > > > > > +        qemu_mutex_init(&event_mtx);
> > > > > > +        qemu_cond_init(&event_complete_cond);
> > > > > > +        colo_compare_active =3D true;
> > > > > > +    }
> > > > > >      QTAILQ_INSERT_TAIL(&net_compares, s, next);
> > > > > > +    qemu_mutex_unlock(&colo_compare_mutex);
> > > > > >
> > > > > >      s->out_sendco.s =3D s;
> > > > > >      s->out_sendco.chr =3D &s->chr_out; @@ -1290,9 +1306,6 @@
> > > > > > static void colo_compare_complete(UserCreatable
> > > > > > *uc, Error **errp)
> > > > > >
> > > > > >      g_queue_init(&s->conn_list);
> > > > > >
> > > > > > -    qemu_mutex_init(&event_mtx);
> > > > > > -    qemu_cond_init(&event_complete_cond);
> > > > > > -
> > > > > >      s->connection_track_table =3D
> > > > > > g_hash_table_new_full(connection_key_hash,
> > > > > >                                                        connecti=
on_key_equal,
> > > > > >                                                        g_free,
> > > > > > @@
> > > > > > -1384,12 +1397,19 @@ static void colo_compare_finalize(Object
> > > > > > *obj)
> > > > > >
> > > > > >      qemu_bh_delete(s->event_bh);
> > > > > >
> > > > > > +    qemu_mutex_lock(&colo_compare_mutex);
> > > > > >      QTAILQ_FOREACH(tmp, &net_compares, next) {
> > > > > >          if (tmp =3D=3D s) {
> > > > > >              QTAILQ_REMOVE(&net_compares, s, next);
> > > > > >              break;
> > > > > >          }
> > > > > >      }
> > > > > > +    if (QTAILQ_EMPTY(&net_compares)) {
> > > > > > +        colo_compare_active =3D false;
> > > > > > +        qemu_mutex_destroy(&event_mtx);
> > > > > > +        qemu_cond_destroy(&event_complete_cond);
> > > > > > +    }
> > > > > > +    qemu_mutex_unlock(&colo_compare_mutex);
> > > > > >
> > > > > >      AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > > > > >      aio_context_acquire(ctx);
> > > > > > @@ -1413,15 +1433,18 @@ static void colo_compare_finalize(Objec=
t =20
> > *obj) =20
> > > > > >          object_unref(OBJECT(s->iothread));
> > > > > >      }
> > > > > >
> > > > > > -    qemu_mutex_destroy(&event_mtx);
> > > > > > -    qemu_cond_destroy(&event_complete_cond);
> > > > > > -
> > > > > >      g_free(s->pri_indev);
> > > > > >      g_free(s->sec_indev);
> > > > > >      g_free(s->outdev);
> > > > > >      g_free(s->notify_dev);
> > > > > >  }
> > > > > >
> > > > > > +void colo_compare_init_globals(void) {
> > > > > > +    colo_compare_active =3D false;
> > > > > > +    qemu_mutex_init(&colo_compare_mutex);
> > > > > > +}
> > > > > > +
> > > > > >  static const TypeInfo colo_compare_info =3D {
> > > > > >      .name =3D TYPE_COLO_COMPARE,
> > > > > >      .parent =3D TYPE_OBJECT,
> > > > > > diff --git a/net/colo-compare.h b/net/colo-compare.h index
> > > > > > 22ddd512e2..eb483ac586 100644
> > > > > > --- a/net/colo-compare.h
> > > > > > +++ b/net/colo-compare.h
> > > > > > @@ -17,6 +17,7 @@
> > > > > >  #ifndef QEMU_COLO_COMPARE_H
> > > > > >  #define QEMU_COLO_COMPARE_H
> > > > > >
> > > > > > +void colo_compare_init_globals(void);
> > > > > >  void colo_notify_compares_event(void *opaque, int event, Error
> > > > > > **errp); void colo_compare_register_notifier(Notifier *notify);
> > > > > > void colo_compare_unregister_notifier(Notifier *notify); diff
> > > > > > --git a/softmmu/vl.c b/softmmu/vl.c index 32c0047889..a913ed5469
> > > > > > 100644
> > > > > > --- a/softmmu/vl.c
> > > > > > +++ b/softmmu/vl.c
> > > > > > @@ -112,6 +112,7 @@
> > > > > >  #include "qapi/qmp/qerror.h"
> > > > > >  #include "sysemu/iothread.h"
> > > > > >  #include "qemu/guest-random.h"
> > > > > > +#include "net/colo-compare.h"
> > > > > >
> > > > > >  #define MAX_VIRTIO_CONSOLES 1
> > > > > >
> > > > > > @@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, cha=
r =20
> > > > **envp) =20
> > > > > >      precopy_infrastructure_init();
> > > > > >      postcopy_infrastructure_init();
> > > > > >      monitor_init_globals();
> > > > > > +    colo_compare_init_globals();
> > > > > >
> > > > > >      if (qcrypto_init(&err) < 0) {
> > > > > >          error_reportf_err(err, "cannot initialize crypto: ");
> > > > > > --
> > > > > > 2.20.1 =20
> > > > > =20
> > > =20
>=20


--Sig_/n2zJZAgFZwzgWSYb6zgU7zD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl62oD4ACgkQNasLKJxd
slgDZA/+IsihxQJFO+Jga/l1gNP8Vmmpi8NLTkzuBHDGMTLWNWH60sBrF5OMUluW
1Ga4YWXB73d6DFp+uHL3QPEucX3FKN9rryeJoS8j3hwBMwmba+m9zMEhIPbVgKSq
rbSRoV29AyLlwduT4Xc0mR1mfdv/iNeIwv4iEPLkpAdvIuChVVcNDMBVGFEq4/Hf
1f74OWuLTt4DD0wDOIr1K88aSsfdeXEHZLHHdZBDZyagl1ZKg2p1nYHP5ljD2h4t
Iu5IHtxzTeMf80pt2VbkYshrzB0ZoC8Ja+vgl45MYlf6Teg8Uis5KGmkN+fsQhOu
+FAWnIUkueiouzirBJmCPGQA1eJNtWBA48YjfuDULl9jMy+mcGQGLgmef3GKV/Vu
+mW/CjNIFX54ZpCYW0v81hFUFypLsOIdhqHywY4mElMMolJ70EX0AEViWsUiXJBG
CSXwHClYgoxciY+uohJFKmzXa2ayGpEzWVKVNDEUT+haEUWvbG8W3I/GZdTaUyQl
KFrU1IpmBLbBZFnxt0YWa+HG4wXPqJR+eIxedjR7881fA4oXeK/fMr5Jlnxg/PcR
vms9ZKxjGQSCpvlQMqM+OhePp2Ay/NTsA2RX5puwXbHbdHQfMfULikUfHwVf0+61
uIDfVwzujWbMv6pZnNwYKsVQITf7RFFY7Bnf5oBdmDUh7wrP1Ro=
=ngSD
-----END PGP SIGNATURE-----

--Sig_/n2zJZAgFZwzgWSYb6zgU7zD--

