Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB4DC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:45:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9123820752
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 19:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="oAevhTOl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9123820752
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYEN3-0002uE-Jb
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 15:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55364)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYEJL-0001vC-7L; Mon, 11 May 2020 15:41:59 -0400
Received: from mout.web.de ([212.227.17.11]:38321)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jYEJJ-0000m4-Pr; Mon, 11 May 2020 15:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1589226111;
 bh=h/1Rw9OSK7nnpsoEkBF0j74r26e3a21eCGVikPJYtIE=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=oAevhTOlin2E7t5DUKaOpTwwZKyhC3XQDpLGdsnM1pbWerThkbaPhXzVy9nVYcTUR
 R25jtV6shJCantx3jUu4z3il+6viCRjiDzSyfACz2o/UCeSdxgj8ubjHlcq9PAWo/t
 uljzyPgvngC78AodZ/AQXeo46XjyQRt/pW9fVcls=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.192]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M8R26-1jCjAz1k4g-00vzG7; Mon, 11
 May 2020 21:41:51 +0200
Date: Mon, 11 May 2020 21:41:32 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 0/5] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200511214132.3c8df306@luklap>
In-Reply-To: <20200511121714.GL1135885@redhat.com>
References: <cover.1589193717.git.lukasstraub2@web.de>
 <20200511114947.GJ1135885@redhat.com>
 <20200511120718.GD2811@work-vm>
 <20200511121714.GL1135885@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ziaXSetJP/J1hLY32NVmLW6";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:EQlOdKQQdd/4okXvn7jq2U0qrKvge2aNxhOnV2iJSNHmStnhVCv
 7V80wN29Wo4hpcL55Vgw3sBxVnqpSBem77jw9d9UffI4jyb1jo3WMQOjgMFdTSUdE9PdQXZ
 PvbHNtzra+ccDmbjFERsLcwjEA7Br18UyPEpZ7Mi2Bjm8hlLa7HpKftS0nyeaUg3m7QwLjU
 jTkPozo4h9Tot+Nhzl30Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nh4iaqHcNNI=:UPwVT5rOIWVqbUZ5RfnySP
 lKurqeHThKadpvbqZspBoy0ZgCM6qaRasqYNUa4RuRK7QhsAyS1xpiy/4ki6p+M3EwxGJhBjL
 0Tf2JbmhlrqTVta/vcjD+58Bu/h7pqOdyGywiWyUCIfNLKyi7WSDkOsEdjE8hINCdz5FkZi5I
 YiEeoEjCQH67vDo9PwyFUJ/VGkfkidTHUaVrIAltgeRYQ9ZVVUzobjdInSbgoBM1MoYmYxndZ
 LZ3g5o8PD64AzUs3UY8cuOumRBc5GK+YXJUNBEBBGvJatRn7luxno1urPole9AO8pNPPJo4OR
 RR4VKLfYMIQ7/XgudQKPGcIEhPEJFKWgUzDRs6ZCDI32SgpMEeMuY2QzEqKo29Cz2FKR6inXO
 cOHqYyXFIP+v3BBe4hNjjNvXcIJ1mNhBbAjq5/ItD7B74KwTRBP+884gANijMpJm265iDcp5o
 D9bhKfyrY9qHQRXVjZqwpyZ6/7geYhFENzmRASGMTWMc5CQ73OShGOlb6/t2nlvJ85KW/Zzit
 agf52ByARpWdE1n8HgithDgTHtiaL6LwihXWWn0J2JZjzzUpYNDxnyAj/iXr2RjCQdKBugk5B
 w7iXMBxg2sYcOgHUCUEiheSHAJjMU9LmjvBGmGaspawKD2/60D9FPfIgS0M8pKZQjnnhKI1QZ
 uBhc4UE0BGP+dDIcZlDUnd6td9XqqdywR6CaZ6QLSIO+vd7gU6ZSys2Xn6A45b1o4Rb+0MtR2
 TypknmN3IdmOTqMQdgOrHSFBdX81A2Dnf5U3nt1IqnXAh0oZBHtCg+7J/t0NlgvWU7NFcomJf
 TikgJL1r8vYsE8uNLDF79+GgSo9jf/ylL8TcFsp4TR2Gg3kAClyjbiXql66EeTVIOFkE5rAjl
 sRjS3qjkTOjiPEdVrFx+g6w3lP6gslsy+dDxc/DCj4+Q0BRE20wPRuVvqF93mrPD7sU3813ij
 CAizLVZsOKGv0TzueLV0MY92AVkGj3YFctnko/Krj0nhKjVKOUvLNIkBkH9FsrCY6n2qOx9O/
 ++9s7OrX19DDhc3eWXM8ZQYOQ6YTmYF9FqgAyH6pV2fKOYWQBmCv6nf8k+3moz5OV1qSNSJ5J
 plleKIcEB4JPJidNcoDmDjTDn4wca8lXqFbU9BNogzUi7pZRbM84D7B7tu1/dRK/G2W+0Z2qf
 q9kps3ajhxETp0jaPf909uOb1NorgMYzDiyAn/ZOSns+rY4wmbrc84Jv0pNGdFnDhuTh3QqLV
 /wq8zkxncEVcO6Mah
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 15:41:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/ziaXSetJP/J1hLY32NVmLW6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2020 13:17:14 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Mon, May 11, 2020 at 01:07:18PM +0100, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote: =20
> > > On Mon, May 11, 2020 at 01:14:34PM +0200, Lukas Straub wrote: =20
> > > > Hello Everyone,
> > > > In many cases, if qemu has a network connection (qmp, migration, ch=
ardev, etc.)
> > > > to some other server and that server dies or hangs, qemu hangs too.=
 =20
