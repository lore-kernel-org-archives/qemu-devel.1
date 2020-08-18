Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C38C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:32:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 595D92065D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="DvKYeVYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 595D92065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k80nE-0006zo-Bh
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 08:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33306)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k80iF-00047R-IZ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:27:35 -0400
Received: from mout.web.de ([217.72.192.78]:50687)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k80iD-0002eb-Lh
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 08:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1597753625;
 bh=xAYAMNZznihGhXB6b0Zne0872D9TrpTHXauiELJAN+8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=DvKYeVYeTYO7RQ/VT+sGqP42ToONbT7vn4l+O0ax2n4WKbWRpPk/U5j+sz9XF/+Kf
 BNfVh1qa3ml4WdnIFnSqpKg4Ap5+JuIk5tp4aMkio746GiBjYn1q3uu3vF/EL3kLuH
 SLKP5seNwpSDVVHk8dIIhQwIH3IA/sZXAPPZzjzc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.107]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lkh7Q-1kiAw916A8-00aUpm; Tue, 18
 Aug 2020 14:27:05 +0200
Date: Tue, 18 Aug 2020 14:27:01 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v3 0/7] colo: Introduce resource agent and test suite/CI
Message-ID: <20200818142701.6d1d82bd@luklap>
In-Reply-To: <cover.1596536719.git.lukasstraub2@web.de>
References: <cover.1596536719.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6h//x_4uwRTisCjHo8L05kG";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:iovb8qppwy+EacJGq5VgMUtf004izfUtikG2yW0NYVfqYjCJKau
 TU/K7bwbumOiRwdTXsge2mPFzf4pGSyk0FauFXOrjIBpIinvuyDx4zS5gKv0BhuYd/6d+fQ
 gSWzP4CU4cOV2bOPtnPiGE6oqNoKD01YBHHLJoYoSA7DEM+2soIjOv9S7rX4ZvfUhiEKElh
 hXoSNo+9C54TlF3CJejHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4mNrPqlApuU=:LeUJWqasNozQmb2P7M5h49
 AoDogSF1LfOvHGcre9Cf9AbS7lMLhzFzJVaGVqPp+gDEq/HdpaAeBjA/gwFPhk6zfs9JDIes3
 u/qRdohxxSZNJ8lItG2r4iD56GJBdLU+pE5eZgz5vgq3zSjQuWZoIa3sPR3Yn7QL0ye4bsykA
 H6YZjfQDYeS05E9Vl5TWa5ReaJ8eSQ+b/ZAK+Ja2C4PySM1BKQhUWcWQTD+OTF6i99IzHtePD
 LL+Osd/exF6TPW1TXDVef3H7aN3Ji3R49/sM+wH3b+aWFYShzygn4CeKseQo1Rtc3ENp00nab
 B058FsZvdjvSi8l0HQTcrP+p+QKBjP0J5GW4RkMmXiWBbUbavIHYTjEm9pSpZ1TyyDuf3rpS0
 rk2Yzw/bE8zDxuS92jjK/a5njKFuLLSWdPoFPJ6+XsBSLBdcKRdNchFW9KLeDnMpJ2Zu+FayD
 cmu970RyUiF586+qA6DtKJF3wnwrTmJ/W2Ihd16j12re+HeNBwNLu7c7HOnr9b2g0YdFHVkO6
 NTc334oW7DYNYEthm2qsvUivuzO7aTsHGMU34M25xBULmsvmAoB1S/d1qNWE3BiNkXv4GqOYS
 jtyo79xS62eurw6KAOu0WbpN1Zk8kkiIdIDk+40yDauYf9nvMlVBPN5/Uc3Qakrqt7pP0s1FO
 mU7KkLhP8CzGXPy/v2qzb7Ym7fx8N0jkA+DFKl/sXR8xdY+mWLNIDS3ulGXvEGK3q1b7c7nBg
 iPtDP4vl27DXD3Sq9TovD/DCa+ogH8rWG+JpERp0eC4hVvQq0HBpkKq7kBWbv/wH9h3KpArL0
 YZogP3mS0DlqPAzidn8JVado9y1Gr9VjOZTH7fztqAwo0Ppr20/xllqpe22szHr+4sXKIsT5h
 u4UjHNhGWicUIl1jJbMJm4BinEGXE8pAqwI8d8KcI6XBZq/6qHkvY6zdsrhc+p5Y0CsMOrnnl
 xsD25wHvAUcQdvJa4kK6DAbO7myXJ+oa+b45ltqhr8VTgwu/231zbSE0XUoD/PN4f3oFguSFF
 aYh7JFsouoQOWeOdqrKWLH7Y9Qn7qL+a6T+4mDot/CVHKMVtmLlYXIpTxneOcKjvn5dJJ+kAc
 o6AwB1i1Us4l6tQRK3nw/UG41JN5ZrQyUmFSKUBXyhMq+GRUwqsJ8cZMNUgdaSBKv1aS8o+nV
 r/UcO9eWbw3IaH6TBknSku6g+XZEHPZha9KJd0riIjWMNfgBAJ0k9RzKNn935IrJKo/m659CQ
 XQk5sqCJveHVFRp2PHbfex0cX9K1F/CNDqu1YUw==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:27:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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

