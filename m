Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC77C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B18420768
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 19:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="PqtKcjhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B18420768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joBTF-0007NW-AA
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 15:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46108)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1joBNR-0000ED-C0; Wed, 24 Jun 2020 15:48:09 -0400
Received: from mout.web.de ([212.227.15.4]:39667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1joBNP-0002Ks-9s; Wed, 24 Jun 2020 15:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1593028079;
 bh=RfGY9TdhO6Zu8c1ZMpPR3twqNWDryW9zd4JjrjpC4tQ=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=PqtKcjhSiVC35eHndbDOScA45iGW1Zuh6EDNAeypUW9Hc+IgKXFJqluJK166ix3SQ
 TQm+hvz3IjrC5ewvoac+CK88xjLl5s1/P1qHMOGWqi1O5hgXVHO4pI1LZNqamWyFO2
 C47iWBEU3hvTyGNkgBpIlVu9q6AOqHgzJ46XWFiw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.64]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LrpKY-1irDmr0kc2-013dMI; Wed, 24
 Jun 2020 21:47:59 +0200
Date: Wed, 24 Jun 2020 21:47:46 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 0/7] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200624214746.4d8057ad@luklap>
In-Reply-To: <cover.1592923201.git.lukasstraub2@web.de>
References: <cover.1592923201.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xSrtkSeZI8ELhxQRI50uCKd";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:Dt+Z8+BhaKm6kD29OolNADUV8D+Seiwge51rcgrGbi80jYTfrXI
 SKfk0XO5quewhJJqkJkLTnwiQw6BKA7QFZ4fM2Km3l9KgHjX32Qt76tzg2/uzA/B34gkbTt
 AHtwEQv+JJ1fgLDbu37wC1Msy4BjayJonXHObWHL0kv77Pvf6TpBIq1GjrtPJvUrnCmQDp+
 AwY+1fg6bFelBElTI2N3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J+C/Q2tLXm4=:tZ1hHBKTadskmg2WsB9rwD
 ZYikIdmtQwrJku5CY66pQ5BM1shMATEYaxB4jpAqeLImJLawlwjQxzi+6ysKbtJslF9VIovti
 4Vwf7O+J5puVyq12GKepuW9SPVRkhUzkQ8lgqudoeYXBEDpw67KspI1TOB8P6EiAGfnhANev6
 3Bykg0ZuRTm/Pgx2pT6x5L5LuycLCp/PTSbSS8qGZAivMY20GWrL6XRM8BXmkOEtbHDWUpiIv
 svUryz1cJcreAfRWEwygrDQxNBiZT6umgCPvk1k0EM9ex63OCum4A+B6wH8dLz6L39e1Z8htj
 DSocuzZ2wjbPkUHqLEdpT/rF7SnGBBOmdRACjpeiwDWpXpeu8Ul/JyOCZkSR1rvI7Zjswiipp
 kIYynNUGrxwsXcyeIO236gyKivLjcqV1w5i+15z3jCsvsUv4AFb7NIdCGp5JAUKvInIiXGLKB
 JId2HHIc6P3n3vK/2v93YC9cAdNmK0OKUGqG0tR9c5lu3EFW6HQOq98qfs5b6bGtOSmbulgla
 qOe/q32W5+zqLJ/AVgv6Am9eQH1FY73eUp9/lz/5pKnIuQdKeUxJhXSUdSyo9HG109dKXvJTB
 LKFG0be5ZgpyAYDVwvyGs7H503rhtztyBqdzpNWt5ieV5FHR5XTX2mtwoMI7uXDzIuRPRLQYl
 bhdtoZZGITaL+GAIEdMoPNABUfZNbJOhsDbUXst82rG/1BjTCZ6pzziXIFoSLrlbijXLKwHo5
 Za/6VQbBT1vKlFjQDo4jVTTZPLqKbg9dYd28+P4vJA4p/Uw4Zwwr7cABbKSciXf5qDuQQlX7y
 OqPVI8/hM9cRNSdaoWuW4+ZoX2BXeLzkpoYQjKHA4j8vsj33e9jkF8q3c5sH798A55SXQHOSM
 4CInEz9DYFKTarJLBK026IR9alDImIm4DjCgTIMn4uoD6KfgBRu2VM3sqIgjbOzOOmHC4gOl7
 qdA26lukOsHVYs5PLGr2WueBeKoxSqmEkBFUFTK3TvH0rIKZ4TvNKo71iSe3s6m+ldR9s/mx0
 IKh/U8aD+oupzEpFwkCxvGBwXFRamP+3gnln3tTiDdJFDr60Sx9wWTuFLL7+jM/NfbsomG/Sb
 SmExhT5plBBgsA/4UbfPkCkczFjQFKscrGeXjgTVG3U10atuvlPPFFTLSllj2YZFYW8FHOwR7
 SVzfG5gs4aA+TVnyXQviuFWh+3x7TjFCAq1HvHwPdeocbL35UsInnExS3NeaXUHyiuH2iX/qh
 Gh5Yhit9J+qbvxJFP
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 15:48:04
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

