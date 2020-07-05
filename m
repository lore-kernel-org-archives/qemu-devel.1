Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11C0C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 09:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9914120786
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 09:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="h7XxDsO2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9914120786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js19f-0008R0-LG
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 05:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1js16N-0006nk-5F
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 05:38:23 -0400
Received: from mout.web.de ([212.227.15.4]:46913)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1js16L-0008Tc-9u
 for qemu-devel@nongnu.org; Sun, 05 Jul 2020 05:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1593941873;
 bh=X6QmM4KFLtvdffCHFW7yr1HuwvLeSAjvWv/SwfoSPak=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=h7XxDsO2a4gsvZYzXkaPBnLdLkNjNHJuI6ZX2AO6azZuh6N7TBJ3K03siVS1AMsRi
 53c3W8bTu1/tHyYgNVKqoWKRAGJQqRhlQzLGkuJfNsMFemTaXJKhNh3jOlKVEoUhpj
 hf4XAIjtcXwzKhEKYvnzmyL3vbI/l0BBQnk04bPU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.118]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MfKtb-1kXvHm0dfH-00gqTH; Sun, 05
 Jul 2020 11:37:53 +0200
Date: Sun, 5 Jul 2020 11:37:50 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 0/7] colo: Introduce resource agent and test suite/CI
Message-ID: <20200705113750.45175374@luklap>
In-Reply-To: <cover.1591456338.git.lukasstraub2@web.de>
References: <cover.1591456338.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pOHUfo.d9W9ayNgbzRqb+LS";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:B6z2x4WP7NpDMDLx0OI6EEncx3KXdP8yFruppojMRnbpvJSJ0so
 Bfi9bpC8zANmIMNwkt1lCDqrVyOP5FXeJGhUrPKei/IOwaT4BE10lf0xnzrzPlMvqW+rBDa
 oowACkXek75i6xyVvI6G/jx0C8BFoOK59gA6fz+b8kHIqKVtlw2yqht1bHnk3YbN5qrCYvV
 S86HkCnGnSsO1eUwVQ0DA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y39aL9xjSpI=:btmgaXl3zenAuA367FZV27
 DysGXAnHtSivlgeF/G8IAFD2b75ZhspVpNMZbT9mXwnmX/XR47up8MqGArIMA+ERrA3YYyUgS
 p+3/bBvFg/FEMGkYF139MVFuIdciQfeIYR7aCYFKS4+azGweJ0zIwIUoOLiVPPwtfZ/CDXQOm
 Xf2rmFyQEcLY4Ag8SI7jXybAYB8rESP3bnh2r/R81Xd+pkJNY5e+Ridy+t2T7tPkNAtpzoSJl
 vuhrj4NcjPBI56ZL3CIwxpN6cIaGxsVCKEGrRz7RxDX52IIt39ejuUbzv7sIXZXVRPJur9K9D
 +oVroiIE9mvhpYOjbaf4nzVjolXHhvfBBXCxoGqJJ/CHZgoHrMsxdzvKnUovtTgZx5an+cIOE
 NFI6OzLDEw/oQ0n0ArrEU8ox6JwTB4OS2AYv4moKrxUQlPXzvUoeZdN0L2P1S9rIH/3YDwO29
 MbDRr+lw55UxkqdGPKLvDH1WRGs6uVhJlx025gYMRr5czaHA5uWO6gMLoukRZjiq6B8Jnf9U8
 ZMUN6IQcnJ8MkbXu2jID3Bfue10IAv0gR0pv9O0NkIRv4jaULIRT/Nvo6ypgShjJrcFDfETEZ
 AXNV0WptT/9GB/9Oqef9m7PVNMKdrtmWTYfu2bEHJuNubmx8o5NL4zt+OvWZM1jzZbL4/O+PS
 5kbhBP2gf9Uoy54OnJjeIoDR7aF6q2Q/iuGvjDTXK/Vu2wKxvlqYR205uI7OyCizXisFTaAKQ
 XZ1PQV4Xnoz1Zn68yEdgvlJc/j4lI6GhnewNBc086FgB88JQzu7dV+RpTabYLvMulyixtAcaQ
 PgC9O2Rb8NS1ZPN0gkuPH8lusPUYFVNn3D1cIoh30UXlKiCE8GcTF9tqQloa1g4FkMWhvG/hK
 Le21Tcod+dlDXmFHRWtcM2L+wvQOLY7LjccQ0y7BLQvSiQone1nxj8dErqPhA+JoVYuPFDxWz
 MpRLN8DgMbrb1lIFEVlTl3IKsgFm9YtMUNcEw7ay4xb79b19NPJGZGPdrbt5kVBaGfn0eDJ9+
 ouUig9VYzPFoPxPt49qIzxj7qat9hc2YJRnp/EqOSilWEie9We7pFAm2vxGnJvrCRUQPEhh+n
 QikTYwtObWzuAy+c6U52WcS8Y9uP0emLNwq6G1k9pw/zRSu335W+rNbcKnZo7J6ArWZfFKsMK
 0d61zOAaB9GR5w/WOysY111vZct0KoynCnuMbtCKyKFZuvLze7YYPhNerm0ewFWrG3KllyQCl
 yhohzVLItQJJOLkri
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/05 05:38:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

