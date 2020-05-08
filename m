Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D2BC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:14:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315E520708
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 06:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HDJ07XsQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315E520708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWwHF-00083K-5D
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 02:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWwE3-0006RO-Pa
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:11:11 -0400
Received: from mout.web.de ([212.227.17.12]:53897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWwE2-0007N9-ED
 for qemu-devel@nongnu.org; Fri, 08 May 2020 02:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588918259;
 bh=ras6cekNjqqPf11yMAq+rlGzdSn7s22LOOGk99w0ukg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=HDJ07XsQDoaeqbeLUJ2WETaHe6AhYAVFTS0kjDFlu15hrxKwmX6virr/IabaF1jU9
 cAe+hbLZ1rideJIGbUQsIptr1J7l56Q7jozYPioDPSw2t+WzANN/UtysFBSgd/5Deb
 xZj1SMNROLlu+Z7VyFM7ibooOHrYVyW14S9w7oC8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.71]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MNLFd-1jV0HK1C3t-006v56; Fri, 08
 May 2020 08:10:59 +0200
Date: Fri, 8 May 2020 08:10:57 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
Message-ID: <20200508081057.7f1db99b@luklap>
In-Reply-To: <59eea784a36643b4b1fe32b0700f57f7@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <f6cbde747d78ff080f680c710e2793867a3cf1fa.1588587700.git.lukasstraub2@web.de>
 <0380e994e53947cd961cc363d46561d3@intel.com>
 <20200507175421.185b48f8@luklap>
 <59eea784a36643b4b1fe32b0700f57f7@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CdsWMHmPx7kUXPyf5yECzq.";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Aa1rBNRHoA6/FiXvNcwcVu4cDZsUIOED9mjx6BxPlBiHk9JAZWv
 +HJaG3nFmLWKyR10AJvR0sEOxxF9fAcrVzSereZbqw2qMX9wBcWV4cURfPDjskj08TSPlNA
 acRLi4RK7YFJo9LL1FKnnkTvBn5ffORVDNv8DzEvGI7ZZ5r+sH0biviw9wUTt1uDcPo8y+s
 7RzhXg1+ZlVBLnEh+jdXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZuphuRaqzH8=:sU2FA6r9cxsj+Kfzzf0/F2
 mT6jcBkUbs1KTMk8FjkcV2JB7qnuC+ASaJEvWcGvMxi14xXzI+lVnBsjy4HFP47UZGp5LCCvq
 oVJ5neBaZjrpb0UzopF93vCSxSct8oZ4J6dMPU7wMjmk5lxphFY1QSCSr/VjUfa6WhzjHVM/8
 0OrX3HJcfwGaiZU02vCvYbv3L8p/U7XVlG9V2ii3GQQOwhHUM78GlmEeIRKqtTkIdh/uR/Lc3
 +0XZ2gfpxiYxh/8PF6TBJgdyLj+qznCPf5Z6hnOAqJl9JcicwyK//zvuAjfSTUGfR+GEtnexU
 F83/Gq7UWlLQIzXwHfvt3r3/eVLIyCzfXodorQ4XPxC0PqgrzetKAvYqz95qcyrJwU9O3OWU+
 QHiqtgvzvXa8UxlivtOMa+ia9ASIVGUeVGfoMP/92vbhCql2cyUCasgt7KGV+SSbaAqpv/9Pz
 kTFVFqyZNuGRniAB4CzGNEWdUv+qpIPpUj233ziAHw99+QaZXNcWyqrOEfH3ctcFlossBM+4B
 hrezHTz2GPWZNiMddtLc//s2JTnOG0YzC+FGXyYZZPWvdKCg6LLJAqqDadQALJEgMS/+0mrkM
 KqfBcDDPv4vlSmZY+C/ZtGoIAntj6e63lQXEuGtHe0s9/yp1vZyJGKzpJ3hBqY+LohcCC4PhA
 exdWekrEGgLvcC6xY2JBosahnVgAv/N4NPGM2xatMFru1BZCQoMoCHzVZCOx4uf7cEHvJpQoz
 htZ3UPBKjls46YfxdtACtEOpfmEp7JTQCWWdsEYeGUKTj3C59iXngBmQtjwdcsJ7cJqZ8xABb
 YtH+nlmDcINVpMLSqdtbILS8gSPnbqvSFbYpxYnU4Ob27LMc8MxLonpBu7zhh7mHdQkZw0pkb
 4hBpDmlW9vX4yj8UZyEsuN/gYEXH1MLwEVwxG7IyU2NhjkkBlSpsJCqaS+2NpvEeVO9mja06z
 QPiKM9doi4JD1G668+Yubae+QEawu4LmZ2SbZ/tNO6k6DGuYw1I4tuajZsCAD3i7c/wffCJIt
 heUyApjDR9ppkm7CxgwatljRTtuuIdeJY9vZdpTlJbSPOtxfU7LR9ayLnOmIKDz0jvgRpCgNM
 sq6jF0sCd/CNO5WU4YaiP4h3TDhaAu5skN5QKbPNxiBv9lAdMX5uK+RSDWs5oHmJ4sX51ECV5
 ZO+r+EUCJ3c/+axNUYtQz8QrIzSnyTBsCwMaztF0bM08KUyycWSP+yl0AbYIbZ47LBrak5BXn
 K0l+s6w6zmhcUTHL0
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 02:08:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/CdsWMHmPx7kUXPyf5yECzq.
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2020 02:26:21 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Thursday, May 7, 2020 11:54 PM
> > To: Zhang, Chen <chen.zhang@intel.com>
> > Cc: qemu-devel <qemu-devel@nongnu.org>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
> > colo-compare is active
> >=20
> > On Thu, 7 May 2020 11:38:04 +0000
> > "Zhang, Chen" <chen.zhang@intel.com> wrote:
> >  =20
> > > > -----Original Message-----
> > > > From: Lukas Straub <lukasstraub2@web.de>
> > > > Sent: Monday, May 4, 2020 6:28 PM
> > > > To: qemu-devel <qemu-devel@nongnu.org>
> > > > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > > > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > > > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > > > <pbonzini@redhat.com>
> > > > Subject: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
> > > > colo- compare is active
> > > >
> > > > If the colo-compare object is removed before failover and a
> > > > checkpoint happens, qemu crashes because it tries to lock the
> > > > destroyed event_mtx in colo_notify_compares_event.
> > > >
> > > > Fix this by checking if everything is initialized by introducing a
> > > > new variable colo_compare_active which is protected by a new mutex
> > > > colo_compare_mutex. The new mutex also protects against concurrent
> > > > access of the net_compares list and makes sure that
> > > > colo_notify_compares_event isn't active while we destroy event_mtx
> > > > and event_complete_cond.
> > > >
> > > > With this it also is again possible to use colo without colo-compare
> > > > (periodic
> > > > mode) and to use multiple colo-compare for multiple network interfa=
ces.
> > > > =20
> > >
> > > Hi Lukas,
> > >
> > > For this case I think we don't need to touch vl.c code, we can solve =
this =20
> > issue from another perspective: =20
> > > How to remove colo-compare?
> > > User will use qemu-monitor or QMP command to disable an object, so we
> > > just need return operation failed When user try to remove colo-compar=
e =20
> > object while COLO is running.
> >=20
> > Yeah, but that still leaves the other problem that colo can't be used w=
ithout
> > colo-compare (qemu crashes then). =20
>=20
> Yes, the COLO-compare is necessary module in COLO original design.
> At most cases, user need it do dynamic sync.
> For rare cases, maybe we can add a new colo-compare parameter to bypass a=
ll the network workload.

