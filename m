Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E699AC38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A4E320659
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="krH8lsv0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A4E320659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWj0V-0004yH-GJ
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 12:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWirE-0003vI-GQ
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:54:44 -0400
Received: from mout.web.de ([212.227.15.4]:50641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWirD-0007dU-0g
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588866863;
 bh=W5/fWHQejwb1rRwtl3PEeCTF6ZLzA/NS8GTzmYgK1cg=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=krH8lsv0cQFNhyz11xZsfbnNBpjJPdPw5gcq6Y5dlxAh4mE1H/lp7qerrtz5QbnSx
 o2oo57Cqshu8kliY69hUgw5tAmHUEFKsuV/HUtB/zuRzNmc5D3MEVi9J2cdgjRrsVr
 OC2bRXjD0PhZO8TCzfWzbGiq+l4nyKVgxxrjPb2o=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.60]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MV4hR-1jcXDe1imr-00YR1x; Thu, 07
 May 2020 17:54:23 +0200
Date: Thu, 7 May 2020 17:54:21 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that
 colo-compare is active
Message-ID: <20200507175421.185b48f8@luklap>
In-Reply-To: <0380e994e53947cd961cc363d46561d3@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <f6cbde747d78ff080f680c710e2793867a3cf1fa.1588587700.git.lukasstraub2@web.de>
 <0380e994e53947cd961cc363d46561d3@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GVB2=bDY+ECw89nTeP7n=n/";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:KEI0zgFpYfAIwnP2xauLxbAJw2kuaxfcCa9wVCuK9uEhLQv45c3
 ortVfqH0+v0WYcqcaoN7Zdi54HzrHRZhmj191NE0Juwu0aF5xLp1hTnQn917KbosFQivqlE
 L4Z4ji53gtbUNvv8y8ycPQ0GDWR7H0/tTs1aGdVNIIOC9XCVEhNx3LAE1qcmHJCV6wFSQu8
 w+zDwxgAWaFCZ7WHYIGtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qIyNNFAOoUc=:hBjNXqI0NJeVZwzfN33aab
 jZinC9ww6qpnIYC/oX8YINefOGoXcreYj0h/vmiMNRMpYLnWHH7OhI4+PQZ97a+DoSr+FPzev
 hfntE5ZrYGxbHWA1OUbV89e3QvrEJqhjk1H63EVRDS6+muO/ZKlk/F+BzdJLBc+UMJxnIs73e
 KtQZX4Iu1uY5y3m595xGIU/m2Vr1WT3xluR/t8Pb22KO4Du6GIYt+8cP9wILN0fz+DzkxpVaL
 Tg+v/TC/xPAlfwQeAqE6BURE9sIx0YWLN0fh21I9RXz5tQwhoRZIWwH0ryDU39og4IWJ2G1qI
 h0rWKvkCjBJGCw9/dVswOMCdw5X8Z/Qw4YHAH1VfJT1dMkbEmKtjKdRCPiVor4WdQfjLujdXt
 cF82H/5nm0efH9nqAKWbe6mMyboSlNA7LaKwFX7w+Mo7ELFDrhwgaGdjwglg6q8bT5Ci2n6ao
 vvhK7fN0cdgorQTmN9Z3ejxd2TIAo2X8tb47bq/bGFhFnjxg72diKAGYkR7m8mrle1IhjJ8j0
 0rlNslDEkp+Z9ROHaui6mK+GtDG6WWQigxHWs6SCZJWHJod7AqO8UE5xRfEAiz4QIx3XB3FdH
 CxL4/fM0OPFytVlTpzQ/BmFk5LFsowf9l7EYBsofXV4/ekuq0zBG543EVywsdiOfWaCfZS9et
 7XTUJpgIuZ50eFIyMMNAn1SatMp+OcTq4gNqfLMJ+qIqIdMnVPlXMqieX8SYH5LgxQ02TwNXv
 oPIC6HHad4GNNGiR1fp44duodQBuOoIxu5hiYGiB4HqjM5EDslHZEhKgOhrZXEoBjszstRmOG
 vQRBqxpGf/fTo6IgpmkLU9+tVPhzlBtitH6ES/gMe05ZiLZQ1pgUinDCwz+QYx65gi9xOp5pd
 HwsB3dDkTpOOixW15rr4/eQzCi79kr9lGE6RLb2urX8+TYwBfKEzbPM9moWBMg2gEI0o0iYq9
 RU9aomCBLk/XhqTJxulsugNuogBGAJ6ub7fvkd7c0+hHmqwy7LYDJPEt9RH7YqOYXFjvbTlM7
 IF+H0bFdPByNM45kQrBMWvu15pI4uYURRz4lFDREcp5j0yl6fHxjAynQDRwHwV/GXfAY6FaAv
 9bdIvC55H6EdQmkgTKoIV54FengYlDhkBQyNbIYGG/F+8qm1lXNHa2L0bWRBx70y5Mi6fwZ9B
 U8AX8HQd/KhYdDGrQ8YGRIXzHclMYnYD2bZG+vaghcbUsHYESSGRZ67wq8Mz8bu4VIe9fy+Ij
 sEhgQWxnCq2HwKw8z
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 10:29:47
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

