Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91053C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:26:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E47820657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 13:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XimrtNTa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E47820657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZaLg-0004Pm-7e
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 09:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZa0Z-0003L9-78; Fri, 15 May 2020 09:04:11 -0400
Received: from mout.web.de ([212.227.15.14]:35347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jZa0X-0006w6-Fv; Fri, 15 May 2020 09:04:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589547842;
 bh=MyMelhgH1XNf8vYPuQ0rDUiZxVUz+acV8VcCxXyVYU0=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=XimrtNTamWhW8qffZ0dubhMpgQOV3Mxg2DQSo66wOq/vAf1IPD0/TjAc4e2ZdxjsU
 JSmxmMTPCL9omtYartU0AoJNF+eeV+Xfs2OUJSPELNb22BC4tehNO63Qzb9MUaNPGV
 +QSqQUKhVt1miOEgxTItnxvc2MNDBSbCniGGLLKs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.164]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LsNpI-1j6xLd42Ke-0122Oq; Fri, 15
 May 2020 15:04:02 +0200
Date: Fri, 15 May 2020 15:03:30 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 3/5] block/nbd.c: Add yank feature
Message-ID: <20200515150330.5a6da104@luklap>
In-Reply-To: <20200515102613.GI1300305@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <1e712fa7f08e4772c2a68197a851161bee51610f.1589193717.git.lukasstraub2@web.de>
 <20200511161909.GJ2811@work-vm> <20200511190524.3681e58c@luklap>
 <20200512085458.GE1191162@redhat.com>
 <20200515114818.25d9eb9c@luklap>
 <20200515100413.GG1300305@redhat.com>
 <20200515121447.60bbd80d@luklap>
 <20200515102613.GI1300305@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/n0SS7W4RCdvvoM6GqtICd8z";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:em4ul1qtdT6/wCB+Tb39pWChQRRXizj/TAf0bU4SNoVNBJnPpZ/
 3JoHfqv8Q6jwD6WNGwNIKaaER3QggHpUoyYnANCNUHUbHWd6hGk05OJXjWbyYwUntsPX6V0
 PdOlOZ4TQS2iC1XbDP3VBhBATuXeFoRQYjLbFiSdSW/Ghrw0U2kL2a3zY8ed869uFIIZMI7
 11InFVKe2qSnzw/HNxumA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6og6bpGiKh0=:Kdb1KXYzIwbkooOhJjgHM4
 5+ZeG9mVInq9IYfn0DSqGQ5E6jop1QT6UtMKF22qlvo6ZglWyR1245vxmXsLHDH/sDPHpOhCS
 nZeSs/QiFa+f7BQlJgKSdGCDa0rbY+QRfvbfC9oGzNujPyAp63BQVLLDY7UwIyN4V4fe5KXY6
 pXgFlU5TQ454E0Q//3Z+mT5DYR2vsbiDcRcQaRhd+9DRRA4r9beHeJOf4K55jsgxCoJ36+Cep
 tBvuA/xplvUVZI67iFeiJ11k1E3rGjg34RQGDrv96NBcx6aSKvxgzTuMBBp0RvsIWYrzL3raR
 GWbN7OMgfbEcK1eNXDqDefj7m8WwZgzdTVQD8kL42N+JH8aDebtBKztMEt9M5AGprf1Qg73VE
 10qYwKkcTSDbacjZ+C5cUN2+nUCPJvg5fd0X59Cj3AH508Q0tGoptukTZE+W/h+73UpBTd3T6
 BCQV1P9b/sJH7YFCrfru3uBB3hAxp88e4yTPsMK+yKF/2nT+VRASR0Nd8U3nYM0A5ior9UH8n
 XOZ0BInAVb83H6GBUC8hXpEB6xxSli+EGZQjMtk77Cf3bNRDls5esqQU+Rgn/y8IHwEA0Mz5U
 SZLasraqW6+kXQB2jifDKq252CgB6LE1uWCrv7W1Nl4okaD1LvlYyyV1yqd0errvRhM/hLjd7
 85VSyRtYj9KvmSxW6QZAY7a/QzCtW0yTJc40FL+QC4y0f9gx+/69BNtutGwsvZSWK0E3X5qp2
 JAQ8dZRgtBvcAd4FHxSAYGeOsY0S9VLlPls2Y4MQHofAEQwQ3gpKyKxWShJK1w9bkTTe6e6Vj
 vBx5yldQptPSYvasOMsgDl4D5TtXVv4SJofEIUVRufOkkUuri001SZx/yX1od9EqCFi41/kxI
 CuLRaXnshZJ0hJYOp05FB4VAGnAc732mGFN9mdxAGA8SylTrWOnmfDVvHqd0Xg3O2f8dSu4i2
 uRgE8kb62eyh7s7JtNDUkl3KAOOCn25DEqQ5vL6StkbtJm6bVzC4iQY+ZB6CkJ9VEirM2SOaN
 F5Y4WcAfIu/47RCWiHy9w0ILVP9jmyk/6CBfhLye7YfS5OYUHq650O3WVToCARcWuxsITk4IA
 EJax/PBiJpgupdORpBNKIQegEzyCMuHpGOW4o/olYcshV310P74/6f7rDEe3XBSDVe7sPD+oq
 Gu52ig9raXVoSJnbom49ASk6HnZCB98Pwx1FOHr9aaq50SPc1/m4kxAD851THDinsON8ZNPTg
 pOLl/VsY1cL5SgB5Q
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 07:11:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/n0SS7W4RCdvvoM6GqtICd8z
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2020 11:26:13 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Fri, May 15, 2020 at 12:14:47PM +0200, Lukas Straub wrote:
> > On Fri, 15 May 2020 11:04:13 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Fri, May 15, 2020 at 11:48:18AM +0200, Lukas Straub wrote: =20
> > > > On Tue, 12 May 2020 09:54:58 +0100
> > > > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> > > >    =20
> > > > > On Mon, May 11, 2020 at 07:05:24PM +0200, Lukas Straub wrote:   =
=20
> > > > > > On Mon, 11 May 2020 17:19:09 +0100
> > > > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > > > >      =20
> > > > > > > * Lukas Straub (lukasstraub2@web.de) wrote:     =20
> > > > > > > > Add yank option, pass it to the socket-channel and register=
 a yank
