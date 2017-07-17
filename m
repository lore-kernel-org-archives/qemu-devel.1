Received: from eggs.gnu.org ([2001:4830:134:3::10]:59736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX5Qe-0001Ey-2e
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX5QZ-0003ZJ-DL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:47:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dX5QZ-0003Yv-7U
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:47:07 -0400
References: <20170717114332.2941-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5594426e-d785-7143-9a7d-df0cc5c123f3@redhat.com>
Date: Mon, 17 Jul 2017 14:46:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170717114332.2941-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] keymaps: fr-ca: more fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?SsOpcsO0bWUgUG91bGlu?= <jeromepoulin@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 17.07.2017 13:43, Gerd Hoffmann wrote:
> Fixes: https://bugs.launchpad.net/qemu/+bug/533613
> Cc: Thomas Huth <thuth@redhat.com>
> Suggested-by: J=C3=A9r=C3=B4me Poulin
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  pc-bios/keymaps/fr-ca | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/pc-bios/keymaps/fr-ca b/pc-bios/keymaps/fr-ca
> index 030f56a78e..b177d074c9 100644
> --- a/pc-bios/keymaps/fr-ca
> +++ b/pc-bios/keymaps/fr-ca
> @@ -3,6 +3,8 @@
>  include common
>  map 0xc0c
> =20
> +numbersign 0x29
> +bar 0x29
>  backslash 0x29 altgr
>  plusminus 0x2 altgr
>  at 0x3 altgr
> @@ -10,7 +12,6 @@ sterling 0x4 altgr
>  cent 0x5 altgr
>  currency 0x6 altgr
>  notsign 0x7 altgr
> -bar 0x29 shift

Now both, numbersign and bar are mapped to 0x29, which sounds wrong to
me. Before this patch, bar was mapped to "0x29 shift", so keeping that
might be a better option instead?

 Thomas
