Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50D7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7766B2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7766B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsX7-0003u9-Fm
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ptoscano@redhat.com>) id 1hxsWK-0003GD-LX
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hxsWJ-0002V3-JY
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48260)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hxsWH-0002TW-BW; Wed, 14 Aug 2019 08:36:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9882D4C95D;
 Wed, 14 Aug 2019 12:36:48 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (unknown [10.43.2.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2CDAB8E7A2;
 Wed, 14 Aug 2019 12:36:44 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Date: Wed, 14 Aug 2019 14:36:43 +0200
Message-ID: <18212418.TTLG0Ac5hC@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <20190814121527.17876-2-philmd@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
 <20190814121527.17876-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4237456.YCKIjLNRqX";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Wed, 14 Aug 2019 12:36:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 1/4] configure: Improve libssh check
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 "Richard W . M . Jones" <rjones@redhat.com>, Max Reitz <mreitz@redhat.com>,
 =?utf-8?B?5ZGo5paH6Z2S?= <1151451036@qq.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart4237456.YCKIjLNRqX
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, 14 August 2019 14:15:24 CEST Philippe Mathieu-Daud=E9 wrote:
> The libssh pkg-config is not complete, the libraries required to
> link with libssh are not returned. For example on Ubuntu 18.04:
>=20
>   $ dpkg -l|fgrep libssh
>   ii libssh-4:arm64 0.8.0~20170825.94fa1e38-1ubuntu0.2 arm64 tiny C SSH l=
ibrary (OpenSSL flavor)
>   ii libssh-dev 0.8.0~20170825.94fa1e38-1ubuntu0.2 arm64 tiny C SSH libra=
ry. Development files (OpenSSL flavor)
>=20
>   $ pkg-config libssh --libs
>   -lssh
>=20
> Since the ./configure script tries to link an object to figure if
> libssh is available, it fails:
>=20
>   $ cat  config.log
>   [...]
>   cc -pthread -I/usr/include/glib-2.0 [...] -o config-temp/qemu-conf.exe =
config-temp/qemu-conf.c -m64 -static -g -lssh
>   /usr/lib/gcc/x86_64-linux-gnu/7/../../../x86_64-linux-gnu/libssh.a(dh.c=
=2Eo): In function `ssh_crypto_init':
>   (.text+0x1a9): undefined reference to `BN_new'
>   (.text+0x1c2): undefined reference to `BN_set_word'
>   (.text+0x1c7): undefined reference to `BN_new'
>   (.text+0x1e7): undefined reference to `BN_bin2bn'
>   (.text+0x1ec): undefined reference to `BN_new'
>   (.text+0x20c): undefined reference to `BN_bin2bn'
>   (.text+0x218): undefined reference to `OPENSSL_init_crypto'
>   [...]
>   collect2: error: ld returned 1 exit status

Sigh :/

> ---
> Should we check for libcrypto?
>=20
> $ pkg-config --libs libssh openssl
> -lssh -lssl -lcrypto

Definitely not! The crypto library is an internal implementation of
libssh, so please do not assume libssh is built against openssl.

=2D-=20
Pino Toscano
--nextPart4237456.YCKIjLNRqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl1UAFsACgkQw9FMLZhk
N81+BA/+Ja6yMrWf38jZrUOp4jiZkzG/3A3ghT3Ha+ffnqEx/Qe0qV9I+Z9gLj96
iFBXeKKu9SVr4yKVuNj28ZBY1u706lRK/6hyiH8kDGflMzuKBvC04EgW6EguAq/o
sn/EyBuwe87B/Hr2v5dRSksmS4gUUF5Jkyninfu9Fv9cA9UleZb0USyLtARNLLIn
hbA4gyzWpSaUcGDXU7Hbtx3d0k3W5GlxV7uNuOAS/n+CQjDhihHUA5KABasAGZR/
Y2qLxlVWdxxgziFl/V3BbxcbO5aHmz/lQ8PopSMd+ZH9HZSHVosjpNtuGxVnhSwx
7yUkWwNcMPqqV/x+fwbwLUkdWHxVm+fZWd06K3Alv75V1PhUUA8A0os+6VdIw9Pa
Gl0Fut4VkBoUE2OtHEmZdPDybJiw8bwgn+Sp3Usu4J78jXB2Y41ryQ/wN9lZmv7B
OX/kWJldH5YrU94I364Epc6uf8KvJ3x88QGrpcNZLAy3hp3G4V68qf5ySVD8nCSZ
apPyT+mHpzlU1epPIPBqEPNGKO5fEi/nqruvaEoebOuZSiOWADSZo9g2jepZ99P6
uyK10xNo/uca+NhENO5/1aN86UwdEgfolPy6Z1DM4KSligRMr6fRCuU511tfMe1O
A102sKwhPBUpxHrA6ZSW37KHRcmctN1h3ocAMbMOVq0MSok8pmM=
=ZYrL
-----END PGP SIGNATURE-----

--nextPart4237456.YCKIjLNRqX--




