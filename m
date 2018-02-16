Received: from eggs.gnu.org ([2001:4830:134:3::10]:36392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrRK-0002V6-QT
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1enrRH-00011C-Lp
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:49:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39682
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1enrRH-000107-GW
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:49:27 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1JJnQ5v095998
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:49:26 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2g820yytfj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 14:49:26 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 12:39:22 -0700
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180211093607.27351-5-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-5-armbru@redhat.com>
Date: Fri, 16 Feb 2018 16:56:22 -0600
Message-Id: <151882178212.30451.10416369015194419115@sif>
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, eblake@redhat.com

Quoting Markus Armbruster (2018-02-11 03:35:42)
> Rename the variable holding the QAPISchemaGenFOOVisitor from gen to
> vis, to avoid confusion in the next commit.
> =

> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

> ---
>  scripts/qapi-commands.py   | 8 ++++----
>  scripts/qapi-event.py      | 8 ++++----
>  scripts/qapi-introspect.py | 8 ++++----
>  scripts/qapi-types.py      | 8 ++++----
>  scripts/qapi-visit.py      | 8 ++++----
>  5 files changed, 20 insertions(+), 20 deletions(-)
> =

> diff --git a/scripts/qapi-commands.py b/scripts/qapi-commands.py
> index 84a980d882..c3aa52fce1 100644
> --- a/scripts/qapi-commands.py
> +++ b/scripts/qapi-commands.py
> @@ -291,9 +291,9 @@ void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmd=
s);
>                    prefix=3Dprefix, c_prefix=3Dc_name(prefix, protect=3DF=
alse)))
> =

>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenCommandVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenCommandVisitor()
> +schema.visit(vis)
> +fdef.write(vis.defn)
> +fdecl.write(vis.decl)
> =

>  close_output(fdef, fdecl)
> diff --git a/scripts/qapi-event.py b/scripts/qapi-event.py
> index 0a098803e2..edb9ddb650 100644
> --- a/scripts/qapi-event.py
> +++ b/scripts/qapi-event.py
> @@ -203,9 +203,9 @@ fdecl.write(mcgen('''
>  event_enum_name =3D c_name(prefix + 'QAPIEvent', protect=3DFalse)
> =

>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenEventVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenEventVisitor()
> +schema.visit(vis)
> +fdef.write(vis.defn)
> +fdecl.write(vis.decl)
> =

>  close_output(fdef, fdecl)
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index bd9253a172..ebe8706f41 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -193,9 +193,9 @@ fdef.write(mcgen('''
>                   prefix=3Dprefix))
> =

>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenIntrospectVisitor(opt_unmask)
> +schema.visit(vis)
> +fdef.write(vis.defn)
> +fdecl.write(vis.decl)
> =

>  close_output(fdef, fdecl)
> diff --git a/scripts/qapi-types.py b/scripts/qapi-types.py
> index 1103dbda2d..4db8424da1 100644
> --- a/scripts/qapi-types.py
> +++ b/scripts/qapi-types.py
> @@ -273,9 +273,9 @@ fdecl.write(mcgen('''
>  '''))
> =

>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenTypeVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenTypeVisitor()
> +schema.visit(vis)
> +fdef.write(vis.defn)
> +fdecl.write(vis.decl)
> =

>  close_output(fdef, fdecl)
> diff --git a/scripts/qapi-visit.py b/scripts/qapi-visit.py
> index e56b3c1256..3c1a0e2544 100644
> --- a/scripts/qapi-visit.py
> +++ b/scripts/qapi-visit.py
> @@ -360,9 +360,9 @@ fdecl.write(mcgen('''
>                    prefix=3Dprefix))
> =

>  schema =3D QAPISchema(input_file)
> -gen =3D QAPISchemaGenVisitVisitor()
> -schema.visit(gen)
> -fdef.write(gen.defn)
> -fdecl.write(gen.decl)
> +vis =3D QAPISchemaGenVisitVisitor()
> +schema.visit(vis)
> +fdef.write(vis.defn)
> +fdecl.write(vis.decl)
> =

>  close_output(fdef, fdecl)
> -- =

> 2.13.6
>=20
