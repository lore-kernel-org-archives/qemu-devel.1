Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF598C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 18:11:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB00A21548
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 18:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="OOXLJkO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB00A21548
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmLTr-0004oL-Kx
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 14:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmLQt-0007ZW-D5; Fri, 19 Jun 2020 14:08:07 -0400
Received: from mout.web.de ([212.227.15.14]:37735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jmLQn-0006Dp-NT; Fri, 19 Jun 2020 14:08:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1592590070;
 bh=jk96er0gjnQzDx8bWS8qjFbEs2BGbDXLp1aArx7QkEo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=OOXLJkO3qP0nWNi7qyzJR3YgjmQq0u/URVBvlB3k42YeDf2FQ6vUu5q1OwrMegwi7
 2zb3f3mZl/7yYnBcna1KSpPcQnc1exeygNZYBR3uobkynGYpw4LTs2ypdxvV9VzQv6
 O4/rXEYLV85kZWDH2J6RZbLHhW7Um9qRcKgN4MKE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.165]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V6E-1jmtOO1ubq-000fjY; Fri, 19
 Jun 2020 20:07:50 +0200
Date: Fri, 19 Jun 2020 20:07:34 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH v4 2/4] block/nbd.c: Add yank feature
Message-ID: <20200619200734.12fca8d3@luklap>
In-Reply-To: <20200617150909.GL1728005@stefanha-x1.localdomain>
References: <cover.1590421341.git.lukasstraub2@web.de>
 <8e6a8e61b25813cdcdf385729709ef57f6255a3e.1590421341.git.lukasstraub2@web.de>
 <20200617150909.GL1728005@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E0oJJY0zFcYcRQ=3dsE8fa2";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:8S8M62vT9brjIi/hXPxG0pCbCB1+mc4IN4j/BYqfe8c71aWPem7
 e3tFdRk7N1ctNSj5rrhxsiSgJ4NY/px1gKI+pQRr2gNnLgtBke2JhIZ3bvhSfs2Qpx6Plj3
 SxiDVx9q3zzqtP6+6XjApcfURW3p2vCAmleIw5/bQztFZ5ofH9xPKQ8Jdsv58v0U4u3dVWp
 nZ2oBf1OimVF/juQX/OSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IM499oXQlXc=:Pg76vAN72uIonRg6fSv/td
 rXvdXzTiZt0UOBHFN6U17RIEhutFPUo47fu/jMIokVLRKt7GY6jOZ6ppAEhPOs6WiROGU4C8D
 t/sMcxpCStHCbYtVD6MEscwd7+OvPpPAnfTgWvg9RkUpWQXcnjWdPB66mtkh8mfAj3ru34f2b
 xGLM1Y0iMxg3lpqleVpl2ZiE2Dia2X6IcFdRv8QrjZ2xHLWQfg1SPqkK8hPWjCIdXq2wCiE34
 T1B16pu7/4iS5uH18RdpUHFFI4sqQfttz5QI4O/nZ/2uKJWRW/ZnRLNo/kxXVlsT5cpfHUVia
 2dsrfnB9wgqBwXhzMp1PI+kZ0ClP/Q/xRW0p3QKlZIUek/M1xn3wZ5y5xuCsNBqr1pPXQJKwH
 Dbl00VuW0k+p99wdUBeaepXxhSJKVt10W9vgi9pKLTyY+NVLQ1Go6xBTqYBYt1K4QF6AIu9WV
 poqv9rxWD/9PbxAtaJaSqv/BzcDA3twLBbYxGjbXB2D5utEXhTVSJtZmORORoGgi2wHtV3s/s
 Z7ISJ7bhjR6BXax3fT6PxMyqS67NpVtLepnnTsd/ZcnV64C2npy9m04wqGbkDu0zIOoerfce0
 aSHuGaSh9xWWL7ciUrFLJvnMVfL7dLff7++lueu5Y2zYWNt07kk2A38yFPj0w84DVnZ91lWM8
 0xw/BkymmZ1mhrBu3AxBQiXbNrMr60pA12wlUEpYMXnMQ+HRpUBuTWvvi0F7L9aYp4OMhgM1R
 /V1H5U0h4BOwU/PtksdtTRqYGDefIxDy+S4C06Vv50BHju4Iz8wGbnj4ahWxWWrhjp0iv1/6u
 1SkG8+39LTNI0hsyRwwuYsxXA50VZM7rnLm2z8y7Z9O3+UA4ySVmdax5JFAx+iS/mX2W/XjtC
 IYMdffNs6jzno8XHT/0/GYzZMTrIq2MtLj8dNy3NUIL6pk0vJ3dhOzfwIwR8khLi/IiylIpnb
 HczapwOvzILgc8rAN4PB71YgWZh60wL5dRyGKFvhoyJmxuYkXWQtJEianc+3tlFozRaFdg1nI
 F3AzcHB844BR/XnpsuTHU4JhI8V2ahCd3GfGDUdpT3rXurhKjCFo0VoS+q0ZXPP+qmagTouc1
 FQVDMV41tMmv0VOF15/N3BllAqrXua+Z3To/1hAcLi5XVu6ALYZxG9hvnrdnWVXeSfK8PaszG
 kH6rCu7DtMKdB7ID5kK7fLBlxxYYqZwLvRXRB+9Avebrt1+vxHX7xB763rW5TdbfSahk3LF4n
 h8lLdFXTA+PbLwA0I
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 14:07:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/E0oJJY0zFcYcRQ=3dsE8fa2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Jun 2020 16:09:09 +0100
Stefan Hajnoczi <stefanha@gmail.com> wrote:

