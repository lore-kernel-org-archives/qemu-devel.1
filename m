Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D02C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A2612177B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="B3NuCqZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A2612177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDXk-0008HD-Jq
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:46:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kBDUl-0007GQ-2r; Thu, 27 Aug 2020 04:42:55 -0400
Received: from mout.web.de ([212.227.17.12]:49811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kBDUj-0006pZ-9q; Thu, 27 Aug 2020 04:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598517768;
 bh=bcXRMSi6YJYz704wAXxQwPfHknoLUgU9pLiHl9cE30w=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=B3NuCqZK9k9Yp9qg1QXcRL91yLmKrgkkp6c3Qir+CDn8zD55D+b18KzDtDWhKatq2
 NXaUw7spNUvzDpIfhrFsRZ/wQodL0Ij0FBY6CyyiVTEzqVAPsQOKbcPuWQYazer/Jb
 56hxC8aLdjFBZxhwZb11TIZUpAOblCrnaxNyxpA0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.239]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LoYb8-1kqaj73YLK-00gbeZ; Thu, 27
 Aug 2020 10:42:47 +0200
Date: Thu, 27 Aug 2020 10:42:46 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 0/8] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200827104246.63754338@luklap>
In-Reply-To: <20200818142631.3e1c1481@luklap>
References: <cover.1596528468.git.lukasstraub2@web.de>
 <20200818142631.3e1c1481@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cYpDfUd2ynkPymOatnsZqt0";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:pLv9nm5tXm6H6Ow0TIaukW19SaVHBNE7X09cN7vonSp78d7IbH7
 lS5xfKGUJ5sbj4rugnPq7GDrU57uigbYBjZBrjQLW8gXUnKt2ZDanjFvd76rQWYhb+118YN
 SDOhmp7OXsV4zNMY8ylPPiP3Xlx2iVHmpyVqSzl1kR1fYfvW+mh8cs1oMWcVoVPIikCbNwi
 GLX+Su/qoO/aaNkX42pKA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JAWGaXQDMJk=:+/aCrsvXK80S86dPgENAyh
 3VSBHXulGH4uyf5I66YEWQBgJMwyhQ5GrIiYgAJrk2X/Nm4Y7q5ATQLr5vxY4H9Mi9VXOQVff
 zH7aEjXhkfkkRF3dMUFyj8yo9lExCl2xe0Wa9WTsjPrQZOy+8Aapn+QZP6fxIcoljOx+ZpXVQ
 mS7xy9Q+gu6Ngs6GkwiSDXCBb4/tJmrlL8Lyy+7yP7PO7HpWcTy/30HRxpgNIPGj0TKwCBt+q
 n5yau1WgKMVz9ilDmyeqohIm3yU048DkU+UtpMTorqzQo6zw4MV1bcmccUqdoB2T/3A9pgKUd
 2JEnjVydKvOfZUrH6vQgO+ZOT+EMcDV4373BFMVamrXaV+ZFopzEzItvwWtSd9YH/4Qw7NSk7
 F0xcDuCiTnjNNE5SVakRDWfvAP9NIfdmOD4pDHOtSW2lhhEfDLjrdeGRZI/7A8+1F0g7/tNmR
 WNt50A00WQkCV5PR1HB6PcodFUuzOV969T+PN00eLHqEY2ENYIZZ+hy7LcSZDABGFdX6hKMEz
 91XdTuQEWPcAeNMI6qjF57pywej/Jkg/Up7U0vMntw4BKLZsOEAZkw/AaUVi9+6+1ZAtnFljM
 9DLY+3AcHs3UjCLnmaiyn8y8P7vH+vobaq+mGt4iq8o5nJE150FDFE1c6aiazT52hA65A8CLx
 p78uNLHe9kCy10ermcosHEXmHwLmafIoH1+bGO1tA9HRv0cclibRxo8/NeuYwZvlrTaWNM8Jd
 FkhMiQxIz4yi0LvScZLa/DxvKgGoLodSDrYRwms3x3TpscqjXmBAiw1VX9X7rEYiXpYrEE0Ed
 qSUks1ofBNzayJzkI4wX9t8NAHaZsAyWLC+dPwusxWI/HXVZDtv+BWtXd9+oHOKqiTt872IPr
 BswhghP0YxYepUn8ZhrHNA4YUDnFK8shuzMC3Z2SRDwEi2gUVYWQDMhQ3FWrpvdrojLhERcsD
 G2zN5JOCojZHSN1pdqTVDAS//WsbNMZPNxgG6fRsvSuvWo+G6zTyHGYCK1ovmlnuwlpA9LpCF
 XEW/CbgOLzX2In7CFYQy4UO8uAVHcLCbHe5e3GA3H6tjZKgnVVQ4prI0aWpbFW/b/t+neynXN
 PSykmHz7jxykLCDSYYzdY3kceXF7m3cVLY4Icq3UCy8Eblvak63rsbiIa58PxULD9kDB9F/j4
 rdfCLI902xqbeEpgluwBZOnVL/UBRaJHTVIknsW7PQZAkwXEKyWIPljfXPQ7eVZRPSKnEWCYs
 mdOmf8ziUCcQfAfk/p/eFnRRUtJgcgXL+uuo7xw==