--Sig_/GVB2=bDY+ECw89nTeP7n=n/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 May 2020 11:38:04 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Monday, May 4, 2020 6:28 PM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: [PATCH v4 5/6] net/colo-compare.c, softmmu/vl.c: Check that co=
lo-
> > compare is active
> >=20
> > If the colo-compare object is removed before failover and a checkpoint
> > happens, qemu crashes because it tries to lock the destroyed event_mtx =
in
> > colo_notify_compares_event.
> >=20
> > Fix this by checking if everything is initialized by introducing a new =
variable
> > colo_compare_active which is protected by a new mutex
> > colo_compare_mutex. The new mutex also protects against concurrent
> > access of the net_compares list and makes sure that
> > colo_notify_compares_event isn't active while we destroy event_mtx and
> > event_complete_cond.
> >=20
> > With this it also is again possible to use colo without colo-compare (p=
eriodic
> > mode) and to use multiple colo-compare for multiple network interfaces.
> >  =20
>=20
> Hi Lukas,
>=20
> For this case I think we don't need to touch vl.c code, we can solve this=
 issue from another perspective:
> How to remove colo-compare?
> User will use qemu-monitor or QMP command to disable an object, so we jus=
t need return operation failed
> When user try to remove colo-compare object while COLO is running.

Yeah, but that still leaves the other problem that colo can't be used witho=
ut colo-compare (qemu crashes then).

Regards,
Lukas Straub

