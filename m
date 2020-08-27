Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084C4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD6602074A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 08:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="NUcnNkRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD6602074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBDWb-0007oS-TL
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 04:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kBDTW-0006zc-Sk
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:41:38 -0400
Received: from mout.web.de ([212.227.17.12]:50881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1kBDTU-0006gI-GC
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 04:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598517665;
 bh=7RWWDZwbVONcVmSnXX1cIILVnU/OnbMtE3GHvvMf18E=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=NUcnNkRrbzUWZsZKrFRuAm8DChgC00Nc06cY2Q3Ofh6XZYTVWioGP5Srtz2cM7Y3h
 b+g2sXqwdSfYO+5aCR0mBAXNbjhOg8U0I/08xXOZqWMPE8m40n8n63gKV8963asAbM
 acEsbEv+7FmCZkgYoES7zgjYzdfp8ZLvhBLN8HCs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.239]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MyvBA-1kWibD0uKQ-00wGEy; Thu, 27
 Aug 2020 10:41:05 +0200
Date: Thu, 27 Aug 2020 10:40:54 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 0/7] colo: Introduce resource agent and test suite/CI
Message-ID: <20200827104054.45a116fb@luklap>
In-Reply-To: <20200818142701.6d1d82bd@luklap>
References: <cover.1596536719.git.lukasstraub2@web.de>
 <20200818142701.6d1d82bd@luklap>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Sv.YT3J+8XPtH/L/mqFaYO1";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:eSMoYnXQC7HPzembwt8u6wbOm7lIXKxNQd+y7BJ9B87zhNnK72i
 T9H57Tu7yU9kFEB4UIjGmBD1uvgt6GmNReSEXFF0VWXBheqAxHCbuMl4bX3qBcNnca5V+wI
 9j1efmaB89gEqpOe+8LRlRSvjKG+QupzQrnthUFKydDRVB62hD8DBKDN0ZwHeXV+F37//fi
 blF+iSDNUqfE0aVC5PG4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lBpMALD5GnM=:Z6O15pnSBUca1Er5D3Avje
 ZqLQ4s82UKe8OySKBvPwkEviifNJFY3Jng0EWjbA43rc511SSwqJaU9Z16lhGpI90lNB66xPr
 6dwAOm++k7RGkKwSTKX3UvxF7yenU3N8Zt6kla7fjWSzxAMp2ssEKaG10vVrcgZnRNA+waOUv
 l9t0dH8WDCjhbgqZvEbyivXB9XnsxZuXp7bUMfD+ouTj8LgTk3Q6HfRwrDPDfd+YvCwhn7GTQ
 FxXlqLm2u2FMt4dg9GcuowaZdKZO3eyHb9AWNDpVYPZVfdbpVwiVnFlBWEcW21UPxXiJU7ODs
 8yVt7dr1dzNkkqHXrSXqGLcOyyH0Zy1OYuwcldHuMzkgLVEdq8DFq09/qjKvvd5XnexYU820+
 XCXe8soFE+NlDTXUOd03vwbCvpzjYzLtuRsTvpL91e33aTz+jrYJkVo0vk8Z/jaB4vGqfVOT2
 bR9rMkEVV7fFqkJZIL8me+dt0eBwjEVyrIaXPfu4ukLzDYpu7YzizAYL5gF+tZEbLP6ktCadr
 Yy+W8ugmvz8LpXw41bDmcmUYR1YwVIa1YPg7IbGi16XqBEcN8vKv41f9n13674Z1o2gbcf5ON
 hPZPVKyKcNrpWGQvXyUdFYjEq7gz2T3Msf7icNOjd3CNAXblz5HnA20SQOAvCwLgEtoaa2gn9
 8jcF28+yvKzbR6OToqAF2zsuCapwqf1KGsj9h2M8OkRpeHYRmHV0LLXTzt6cvsNi+XNBEtkdU
 sNF7zTwf68cbkR4tpdiSgp5mIm6wYeyuiIfIxBKr4+ZdA3/CqOLPNWqHyNhOg4a1WbxkrOdpc
 G8VTnDaB4GuKmHkK6BWcADogmHAE09jR40vJ+pP8+HT/uDthQmOCyKP0QMXDpRIkwbzTeqoRc
 UmSNRt2zoOkQsWXC+v+jr58gmS+m5K/Uqo18DIdIVc5dFPdEbpK8GdSQla3esCgvNORcdogNu
 A4szCL3Y8VpIkA2KqB7MG6xGbne+IcDeHM4NGqdiwHZf+5iadEREyj4wUIPyonYtcizo2RccG
 2Z1x7qRtT2j3fpe/U1NboK6/biZjw7R8tIoVea6noW+j2rhhfYDF0Bsf3zQl42rcY0Hz3OYES
 VrnqRxWViLiloNruC5Vy2avq5xoftsqbuk3R/beRavRS1W4Rm4qzR6Be2QpVnI90OXUVzGCU+
 U0xWHzHip2vdTuML30WawkDu5An01A6LnOqPdFYxGs+5oOBFILn1+xW2q/dYtpeNXWMXXHlvi
 etX06jaV8m3XAs2wgfFe+zLgYUCStSqrXXnKYXA==
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Sv.YT3J+8XPtH/L/mqFaYO1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Aug 2020 14:27:01 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> On Tue, 4 Aug 2020 12:46:29 +0200
> Lukas Straub <lukasstraub2@web.de> wrote:
>=20
> > Hello Everyone,
> > So here is v3. Patch 1 can already be merged independently of the other=
s.
> > Please review.
> >=20
> > Regards,
> > Lukas Straub
> >=20
> > Based-on: <cover.1596528468.git.lukasstraub2@web.de>
> > "Introduce 'yank' oob qmp command to recover from hanging qemu"
> >=20
> > Changes:
> >=20
> > v3:
> >  -resource-agent: Don't determine local qemu state by remote master-sco=
re, query
> >   directly via qmp instead
> >  -resource-agent: Add max_queue_size parameter for colo-compare
> >  -resource-agent: Fix monitor action on secondary returning error during
> >   clean shutdown
> >  -resource-agent: Fix stop action setting master-score to 0 on primary =
on
> >   clean shutdown
> >=20
> > v2:
> >  -use new yank api
> >  -drop disk_size parameter
> >  -introduce pick_qemu_util function and use it
> >=20
> > Overview:
> >=20
> > Hello Everyone,
> > These patches introduce a resource agent for fully automatic management=
 of colo
