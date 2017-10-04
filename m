Received: from eggs.gnu.org ([2001:4830:134:3::10]:57789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhKi-0003Xn-5H
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzhKh-00029f-8C
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:55:20 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzhKg-00029I-TG
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:55:19 -0400
Received: by mail-oi0-x243.google.com with SMTP id s145so6835839oie.5
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:55:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002152552.27999-10-armbru@redhat.com>
References: <20171002152552.27999-1-armbru@redhat.com>
	<20171002152552.27999-10-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:55:17 +0200
Message-ID: <CAJ+F1C+=LH3EmeP3Mzo8jUS+nZ4wwZZs5r_3Kd1XHMiqw69R_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 09/32] qapi: check_type() parameter
 allow_optional is now unused, drop
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
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi.py | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index 208010c241..8f9c5666bd 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -629,8 +629,7 @@ def add_name(name, info, meta, implicit=3DFalse):
>      all_names[name] =3D meta
>
>
> -def check_type(info, source, value, allow_array=3DFalse,
> -               allow_dict=3DFalse, allow_optional=3DFalse,
> +def check_type(info, source, value, allow_array=3DFalse, allow_dict=3DFa=
lse,
>                 allow_metas=3D[]):
>      global all_names
>
> @@ -686,7 +685,7 @@ def check_command(expr, info):
>      if boxed:
>          args_meta +=3D ['union', 'alternate']
>      check_type(info, "'data' for command '%s'" % name,
> -               expr.get('data'), allow_dict=3Dnot boxed, allow_optional=
=3DTrue,
> +               expr.get('data'), allow_dict=3Dnot boxed,
>                 allow_metas=3Dargs_meta)
>      returns_meta =3D ['union', 'struct']
>      if name in returns_whitelist:
> @@ -704,8 +703,7 @@ def check_event(expr, info):
>      if boxed:
>          meta +=3D ['union', 'alternate']
>      check_type(info, "'data' for event '%s'" % name,
> -               expr.get('data'), allow_dict=3Dnot boxed, allow_optional=
=3DTrue,
> -               allow_metas=3Dmeta)
> +               expr.get('data'), allow_dict=3Dnot boxed, allow_metas=3Dm=
eta)
>
>
>  def check_union(expr, info):
> @@ -728,8 +726,7 @@ def check_union(expr, info):
>      else:
>          # The object must have a string or dictionary 'base'.
>          check_type(info, "'base' for union '%s'" % name,
> -                   base, allow_dict=3DTrue, allow_optional=3DTrue,
> -                   allow_metas=3D['struct'])
> +                   base, allow_dict=3DTrue, allow_metas=3D['struct'])
>          if not base:
>              raise QAPISemError(info, "Flat union '%s' must have a base"
>                                 % name)
> @@ -843,7 +840,7 @@ def check_struct(expr, info):
>      members =3D expr['data']
>
>      check_type(info, "'data' for struct '%s'" % name, members,
> -               allow_dict=3DTrue, allow_optional=3DTrue)
> +               allow_dict=3DTrue)
>      check_type(info, "'base' for struct '%s'" % name, expr.get('base'),
>                 allow_metas=3D['struct'])
>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