> > > > > > > > function which sets s->state =3D NBD_CLIENT_QUIT. This is t=
he same
> > > > > > > > behaviour as if an error occured.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Lukas Straub <lukasstraub2@web.de>       =20
> > > > > > >      =20
> > > > > > > > +static void nbd_yank(void *opaque)
> > > > > > > > +{
> > > > > > > > +    BlockDriverState *bs =3D opaque;
> > > > > > > > +    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
> > > > > > > > +
> > > > > > > > +    atomic_set(&s->state, NBD_CLIENT_QUIT);       =20
> > > > > > >=20
> > > > > > > I think I was expecting a shutdown on the socket here - why d=
oesn't it
> > > > > > > have one?     =20
> > > > > >=20
> > > > > > For nbd, we register two yank functions: This one and we enable
> > > > > > the yank feature on the qio channel (see function
> > > > > > nbd_establish_connection below).     =20
> > > > >=20
> > > > > As mentioned on the earlier patch, I don't want to see any yank
> > > > > code in the QIOChannel object directly. This nbd_yank function
> > > > > can simply call the qio_channel_shutdown() function directly
> > > > > and avoid need for modifying the QIOChannel object with yank
> > > > > support.   =20
> > > >=20
> > > > Hi,
> > > > Looking at it again, the problem is not with registering the yank f=
unctions, but with tracking the lifetime of it. Suppose we add qio_channel_=
shutdown to the yank_nbd function. Then we need to unregister it whenever t=
he QIOChannel object is freed.
> > > >=20
> > > > In the code that would lead to the following constructs in a lot of=
 places:
> > > >      if (local_err) {
> > > >          yank_unregister_function(s->yank_name, yank_nbd, bs);
> > > >          object_unref(OBJECT(sioc));
> > > >          error_propagate(errp, local_err);
> > > >          return NULL;
> > > >      }   =20
> > >=20
> > > The nbd patch here already has a yank_unregister_function() so I'm
> > > not seeing anything changes in that respect. The "yank_nbd" function
> > > should check that the I/O channel is non-NULL before calling the
> > > qio_channel_shutdown method. =20
> >=20
> > Hmm, but if object_unref frees the object, it doesn't set the
> > pointer to NULL does it? =20
>=20
> So set  "ioc =3D NULL" after calling object_unref. AFAICT, nbd already
> does exactly this.

I see 3 options to do that in a thread-safe manner:
1. Introduce a mutex here.
2. Use atomics to check for NULL and increase the reference count at the sa=
me time in yank_nbd so it isn't freed while calling qio_channel_shutdown on=
 it. (I'm unsure how to do that)
3. Do it like it is currently done (but with the new subclass). We get thre=
ad safety for free trough the mutex in yank.c.

I prefer option 3 :)

The subclass can live in yank.c. There'd have to be 2 yank functions again =
but a comment in yank_nbd should suffice.

Regards,
Lukas Straub

--Sig_/n0SS7W4RCdvvoM6GqtICd8z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6+kyIACgkQNasLKJxd
sljMuhAAk0OmHBpMs3IO1tqgYc2QJsBLax/jbrJtRhCPgsaFh/RIsul/2ScNrV2S
bphY7FLNqMwQAmP3Xo6A62XUlhS1fBz9w9Jxg+8tQ9mRhM/4bK695hsPfut+aRxp
Y0z6uKZJNfBFurkCACHx8w10gBiBX6qn1Es5Sgbm9i02nurRq9in9s2pN7ENQqIj
yALfq/aBsq2+UGFx6E0K89yXzxJyRZbxcIaoV6BBj4zAio78LOklg+0MagUk+NUE
A4/SkCFLT/6qNl/2iCI/qQlS+ItJuDn9gPoWY7f4q13HCRxgCzwT/zBWwxse4DjV
pzzR31WGf1WbI8ByghYoOFWZmGNpJzvSIHNMSgvjX1wAFGshG1MUwCMU2AEB7zjK
iIO/nRyrapM2p4/gdBlXsuOS2OBe2v6FHjWfuTQAqiqf4H93HXuM4WK6rrrmQ3JN
6yEjwgGBXzvebT70BAR9O+vhFTANCtdWXceaMS551/CSJ/WTEz7wPUXQzKCLAkxn
EKlImehrlO7LMhbcuCW9bYloun0d/DHSxX97cz0r7dRek/3A4uqV32Wqdinws8RA
6jtTZXWj2xl9N02RKRASg0A+O8Av5bH4sIzsJImJ/ac4qeuRridqSj1KybS26y0O
e7tStb0s6AwY5TblYmQ75phcYbYTmpQNI72bxB+hKJepp0rEyiE=
=RGT1
-----END PGP SIGNATURE-----

--Sig_/n0SS7W4RCdvvoM6GqtICd8z--