--Sig_/pOHUfo.d9W9ayNgbzRqb+LS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 6 Jun 2020 21:17:32 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> Hello Everyone,
> So here is v2. Patch 1 can already be merged independently of the others.
>=20
> Regards,
> Lukas Straub
>=20
> Changes:
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
> The test suite needs access to a network bridge to properly test the netw=
ork,
> so some parameters need to be given to the test run. See
> tests/acceptance/colo.py for more information.
>=20
> I wonder how this integrates in existing CI infrastructure. Is there a co=
mmon
> CI for qemu where this can run or does every subsystem have to run their =
own
> CI?
>=20
> Regards,
> Lukas Straub
>=20
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
>  scripts/colo-resource-agent/colo          | 1466 +++++++++++++++++++++
>  scripts/colo-resource-agent/crm_master    |   44 +
>  scripts/colo-resource-agent/crm_resource  |   12 +
>  tests/acceptance/avocado_qemu/__init__.py |   15 +
>  tests/acceptance/boot_linux.py            |   11 +-
>  tests/acceptance/colo.py                  |  677 ++++++++++
>  10 files changed, 2251 insertions(+), 15 deletions(-)
>  create mode 100755 scripts/colo-resource-agent/colo
>  create mode 100755 scripts/colo-resource-agent/crm_master
>  create mode 100755 scripts/colo-resource-agent/crm_resource
>  create mode 100644 tests/acceptance/colo.py
>=20
> --
> 2.20.1

Ping...

--Sig_/pOHUfo.d9W9ayNgbzRqb+LS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl8Bn24ACgkQNasLKJxd
slhHdA//WyBx9EEIg37jcRtQmfjPGEZMeA3i52D0cfOhG1rhdvscUqMmFqTNJSEq
gaaHzkKhHsCz0gIZTmW8lLfbuPhmAfadKCHfqFw0dZvLsAzseaoaB0tfK1al5p9O
VxWgSWIDaHyeMgPehIRM57J9fsIiuJL0M6jX+6bvzF4sSTtFyNY05BGFcVnXa+9r
vO6PvheVJdXkxCi/YfDGf3TzVCtrtuXTIVLkr0qgzhcB4KR7pKzXdkUqHa8P7guU
km2YlN+m+wFlLf2YOk7Df3l3ZXZ33uyodpySG49Md6dzudBp64QKu+EuDgHlannQ
csjAPpIEEHbW6rqPghW3UDE5uRPsrfUXfDPfuSplUrAkwSqRAGZYqviAt4qhmj44
enOThudIbuIm6O5QLRTqRmoy6fEgaOnxnNJdxJhOIipFJn/86rp5ttuj5J/fdp8v
mhnMTb4bE6bBkfLRZIEXWMHYppS+Z6w+7bw7GPh4gnIEk1IfXzIYK0pRF34Nj6vD
P4FJlKuRBe7zWEOy+e1IRri2x1GaTHDw/T8MX6BXn5f4JS3dYq+OLuLy/x31JiWR
ckKKKhsW7sifCI7At/HTG9/J8wx5Dh3U1LxS8E9xTAWkvxE+CpGwn6V+UTdxwMPB
LmUX3Y72iCarvks5FazcT4+v2illD5tNlvobSVLeqHsLv8hV3Zo=
=qp/j
-----END PGP SIGNATURE-----

--Sig_/pOHUfo.d9W9ayNgbzRqb+LS--

