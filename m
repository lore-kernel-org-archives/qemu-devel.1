Received: from eggs.gnu.org ([2001:4830:134:3::10]:56709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX46f-00013g-J3
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dX46c-0002Zz-CE
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:22:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dX46c-0002Zi-6G
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 07:22:26 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 20F27356D9
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 11:22:25 +0000 (UTC)
References: <20170717111549.31511-1-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <45f5f80e-06ac-19d7-6a32-068117f94327@redhat.com>
Date: Mon, 17 Jul 2017 13:22:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170717111549.31511-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] keymaps: fr-ca: more fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org


If you'd like to do me a favour, please put the URL to the Launchpad bug
into the commit message - then it is later easier to close the bug with
the scripts/show-fixed-bugs.sh script.

On 17.07.2017 13:15, Gerd Hoffmann wrote:
> Cc: 533613@bugs.launchpad.net
> Cc: Thomas Huth <thuth@redhat.com>
> Suggested-by: J=C3=A9r=C3=B4me Poulin
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  pc-bios/keymaps/fr-ca | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>=20
> diff --git a/pc-bios/keymaps/fr-ca b/pc-bios/keymaps/fr-ca
> index 030f56a78e..2e540d596c 100644
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
>  twosuperior 0x9 altgr
>  threesuperior 0xa altgr
>  onequarter 0xb altgr
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
> @@ -48,5 +53,8 @@ parenleft 0xa shift
>  parenright 0xb shift
>  underscore 0xc shift
>  plus 0xd shift
> -minus 0xc
> -equal 0xd
> +minus 0x0c

The other values don't use a leading 0 in the hex value, so I'd maybe
keep the "0xc" instead of "0x0c" here?

> +underscore 0x0c shift
> +equal 0x0d

dito

> +semicolon 0x27
> +colon 0x27 shift
>=20