I think such an parameter would only be a workaround instead of a real solu=
tion like this patch.

Regards,
Lukas Straub

> Thanks
> Zhang Chen=20
>=20
> >=20
> > Regards,
> > Lukas Straub
> >  =20
> > > Thanks
> > > Zhang Chen
> > > =20
> > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > > > ---
> > > >  net/colo-compare.c | 35 +++++++++++++++++++++++++++++------
> > > >  net/colo-compare.h |  1 +
> > > >  softmmu/vl.c       |  2 ++
> > > >  3 files changed, 32 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > > > 56db3d3bfc..c7572d75e9 100644
> > > > --- a/net/colo-compare.c
> > > > +++ b/net/colo-compare.c
> > > > @@ -54,6 +54,8 @@ static NotifierList colo_compare_notifiers =3D
> > > > #define REGULAR_PACKET_CHECK_MS 3000  #define =20
> > DEFAULT_TIME_OUT_MS =20
> > > > 3000
> > > >
> > > > +static QemuMutex colo_compare_mutex; static bool
> > > > +colo_compare_active;
> > > >  static QemuMutex event_mtx;
> > > >  static QemuCond event_complete_cond;  static int
> > > > event_unhandled_count; @@ -906,6 +908,12 @@ static void
> > > > check_old_packet_regular(void *opaque) void
> > > > colo_notify_compares_event(void *opaque, int event, Error **errp)  {
> > > >      CompareState *s;
> > > > +    qemu_mutex_lock(&colo_compare_mutex);
> > > > +
> > > > +    if (!colo_compare_active) {
> > > > +        qemu_mutex_unlock(&colo_compare_mutex);
> > > > +        return;
> > > > +    }
> > > >
> > > >      qemu_mutex_lock(&event_mtx);
> > > >      QTAILQ_FOREACH(s, &net_compares, next) { @@ -919,6 +927,7 @@
> > > > void colo_notify_compares_event(void *opaque, int event, Error **er=
rp)
> > > >      }
> > > >
> > > >      qemu_mutex_unlock(&event_mtx);
> > > > +    qemu_mutex_unlock(&colo_compare_mutex);
> > > >  }
> > > >
> > > >  static void colo_compare_timer_init(CompareState *s) @@ -1274,7
> > > > +1283,14 @@ static void colo_compare_complete(UserCreatable *uc, =20
> > Error **errp) =20
> > > >                             s->vnet_hdr);
> > > >      }
> > > >
> > > > +    qemu_mutex_lock(&colo_compare_mutex);
> > > > +    if (!colo_compare_active) {
> > > > +        qemu_mutex_init(&event_mtx);
> > > > +        qemu_cond_init(&event_complete_cond);
> > > > +        colo_compare_active =3D true;
> > > > +    }
> > > >      QTAILQ_INSERT_TAIL(&net_compares, s, next);
> > > > +    qemu_mutex_unlock(&colo_compare_mutex);
> > > >
> > > >      s->out_sendco.s =3D s;
> > > >      s->out_sendco.chr =3D &s->chr_out; @@ -1290,9 +1306,6 @@ static
> > > > void colo_compare_complete(UserCreatable
> > > > *uc, Error **errp)
> > > >
> > > >      g_queue_init(&s->conn_list);
> > > >
> > > > -    qemu_mutex_init(&event_mtx);
> > > > -    qemu_cond_init(&event_complete_cond);
> > > > -
> > > >      s->connection_track_table =3D
> > > > g_hash_table_new_full(connection_key_hash,
> > > >                                                        connection_k=
ey_equal,
> > > >                                                        g_free, @@
> > > > -1384,12 +1397,19 @@ static void colo_compare_finalize(Object *obj)
> > > >
> > > >      qemu_bh_delete(s->event_bh);
> > > >
> > > > +    qemu_mutex_lock(&colo_compare_mutex);
> > > >      QTAILQ_FOREACH(tmp, &net_compares, next) {
> > > >          if (tmp =3D=3D s) {
> > > >              QTAILQ_REMOVE(&net_compares, s, next);
> > > >              break;
> > > >          }
> > > >      }
> > > > +    if (QTAILQ_EMPTY(&net_compares)) {
> > > > +        colo_compare_active =3D false;
> > > > +        qemu_mutex_destroy(&event_mtx);
> > > > +        qemu_cond_destroy(&event_complete_cond);
> > > > +    }
> > > > +    qemu_mutex_unlock(&colo_compare_mutex);
> > > >
> > > >      AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> > > >      aio_context_acquire(ctx);
> > > > @@ -1413,15 +1433,18 @@ static void colo_compare_finalize(Object *o=
bj)
> > > >          object_unref(OBJECT(s->iothread));
> > > >      }
> > > >
> > > > -    qemu_mutex_destroy(&event_mtx);
> > > > -    qemu_cond_destroy(&event_complete_cond);
> > > > -
> > > >      g_free(s->pri_indev);
> > > >      g_free(s->sec_indev);
> > > >      g_free(s->outdev);
> > > >      g_free(s->notify_dev);
> > > >  }
> > > >
> > > > +void colo_compare_init_globals(void) {
> > > > +    colo_compare_active =3D false;
> > > > +    qemu_mutex_init(&colo_compare_mutex);
> > > > +}
> > > > +
> > > >  static const TypeInfo colo_compare_info =3D {
> > > >      .name =3D TYPE_COLO_COMPARE,
> > > >      .parent =3D TYPE_OBJECT,
> > > > diff --git a/net/colo-compare.h b/net/colo-compare.h index
> > > > 22ddd512e2..eb483ac586 100644
> > > > --- a/net/colo-compare.h
> > > > +++ b/net/colo-compare.h
> > > > @@ -17,6 +17,7 @@
> > > >  #ifndef QEMU_COLO_COMPARE_H
> > > >  #define QEMU_COLO_COMPARE_H
> > > >
> > > > +void colo_compare_init_globals(void);
> > > >  void colo_notify_compares_event(void *opaque, int event, Error
> > > > **errp); void colo_compare_register_notifier(Notifier *notify);
> > > > void colo_compare_unregister_notifier(Notifier *notify); diff --git
> > > > a/softmmu/vl.c b/softmmu/vl.c index 32c0047889..a913ed5469 100644
> > > > --- a/softmmu/vl.c
> > > > +++ b/softmmu/vl.c
> > > > @@ -112,6 +112,7 @@
> > > >  #include "qapi/qmp/qerror.h"
> > > >  #include "sysemu/iothread.h"
> > > >  #include "qemu/guest-random.h"
> > > > +#include "net/colo-compare.h"
> > > >
> > > >  #define MAX_VIRTIO_CONSOLES 1
> > > >
> > > > @@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, char =20
> > **envp) =20
> > > >      precopy_infrastructure_init();
> > > >      postcopy_infrastructure_init();
> > > >      monitor_init_globals();
> > > > +    colo_compare_init_globals();
> > > >
> > > >      if (qcrypto_init(&err) < 0) {
> > > >          error_reportf_err(err, "cannot initialize crypto: ");
> > > > --
> > > > 2.20.1 =20
> > > =20
>=20


--Sig_/CdsWMHmPx7kUXPyf5yECzq.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl609/EACgkQNasLKJxd
slig/w//QeI+uUj8RcpHJ2XAnpQqKOrcefPhcH05/v5oO3ztX7IgTl+r+K3Cv43F
kDCqLbDCA3Rn/kWpY59U3uZ32PKVwyrh84RJfq2m55OIGmal5M8O/7VcTll0OwTN
vji+AGvnYvblFU1zLwTc9j0+y2QgoMGzKYdtAt8X4rkQbh1unXxtS05IfrgSDFOm
JFVv6QDsdlJ2FT6S+cuB8nQ7hf8EDLYZqcOioWKni5TmvXRQsuT1Uw8QFVYyO4l8
sUMxmjkbtNYg+eSIPz493sYuytd+RfO4PVT9KNYCR7i8q+HXoyMCM70PSoB/nCQq
QiV1uwnperARVF5JBVcJ2VJlzVPcMBoDlaDKiaXJvl/pO2eo6LwJRQUBiB506zn9
XfZZAj16ElXQ8EPX06czpPSsNdWLTqhLNGve5RnRAma/RaQGzZYAjkX44cvvvMLV
0+8pcDBo2uBBnd8WVuJz3JbmxL6FoqpyDN7WQn6GLPH5Qzok5/nYGMSwfdaQ3ndo
O09RZdLcpTjBo0gbyDrT9J7Modfksbivng6UgayaNXe5RshcYOEHlHuXTk+4aC/m
6myxv4sBnxg9f8CKwJT2hmq8Rxni1ngCOXvt5BEoBhmiQlPu6rLQBhzuKdhS8+7e
vEq0W2phe7g6Rdzb69edNZSg/PThReSRQUEbjKjoI41yzUlttyU=
=+7Zf
-----END PGP SIGNATURE-----

--Sig_/CdsWMHmPx7kUXPyf5yECzq.--