> On Mon, May 25, 2020 at 05:44:26PM +0200, Lukas Straub wrote:
> > @@ -1395,6 +1407,15 @@ static int nbd_client_reopen_prepare(BDRVReopenS=
tate *state,
> >      return 0;
> >  }
> >=20
> > +static void nbd_yank(void *opaque)
> > +{
> > +    BlockDriverState *bs =3D opaque;
> > +    BDRVNBDState *s =3D (BDRVNBDState *)bs->opaque;
> > +
> > +    qio_channel_shutdown(QIO_CHANNEL(s->sioc), QIO_CHANNEL_SHUTDOWN_BO=
TH, NULL); =20
>=20
> qio_channel_shutdown() is not guaranteed to be thread-safe. Please
> document new assumptions that are being introduced.
>=20
> Today we can more or less get away with it (although TLS sockets are a
> little iffy) because it boils down the a shutdown(2) system call. I
> think it would be okay to update the qio_channel_shutdown() and
> .io_shutdown() documentation to clarify that this is thread-safe.

Good idea, especially since the migration code already assumes this. I will=
 do this in the next version.

> > +    atomic_set(&s->state, NBD_CLIENT_QUIT); =20
>=20
> docs/devel/atomics.rst says:
>=20
>   No barriers are implied by ``atomic_read`` and ``atomic_set`` in either=
 Linux
>   or QEMU.
>=20
> Other threads might not see the latest value of s->state because this is
> a weakly ordered memory access.
>=20
> I haven't audited the NBD code in detail, but if you want the other
> threads to always see NBD_CLIENT_QUIT then s->state should be set before
> calling qio_channel_shutdown() using a stronger atomics API like
> atomic_load_acquire()/atomic_store_release().

You are right, I will change that in the next version.

Thanks,
Lukas Straub

--Sig_/E0oJJY0zFcYcRQ=3dsE8fa2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7s/uYACgkQNasLKJxd
sliWOg/7BRJAKBuTaoAU9dAam6lmapBSmks8sDw/5jKiboA7ExQbHZCRk6UZnsZg
Q80Z+D8+dv36XL/HItwoNWRWFzGAomaBdSWcw6O3g+o7Mi20TA91/389ErUa6F0M
FCiOEz3evxBFVZxPWtpg5PJ/Xka8jaHzjhiw1utsX3HAjoV7Ht7V82NJ5iFXxJyn
Ejt3ptLxI2a9A4du6M7+xlDgWPPtP5wrdQBbzh0EtCf/TNK8pSwhcSKxYjEvvfWo
S01xcwt5QCGkODH3WuAUMAzIP440J3ceH+lw3X5x3aXh88rG/oWjCQvPWzPMENbj
NsCRSQjSX6rOUHhUmUbWd8zzgYK/VyCktMHcNSFZWCvsm0aCFBzsDg22AkD3TiqM
OOuYuY5eHV/7ojJErDP1Ru+6pXcQujMKAg0xE0ihRpUVyIw1ULkX9k2WIn5WWH7e
qZ+ztluj8qau368XJ0S3MRg4/DhDaMabGdcuds4dvwD29xuimTgzPEnnXmEPTPSD
uU5JQwvBu9xJUS7w15NPCM21ySyQlcWZbmAn95PSYMYysWAYW7Y5PyjxjdQgdxCL
lAwiNzqaGm/t9Kfx6M6BAJ6KIbeG9F7x+BgTgDUn4p0GYG0nN82WtFFDPAp+A6tO
dbeda2kM9jJaWy1SyVcJKt4AjIhGRc7aHVhiE8edEigIddppjsU=
=Ahij
-----END PGP SIGNATURE-----

--Sig_/E0oJJY0zFcYcRQ=3dsE8fa2--