Received-SPF: pass client-ip=212.227.17.12; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 04:41:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/cYpDfUd2ynkPymOatnsZqt0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Aug 2020 14:26:31 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> On Tue, 4 Aug 2020 10:11:22 +0200
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
> > v7:
> >  -yank_register_instance now returns error via Error **errp instead of =
aborting
> >  -dropped "chardev/char.c: Check for duplicate id before  creating char=
dev"
> >=20
> > v6:
> >  -add Reviewed-by and Acked-by tags
> >  -rebase on master
> >  -lots of changes in nbd due to rebase
> >  -only take maintainership of util/yank.c and include/qemu/yank.h (Dani=
el P. Berrang=C3=A9)
> >  -fix a crash discovered by the newly added chardev test
> >  -fix the test itself
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
> > Lukas Straub (8):
> >   Introduce yank feature
> >   block/nbd.c: Add yank feature
> >   chardev/char-socket.c: Add yank feature
> >   migration: Add yank feature
> >   io/channel-tls.c: make qio_channel_tls_shutdown thread-safe
> >   io: Document thread-safety of qio_channel_shutdown
> >   MAINTAINERS: Add myself as maintainer for yank feature
> >   tests/test-char.c: Wait for the chardev to connect in
> >     char_socket_client_dupid_test
> >=20
> >  MAINTAINERS                   |   6 ++
> >  block/nbd.c                   | 129 +++++++++++++++---------
> >  chardev/char-socket.c         |  31 ++++++
> >  include/io/channel.h          |   2 +
> >  include/qemu/yank.h           |  80 +++++++++++++++
> >  io/channel-tls.c              |   6 +-
> >  migration/channel.c           |  12 +++
> >  migration/migration.c         |  25 ++++-
> >  migration/multifd.c           |  10 ++
> >  migration/qemu-file-channel.c |   6 ++
> >  migration/savevm.c            |   6 ++
> >  qapi/misc.json                |  45 +++++++++
> >  tests/Makefile.include        |   2 +-
> >  tests/test-char.c             |   1 +
> >  util/Makefile.objs            |   1 +
> >  util/yank.c                   | 184 ++++++++++++++++++++++++++++++++++
> >  16 files changed, 493 insertions(+), 53 deletions(-)
> >  create mode 100644 include/qemu/yank.h
> >  create mode 100644 util/yank.c
> >=20
> > --
> > 2.20.1 =20
>=20
> Ping...

Ping 2...

Also, can the different subsystems have a look at this and give their ok?

Regards,
Lukas Straub

--Sig_/cYpDfUd2ynkPymOatnsZqt0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9HcgYACgkQNasLKJxd
sli6lA/+J/fVppEvaTcXlOuiLJHxtvoaa8zTu/30T0PIgL+BY13Mh+YqJ7H+1wf8
COZgjhYWNQztpxZR4u5ALzkNLndV7rDSTCwvqu98zmAiiZsj9It1QQdd1ZsCWpg8
8v8yDtbfhOBzLC74suS1N2I8DJIe1PFFe/C9MRUVATYZdqka0Y0vJKeXR0dtItkU
VD2SwVCZosTsjpiofbSAOckFKBkC4wTxfF1Xu6UM9091Cek4E/O3K24i1CXgmnHm
wFu3cx1MJOoKE0+ZWC6F9a57joMrILyBq0/HAhTIC6TxRcxyG1S0tAgP6TfVlrYj
V4hcJGcAuY1eBUzrzS62ht8IjEFYbXABGddJQm1Tfwnp5XHFS8tAvRXth7QswUWq
ImUqcUe+8gFukIzVcRahK+7vEzNEHnRorzOaQ9+A2mV6axiTkt82AEdzpxnlZOZy
xk6XUk4yay5aesTJlveRqmRimm7SnPl+ykqaMzmGsJ6IaJJPxqRFSCDapihuOyA9
+yjwW8fHb6bYwx/eh+m1WbhuCc3iO6hjnql+pIl0O+AEMc5KklmAjwkqqfgWTTVb
aeJ0wjzxyit0YULG5D12Oum4qEJol8quXrVGrSVfqouZQmW2LMQuxZeZ1N90IEd/
klW+45X9ENWDWExgaIekpPzEPM5YSmUarGdvv6L3V3wEL/ab1j8=
=5O18
-----END PGP SIGNATURE-----

--Sig_/cYpDfUd2ynkPymOatnsZqt0--

