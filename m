Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF8C54E8E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCC0D20736
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 18:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QRw4sMk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCC0D20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYCzr-0004s1-HM
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 14:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYCuo-00080S-Bc; Mon, 11 May 2020 14:12:34 -0400
Received: from mout.web.de ([217.72.192.78]:53625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYCun-0005PL-28; Mon, 11 May 2020 14:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589220746;
 bh=RIO1uR5/qXZfhxy8FN26f+NUR2xFvNPnNW8X+jRZNYo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=QRw4sMk3oNPK/jENO5BV6Imra+H8A0s71ghcOooZMFIKEYLbzK1+JHmqhacFP9Rvk
 bMn/wFxEFEH1c2N3NdOeWrBIA64g2ScjjwyAvw7EY0GoOBtwfzyphmyMrshZpKGfSd
 U/uXh1c9FhTw0PLw126pWhGD7E1Iys5yD7xlJVck=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lzb94-1j3uSu2sk6-014iJ9; Mon, 11
 May 2020 20:12:26 +0200
Date: Mon, 11 May 2020 20:12:18 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200511201218.76f30e0b@luklap>
In-Reply-To: <20200511114947.GJ1135885@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CD/45VGwZzO3pbSoClW__u3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Gt7OEDZmqFSBTJj2FuniN7X5pdGI5vVdcOEXBf4K/kMQqR6JqCx
 95URnlYtnWqYpfjYGOIwRw+pM7o4XhG9kT3czEdCTkWpNktieiotyHaEUyUejEHNkqJrmEp
 YIyU+Us5b5ac36r/GWm18lETCVdqQZESnrNzyjJG2vsF8okFFaWV6QsNdwL4eiy6OnBPbq/
 BRoKkYHkXghAf+k1xljVw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MsB/vzk29zg=:UGxldEesNMqcWWFQ/vaxuW
 D15CXuzVGJPBCXZ+PN0QB2lGoU9QPAu+aTqBI7BDP1kYJ+9fgOcS/BrbF9rV25HyoCUiGhZFx
 bz3Zm4KGZG3wDVkHM/fpEYlMLcc+BMFwubQ1djw0k36ptYn27vj8sXzTOnKKvAjMJ+rryXTng
 djy8OFK24WgZh+mfIsN3Pxdl5IY9kSIGFJiL8/JWcqqmIcYKapbEYu3ON5NJOFAhkE00IEyAe
 AhhWVRmXBIbp7JGKWFvzQmUSflBqiqgru0/UzjYyhSU+T3HboTEBn/12VGtGURD2go+gE2cfR
 eWXYKPd9vUnXxjxSQxCIJf2t3m8Nmmq5rgX+OwnQVt0NN41Yjm+soDVo0jMWrwk+8L1+zqXqT
 36HgaiFpNFTU4yahO56pERxtofx3U90oVhcLPHB0yXSpeKnPvvMVCdz+EG1LP+tJ4dVJReMRW
 fPfzONT+UlxGRbMHsWyrMgsamAyTDYejfRlt+fJ6ZwPlStnsROIuhMJ1F5uofPSoPHOaRJlRQ
 5FPrwCf68WbiG2sDzSuuT5Oi1saLOd2BJ7yIZ9Gp6yeRyhhcZ4iFep8BN16ZTOzK5MuO4Wc6f
 rYA+g1LTveZU491JTvgzEYWBOCLikiP14fPuN0UwgTEm83xatJaGD3EocMII5hznGVbZu8p8Q
 s2n0OTKEcryFxNf4TJVXjV/KlA7ssG2d60ffBglNFxYBuDkbhGzHiFa9cHRn86+foumyBsfsb
 nv+AbJmGteKDM76FkGapdJoZrw4twOUu/pFNnE+kETEuG6Jrd7MhH0zgP9BPOgHCg/Ojn1apo
 4r68VTMJyMGO5AnavWDKcitIaVwDjXuRzN87OHKg89Z/9JRXdTyg6NMOlspdhD2TZMs+QzHxa
 Eq9OADMLd8cQMgC0rZJ9qe463dGW/Qfia1qhDZ1AXVC2n4RgDXwsQWf2g/M0k46cSB2vaMvfJ
 gIV80X7pmwDt41wDxEj23Xyz+w6oecBUzLxnVkZh9Yk++tIsRC6JDPJ+yPa1o4RL1Gxt+qMDb
 bzXs6u1xJ6WNGTwJDzrZINoTUFO0PVQhQ/0EBnNOgwWvvlWTWKpmdCHA9+9lFZm9CMl6wP/T0
 y1TwbjzdRAc5agdl9+WXTTZe41F/Ufg2TKrCWCWGpsV/bLBPi1xF0OEfV6bh8p62Sh1T8MA5m
 QUSDVjecch2bU0T71MN+ur672+x6Zl4wg78hNsAqA2a909ngLUrYqK/iiwhfXjLGiLKJI1Yp9
 96EbEkdpbfId9T7Pr
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/CD/45VGwZzO3pbSoClW__u3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2020 12:49:47 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, May 11, 2020 at 01:14:34PM +0200, Lukas Straub wrote:
> > Hello Everyone,
> > In many cases, if qemu has a network connection (qmp, migration, charde=
v, etc.)
> > to some other server and that server dies or hangs, qemu hangs too. =20
>=20
> If qemu as a whole hangs due to a stalled network connection, that is a
> bug in QEMU that we should be fixing IMHO. QEMU should be doing non-block=
ing
> I/O in general, such that if the network connection or remote server stal=
ls,
> we simply stop sending I/O - we shouldn't ever hang the QEMU process or m=
ain
> loop.
>=20
> There are places in QEMU code which are not well behaved in this respect,
> but many are, and others are getting fixed where found to be important.
>=20
> Arguably any place in QEMU code which can result in a hang of QEMU in the
> event of a stalled network should be considered a security flaw, because
> the network is untrusted in general.

The fact that out-of-band qmp commands exist at all shows that we have to m=
ake tradeoffs of developer time vs. doing things right. Sure, the migration=
 code can be rewritten to use non-blocking i/o and finegrained locks. But a=
s a hobbyist I don't have time to fix this.

> > These patches introduce the new 'yank' out-of-band qmp command to recov=
er from
> > these kinds of hangs. The different subsystems register callbacks which=
 get
> > executed with the yank command. For example the callback can shutdown()=
 a
> > socket. This is intended for the colo use-case, but it can be used for =
other
> > things too of course. =20
>=20
> IIUC, invoking the "yank" command unconditionally kills every single
> network connection in QEMU that has registered with the "yank" subsystem.
> IMHO this is way too big of a hammer, even if we accept there are bugs in
> QEMU not handling stalled networking well.
>=20
> eg if a chardev hangs QEMU, and we tear down everything, killing the NBD
> connection used for the guest disk, we needlessly break I/O.

Yeah, these patches are intended to solve the problems with the colo use-ca=
se where all external connections (migration, chardevs, nbd) are just for r=
eplication. In other use-cases you'd enable the yank feature only on the no=
n-essential connections.

> eg doing this in the chardev backend is not desirable, because the bugs
> with hanging QEMU are typically caused by the way the frontend device
> uses the chardev blocking I/O calls, instead of non-blocking I/O calls.
>=20
>=20
> Regards,
> Daniel


--Sig_/CD/45VGwZzO3pbSoClW__u3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65lYIACgkQNasLKJxd
sljDoRAAh+kIfXBhoAqK8zix85hLtsz21AgGol1JTLO9pvf/8wzlLvaa6hdHJ/ZP
fN69DTjEQzfv1tgzI1HbsMf+KHPA74OIqfnfs3rd1cP07XWprRNj2Yndz2oQQR7x
Bi6GZSAkz+l3lJqL+8AYP1LBOJAz/b7TK4VKPgzYSxyDTQBYBh9mepmqQpKbenZB
aKR8o5ZUNSy4+f/YfBuTbmxM59XjdZMYDTuASKi69XYZps9ZxgYb7Su1xVUxuLYD
Gd60wcoQ/qbLNXl8BtQmiBl3oYnVYabKG7fKaNmJ6iyfUNRyLpuHkfltKEhEpm2I
fXr+OROLV8LJwutUDK0Vw0XOQRH1BW1oZhDW34Dmls4VEOiEAIQ5IyCoduFKD5VZ
bss1CgServ2yG+tQfdAaeRpWDz454mmiNTj7/ClJTu8qWwBiDOu5d3kVa8Zgsa1r
E0moWJ9ASMDcSHxhkNFKZWZNThuFW7Auj8E6k36czr5r74vfBSSP7f4uCsLztBuG
p9iNBZXR19NQxkGbRX8xcxATjj9S34sDDBlAGEd0j0rk0cu+WXA5xVmJg5sptIWf
NONTELTMBjPOjhokvnl02E/tRc74sVa0y1+4zrZxsp+diUJm3WzWiFvlGTnA/5F5
1yn5s5Nai2eqp0TKoCRJm4O4ZLwnopfNn7RB5d9f0r3Jlno+hrU=
=snrg
-----END PGP SIGNATURE-----

--Sig_/CD/45VGwZzO3pbSoClW__u3--

