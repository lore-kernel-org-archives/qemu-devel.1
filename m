Received: from eggs.gnu.org ([2001:4830:134:3::10]:51691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dwACX-00005j-TH
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 12:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dwACU-0007CE-Rk
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 12:56:17 -0400
Date: Sun, 24 Sep 2017 12:56:11 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <1327714502.20871949.1506272171027.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170922225533.1928-1-lyan@suse.com>
References: <20170922225533.1928-1-lyan@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] chardev/baum: fix baum that releases
 brlapi twice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liang Yan <lyan@suse.com>
Cc: samuel thibault <samuel.thibault@ens-lyon.org>, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-trivial@nongnu.org



----- Original Message -----
> Error process of baum_chr_open needs to set brlapi null, so it won't
> get released twice in char_braille_finalize, which will cause
> "/usr/bin/qemu-system-x86_64: double free or corruption (!prev)"
>=20
> Signed-off-by: Liang Yan <lyan@suse.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/baum.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/chardev/baum.c b/chardev/baum.c
> index 302dd9666c..67fd783a59 100644
> --- a/chardev/baum.c
> +++ b/chardev/baum.c
> @@ -643,6 +643,7 @@ static void baum_chr_open(Chardev *chr,
>          error_setg(errp, "brlapi__openConnection: %s",
>                     brlapi_strerror(brlapi_error_location()));
>          g_free(handle);
> +        baum->brlapi =3D NULL;
>          return;
>      }
>      baum->deferred_init =3D 0;
> --
> 2.14.1
>=20
>=20
