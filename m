Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31D6C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9614020838
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 16:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="JZOPOfSr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9614020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWj9S-0001JX-Hh
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 12:13:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWj5e-0005wt-5I
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:09:38 -0400
Received: from mout.web.de ([217.72.192.78]:60847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jWj5c-0000Pu-LM
 for qemu-devel@nongnu.org; Thu, 07 May 2020 12:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1588867760;
 bh=IlmrSLSPD71Xw1XGS5W4wZG7wtI5b5cR/XLj4rs4wAY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=JZOPOfSrx4TmR1hP/VR/VrlN62iIcDe6XDtFSJ7GbZ/yabocPEU9jUfgjJk0OWsSm
 2FkCAApPanZHOfR1MTzTgTBVwMz7ofsi5Jl2gg8dhq8/bkKhZzl8B3UFfhF0HBTK+0
 Sk4rDfHUFA4bFcR+LbaGuF1Su0fZAexWrberkrkk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.60]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSrgv-1jejyU3Zf3-00Ru7n; Thu, 07
 May 2020 18:09:19 +0200
Date: Thu, 7 May 2020 18:09:09 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH v4 6/6] net/colo-compare.c: Correct ordering in complete
 and finalize
Message-ID: <20200507180909.06165172@luklap>
In-Reply-To: <83c26ab24d28480d94c45c0a0f49d130@intel.com>
References: <cover.1588587700.git.lukasstraub2@web.de>
 <ac784f17537184c3ab8c745a1d593b02bde85738.1588587700.git.lukasstraub2@web.de>
 <83c26ab24d28480d94c45c0a0f49d130@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5ls5PXc6JyqvPwOoRK2WSQ2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:6bvART3vtrmM48BV1BlT6ADxszO+/eIvaTscSDTzdFIIhYjYaWP
 XfbowLzUU7TxqBpwEPYdJ4jiouj1xfMnCmJRd4d3+ggiGfnqQXGCzt2bZqERF96Ql0gDM3b
 OqQPM4Irh9JHfle05wVbpce3X+LDu/nhB312d+YdQlfX9v7h46G5bepPR7gdU6K3BDXI7kf
 QYBq5G30LWRgVPKMmqmLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eSZehb1LJtg=:WMtT+/uSMWxzYMM8ENoiyK
 C+S1S4LhFevG7m8HHVE4zldIpKH4Ud8GJnvI7nPFTfpdp2B9bjxG1JdCcP66Skon4AVeAQYUj
 PB3b+vODpwaVrawAru6KHBfZIC2Ab6yv3kKG8ogH9FQN34X15IR35ITkoLis4eRxg37E+tozc
 Hav1kVD47DQIbBg+UY0U2A5AQBhdO4illqHIqbEx3DnJRdknbS5Lj09EJdvhKnwm+4hWX6kTD
 TZzucGca/wegorbtJMMSFA/nViy0msUL0WK7aqzCypKa26/aiyHLNt1AkrMO67ye1eDqCEX6f
 5K0B660kBipwSkkr+OdXbdyBeIdGMumVhFMXI4qJ4FsRMLVHWXxOiyNhKXBzmJV5/02lPkV0X
 LOCreQXjFVCXYk1dBW9GyS529o2sgbBA4flG4PtjdOXkgAc3LLUxSYW2/PatUS/4BbFn155zK
 OKglta14rzdlE/QDtooLgpmf052Pvnx0Ji1YfDFE6fybXHZ5oWGqEzoic2480MSacf2eLXZlk
 EFGHZtontaMGJG16O5/XiX561HEaMHpTVj6Wu9m2TgFwH28PIck+FtYcasyMLrpc5+Qhst4d+
 DhtULmBqF9aCetEkRmYPG3PIujJCd7IE1D7+NHjKUeNGU6ORDoblum6szDP9WkpRD+yT/KnYh
 zwu8StJAzyxRaRkXn8vnoWdQnw4HE/0gL2ZU/X+9ebc1m+ui8GY1e9/VdnKN6Q5pJCuXkgWA3
 NcmmW/hc4jEBaFkDbOz4rWSEH12ADOEDlB3ZKef6Aqf7QHzIiSvXx/kR/X2ABYVZWIav6SHmY
 XVVxuMF26QeC5pZ5Z6gU0C3iSYUaOTOypNgRofZmI4rC0W9Fp+9WTFrc5W3UWlkf0IJ8s8iEs
 /zs8RbvcK9HYuLwM2j/poe880e5CVM+i65JcjK5zEE484LKORMxF8jMSFUUHXHLt5zMwRUFcY
 S6SrsW0KTS2m3gm+33FUHxOEDK+SVchRaoJ0rw//LS6UfPwWd+F6ns3LEVxFXfnS1HadK9OzX
 3fXO8z+P3VhrBfDGcADg6izql/DqLjC2FM/AR8OPvRfYYqkYTyjqARX5bembH/gwh81UnqKY8
 1b0niXOeh77kjFYoRuPAEQuR4Q+WRclcw+pnpkiUbYK+WweE/nXj1DJfHTbYEoM0qLZEIGpws
 ZI2Vfa0azVui7rroH64ZSRLIhzYjI55l0DDTfTR9ZCFIo22MyITX6yBUabkADWmfqaax7CIv5
 CZc7Xby0pEt5Jnxwm
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 12:09:34
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/5ls5PXc6JyqvPwOoRK2WSQ2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 May 2020 13:26:11 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Monday, May 4, 2020 6:28 PM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Zhang, Chen <chen.zhang@intel.com>; Li Zhijian
> > <lizhijian@cn.fujitsu.com>; Jason Wang <jasowang@redhat.com>; Marc-
> > Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>; Paolo Bonzini
> > <pbonzini@redhat.com>
> > Subject: [PATCH v4 6/6] net/colo-compare.c: Correct ordering in complete
> > and finalize
> >=20
> > In colo_compare_complete, insert CompareState into net_compares only
> > after everything has been initialized.
> > In colo_compare_finalize, remove CompareState from net_compares before
> > anything is deinitialized. =20
>=20
> S/deinitialized/finalized
>=20
> It looks no dependences on each step on initialization and finalization.
> Do you means we just need add/remove each colo-compare module at last in =
logic?

