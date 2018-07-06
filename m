Received: from eggs.gnu.org ([2001:4830:134:3::10]:33151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fbQfj-00074c-69
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fbQfi-0006Q8-8f
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:21:15 -0400
Received: from mail-yw0-x242.google.com ([2607:f8b0:4002:c05::242]:32799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1fbQfi-0006Pq-41
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:21:14 -0400
Received: by mail-yw0-x242.google.com with SMTP id c135-v6so4166196ywa.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 06:21:13 -0700 (PDT)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180705161629.13734-1-marcandre.lureau@redhat.com>
References: <20180705161629.13734-1-marcandre.lureau@redhat.com>
Message-ID: <153088326737.8870.11485147711961793106@sif>
Date: Fri, 06 Jul 2018 08:21:07 -0500
Subject: Re: [Qemu-devel] [PATCH] qga: fix 'driver' leak in guest-get-fsinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com

Quoting Marc-Andr=C3=A9 Lureau (2018-07-05 11:16:29)
> 'driver' is leaked when the loop is not broken.
> =

> Leak introduced by commit 743c71d03c20d64f2bae5fba6f26cdf5e4b1bda6,
> spotted by ASAN.
> =

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks, applied to qga tree:
  https://github.com/mdroth/qemu/commits/qga

> ---
>  qga/commands-posix.c | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 233f78a406..c46767b0dd 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -890,6 +890,7 @@ static void build_guest_fsinfo_for_real_device(char c=
onst *syspath,
>              break;
>          }
> =

> +        g_free(driver);
>          if (sscanf(p, "/%x:%x:%x.%x%n",
>                            pci, pci + 1, pci + 2, pci + 3, &pcilen) =3D=
=3D 4) {
>              p +=3D pcilen;
> -- =

> 2.18.0.rc1
>=20
