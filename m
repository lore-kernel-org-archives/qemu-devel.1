Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88349C54E8D
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52AB720714
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 17:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="m+BDAZOz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52AB720714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYBve-0002GF-8s
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 13:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59536)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYBs5-0000B8-H2; Mon, 11 May 2020 13:05:41 -0400
Received: from mout.web.de ([217.72.192.78]:48233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYBs4-0000QT-AM; Mon, 11 May 2020 13:05:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589216733;
 bh=3UZ9T42ixVhIK6oedstnerVogxYPsFF+JVelGAkxhGI=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=m+BDAZOzm6K57ahVBrZtFWFAnArD15LLuLJgSDLsfWHJmXjx+V6zU5W66sYQ/2coj
 xvYDZ9j6OK3E7P2QBh/aPCL5S5Iwhcv1mxMDXPF0BXE9100UW8oaTvPxiFjvWQdbGp
 poG355iC3h6M96uxBaqtMNP4BEsu/R7Z8nMyYZTs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MGzXS-1jLaxD0nYo-00Dow7; Mon, 11
 May 2020 19:05:33 +0200
Date: Mon, 11 May 2020 19:05:24 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH 3/5] block/nbd.c: Add yank feature
Message-ID: <20200511190524.3681e58c@luklap>
In-Reply-To: <20200511161909.GJ2811@work-vm>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <1e712fa7f08e4772c2a68197a851161bee51610f.1589193717.git.lukasstraub2@web.de>
 <20200511161909.GJ2811@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Fw26JbUyinwh0/FOh7zPil4";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:PDZzxCt7km1iM7AUCJ/aKMX+ZEZZ/1Mna4hOygbVjz6SviJ+vUL
 LYNP6Al17qhlEdS8T00BKSsMiUF7AxQ84bOpWIgo0m6gi/1fBEpGAR9tlMcac0KipIMZTQ8
 1fXVlh+znlj7zZyOi2OBlKlh/KxwlXfML51GMd97Vw6DAF5+7lRUij8wou2Kv6i3kNFVirC
 PC8wxGREtxLUVPdDOnPIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HGdt8KSuEeI=:U2RDQ9uO/FsGC9yKBkBT39
 qn1QSx2jyE0ewiRe5Dng6FjDqecQROZp+rRny/O1upG2GOCOns+dBWPJ8ef4KAHt4cgYdguub
 W6EvrXlPi8ns+bNgNTGNZtV1P4MdmqDUI7p6BaqqNqLEM8YAfp0pcwirSA6leYUDyiSZRkh0h
 CmRLwOnCEozau8QLkvNnCCCGKVX+SeK0mPiXVZ2Id7542ncSLmiVmFlroNPtQIJNQgmU4eb5V
 21cE53Z6paoxXkRxJhaAW9SmcO6Rlq7EWizyRaas6T1l2Apf52iN7psJ0rg4y0xiNLnlZnqY3
 A8QG6FQJgnylCIyu1TjfhOpSFJ+FFLO8H4+Bgz/EWvPJCGGKLEbPSf06ZpXMPxXYxem6Tz8xp
 +gm5H68eV/j5Ty39As+BoNlML3WEQV4ja51i57dDMCUBhHcWZSjQ5gKDjnrwmUOQqXXPirsoc
 d4xWcvhHwmmJ+CgwWAwIvde9R6QuR0MjDJUbxzUwE5HeYGlLmfWpOo9AYUlD8rv/TjZDxrhK0
 MdEAbyBndsZ1U7v6xYNmjR1foAG3a/OLs4oy7HdCwXikduOnY5UzmE9TzHlLJJ4wVotZ4/9J7
 9QCP5HAmNgA0GmCE47dkEpW1tS5GOqXk+BWs2Bg3avOHQIQdatBFWa6pEvpheKa9lw6Cwf0Uh
 KagXjxKDLXGrjGGkUoEn/8prnep3vyVQpN+eECrgcrCFYNQTW2FN0ADxHN7iq1K3gZbBRI2q3
 4UoDY093bMZbXiKLz/atx4igBUXCIFwzI3U7D6BGNoPgg8Vs2Co4CHAlVR+656agi608d5DBb
 mb05iKpAxVgt/OR/a9M/6yeJbJc9NAoTp9LgoRIyfJPIGHixfUrfgLhTpwnZS0KurxssHkeJj
 FXXljoAk2AoC35OmWcwgD0Zmrip+wlfkK9rzCvhUxr9WfmVY9Jub5OnGUqcXOEtVAmXx+tQpH
 d16mE7+UExMFkWIlxjasCjtqiuJwuQPVfo39xAGbiZLWROTjJQwuC0o/UBZb6ZVhEtxDXmLSR
 WD+dXBo14g/hpl8MXpROyESXJBdlpkzxtUcNR6j3BNNyoudVLmpeOc8DoBb+nCJLivBieF/eL
 GYoP7VFqgzj8lZoeNJlgfjT8APQpVBAr8zab/lXUansQmmcFtSju8zGXCA81KDJ4Tx4mB+99A
 zCc3N/2yS1FC+06cqxPL6sBpyfYiOp9EpNAscjLHhzpMo3JVvaSb1WJNlSFlyigKGdMlpL3PL
 rCa+F6tLx9BMR83Ln
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 13:05:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Fw26JbUyinwh0/FOh7zPil4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2020 17:19:09 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Lukas Straub (lukasstraub2@web.de) wrote:
> > Add yank option, pass it to the socket-channel and register a yank
> > function which sets s->state =3D NBD_CLIENT_QUIT. This is the same
> > behaviour as if an error occured.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de> =20
>=20
> > +static void nbd_yank(void *opaque)
> > +{
> > +    BlockDriverState *bs =3D opaque;
> > +    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
> > +
> > +    atomic_set(&s->state, NBD_CLIENT_QUIT); =20
>=20
> I think I was expecting a shutdown on the socket here - why doesn't it
> have one?

For nbd, we register two yank functions: This one and we enable the yank fe=
ature on the qio channel (see function nbd_establish_connection below).

Regards,
Lukas Straub

> Dave
>=20
> > +}
> > +
> >  static void nbd_client_close(BlockDriverState *bs)
> >  {
> >      BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
> > @@ -1407,14 +1421,17 @@ static void nbd_client_close(BlockDriverState *=
bs)
> >      nbd_teardown_connection(bs);
> >  }
> > =20
> > -static QIOChannelSocket *nbd_establish_connection(SocketAddress *saddr,
> > +static QIOChannelSocket *nbd_establish_connection(BlockDriverState *bs,
> > +                                                  SocketAddress *saddr,
> >                                                    Error **errp)
> >  {
> > +    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
> >      QIOChannelSocket *sioc;
> >      Error *local_err =3D NULL;
> > =20
> >      sioc =3D qio_channel_socket_new();
> >      qio_channel_set_name(QIO_CHANNEL(sioc), "nbd-client");
> > +    qio_channel_set_yank(QIO_CHANNEL(sioc), s->yank);
> > =20
> >      qio_channel_socket_connect_sync(sioc, saddr, &local_err);
> >      if (local_err) {
> > @@ -1438,7 +1455,7 @@ static int nbd_client_connect(BlockDriverState *b=
s, Error **errp)
> >       * establish TCP connection, return error if it fails
> >       * TODO: Configurable retry-until-timeout behaviour.
> >       */
> > -    QIOChannelSocket *sioc =3D nbd_establish_connection(s->saddr, errp=
);
> > +    QIOChannelSocket *sioc =3D nbd_establish_connection(bs, s->saddr, =
errp);
> > =20
> >      if (!sioc) {
> >          return -ECONNREFUSED;
> > @@ -1829,6 +1846,12 @@ static QemuOptsList nbd_runtime_opts =3D {
> >                      "future requests before a successful reconnect wil=
l "
> >                      "immediately fail. Default 0",
> >          },
> > +        {
> > +            .name =3D "yank",
> > +            .type =3D QEMU_OPT_BOOL,
> > +            .help =3D "Forcibly close the connection and don't attempt=
 to "
> > +                    "reconnect when the 'yank' qmp command is executed=
.",
> > +        },
> >          { /* end of list */ }
> >      },
> >  };
> > @@ -1888,6 +1911,8 @@ static int nbd_process_options(BlockDriverState *=
bs, QDict *options,
> > =20
> >      s->reconnect_delay =3D qemu_opt_get_number(opts, "reconnect-delay"=
, 0);
> > =20
> > +    s->yank =3D qemu_opt_get_bool(opts, "yank", false);
> > +
> >      ret =3D 0;
> > =20
> >   error:
> > @@ -1921,6 +1946,10 @@ static int nbd_open(BlockDriverState *bs, QDict =
*options, int flags,
> >      /* successfully connected */
> >      s->state =3D NBD_CLIENT_CONNECTED;
> > =20
> > +    if (s->yank) {
> > +        yank_register_function(nbd_yank, bs);
> > +    }
> > +
> >      s->connection_co =3D qemu_coroutine_create(nbd_connection_entry, s=
);
> >      bdrv_inc_in_flight(bs);
> >      aio_co_schedule(bdrv_get_aio_context(bs), s->connection_co);
> > @@ -1972,6 +2001,11 @@ static void nbd_close(BlockDriverState *bs)
> >      BDRVNBDState *s =3D bs->opaque;
> > =20
> >      nbd_client_close(bs);
> > +
> > +    if (s->yank) {
> > +        yank_unregister_function(nbd_yank, bs);
> > +    }
> > +
> >      nbd_clear_bdrvstate(s);
> >  }
> > =20
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 943df1926a..1c1578160e 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -3862,6 +3862,8 @@
> >  #                   reconnect. After that time, any delayed requests a=
nd all
> >  #                   future requests before a successful reconnect will
> >  #                   immediately fail. Default 0 (Since 4.2)
> > +# @yank: Forcibly close the connection and don't attempt to reconnect =
when
> > +#        the 'yank' qmp command is executed. (Since: 5.1)
> >  #
> >  # Since: 2.9
> >  ##
> > @@ -3870,7 +3872,8 @@
> >              '*export': 'str',
> >              '*tls-creds': 'str',
> >              '*x-dirty-bitmap': 'str',
> > -            '*reconnect-delay': 'uint32' } }
> > +            '*reconnect-delay': 'uint32',
> > +	    'yank': 'bool' } }
> > =20
> >  ##
> >  # @BlockdevOptionsRaw:
> > --=20
> > 2.20.1
> >  =20
>=20
>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


