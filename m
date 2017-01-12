Received: from eggs.gnu.org ([2001:4830:134:3::10]:58040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRfOJ-0005Fn-21
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:26:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRfOD-0008Gs-Of
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:26:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRfOD-0008GO-Ji
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:26:01 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AEB244DB15
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 13:26:01 +0000 (UTC)
Date: Thu, 12 Jan 2017 11:25:58 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112132558.GL3565@thinpad.lan.raisama.net>
References: <20170104205722.26492-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170104205722.26492-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Revert "win32: don't run subprocess tests
 on Mingw32 platform"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com

On Wed, Jan 04, 2017 at 09:57:22PM +0100, Marc-Andr=E9 Lureau wrote:
> This reverts commit 7ad9339e372fcd12d584684d7f52ac259604a4f4.
>=20
> The error "Failed to execute helper program (No such file or directory)=
"
> is due to broken glib installation, missing windows gspawn helpers.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Daniel, are you still unable to run subprocess tests on Migw32?

Anybody else able to test this and send a Tested-by line?


> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 218df87d21..54a222d5e7 100755
> --- a/configure
> +++ b/configure
> @@ -3077,7 +3077,7 @@ fi
> =20
>  # g_test_trap_subprocess added in 2.38. Used by some tests.
>  glib_subprocess=3Dyes
> -if test "$mingw32" =3D "yes" || ! $pkg_config --atleast-version=3D2.38=
 glib-2.0; then
> +if ! $pkg_config --atleast-version=3D2.38 glib-2.0; then
>      glib_subprocess=3Dno
>  fi
> =20
> --=20
> 2.11.0
>=20

--=20
Eduardo