--Sig_/xSrtkSeZI8ELhxQRI50uCKd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Jun 2020 16:42:30 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> Hello Everyone,
> In many cases, if qemu has a network connection (qmp, migration, chardev,=
 etc.)
> to some other server and that server dies or hangs, qemu hangs too.
> These patches introduce the new 'yank' out-of-band qmp command to recover=
 from
> these kinds of hangs. The different subsystems register callbacks which g=
et
> executed with the yank command. For example the callback can shutdown() a
> socket. This is intended for the colo use-case, but it can be used for ot=
her
> things too of course.
>=20
> Regards,
> Lukas Straub
>=20
> v5:
>  -move yank.c to util/
>  -move yank.h to include/qemu/
>  -add license to yank.h
>  -use const char*
>  -nbd: use atomic_store_release and atomic_load_aqcuire
>  -io-channel: ensure thread-safety and document it
>  -add myself as maintainer for yank
>=20
> v4:
>  -fix build errors...
>=20
> v3:
>  -don't touch softmmu/vl.c, use __contructor__ attribute instead (Paolo B=
onzini)
>  -fix build errors
>  -rewrite migration patch so it actually passes all tests
>=20
> v2:
>  -don't touch io/ code anymore
>  -always register yank functions
>  -'yank' now takes a list of instances to yank
>  -'query-yank' returns a list of yankable instances
>=20
> Lukas Straub (7):
>   Introduce yank feature
>   block/nbd.c: Add yank feature
>   chardev/char-socket.c: Add yank feature
>   migration: Add yank feature
>   io/channel-tls.c: make qio_channel_tls_shutdown thread-safe
>   io: Document thread-safety of qio_channel_shutdown
>   MAINTAINERS: Add myself as maintainer for yank feature
>=20
>  MAINTAINERS                   |  13 +++
>  block/nbd.c                   | 101 ++++++++++++-------
>  chardev/char-socket.c         |  24 +++++
>  include/io/channel.h          |   2 +
>  include/qemu/yank.h           |  79 +++++++++++++++
>  io/channel-tls.c              |   6 +-
>  migration/channel.c           |  12 +++
>  migration/migration.c         |  18 +++-
>  migration/multifd.c           |  10 ++
>  migration/qemu-file-channel.c |   6 ++
>  migration/savevm.c            |   2 +
>  qapi/misc.json                |  45 +++++++++
>  tests/Makefile.include        |   2 +-
>  util/Makefile.objs            |   1 +
>  util/yank.c                   | 179 ++++++++++++++++++++++++++++++++++
>  15 files changed, 459 insertions(+), 41 deletions(-)
>  create mode 100644 include/qemu/yank.h
>  create mode 100644 util/yank.c
>=20
> --
> 2.20.1

Forgot to cc Stefan Hajnoczi...

--Sig_/xSrtkSeZI8ELhxQRI50uCKd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7zreIACgkQNasLKJxd
slgZrRAAp3jojzJvcOpvsoeMNDj/vM2NcuaCYoE4uN+4tPhlJcmQeGQLW+hAN1Qa
B7Wspbi/FoMr2NEcp2bS25PEpqH55ENAoAsFFmyJU6V/J1uroHW3MVrNHtiTrWmq
jzrH8y+QBtXtCh6upfoMDtiCow//khn140BW1C+kBsSFO5dJmRB2k7CmAfK6I50L
njlXYUJwBk01/cRlWfI9OWP4lxruyYpc/911oacMHPSFoNbmA8voo+qtYzwTAs2Z
F+lAksoG4NbBvP3hMAe4x0IcJECCTfz9rSwav1iGdWL7YN/behmKC5NgYG/ndcUA
pIf86uR0zDz8pwdGYSxaYkxAeZvp0tODcEZr+3CofUVuRwApSWxtt02iq+YqlS9U
cVflE9k+WfBLnMxCCGw+bYWPjnpt970kaOpx4jgH0zFjXufVlLX+ImaQbbRDv9yW
m9T4qOMgep/UkeIUvjsH58bJRjDfYwa6VhSsvWoQkJf4cHr2goYaBwpMVmNNZ/Ep
wvJUm/pAhNyThlZvk4WM4fl4yLTZWotgnB92/RwZ1qFxyVnAHnldstUIsGvjI79q
PTSWbUYV/TSpEFCmXitg2EkVS/qtcvMkcBzIiVWF6MD9x1ygktaFiR48D/fvpUg8
FY1XSGW9vm+vc28XAcIu8Q0xOzfXpThQTfy8wLkHeQfGz6iFV+E=
=7vwh
-----END PGP SIGNATURE-----

--Sig_/xSrtkSeZI8ELhxQRI50uCKd--