--Sig_/Fw26JbUyinwh0/FOh7zPil4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65hdQACgkQNasLKJxd
slj61w//VuZw0l2bgNq22nbRtNjjROv6PoHr2A59nAwdA61oe4NGSwTLVcZSBKLB
Xo/xHkTBBzLwslc7uoAQP64rkqsg0jSXeq4WArF4YGr4Q1mBRCnGXaGu6EH+XwI+
iokDn60KVysJXO9PV1pUFd9ApTgWH8oo3AKRTD9lNLEmPTqb6eGW0Yg3IFfH2KKf
orD65uQhLdQ+FTwub3SmFyTzZ4C+Cyp1k8jhi2KaDqtWjbuLwB3zBnWmYZuILuAQ
FkyVY/E0qEV3HyutZmp98Q8cA7DL2LHsi2FHDZc7nszujv6UNYXL3Z7sLLsZZLeT
QQkfOzwnbGjgp3+sFRcOo1vtgbtVGV+IVcw8+gJq+iytR3QwNoqbQdGNOd1CF9NS
azg1RXrEG8wc3Yrl6wddHz+CD9BugFeUsix6hCdCvO11SXqCXjXZn8Gdjg4ZsfnJ
OpSDN4ghTa+ZahLheCAlIDgc9aTRNtpPgL3ueG8OyVryahaZZ431EoDQrFq+YWXf
hyzk0dYEp+XXx1gAscBDdp/kaE/zfbB/jlsVDUj5HH86ICzWGozAK4rnr7kkR/1J
TfPPhkAEG5R/O9slnY5De+lyH30Bs05kYkg7Or8iuWejn28JWgRajj/Ln0nL4SVT
M5cBwvZLo9Tgi/QkqYhPdeIDsY7Dm1aWbvpdUrZ45OpJ8R6ApIc=
=q35d
-----END PGP SIGNATURE-----

--Sig_/Fw26JbUyinwh0/FOh7zPil4--