> Thanks
> Zhang Chen
>=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  net/colo-compare.c | 35 +++++++++++++++++++++++++++++------
> >  net/colo-compare.h |  1 +
> >  softmmu/vl.c       |  2 ++
> >  3 files changed, 32 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > 56db3d3bfc..c7572d75e9 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -54,6 +54,8 @@ static NotifierList colo_compare_notifiers =3D  #defi=
ne
> > REGULAR_PACKET_CHECK_MS 3000  #define DEFAULT_TIME_OUT_MS 3000
> >=20
> > +static QemuMutex colo_compare_mutex;
> > +static bool colo_compare_active;
> >  static QemuMutex event_mtx;
> >  static QemuCond event_complete_cond;
> >  static int event_unhandled_count;
> > @@ -906,6 +908,12 @@ static void check_old_packet_regular(void *opaque)
> > void colo_notify_compares_event(void *opaque, int event, Error **errp) =
 {
> >      CompareState *s;
> > +    qemu_mutex_lock(&colo_compare_mutex);
> > +
> > +    if (!colo_compare_active) {
> > +        qemu_mutex_unlock(&colo_compare_mutex);
> > +        return;
> > +    }
> >=20
> >      qemu_mutex_lock(&event_mtx);
> >      QTAILQ_FOREACH(s, &net_compares, next) { @@ -919,6 +927,7 @@ void
> > colo_notify_compares_event(void *opaque, int event, Error **errp)
> >      }
> >=20
> >      qemu_mutex_unlock(&event_mtx);
> > +    qemu_mutex_unlock(&colo_compare_mutex);
> >  }
> >=20
> >  static void colo_compare_timer_init(CompareState *s) @@ -1274,7 +1283,=
14
> > @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
> >                             s->vnet_hdr);
> >      }
> >=20
> > +    qemu_mutex_lock(&colo_compare_mutex);
> > +    if (!colo_compare_active) {
> > +        qemu_mutex_init(&event_mtx);
> > +        qemu_cond_init(&event_complete_cond);
> > +        colo_compare_active =3D true;
> > +    }
> >      QTAILQ_INSERT_TAIL(&net_compares, s, next);
> > +    qemu_mutex_unlock(&colo_compare_mutex);
> >=20
> >      s->out_sendco.s =3D s;
> >      s->out_sendco.chr =3D &s->chr_out;
> > @@ -1290,9 +1306,6 @@ static void colo_compare_complete(UserCreatable
> > *uc, Error **errp)
> >=20
> >      g_queue_init(&s->conn_list);
> >=20
> > -    qemu_mutex_init(&event_mtx);
> > -    qemu_cond_init(&event_complete_cond);
> > -
> >      s->connection_track_table =3D
> > g_hash_table_new_full(connection_key_hash,
> >                                                        connection_key_e=
qual,
> >                                                        g_free, @@ -1384=
,12 +1397,19 @@ static void
> > colo_compare_finalize(Object *obj)
> >=20
> >      qemu_bh_delete(s->event_bh);
> >=20
> > +    qemu_mutex_lock(&colo_compare_mutex);
> >      QTAILQ_FOREACH(tmp, &net_compares, next) {
> >          if (tmp =3D=3D s) {
> >              QTAILQ_REMOVE(&net_compares, s, next);
> >              break;
> >          }
> >      }
> > +    if (QTAILQ_EMPTY(&net_compares)) {
> > +        colo_compare_active =3D false;
> > +        qemu_mutex_destroy(&event_mtx);
> > +        qemu_cond_destroy(&event_complete_cond);
> > +    }
> > +    qemu_mutex_unlock(&colo_compare_mutex);
> >=20
> >      AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> >      aio_context_acquire(ctx);
> > @@ -1413,15 +1433,18 @@ static void colo_compare_finalize(Object *obj)
> >          object_unref(OBJECT(s->iothread));
> >      }
> >=20
> > -    qemu_mutex_destroy(&event_mtx);
> > -    qemu_cond_destroy(&event_complete_cond);
> > -
> >      g_free(s->pri_indev);
> >      g_free(s->sec_indev);
> >      g_free(s->outdev);
> >      g_free(s->notify_dev);
> >  }
> >=20
> > +void colo_compare_init_globals(void)
> > +{
> > +    colo_compare_active =3D false;
> > +    qemu_mutex_init(&colo_compare_mutex);
> > +}
> > +
> >  static const TypeInfo colo_compare_info =3D {
> >      .name =3D TYPE_COLO_COMPARE,
> >      .parent =3D TYPE_OBJECT,
> > diff --git a/net/colo-compare.h b/net/colo-compare.h index
> > 22ddd512e2..eb483ac586 100644
> > --- a/net/colo-compare.h
> > +++ b/net/colo-compare.h
> > @@ -17,6 +17,7 @@
> >  #ifndef QEMU_COLO_COMPARE_H
> >  #define QEMU_COLO_COMPARE_H
> >=20
> > +void colo_compare_init_globals(void);
> >  void colo_notify_compares_event(void *opaque, int event, Error **errp);
> > void colo_compare_register_notifier(Notifier *notify);  void
> > colo_compare_unregister_notifier(Notifier *notify); diff --git a/softmm=
u/vl.c
> > b/softmmu/vl.c index 32c0047889..a913ed5469 100644
> > --- a/softmmu/vl.c
> > +++ b/softmmu/vl.c
> > @@ -112,6 +112,7 @@
> >  #include "qapi/qmp/qerror.h"
> >  #include "sysemu/iothread.h"
> >  #include "qemu/guest-random.h"
> > +#include "net/colo-compare.h"
> >=20
> >  #define MAX_VIRTIO_CONSOLES 1
> >=20
> > @@ -2906,6 +2907,7 @@ void qemu_init(int argc, char **argv, char **envp)
> >      precopy_infrastructure_init();
> >      postcopy_infrastructure_init();
> >      monitor_init_globals();
> > +    colo_compare_init_globals();
> >=20
> >      if (qcrypto_init(&err) < 0) {
> >          error_reportf_err(err, "cannot initialize crypto: ");
> > --
> > 2.20.1 =20
>=20


--Sig_/GVB2=bDY+ECw89nTeP7n=n/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl60Ly0ACgkQNasLKJxd
sljWphAAp/6lW/OuxEUh+gIaFAapOH4p9NxxVWjRfPWjdMRfR3zt4LJn5TMQJ65w
waS8C6L1PkTZqIXsgAFtwQwMO+zoOqh+g1AJsH7OroJDZZTqBhWGclaLNLdxSrwS
lI2Ue3MtFEBNvRSOkXJ5c6+CqFDTu2z96AbucSKZlainUmtX85kAG6IgPKj1rt8A
lpemOkDrcNWk4bmjkTbI9Jduq51D45dawIC5Xe/QoeNym7u9ohTaZ1o9sOdjGJ5v
tgc1ztf9nDSuJz/Kl8VMuEWEWt2QaiczcMC+0nyxPcqJZKu5YGkd4W9yDSQXHn9o
oVL9TvYhWt/2v16RZe2Zkh3ZiMhBT5QPUyiouscdA4Bf0b6cJb/Dv7UmRoRgDx1v
/9slUmICQc6SRVoqUXPL7WMF88YdwUjwAHFkcWsbmenul+7QH5kYuG0F17ZQVdpy
BdOrsq+4MUFW+GozM91n2xXIXPcRkkDvCIPDaYp96Yl6XnhoQboZZLeuknnIgoUe
50N8lfoBDwYKDket8FeGFUNqt/p7sidQ9ybZUC1aUu+T61Hcwd06B4at56XlKAJN
I32Wys0gXwSkJ4ZtPvm9cG5gtlswUJDEqs9/VzOI09kBzLMhhwFP03r2lW6E1yRJ
Rbo1i+36iHfsTLS/LdzjDcTIFNbujyzCgGFCnrVEa3+0yWQjWVU=
=joDd
-----END PGP SIGNATURE-----

--Sig_/GVB2=bDY+ECw89nTeP7n=n/--

