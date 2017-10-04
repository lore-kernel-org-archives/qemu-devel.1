Received: from eggs.gnu.org ([2001:4830:134:3::10]:56979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhIP-0001TI-6r
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhIO-000864-Dg
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:52:57 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:44365)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzhIO-00085K-85
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:52:56 -0400
Received: by mail-oi0-x231.google.com with SMTP id s145so13106722oie.1
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:52:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-8-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-8-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:52:54 +0200
Message-ID: <CAJ+F1CKg5ig8ohVUN-DxFqaai20bsOQWn0baSo-ZDudHusaT5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 07/32] qapi: Drop superfluous
 allow_optional=True
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Mon, Oct 2, 2017 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> check_command() passes allow_optional=3DTrue to check_type().  Useless
> unless you also pass allow_dict=3DTrue, which check_command() doesn't.
> Drop the superfluous argument.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 43a54bf40f..248af89b0b 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -695,7 +695,7 @@ def check_command(expr, info):
>          returns_meta +=3D ['built-in', 'alternate', 'enum']
>      check_type(info, "'returns' for command '%s'" % name,
>                 expr.get('returns'), allow_array=3DTrue,
> -               allow_optional=3DTrue, allow_metas=3Dreturns_meta)
> +               allow_metas=3Dreturns_meta)
>
>
>  def check_event(expr, info):
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