> > and a test suite building upon the resource agent to extensively test c=
olo.
> >=20
> > Test suite features:
> > -Tests failover with peer crashing and hanging and failover during chec=
kpoint
> > -Tests network using ssh and iperf3
> > -Quick test requires no special configuration
> > -Network test for testing colo-compare
> > -Stress test: failover all the time with network load
> >=20
> > Resource agent features:
> > -Fully automatic management of colo
> > -Handles many failures: hanging/crashing qemu, replication error, disk =
error, ...
> > -Recovers from hanging qemu by using the "yank" oob command
> > -Tracks which node has up-to-date data
> > -Works well in clusters with more than 2 nodes
> >=20
> > Run times on my laptop:
> > Quick test: 200s
> > Network test: 800s (tagged as slow)
> > Stress test: 1300s (tagged as slow)
> >=20
> > For the last two tests, the test suite needs access to a network bridge=
 to
> > properly test the network, so some parameters need to be given to the t=
est
> > run. See tests/acceptance/colo.py for more information.
> >=20
> > Regards,
> > Lukas Straub
> >=20
> > Lukas Straub (7):
> >   block/quorum.c: stable children names
> >   avocado_qemu: Introduce pick_qemu_util to pick qemu utility binaries
> >   boot_linux.py: Use pick_qemu_util
> >   colo: Introduce resource agent
> >   colo: Introduce high-level test suite
> >   configure,Makefile: Install colo resource-agent
> >   MAINTAINERS: Add myself as maintainer for COLO resource agent
> >=20
> >  MAINTAINERS                               |    6 +
> >  Makefile                                  |    5 +
> >  block/quorum.c                            |   20 +-
> >  configure                                 |   10 +
> >  scripts/colo-resource-agent/colo          | 1501 +++++++++++++++++++++
> >  scripts/colo-resource-agent/crm_master    |   44 +
> >  scripts/colo-resource-agent/crm_resource  |   12 +
> >  tests/acceptance/avocado_qemu/__init__.py |   15 +
> >  tests/acceptance/boot_linux.py            |   11 +-
> >  tests/acceptance/colo.py                  |  677 ++++++++++
> >  10 files changed, 2286 insertions(+), 15 deletions(-)
> >  create mode 100755 scripts/colo-resource-agent/colo
> >  create mode 100755 scripts/colo-resource-agent/crm_master
> >  create mode 100755 scripts/colo-resource-agent/crm_resource
> >  create mode 100644 tests/acceptance/colo.py
> >=20
> > --
> > 2.20.1 =20
>=20
> Ping...

Ping 2...

Kevin, can you already apply patch 1 "block/quorum.c: stable children names=
"? It resolves the following bug: https://bugs.launchpad.net/qemu/+bug/1881=
231

Regards,
Lukas Straub

--Sig_/Sv.YT3J+8XPtH/L/mqFaYO1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl9HcZYACgkQNasLKJxd
slhHmhAArJG6jI/kY+iBFzwsbTRHu0yqcr+K9cIHBqeEHFMSPyTLYPv4gOymj5wL
tVtKgEkTN+wKnmVIbSM4IHYZM/Sh3eQK5NNd+sQcvzEOk1rSKA2IA2Yu8A/KaM0v
7krafVlOF+lpiYFhpUDzkBhlXYrlvFiEJ9Vt5ICeHkXn+GBX26J+fi8BFeEhzKm5
EMfANaDV7Noep5V3Qud4V5BONXNtWj73HTNwlM+UDrZ+53/mlg67KSYTFHuGR5QZ
VxcyTjfCCNbidh6q6aSOKB9glrPuaBc8Gd+GCVnbBCE/2u/ap1kNj5Ba95r5Bucv
LZ0EMkQKAdxwZebYccAqZc+uTufZZcGAce5WD8gTjtf0feDWOMKMqIRXTzRlYgWe
hpcKPkmEkF8J5PICmzo4QKMezUc+4YrvYlQPcuw38GddoCja2rydqJ8azQpw9QEq
h9Quswmn6L9R0/i1zSxm3JBaJHH25Mlwtce0bNELmJhO7Z9UEWFkAuDz/Ynb1kx6
XQ50GmCYaXuU9MuD1Dsv+wfAYid2DkGkfAqItvvoNtk5JDYgt0mGvNOSNkho6h7P
JQ9TbE7ld5qcNr+VdqM2WkV1yjRGOYcDztWLuLIOi9QIvm3T4Sg4OrP35I0ArBVn
ywd3vq8hLyNP/AOCA63PpwIzVPj0OxrSs0zuDdIS1VepXPEBZA8=
=reDT
-----END PGP SIGNATURE-----

--Sig_/Sv.YT3J+8XPtH/L/mqFaYO1--