> > >=20
> > > If qemu as a whole hangs due to a stalled network connection, that is=
 a
> > > bug in QEMU that we should be fixing IMHO. QEMU should be doing non-b=
locking
> > > I/O in general, such that if the network connection or remote server =
stalls,
> > > we simply stop sending I/O - we shouldn't ever hang the QEMU process =
or main
> > > loop.
> > >=20
> > > There are places in QEMU code which are not well behaved in this resp=
ect,
> > > but many are, and others are getting fixed where found to be importan=
t.
> > >=20
> > > Arguably any place in QEMU code which can result in a hang of QEMU in=
 the
> > > event of a stalled network should be considered a security flaw, beca=
use
> > > the network is untrusted in general. =20
> >=20
> > That's not really true of the 'management network' - people trust that
> > and I don't see a lot of the qemu code getting fixed safely for all of
> > them. =20
>=20
> It depends on the user / app / deployment scenario. In OpenStack alot of
> work was done to beef up security between services on the mgmt network,
> with TLS encryption as standard to reduce attack vectors.
>=20
> > > > These patches introduce the new 'yank' out-of-band qmp command to r=
ecover from
> > > > these kinds of hangs. The different subsystems register callbacks w=
hich get
> > > > executed with the yank command. For example the callback can shutdo=
wn() a
> > > > socket. This is intended for the colo use-case, but it can be used =
for other
> > > > things too of course. =20
> > >=20
> > > IIUC, invoking the "yank" command unconditionally kills every single
> > > network connection in QEMU that has registered with the "yank" subsys=
tem.
> > > IMHO this is way too big of a hammer, even if we accept there are bug=
s in
> > > QEMU not handling stalled networking well. =20
> >=20
> > But isn't this hammer conditional - I see that it's a migration
> > capabiltiy for the migration socket, and a flag in nbd - so it only
> > yanks things you've told it to. =20
>=20
> IIUC, you have to set these flags upfront when you launch QEMU, or
> hotplug the device using the feature. When something gets stuck,
> and you issue the "yank" command, then everything that has the flag
> enabled gets torn down. So in practice it looks like the flag will
> get enabled for everything at QEMU startup, and yanking down tear
> down everything.
>=20
> > > eg if a chardev hangs QEMU, and we tear down everything, killing the =
NBD
> > > connection used for the guest disk, we needlessly break I/O.
> > >=20
> > > eg doing this in the chardev backend is not desirable, because the bu=
gs
> > > with hanging QEMU are typically caused by the way the frontend device
> > > uses the chardev blocking I/O calls, instead of non-blocking I/O call=
s.
> > >  =20
> >=20
> > Having a way to get out of any of these problems from a single point is
> > quite nice.  To be useful in COLO you need to know for sure you can get
> > out of any network screwup.
> >=20
> > We already use shutdown(2) in migrate_cancel and migrate-pause for
> > basically the same reason; I don't think we've got anything similar for
> > NBD, and we probably should have (I think I asked for it fairly
> > recently). =20
>=20
> Yes, the migrate_cancel is an example of a more fine grained way to
> recover. I was thinking that we need an equivalent fine control knob
> for NBD too.

One reason why the yank feature is done this way is that the management app=
lication may not know in what state qemu is and so it doesn't know what to =
yank. Poking in the dark would work too in my case, but it's not that nice.

Regards,
Lukas Straub

> That way if QEMU does get stuck, you can start by tearing down the
> least distruptive channel. eg try tearing down the migration connection
> first (which shouldn't negatively impact the guest), and only if that
> doesn't work then, move on to tear down the NBD connection (which risks
> data loss)
>=20
> Regards,
> Daniel


--Sig_/ziaXSetJP/J1hLY32NVmLW6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl65qmwACgkQNasLKJxd
sliFWBAAuUReEs8Jdpj/coGWlDfLA2XYxE5Fnc8Wq8xwPCu5YGjE/cgqrpWK48DN
r06Ava7mE8/btQqaZ5Tw0MFL+NoBkotuw6Zn/KST5CsJVziVn8HGoVWff6y85TLH
OX2gM2g5LhRafiwRwBB2xsk140L9tC4wy1ZbbSf+4U7qpa/Hj5sAhKviB8FsOziA
kj7mo/A4M7/+lG7O/nJvOWgxjdQpcVK+ZehmWmnpFW0bcETa3GewYvq7shv4CfXT
1ml0aNENBuSqblt+hHLWwVxKKOlVlKflBLrlK/ytECiipoUwxhbSGx6r6SDGijm/
BXss7lqY9jQVR0Oqzk1w2GZirzxN/mWWYy7mxiHFAJzG7F0+ojfosYMQJy1ho+gb
CKz4oHZFGylVHxD4avVGGNG5PWPkyU+9goOUm5I9GVXyRVLCADFBjQ65od78q1Ru
TNJcDP2UyfJtbTxl2tE8YtYy1POOCvbOl/KTvtXEBGrSQQxZJ6orN2yUNndV6PB6
OTdu//U8wkDYGp8wCG5dsHwn1iNmxjOaE+9Mhbqp7sZh8sRV3fQ9+8khIco19RW2
GlLBmv6/m3VvDrIWBNhPbgQEniB4cm4IaDTAjf1e7CxLgsxmYaRO9b7aZKZhkKet
QCgXRMEkkfqtyqlj7aSAFTiQ3mqQ5xGhuJMwg8woEI1/QleacwE=
=Ymyr
-----END PGP SIGNATURE-----

--Sig_/ziaXSetJP/J1hLY32NVmLW6--

