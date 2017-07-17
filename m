Received: from eggs.gnu.org ([2001:4830:134:3::10]:47361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX6Me-0007sN-OH
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX6Md-0000LR-HN
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:47:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dX6Md-0000KN-Bc
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 09:47:07 -0400
References: <20170717133444.16743-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <04a388b6-9adc-8552-51ae-014996bf04c5@redhat.com>
Date: Mon, 17 Jul 2017 15:46:55 +0200
MIME-Version: 1.0
In-Reply-To: <20170717133444.16743-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] keymaps: fr-ca: more fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?B?SsOpcsO0bWUgUG91bGlu?= <jeromepoulin@gmail.com>

On 17.07.2017 15:34, Gerd Hoffmann wrote:
> Fixes: https://bugs.launchpad.net/qemu/+bug/533613
> Cc: Thomas Huth <thuth@redhat.com>
> Suggested-by: J=C3=A9r=C3=B4me Poulin <jeromepoulin@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  pc-bios/keymaps/fr-ca | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/pc-bios/keymaps/fr-ca b/pc-bios/keymaps/fr-ca
> index 030f56a78e..13a0306762 100644
> --- a/pc-bios/keymaps/fr-ca
> +++ b/pc-bios/keymaps/fr-ca
> @@ -10,6 +10,7 @@ sterling 0x4 altgr
>  cent 0x5 altgr
>  currency 0x6 altgr
>  notsign 0x7 altgr
> +numbersign 0x29
>  bar 0x29 shift
>  twosuperior 0x9 altgr
>  threesuperior 0xa altgr
> @@ -38,6 +39,10 @@ dead_cedilla 0x1b
>  dead_diaeresis 0x1b shift
>  exclam 0x2 shift
>  quotedbl 0x3 shift
> +comma 0x33
> +apostrophe 0x33 shift
> +period 0x34
> +period 0x34 shift
>  slash 0x4 shift
>  dollar 0x5 shift
>  percent 0x6 shift
> @@ -47,6 +52,9 @@ asterisk 0x9 shift
>  parenleft 0xa shift
>  parenright 0xb shift
>  underscore 0xc shift
> -plus 0xd shift
>  minus 0xc
> +underscore 0xc shift
>  equal 0xd
> +plus 0xd shift
> +semicolon 0x27
> +colon 0x27 shift

I don't have a fr-ca keyboard, but at least from having a quick look at
it, the patch looks now fine to me.

 Thanks,
  Thomas