--Sig_/6h//x_4uwRTisCjHo8L05kG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2020 12:46:29 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> Hello Everyone,
> So here is v3. Patch 1 can already be merged independently of the others.
> Please review.
>=20
> Regards,
> Lukas Straub
>=20
> Based-on: <cover.1596528468.git.lukasstraub2@web.de>
> "Introduce 'yank' oob qmp command to recover from hanging qemu"
>=20
> Changes:
>=20
> v3:
>  -resource-agent: Don't determine local qemu state by remote master-score=
, query
>   directly via qmp instead
>  -resource-agent: Add max_queue_size parameter for colo-compare
>  -resource-agent: Fix monitor action on secondary returning error during
>   clean shutdown
>  -resource-agent: Fix stop action setting master-score to 0 on primary on
>   clean shutdown
>=20
> v2:
>  -use new yank api
>  -drop disk_size parameter
>  -introduce pick_qemu_util function and use it
>=20
> Overview:
>=20
> Hello Everyone,
> These patches introduce a resource agent for fully automatic management o=
f colo
> and a test suite building upon the resource agent to extensively test col=
o.
>=20
> Test suite features:
> -Tests failover with peer crashing and hanging and failover during checkp=
oint
> -Tests network using ssh and iperf3
> -Quick test requires no special configuration
> -Network test for testing colo-compare
> -Stress test: failover all the time with network load
>=20
> Resource agent features:
> -Fully automatic management of colo
> -Handles many failures: hanging/crashing qemu, replication error, disk er=
ror, ...
> -Recovers from hanging qemu by using the "yank" oob command
> -Tracks which node has up-to-date data
> -Works well in clusters with more than 2 nodes
>=20
> Run times on my laptop:
> Quick test: 200s
> Network test: 800s (tagged as slow)
> Stress test: 1300s (tagged as slow)
>=20
> For the last two tests, the test suite needs access to a network bridge to
> properly test the network, so some parameters need to be given to the test
> run. See tests/acceptance/colo.py for more information.
>=20
> Regards,
> Lukas Straub
>=20
> Lukas Straub (7):
>   block/quorum.c: stable children names
>   avocado_qemu: Introduce pick_qemu_util to pick qemu utility binaries
>   boot_linux.py: Use pick_qemu_util
>   colo: Introduce resource agent
>   colo: Introduce high-level test suite
>   configure,Makefile: Install colo resource-agent
>   MAINTAINERS: Add myself as maintainer for COLO resource agent
>=20
>  MAINTAINERS                               |    6 +
>  Makefile                                  |    5 +
>  block/quorum.c                            |   20 +-
>  configure                                 |   10 +
>  scripts/colo-resource-agent/colo          | 1501 +++++++++++++++++++++
>  scripts/colo-resource-agent/crm_master    |   44 +
>  scripts/colo-resource-agent/crm_resource  |   12 +
>  tests/acceptance/avocado_qemu/__init__.py |   15 +
>  tests/acceptance/boot_linux.py            |   11 +-
>  tests/acceptance/colo.py                  |  677 ++++++++++
>  10 files changed, 2286 insertions(+), 15 deletions(-)
>  create mode 100755 scripts/colo-resource-agent/colo
>  create mode 100755 scripts/colo-resource-agent/crm_master
>  create mode 100755 scripts/colo-resource-agent/crm_resource
>  create mode 100644 tests/acceptance/colo.py
>=20
> --
> 2.20.1

Ping...

--Sig_/6h//x_4uwRTisCjHo8L05kG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl87yRUACgkQNasLKJxd
sljr4hAAgBf0+dbcWmLTQHPaN6cMZ5mLIJGQlrCC3ua3iwc2HYlcEUdJU2uC2TWq
TPGVvuHVaq3HiWltPlZzAZn7GHXHKmfqwzUD8v8IVPFz5TclEC/cTNL38cfDj0f+
NOV9PcqRw0nalIbsgONqpBAlo2D8HpGIQQhJt0lM3W52bcMhONHc3sMfflicgGIn
/WbMCDQvJ0PuBOrTCFK46m8JRIkcPmvpNu7MVE6Xpd3/s1xE4qe8rNnYWNLK3ux5
SjeOkIEoM/QXzFHE7yR0E8hYPJWWiUJGglMMHgjEJpLgv2gsf9QgElp5cftoBPCP
PLMJYifKJedaF8lXP+ejtI9vOXL4yqvk+J93+2JMetz0cxO93Tp5MwMQYu/S7ybB
J1JYNMLNwFQv3duNeySCkcSLyC6IGhI3ORPdlWfHvuRHRQDI25gZXTE3WdaQi1XM
F/5tqMShmC+blwQQAWkcuylvJdTu9F1ZpQGc+wUXZ3BQgGPvofAlpLChlmplx8yC
bARr2B0EeHn9jItxA/Psfa0pIGHnPdxmB7CFGFwGM25k1YByIPbmyfZQfl7LgRvL
iKck277cg7wJ58MbJTON/0+EYJ8Fd3gKfd+x/iK1ow7K4cV1QhiGNSHynPKfbti2
/nePAGrvIBDVrriSCkPFvErhQqFOYNvex/Hi2nnBtGsdGkAwzaM=
=gMjj
-----END PGP SIGNATURE-----

--Sig_/6h//x_4uwRTisCjHo8L05kG--

