Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF6EC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:36:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75797214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:36:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75797214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsVy-0002re-Jy
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ptoscano@redhat.com>) id 1hxsVB-0002Lx-IY
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:35:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hxsVA-0001zo-85
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:35:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41763)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hxsV7-0001x9-F7; Wed, 14 Aug 2019 08:35:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 015723172D92;
 Wed, 14 Aug 2019 12:35:36 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (unknown [10.43.2.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 316D78069F;
 Wed, 14 Aug 2019 12:35:31 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Date: Wed, 14 Aug 2019 14:35:17 +0200
Message-ID: <4610855.PE5deYgxqJ@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <20190814121527.17876-3-philmd@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
 <20190814121527.17876-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2189404.1jKhGM7Ox4";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Wed, 14 Aug 2019 12:35:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] configure: Avoid using libssh
 deprecated API
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
 Andrea Bolognani <abologna@redhat.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart2189404.1jKhGM7Ox4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Wednesday, 14 August 2019 14:15:25 CEST Philippe Mathieu-Daud=E9 wrote:
> The libssh packaged by a distribution can predate version 0.8,
> but still provides the newer API introduced after version 0.7.
>=20
> Using the deprecated API leads to build failure, as on Ubuntu 18.04:
>=20
>     CC      block/ssh.o
>   block/ssh.c: In function 'check_host_key_hash':
>   block/ssh.c:444:5: error: 'ssh_get_publickey' is deprecated [-Werror=3D=
deprecated-declarations]
>        r =3D ssh_get_publickey(s->session, &pubkey);
>        ^
>   In file included from block/ssh.c:27:0:
>   /usr/include/libssh/libssh.h:489:31: note: declared here
>    SSH_DEPRECATED LIBSSH_API int ssh_get_publickey(ssh_session session, s=
sh_key *key);
>                                  ^~~~~~~~~~~~~~~~~
>   rules.mak:69: recipe for target 'block/ssh.o' failed
>   make: *** [block/ssh.o] Error 1
>=20
> Fix by using the newer API if available.
>=20
> Suggested-by: Andrea Bolognani <abologna@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  block/ssh.c | 2 +-
>  configure   | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/ssh.c b/block/ssh.c
> index 501933b855..f5fea921c6 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -438,7 +438,7 @@ check_host_key_hash(BDRVSSHState *s, const char *hash,
>      unsigned char *server_hash;
>      size_t server_hash_len;
> =20
> -#ifdef HAVE_LIBSSH_0_8
> +#ifdef HAVE_SSH_GET_SERVER_PUBLICKEY
>      r =3D ssh_get_server_publickey(s->session, &pubkey);
>  #else
>      r =3D ssh_get_publickey(s->session, &pubkey);
> diff --git a/configure b/configure
> index 1d5c07de1f..fe3fef9309 100755
> --- a/configure
> +++ b/configure
> @@ -3949,11 +3949,18 @@ fi
>  if test "$libssh" =3D "yes"; then
>    cat > $TMPC <<EOF
>  #include <libssh/libssh.h>
> +#ifdef HAVE_SSH_GET_SERVER_PUBLICKEY
>  int main(void) { return ssh_get_server_publickey(NULL, NULL); }
> +#else
> +int main(void) { return ssh_get_publickey(NULL, NULL); }
> +#endif
>  EOF
>    if compile_object "$libssh_cflags"; then
>      libssh_cflags=3D"-DHAVE_LIBSSH_0_8 $libssh_cflags"
>    fi
> +  if compile_object "$libssh_cflags -DHAVE_SSH_GET_SERVER_PUBLICKEY"; th=
en
> +    libssh_cflags=3D"-DHAVE_SSH_GET_SERVER_PUBLICKEY $libssh_cflags"
> +  fi

Why try to compile it twice? If the check for ssh_get_server_publickey
works, then it is available...

Just add an additional HAVE_SSH_GET_SERVER_PUBLICKEY define when this
test succeeds, and change the usage of ssh_get_server_publickey based
on this.

=2D-=20
Pino Toscano
--nextPart2189404.1jKhGM7Ox4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl1UAAUACgkQw9FMLZhk
N83EphAAuDi1pG5uKyCZPYtKWSalpAs264NTKJhIUsfH9cRQt1gdUPfaMyMxbFCN
wa5OY9MzkNAZC33GZ4wkh2vDzUuWnVsGFy3r8Uwqvy3WvRzQGwAiSOcUF01auhZ7
ShUCFcU9V2VKihbhhWGPSUnQFLsXPdmtRyvgSghNR2X3M8a8aTl9FJK0Y/Tzflvy
Q4N2UQ9pe0TmD/B51stbB6lnmkY7Qww63VafilkRZGDuvBQbEC/YiJ08/5GU1x6x
pq0JkZqvqWdfNIVVe7f4VXgMUh2JhLiX6Ci0vU9RGODiR7quHFQJecfRHLmgdX3U
P5n8REF/HtKhSAGwRLEzkVVu1Y+BMp3jWCjGDGmM9CCIrCRY0Sqrmm8dVuelq8js
AwhfDWLWq1jKTGbE9B40gPvaoKIpNstRXWL+rQ17sjv53aK/C3iGo7gFUXvtxDYs
uily0mGfc8n1t7e7d16QjO8YLFnr10qsUntzxD1q/4G9BjTY/2U6XpqCdGab7RNh
AnB/Q0rWEj/za01HC/uYLqEhZbBA94LGskEui0CANyBoTZgQdOLoLDixB8uq3oC1
smYmdDwv5Zf/fCpBCJmoRqAhMxwI4TAzhGxyl3FaaJaHzYbjeDURnnr7mAQPstZK
E+hPjmxmf9nm31hlkVyll+95XAhTUdTM6wi/2GZRMO/GU4BvkeU=
=1tOW
-----END PGP SIGNATURE-----

--nextPart2189404.1jKhGM7Ox4--




