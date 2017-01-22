Received: from eggs.gnu.org ([2001:4830:134:3::10]:57021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVIe4-00007o-U9
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 08:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cVIe3-0005cr-OU
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 08:57:25 -0500
MIME-Version: 1.0
References: <20170122133831.26150-1-sw@weilnetz.de>
In-Reply-To: <20170122133831.26150-1-sw@weilnetz.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sun, 22 Jan 2017 13:57:10 +0000
Message-ID: <CAJ+F1CJ10iLPVV0u0DQtZwEMZcHvHm3SDkBmDTmH=huC1k2cpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qapi2texi: Suppress unwanted commas in
 generated output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Sun, Jan 22, 2017 at 5:39 PM Stefan Weil <sw@weilnetz.de> wrote:

> Parts of the code use #optional followed by a comma.
>
> We don't want that comma to be part of the generated documentation,
> so remove it, too.
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>
> I added the generated documentation to https://qemu.weilnetz.de/doc/.
>
> See https://qemu.weilnetz.de/doc/qemu-qmp-ref.html for an
> example of the output without this patch (look for ", net").
>
> We could also remove the commas from the code, but I think
> that removing them programmatically is more robust (and also
> allows people placing commas as they like).
>

Sometime there is also a - : @ipv6: #optional - force the use of ipv6

I think I would rather fix the doc. Making the parser/generator more subtle
will also be harder to document or change later on.


> Regards
> Stefan
>
>  scripts/qapi2texi.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi2texi.py b/scripts/qapi2texi.py
> index 83ded95c2d..65c4aecfaf 100755
> --- a/scripts/qapi2texi.py
> +++ b/scripts/qapi2texi.py
> @@ -146,7 +146,7 @@ def texi_body(doc):
>              desc =3D str(section)
>              opt =3D ''
>              if "#optional" in desc:
> -                desc =3D desc.replace("#optional", "")
> +                desc =3D re.sub("#optional,?", "", desc)
>                  opt =3D ' (optional)'
>              body +=3D "@item @code{'%s'}%s\n%s\n" % (arg, opt,
>                                                     texi_format(desc))
> --
> 2.11.0
>
>
> --
Marc-Andr=C3=A9 Lureau