Yes. While I didn't see any crashes here, there is the possibility that if =
colo-compare is removed during checkpoint, the destroyed event_bh is called=
 from colo_notify_compares_event. Same with colo_compare_complete (very unl=
ikely) if colo-compare is created while colo is running, colo_notify_compar=
es_event may call the uninitialized event_bh.

Regards,
Lukas Straub

> Or current code have some issue?
>=20
> Thanks
> Zhang Chen
>=20
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  net/colo-compare.c | 45 +++++++++++++++++++++++----------------------
> >  1 file changed, 23 insertions(+), 22 deletions(-)
> >=20
> > diff --git a/net/colo-compare.c b/net/colo-compare.c index
> > c7572d75e9..6f80bcece6 100644
> > --- a/net/colo-compare.c
> > +++ b/net/colo-compare.c
> > @@ -1283,15 +1283,6 @@ static void
> > colo_compare_complete(UserCreatable *uc, Error **errp)
> >                             s->vnet_hdr);
> >      }
> >=20
> > -    qemu_mutex_lock(&colo_compare_mutex);
> > -    if (!colo_compare_active) {
> > -        qemu_mutex_init(&event_mtx);
> > -        qemu_cond_init(&event_complete_cond);
> > -        colo_compare_active =3D true;
> > -    }
> > -    QTAILQ_INSERT_TAIL(&net_compares, s, next);
> > -    qemu_mutex_unlock(&colo_compare_mutex);
> > -
> >      s->out_sendco.s =3D s;
> >      s->out_sendco.chr =3D &s->chr_out;
> >      s->out_sendco.notify_remote_frame =3D false; @@ -1312,6 +1303,16 @@
> > static void colo_compare_complete(UserCreatable *uc, Error **errp)
> >                                                        connection_destr=
oy);
> >=20
> >      colo_compare_iothread(s);
> > +
> > +    qemu_mutex_lock(&colo_compare_mutex);
> > +    if (!colo_compare_active) {
> > +        qemu_mutex_init(&event_mtx);
> > +        qemu_cond_init(&event_complete_cond);
> > +        colo_compare_active =3D true;
> > +    }
> > +    QTAILQ_INSERT_TAIL(&net_compares, s, next);
> > +    qemu_mutex_unlock(&colo_compare_mutex);
> > +
> >      return;
> >  }
> >=20
> > @@ -1384,19 +1385,6 @@ static void colo_compare_finalize(Object *obj)
> >      CompareState *s =3D COLO_COMPARE(obj);
> >      CompareState *tmp =3D NULL;
> >=20
> > -    qemu_chr_fe_deinit(&s->chr_pri_in, false);
> > -    qemu_chr_fe_deinit(&s->chr_sec_in, false);
> > -    qemu_chr_fe_deinit(&s->chr_out, false);
> > -    if (s->notify_dev) {
> > -        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
> > -    }
> > -
> > -    if (s->iothread) {
> > -        colo_compare_timer_del(s);
> > -    }
> > -
> > -    qemu_bh_delete(s->event_bh);
> > -
> >      qemu_mutex_lock(&colo_compare_mutex);
> >      QTAILQ_FOREACH(tmp, &net_compares, next) {
> >          if (tmp =3D=3D s) {
> > @@ -1411,6 +1399,19 @@ static void colo_compare_finalize(Object *obj)
> >      }
> >      qemu_mutex_unlock(&colo_compare_mutex);
> >=20
> > +    qemu_chr_fe_deinit(&s->chr_pri_in, false);
> > +    qemu_chr_fe_deinit(&s->chr_sec_in, false);
> > +    qemu_chr_fe_deinit(&s->chr_out, false);
> > +    if (s->notify_dev) {
> > +        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
> > +    }
> > +
> > +    if (s->iothread) {
> > +        colo_compare_timer_del(s);
> > +    }
> > +
> > +    qemu_bh_delete(s->event_bh);
> > +
> >      AioContext *ctx =3D iothread_get_aio_context(s->iothread);
> >      aio_context_acquire(ctx);
> >      AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
> > --
> > 2.20.1 =20


--Sig_/5ls5PXc6JyqvPwOoRK2WSQ2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl60MqUACgkQNasLKJxd
slhoMBAAoc6/x8Gx1aeYJWDGgR/MnEfzTqQh7T7hepF+D1RYXwCe/SsNcG45ngmj
m2b/muTAunZLHDm6xjFSUebxWHd6xFKgYBn+Vm9Z4aM9XfRiquxQasfaux4j21MG
qhKvD4ZAm+JcRidFvZ8ur2xprbKNkk2q21VuThv7gJOJOeJy6TsHmK9ayanCAqwP
3dBBq6K1nul9hfBCqT8meQiexO1I8ftmCx4PJe5tgkVyqlKANUy6xJsSa143jMS2
bTjX5t4EI8ulHh4S1cDDsfq5kG2mn+b1S/NdWJmg/SljwJuzuslEfn46kJoEhyn/
3+/5Bkfu99V7VlHkIf9tqtHZ2WKpqc9Zg/d3dj4hnFdsqgVItCoEZ3CkOWahbJTv
lmF/8KDe1Z+P1enVvgtmH+jypRebuXAovyVk6kVuDaOVo1LxS5JqPEB+COMPZ4ov
8DiYfekb2yzZVtzuJKqLELWdI0t4Lje1NKDzQgFPGMzspHgWrOjN5zpAg8vv1ixx
4vjMT7XS47FQUjW/vcVKLaE1zwsIoPaqnHo8jraZSnn/bVKvyFsdbkPdnOWgQ3ac
VgKyvwHDzMOPCcXbQbhkGirgtnkWL1nti0sdtHgIu4ZLE22jySTxw9KJI2Rf+0kU
7xsT1s8bWRmxowZRyClVs9g7mrgpADGqL3m/qenIdb1JMa7roCE=
=FaJ6
-----END PGP SIGNATURE-----

--Sig_/5ls5PXc6JyqvPwOoRK2WSQ2--

