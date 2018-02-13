Received: from eggs.gnu.org ([2001:4830:134:3::10]:47505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1elcRy-0004Pm-Pu
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1elcRw-0001Rw-4E
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:24:54 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:38391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1elcRv-0001RP-VX
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 10:24:52 -0500
Received: by mail-qt0-f195.google.com with SMTP id k13so3994427qtg.5
	for <qemu-devel@nongnu.org>; Tue, 13 Feb 2018 07:24:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180211093607.27351-5-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-5-armbru@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 13 Feb 2018 16:24:51 +0100
Message-ID: <CAMxuvaxsUKxj+KQZhaydcZsvVJjJz_P76vJ3u5fuiRPmpk2g5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 04/29] qapi: Rename variable holding the
 QAPISchemaGenFOOVisitor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, marcandre <marcandre.lureau@redhat.com>, "Blake, Eric" <eblake@redhat.com>

On Sun, Feb 11, 2018 at 10:35 AM, Markus Armbruster <armbru@redhat.com> wro=
te:
> Rename the variable holding the QAPISchemaGenFOOVisitor from gen to
> vis, to avoid confusion in the next commit.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  scripts/qapi-commands.py   | 8 ++++----
>  scripts/qapi-event.py      | 8 ++++----
>  scripts/qapi-introspect.py | 8 ++++----
>  scripts/qapi-types.py      | 8 ++++----
>  scripts/qapi-visit.py      | 8 ++++----
>  5 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index 84a980d882..c3aa52fce1 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -291,9 +291,9 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
>                    prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DF=
alse)))
>
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenCommandVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenCommandVisitor()
> +schema.visit(vis)
> +fdef.write(vis.defn)
> +fdecl.write(vis.decl)
>
>  close_output(fdef, fdecl)
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index 0a098803e2..edb9ddb650 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -203,9 +203,9 @@ fdecl.write(mcgen('''
>  event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse)
>
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenEventVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenEventVisitor()
> +schema.visit(vis)
> +fdef.write(vis.defn)
> +fdecl.write(vis.decl)
>
>  close_output(fdef, fdecl)
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index bd9253a172..ebe8706f41 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -193,9 +193,9 @@ fdef.write(mcgen('''
>                   prefix=3Dprefix))
>
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
> +schema.visit(vis)
> +fdef.write(vis.defn)
> +fdecl.write(vis.decl)
>
>  close_output(fdef, fdecl)
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index 1103dbda2d..4db8424da1 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -273,9 +273,9 @@ fdecl.write(mcgen('''
>  '''))
>
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenTypeVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenTypeVisitor()
> +schema.visit(vis)
> +fdef.write(vis.defn)
> +fdecl.write(vis.decl)
>
>  close_output(fdef, fdecl)
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index e56b3c1256..3c1a0e2544 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -360,9 +360,9 @@ fdecl.write(mcgen('''
>                    prefix=3Dprefix))
>
>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenVisitVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenVisitVisitor()
> +schema.visit(vis)
> +fdef.write(vis.defn)
> +fdecl.write(vis.decl)
>
>  close_output(fdef, fdecl)
> --
> 2.13.6
>
