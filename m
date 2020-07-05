Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54745C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 09:38:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B0522073E
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 09:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Bzki995j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B0522073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js16j-0006dU-7l
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 05:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1js13z-0005RT-2w; Sun, 05 Jul 2020 05:35:55 -0400
Received: from mout.web.de ([212.227.17.12]:36049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1js13x-0008Hh-0g; Sun, 05 Jul 2020 05:35:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1593941744;
 bh=DAPHquYnTj2nzfX37SmmhQe3xnk+jC00RI5CUiKAios=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Bzki995jPtoD1fDOTbQUX3UgPxW37Zr4jZ0FlJXSX+4GIIBMnMZT6KJevKe8Pdtqs
 evXNj9rYgc9vXa7/ENbiBGOx32DqdCRPgwfrUsaxCmFE8mByL2uH6xYxKWMVLIpRWE
 GcNwqa/Z7KiTunnKiMP2UUZIgvbON1Y5ZU9qWRlE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.118]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MLRUX-1k9xQ32ayx-00IQTo; Sun, 05
 Jul 2020 11:35:44 +0200
Date: Sun, 5 Jul 2020 11:35:35 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 0/7] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200705113535.250a4c1c@luklap>
In-Reply-To: <20200624214746.4d8057ad@luklap>
References: <cover.1592923201.git.lukasstraub2@web.de>
 <20200624214746.4d8057ad@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uWDwuON=8X+Vv5jj=imo6m_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:UxKtVw0WIsPepAs2yF72UDTVX3UuvUKID3U1+DR/KxhwKtHQuc1
 YkNnVIU+gRRHi01k/bBF/Cq47ROdQv+pf8riZu8QvVG4nn13S3vsOGm8AZXoiTq/ky+oTy8
 tm1mLzfhS27SsW8p6eqfsIeqfRS7wt6bcbWFt/sKrPJsbuPPcQGJg+QdPy9cAn2DYI1HK2G
 r2KAgnPf3X82dUzdhvttg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yns2Y945QVc=:LzScZPdl57+4wL3MWm2hhS
 vwsNtz0jJXHO8Ler3UwyjcZt3pP2dv1Xds7pZkkZWzFV7c4Y8PCqdXCBV0socAQH8bgxKJLBf
 oK4Os1skDVKTdVbP1S3J9Y4zFNIxl1gvRPYci/OW+ndbElIQe8U8LC85qkfnVwWFnylKjNKz1
 aiR1J0/ITw6n0gLOBpHzSoj1VgKABMXfLIM2Eh9iL/oUjRSzNgfd/sbPCPFmQxM97ZgQuuBAs
 cg7n/x8ixGrxmbxk4scwF/BHnxbyWsQwJKmNSkNoLPhnCAvkgOm1luJxur9HF0Ffx02WgJAyr
 9/EJGF+JjD77z8N5lCwI6/qGmlXeqOgDPPFj/27MpsZkCFB81QzKsVx0yZEQXfnz8LFT/94HY
 Smogk7yHuB1fQrpdXFyv4++ul/32V4CHFDvDzpMmk+XrRB996oTrycalxKQM7CcQUADz02hvQ
 3kYyp8pJ/yt2pUPSnOx9aIxEIbREBegDSv47iwCzKs6Zh3otjILuclpmB1XoIihV/xDiDHrB8
 Lv0tiSzZopyDIUQVy27S1Wdcu7RJy1U0uhz2NKu3ikBqAnHMh/VrOz0HAHMYaInXj+ByWqTsE
 64wA35oxwafCwR7ZQiZCrR3D2406gIyCCnmik44ooaG9Hq6tNh2wZ6NnwqJZB+6/k34G7O/Kn
 0bDgj7w/gWw6Iu6C5Q3/8e13cV2vkC0HtbKuwz2Ijwzb1CgLjaMVXAU8fNCRxhK+scKfEspNo
 KwyZiF6Uhgkj3AFgp7l6MfB2YVw0IhqSesqdJ+uxM8HxT9f6ALLa+5lHl0EPoeiNmjPshdyU9
 ML9un1xhGzpDazXQdSY8OQ79G5DA1nmTfdUULKrouzls5HSezyWWJ6tvYc+OwINMATf2x0YzH
 Zb8yiCob4oJP1Z9peE2N71qJf2ZooGfH+W9FtAdCu7YnL7QTIkjLv/5cBqNZ0ZmANEi1AxOFf
 WEgy7nwtA6aRB5lktH9TDrUp/2pDNkJo/+791nZRb+MT6ahw/IiGUxXgFyXDzKOBTa9EJpVaY
 WS0ZGtfUj9J6sBS9Bn/8q7NPtm+6lrFcw9V4R+uzvuBc6qw9cmz+8TL7EbNRQ1EvXE2y772UJ
 oWy1rJMDr+67zCEQBWqEsdMJvDSw+Yg7awOpH/M9Dmy4rVUctFeDXzrW3CZz20RLKwHJZ1NXn
 t4UIJRFPxtAmFkYecjQ8Blwmj1hpU/zJuslR0u9kGO7NC9JbpnVc+otd47kPZdwfo3ZuJR2gK
 ijBya8M4lI5xOnxP5
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 05:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
 Stefan Hajnoczi <stefanha@gmail.com>, "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/uWDwuON=8X+Vv5jj=imo6m_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jun 2020 21:47:46 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> On Tue, 23 Jun 2020 16:42:30 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
