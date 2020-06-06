Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428DAC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:04:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0945720760
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 19:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eMrR8Fkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0945720760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhe74-0000ck-3X
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 15:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jhe3G-000869-AL
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:00:18 -0400
Received: from mout.web.de ([212.227.17.11]:52529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jhe3E-0000oC-Tj
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 15:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591469983;
 bh=LKfIi41zwupSr1slhByAGTrIrxNuyJvhjSRdeZV65bw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=eMrR8Fkx2liQYjoisO2/278VGJQ8Ck2KFmIgii36iLLV6T/5cCVh3nWGAyhuL0f4z
 JSaO7LFaG5mineISlA8TTYpNRzmz2KxnddoNVceXfJHoNcj6xTiiOAuRAwlmA3aN9/
 7pRf4Jn3xlclpSx/AUJC6HWgj6Gi43rOzxpc1jwM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.73]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5fwS-1ik4Gd1VE0-00xajA; Sat, 06
 Jun 2020 20:59:43 +0200
Date: Sat, 6 Jun 2020 20:59:32 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Subject: Re: [PATCH 0/5] colo: Introduce resource agent and test suite/CI
Message-ID: <20200606205932.30099b9f@luklap>
In-Reply-To: <a1d3390036cd4007b53786cf6cb7b5a9@intel.com>
References: <cover.1589199922.git.lukasstraub2@web.de>
 <a1d3390036cd4007b53786cf6cb7b5a9@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Bf4wuToETwGZeBusm2pK=05";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:5lqnJri6O0LNmFw59r2nnSPR6xrz9sOS38kTIm64zg6SZP2MiK+
 uj2xpkHkakmJXJ4WQ8afjmx2CjpheKK6p/biWcGoaxh5iXycITjMrqQvsVYJAw1IDaL3Hba
 /0ZkDGCaCr5EEk1OphJtwy4OMt7UGWuUd5T0YsdTKEBtcA1U+T6Ir16A7kNDTZjdR4mT9/1
 P+TFs0g/Eh6RWwYy3UO0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tbe4l7D6ubY=:raEdtiMpRTvi/qfDo/XWTw
 rl4x+Ajl3Q5/XDrQKFYbhGHVGVXZOga4fByCZ6+Fct8ItJTRHrjbrumaDs0tjvoN4OT970//q
 nktjWEeVsm1/ANCeIHaCSEfEpmsi5Qdj32xnVwBmSvonwacl981arXu29B7mD4B3GYg3P9wPH
 UDzU5i0PVWziD5C+N6W8tvbpShUJgh5KLv/0DA+26fd+nfCNAzdWhj4PcQdQ9Cr1XVAkyrt0E
 WrJY65vPgchmwEEv0JF9XAuNByQGcSYFbz5tULJer2O7FyUPg/elDjU4JW/bEfEhMeli9Ok4O
 Ac9OGRl7Qt8wKtmZXYDF6zk8/NAl9SM19gA9l+OcVj/yGlH1LO9G0i6Y91TuPozATsC+p+Fh/
 t+1ZAWOydPjPsTm5JP+UejYKiQdM3BpObuRdEaG2fqDkHMgKLedRORhrjFrB8qIVfLBaDEuOZ
 FYlm7anOsbrT7HbAAJb+Y2eKjaRTCHDNli0UGvVK6UTCyl78nsP+Iz0UDxLtjYz4XB5GBkdwS
 vc4NkkCPlCiJg2WPwT7+wCrNj8wiiUlpL6/D1lUUvTlu/bJWrg/isRcFM3hJ4gEr4DSfh1fXj
 7X8OGlI4uNaXrTCqnMpZI3RPBmEYqkVNfaWDIMGR6NHX88V/Gaq2oiNGCjJoJt3Y4c4qqWk77
 Jmk3TBN5WbLHDu/ZBIVBvJXBAYOb2FsNdhrla37h1pcvgdxgvaMwvczVRzUVFwKb82gg83qEk
 K6E73ld5Nz0aSLlpzPB7z9oTjPNaY1XsszFVKYCAeL6eVNiG+ZkaFiiKbA8wb6o17nUn6rvHd
 KkDWTnm7+dI5Hic/Rmpi2roYSRhViB92dZO8aaOTZZhxV6NWpQ47BSFdk733JNKflmvbIgY0c
 RRkUkDIHbq4kMoH4ZTJkYaggQxmPfzYpCHPQUVExkqrI5VJ9v73DA01zsHAIIDIG6/i32b3FA
 vz8EkBZJ4QiDmJRdGREzmy9AMTL6bzUQ5cWifOyPkgMiM1c6rgNE5t48W/FtcoQzZ+eNZUybP
 Ut+npNOPNZbeW2FucC/tWDUgXRSDFlBrPpCUmevn+B+81uK45oe4mSC12M2y04V53Ty7oUWSR
 dJ3lwI+r0Hw6p4SJhkIYMgR/OmkdkQhU0pkLMh7JzlIjh6bSjNz1QqSFrH5qe1swFbVdDMw16
 K1C5qmI+vOnoIK6wmR0nUmUMELR7ORZfMQ0VW4lmC+i5tvDBqd3/QouQEtf/lSW0vtFrEUrPS
 29GGsoDzRjqSEY4Vd
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/06 15:00:14
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
Cc: Jason Wang <jasowang@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Bf4wuToETwGZeBusm2pK=05
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 18 May 2020 09:38:24 +0000
"Zhang, Chen" <chen.zhang@intel.com> wrote:

> > -----Original Message-----
> > From: Lukas Straub <lukasstraub2@web.de>
> > Sent: Monday, May 11, 2020 8:27 PM
> > To: qemu-devel <qemu-devel@nongnu.org>
> > Cc: Alberto Garcia <berto@igalia.com>; Dr. David Alan Gilbert
> > <dgilbert@redhat.com>; Zhang, Chen <chen.zhang@intel.com>
> > Subject: [PATCH 0/5] colo: Introduce resource agent and test suite/CI
> >=20
> > Hello Everyone,
> > These patches introduce a resource agent for fully automatic management=
 of
> > colo and a test suite building upon the resource agent to extensively t=
est colo.
> >=20
> > Test suite features:
> > -Tests failover with peer crashing and hanging and failover during chec=
kpoint
> > -Tests network using ssh and iperf3 -Quick test requires no special
> > configuration -Network test for testing colo-compare -Stress test: fail=
over all
> > the time with network load
> >=20
> > Resource agent features:
> > -Fully automatic management of colo
> > -Handles many failures: hanging/crashing qemu, replication error, disk
> > error, ...
> > -Recovers from hanging qemu by using the "yank" oob command -Tracks
> > which node has up-to-date data -Works well in clusters with more than 2
> > nodes
> >=20
> > Run times on my laptop:
> > Quick test: 200s
> > Network test: 800s (tagged as slow)
> > Stress test: 1300s (tagged as slow)
> >=20
> > The test suite needs access to a network bridge to properly test the ne=
twork,
> > so some parameters need to be given to the test run. See
> > tests/acceptance/colo.py for more information.
> >=20
> > I wonder how this integrates in existing CI infrastructure. Is there a =
common
> > CI for qemu where this can run or does every subsystem have to run their
> > own CI? =20
>=20
> Wow~ Very happy to see this series.
> I have checked the "how to" in tests/acceptance/colo.py,
> But it looks not enough for users, can you write an independent document =
for this series?
> Include test Infrastructure ASC II diagram,  test cases design , detailed=
 how to and more information for=20
> pacemaker cluster and resource agent..etc ?

Hi,
I quickly created a more complete howto for configuring a pacemaker cluster=
 and using the resource agent, I hope it helps:
https://wiki.qemu.org/Features/COLO/Managed_HOWTO

Regards,
Lukas Straub

> Thanks
> Zhang Chen
>=20
>=20
> >=20
> > Regards,
> > Lukas Straub
> >=20
> >=20
> > Lukas Straub (5):
> >   block/quorum.c: stable children names
> >   colo: Introduce resource agent
> >   colo: Introduce high-level test suite
> >   configure,Makefile: Install colo resource-agent
> >   MAINTAINERS: Add myself as maintainer for COLO resource agent
> >=20
> >  MAINTAINERS                              |    6 +
> >  Makefile                                 |    5 +
> >  block/quorum.c                           |   20 +-
> >  configure                                |   10 +
> >  scripts/colo-resource-agent/colo         | 1429 ++++++++++++++++++++++
> >  scripts/colo-resource-agent/crm_master   |   44 +
> >  scripts/colo-resource-agent/crm_resource |   12 +
> >  tests/acceptance/colo.py                 |  689 +++++++++++
> >  8 files changed, 2209 insertions(+), 6 deletions(-)  create mode 100755
> > scripts/colo-resource-agent/colo  create mode 100755 scripts/colo-resou=
rce-
> > agent/crm_master
> >  create mode 100755 scripts/colo-resource-agent/crm_resource
> >  create mode 100644 tests/acceptance/colo.py
> >=20
> > --
> > 2.20.1 =20


--Sig_/Bf4wuToETwGZeBusm2pK=05
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl7b55QACgkQNasLKJxd
slgAWQ/9F5ohH2rhwVe1DFPnSgVCLNKJHR80v5I4jY+HvFNbfOv1qVsCPpfFm5wl
qD5zLjUr2SpMozcGHizApl9AZbN3lzDYsFzeyxU++jB200P0TO1J26eIqjam1g8J
eGniR6ZpADBgXMdoZX2kIMy9Tb6r6kz0vmNhPXXTLhWCK4M7f1F7h3k4ew7idGCu
m7SVuRRMmI7CGLdKUD3BKbYTYmYCqngPyVZto9dg4Qrv742Pec1lxT2LuyqhaThT
nvF9Biak+4JFaNQwGNVZI1KBU3d7GFnGk+st9WM1koqgUSuHZI2YJZJFddMtri3I
94HNkusxWY1NfZLvLxUPWYOvUMlBVd74SHaZOASekroy7STWUru35qvH4oWeCUiy
2JazkY3YQuCVpHpSX/EBmd/TZsh0YlwXvqXBlrF0kgprm7Tq2lxA9QO0KwjL6zcO
WFbAbqWf8bDE/uvMDXzrlgptA+ScFHK6d+ntPr1z3CCLjmnyNjKSlvn7H3G83fyA
54rFVotTHJu9HvF27vDroORKi/KP74FiolugeL3JesdinHGE68sBUdT6dL78UI22
xNXLiG/Yvwsco2woGlddpD6JpNE8anorQzz6YBQzFMAlb3lJZodi9kof2/h7m8n+
UX9mq4IDfMJsyNtaNRn12FqW2HGGOGg05SLW8N6ccFgK4vJY6y0=
=6Leo
-----END PGP SIGNATURE-----

--Sig_/Bf4wuToETwGZeBusm2pK=05--

