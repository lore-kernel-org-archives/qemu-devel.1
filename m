Received: from eggs.gnu.org ([2001:4830:134:3::10]:56771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ft6ff-0002zK-4f
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:38:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ft6fd-0005br-Sb
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:38:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52306 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1ft6fd-0005bA-OI
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 03:38:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A76D804B4DB
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 07:38:13 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180821103839.19355-1-marcandre.lureau@redhat.com>
Date: Fri, 24 Aug 2018 09:38:08 +0200
In-Reply-To: <20180821103839.19355-1-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 21 Aug 2018 12:38:39 +0200")
Message-ID: <878t4wcizj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] editorconfig: set emacs mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Some time ago, I proposed to use an (eval) in .dir-locals.el to set
> the mode for all json files and Makefile. Unfortunately, this isn't
> safe, and emacs will prompt the user, which isn't very friendly.
>
> Fortunately, editorconfig provides a special config key which does
> allow to set the emacs mode. Add a few missing entries and set the
> emacs mode.

Please mention editorconfig requires a plugin to work.  Without that,
the reader is left to wonder why we keep the "redundant" Emacs file
local variables.

>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  .editorconfig | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/.editorconfig b/.editorconfig
> index b2022e391a..683c543be3 100644
> --- a/.editorconfig
> +++ b/.editorconfig
> @@ -6,10 +6,23 @@ end_of_line =3D lf
>  insert_final_newline =3D true
>  charset =3D utf-8
>=20=20
> +[*.mak]
> +indent_style =3D tab
> +indent_size =3D 8
> +file_type_emacs =3D makefile
> +

Aside: we should name these .mk like a sane person.

>  [Makefile*]
>  indent_style =3D tab
>  indent_size =3D 8
> +file_type_emacs =3D makefile
>=20=20
>  [*.{c,h}]
>  indent_style =3D space
>  indent_size =3D 4
> +
> +[*.{vert,frag}]
> +file_type_emacs =3D glsl
> +
> +[*.json]
> +indent_style =3D space
> +file_type_emacs =3D python

With the commit message improved:
Acked-by: Markus Armbruster <armbru@redhat.com>
