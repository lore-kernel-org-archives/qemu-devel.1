Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7044EC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:40:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470EB2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 12:40:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470EB2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxsaA-00077Q-FY
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 08:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ptoscano@redhat.com>) id 1hxsYs-00065D-IL
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hxsYr-0003KN-AE
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 08:39:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hxsYo-0003J4-Gt; Wed, 14 Aug 2019 08:39:26 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D154DDDB21;
 Wed, 14 Aug 2019 12:39:25 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (unknown [10.43.2.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3FF4F7A2E1;
 Wed, 14 Aug 2019 12:39:24 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@redhat.com>
Date: Wed, 14 Aug 2019 14:39:23 +0200
Message-ID: <7426390.htdRGj8iG7@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <20190814121527.17876-4-philmd@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
 <20190814121527.17876-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1711251.pPebD6CAJW";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 14 Aug 2019 12:39:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] configure: Improve checking libssh
 version is 0.8
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

--nextPart1711251.pPebD6CAJW
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, 14 August 2019 14:15:26 CEST Philippe Mathieu-Daud=C3=A9 wrot=
e:
> To figure out which libssh version is installed, checking for
> ssh_get_server_publickey() is not sufficient.
>=20
> ssh_get_server_publickey() has been introduced in libssh
> commit bbd052202 (predating 0.8) but distributions also
> backported other pre-0.8 patches, such libssh commit
> 963c46e4f which introduce the ssh_known_hosts_e enum.
>=20
> Check the enum is available to assume the version is 0.8.
>=20
> This fixes build failure on Ubuntu 18.04:
>=20
>     CC      block/ssh.o
>   block/ssh.c: In function 'check_host_key_knownhosts':
>   block/ssh.c:281:28: error: storage size of 'state' isn't known
>        enum ssh_known_hosts_e state;
>                               ^~~~~
>   rules.mak:69: recipe for target 'block/ssh.o' failed
>   make: *** [block/ssh.o] Error 1
>=20
> Reported-by: =E5=91=A8=E6=96=87=E9=9D=92 <1151451036@qq.com>
> Fixes: https://bugs.launchpad.net/qemu/+bug/1838763
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  configure | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index fe3fef9309..040aa8eb6c 100755
> --- a/configure
> +++ b/configure
> @@ -3949,18 +3949,24 @@ fi
>  if test "$libssh" =3D "yes"; then
>    cat > $TMPC <<EOF
>  #include <libssh/libssh.h>
> +#ifdef HAVE_LIBSSH_0_8
> +static const enum ssh_known_hosts_e val =3D SSH_KNOWN_HOSTS_OK;
> +#endif
>  #ifdef HAVE_SSH_GET_SERVER_PUBLICKEY
>  int main(void) { return ssh_get_server_publickey(NULL, NULL); }
>  #else
>  int main(void) { return ssh_get_publickey(NULL, NULL); }
>  #endif
>  EOF
> -  if compile_object "$libssh_cflags"; then
> +  if compile_object "$libssh_cflags -DHAVE_LIBSSH_0_8"; then
>      libssh_cflags=3D"-DHAVE_LIBSSH_0_8 $libssh_cflags"
>    fi
>    if compile_object "$libssh_cflags -DHAVE_SSH_GET_SERVER_PUBLICKEY"; th=
en
>      libssh_cflags=3D"-DHAVE_SSH_GET_SERVER_PUBLICKEY $libssh_cflags"
>    fi
> +  if ! compile_object "$libssh_cflags"; then
> +    error_exit "cannot use with libssh (is it broken?)"
> +  fi

Ugh no, this is way more twisted and complex than really needed.

Instead, just add another build time check for
ssh_session_is_known_server, and change check_host_key_knownhosts to
use it only when found.

=2D-=20
Pino Toscano
--nextPart1711251.pPebD6CAJW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl1UAPsACgkQw9FMLZhk
N81bAw/+MrjEJH+CV53OnmtruIxme4rrU1BgsEFkRQooOwSdSlXiItLJLbKDF+S/
Q7Dnz7UN9qtTpKR31X6VOAnPzHnBlCbD1rXWzptZPZHudcpweU3PtOCb+MKcp1QY
ccRiQdcWpWFGAR2frFPG50OTIC6ONzcbSNtHi95AQxAhqTlXywGhTYXaLyDpPiFq
LrQrchPDZPJ5dChzdic9DsTuy90wFheRixo7yoVchp6uuw1TBRc1PsznzZB4+nN4
4qbXMVvSUxgmIoFTEvo1vDVwvi5hFzVclfEZzcHgewnA20z6bToXwCe+qbRCf2Et
NK+Wyq22WoPl19rEIfFrLqqXWBiaYPx0h7gpNI3/LmFRXs4kOpg/VOSprSg+S7/r
7aYtKxs2RhRPsoHh6DgfkqtPJJIoBOMozQnJiTOwEkKly18swWzaYiqJnOmUb31f
qLpxp2QleTVMEUcOMkCjHQ7EJB4a5kxtYV1LvMq7HekK9+e/ajW3HIvvCitUBvs7
qr4m08xZjxqjqWNNUAKmU4EB5U06futkBDzSx1zS3KAgmCB3JpkPZBOOsOtpl7Cl
bKnnkY8yqZ+GZVia0Lt7V8ur+ffk/5I+OecQAuc20r1QeM8YHrglyMY3JvJ8rgna
EevENzfWdQNlmKdUuSoTQFKU6OMq5d+J46y0Ze27Bpa0XhBgd6w=
=I1mx
-----END PGP SIGNATURE-----

--nextPart1711251.pPebD6CAJW--




