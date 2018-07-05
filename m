Received: from eggs.gnu.org ([2001:4830:134:3::10]:51279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fb8IY-0002tx-1d
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1fb8IT-0004lh-0z
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:44:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46590 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1fb8IS-0004lG-Ri
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:44:00 -0400
References: <20180705161629.13734-1-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <1e40fc1a-7b96-9244-ace8-bdf9d54a3891@redhat.com>
Date: Thu, 5 Jul 2018 19:43:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180705161629.13734-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga: fix 'driver' leak in guest-get-fsinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On 07/05/18 18:16, Marc-Andr=C3=A9 Lureau wrote:
> 'driver' is leaked when the loop is not broken.
>=20
> Leak introduced by commit 743c71d03c20d64f2bae5fba6f26cdf5e4b1bda6,
> spotted by ASAN.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qga/commands-posix.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> index 233f78a406..c46767b0dd 100644
> --- a/qga/commands-posix.c
> +++ b/qga/commands-posix.c
> @@ -890,6 +890,7 @@ static void build_guest_fsinfo_for_real_device(char=
 const *syspath,
>              break;
>          }
> =20
> +        g_free(driver);
>          if (sscanf(p, "/%x:%x:%x.%x%n",
>                            pci, pci + 1, pci + 2, pci + 3, &pcilen) =3D=
=3D 4) {
>              p +=3D pcilen;
>=20

Sorry, I should have noticed this in review.

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Laszlo
