Received: from eggs.gnu.org ([2001:4830:134:3::10]:53569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gVKgw-0000aI-Lc
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gVKgo-0000sq-Mm
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:17:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:11537)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gVKgm-0000do-6f
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 13:17:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C19AB307D981
	for <qemu-devel@nongnu.org>; Fri,  7 Dec 2018 18:17:21 +0000 (UTC)
References: <20181207161447.31314-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <77cd62fe-4b9e-88ac-b048-1d4a6ee5ff83@redhat.com>
Date: Fri, 7 Dec 2018 19:16:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181207161447.31314-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] util/error: Remove an unnecessary NULL
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, "=?UTF-8?Q?Daniel_P_._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 2018-12-07 17:14, Philippe Mathieu-Daud=C3=A9 wrote:
> This NULL check was required while introduced in 680d16dcb79f.
> Later refactor added a NULL check in error_setv(), so this check
> is now redundant.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  util/error.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/util/error.c b/util/error.c
> index b5ccbd8eac..934a78e1b1 100644
> --- a/util/error.c
> +++ b/util/error.c
> @@ -103,10 +103,6 @@ void error_setg_errno_internal(Error **errp,
>      va_list ap;
>      int saved_errno =3D errno;

Could the saved_errno now be removed, too, since err_setv does that again=
?

 Thomas


> -    if (errp =3D=3D NULL) {
> -        return;
> -    }
> -
>      va_start(ap, fmt);
>      error_setv(errp, src, line, func, ERROR_CLASS_GENERIC_ERROR, fmt, =
ap,
>                 os_errno !=3D 0 ? strerror(os_errno) : NULL);
>=20