>=20
> > Hello Everyone,
> > In many cases, if qemu has a network connection (qmp, migration, charde=
v, etc.)
> > to some other server and that server dies or hangs, qemu hangs too.
> > These patches introduce the new 'yank' out-of-band qmp command to recov=
er from
> > these kinds of hangs. The different subsystems register callbacks which=
 get
> > executed with the yank command. For example the callback can shutdown()=
 a
> > socket. This is intended for the colo use-case, but it can be used for =
other
> > things too of course.
> >=20
> > Regards,
> > Lukas Straub
> >=20
> > v5:
> >  -move yank.c to util/
> >  -move yank.h to include/qemu/
> >  -add license to yank.h
> >  -use const char*
> >  -nbd: use atomic_store_release and atomic_load_aqcuire
> >  -io-channel: ensure thread-safety and document it
> >  -add myself as maintainer for yank
> >=20
> > v4:
> >  -fix build errors...
> >=20
> > v3:
> >  -don't touch softmmu/vl.c, use __contructor__ attribute instead (Paolo=
 Bonzini)
> >  -fix build errors
> >  -rewrite migration patch so it actually passes all tests
> >=20
> > v2:
> >  -don't touch io/ code anymore
> >  -always register yank functions
> >  -'yank' now takes a list of instances to yank
> >  -'query-yank' returns a list of yankable instances
> >=20
> > Lukas Straub (7):
> >   Introduce yank feature
> >   block/nbd.c: Add yank feature
> >   chardev/char-socket.c: Add yank feature
> >   migration: Add yank feature
> >   io/channel-tls.c: make qio_channel_tls_shutdown thread-safe
> >   io: Document thread-safety of qio_channel_shutdown
> >   MAINTAINERS: Add myself as maintainer for yank feature
> >=20
> >  MAINTAINERS                   |  13 +++
> >  block/nbd.c                   | 101 ++++++++++++-------
> >  chardev/char-socket.c         |  24 +++++
> >  include/io/channel.h          |   2 +
> >  include/qemu/yank.h           |  79 +++++++++++++++
> >  io/channel-tls.c              |   6 +-
> >  migration/channel.c           |  12 +++
> >  migration/migration.c         |  18 +++-
> >  migration/multifd.c           |  10 ++
> >  migration/qemu-file-channel.c |   6 ++
> >  migration/savevm.c            |   2 +
> >  qapi/misc.json                |  45 +++++++++
> >  tests/Makefile.include        |   2 +-
> >  util/Makefile.objs            |   1 +
> >  util/yank.c                   | 179 ++++++++++++++++++++++++++++++++++
> >  15 files changed, 459 insertions(+), 41 deletions(-)
> >  create mode 100644 include/qemu/yank.h
> >  create mode 100644 util/yank.c
> >=20
> > --
> > 2.20.1 =20
>=20
> Forgot to cc Stefan Hajnoczi...

Ping...

--Sig_/uWDwuON=8X+Vv5jj=imo6m_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8BnucACgkQNasLKJxd
slhfXw//cXpTJfshsnc+C0PknQ5ARP45oD9zp+HB9scWYgwjbsyKZalRUocOJEeb
deQE6rAs632oAQ7SAfRzOBgaWbXzciK3MsxusBvhEGjKOpXM/+QOAIVSxbVtx1vp
gvB9lITO/jSM+SWoS6a/u6797gZK/pY76+Y6zG+Lxza87es2/vBBNAXkEDNS0QRR
KAPDp4STPNPy1n4VRK7DJx7Rv/DrFqeg8QnlSbehOhS5Az/12jOnpIdeEagnOKK1
n69TrueO5ee9WH5LJxVYVYBFLOOtPCD2u/rW3NbXgunylL/6ebBVwfe8ofSxD131
njEcwYM2mrKb6fEotcdY4o0+xT/a9i9+C+wDv9icRyRtKdYmiVT2Zgcxyzucp4/D
kvX1Fsj9+h7C6nTDAaN/XSoy/r5T4+QpJnO7u8pyEjcYcwhA3N+VM/ACpsbMhYp9
pvmom8jbdJlf/CbNhegoLl3LXB1Mp75pzKf+AXQtOOXvNO7dJLpYyaKF3vc/sqY9
kN7VbLj6lPAxd75DS0bzeYIVyFmXJObRWv+gPGb75RTc/BXPQGE6UVDNzda0VzH8
OpZFjwz0ugnSwBBEnr4C6KmRhTDnCpJQtOQ2nTladHky6jY4aU3/NvN88lNJ9b8y
DJioeLHGItsNdjVCUQI3E1BIlqGGvHVZUniUe/8N5z0qjnCI9PE=
=wDy1
-----END PGP SIGNATURE-----

--Sig_/uWDwuON=8X+Vv5jj=imo6m_--

