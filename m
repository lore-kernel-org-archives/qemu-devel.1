Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921C7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691BE2083B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:42:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 691BE2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsbb-0008Ca-Kz
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ptoscano@redhat.com>) id 1hxsay-0007hu-Ib
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:41:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hxsax-00047s-Kb
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:41:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hxsav-00046t-FJ; Wed, 14 Aug 2019 08:41:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70B533090FEE;
 Wed, 14 Aug 2019 12:41:36 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (unknown [10.43.2.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 059968175B;
 Wed, 14 Aug 2019 12:41:34 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Date: Wed, 14 Aug 2019 14:41:34 +0200
Message-ID: <2738213.2Lc8nMRjuf@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <20190814121527.17876-5-philmd@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
 <20190814121527.17876-5-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart55926548.U4DDp3z1WI";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Wed, 14 Aug 2019 12:41:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 4/4] configure: Log the libssh version
 detected
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

--nextPart55926548.U4DDp3z1WI
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, 14 August 2019 14:15:27 CEST Philippe Mathieu-Daud=E9 wrote:
> Log wether the version is 0.7 or 0.8 to better understand
> user reports.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  configure | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 040aa8eb6c..d06cee0ba0 100755
> --- a/configure
> +++ b/configure
> @@ -3930,6 +3930,7 @@ if test "$libssh" !=3D "no" ; then
>    if $pkg_config --exists libssh; then
>      libssh_cflags=3D$($pkg_config libssh --cflags)
>      libssh_libs=3D$($pkg_config libssh --libs)
> +    libssh_version=3D$($pkg_config libssh --modversion)
>      libssh=3Dyes
>    else
>      if test "$libssh" =3D "yes" ; then
> @@ -3960,6 +3961,9 @@ int main(void) { return ssh_get_publickey(NULL, NUL=
L); }
>  EOF
>    if compile_object "$libssh_cflags -DHAVE_LIBSSH_0_8"; then
>      libssh_cflags=3D"-DHAVE_LIBSSH_0_8 $libssh_cflags"
> +  else
> +    # If this is not libssh 0.8, this is likely 0.7
> +    libssh_version=3D"0.7"
>    fi

Not sure why this though -- please leave it out, and just log the
version as found.

=2D-=20
Pino Toscano
--nextPart55926548.U4DDp3z1WI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl1UAX4ACgkQw9FMLZhk
N83KwxAAxg0l/paMr+GupQaFFsZM5Vbnq7LXSsslgMKmnNc7t/tWnXYJCmVRKkIp
UYB+xwXiKmQKgXj8E0CPcvqWG+3BAm5vIZWICMLbHeUjvNhNOr/datF45osY7UUE
cH9s2xT2j3I2LtHeVgRfOFHP3wbfTnXvWujayRBA73qNMOU8NQtLv54VCfZhnntX
xVcwR6FnJMnnEy84XjvreTYGiALMcBEUWFVTR4qnMve7c/6KGKPNRAZ9xAD3irBo
MCV9j0ItIZzKZbVTErINvT2EENcddhMo1pmYJjjFRWyGCHo8W6xeE4AdNBOgnhUf
CIDyjObxYWgSx92iV4nLHqnmgMxtjkGrSVuZ+h55L11KxM4mpNr2oqJhis/8ldFw
QJFveDbIPXGHsitvqmOcyYcHJB873E5VgLszotr8z1skLHOmDAl/oLufa7l9fwoV
m7fi957DGo/LAW6TJia6AH3ig6K7T7d5yH32cc3q1l44P+dP8I+eVHF1VWiHaSGw
n6l7pDksOsovBO2X3Q+jeDqZF5OXz/wiAmNaC5VpJkUIeG3xmNXnghg4cSUKq7x0
oqpb2pvSDfXPRt+NggktriYQO7yE0oa0dP4njQeks2UwSC91GbcKSTdMaGA26edc
81SGBTaUu9rZMlcqOWlsqQrY9iCR4Y27hcSC5oIgLcBWi4jThmQ=
=P2wK
-----END PGP SIGNATURE-----

--nextPart55926548.U4DDp3z1WI--




