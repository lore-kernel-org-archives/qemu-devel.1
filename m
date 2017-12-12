Received: from eggs.gnu.org ([2001:4830:134:3::10]:55790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eOqBH-00072H-4A
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 14:25:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eOqBE-0003rq-FX
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 14:25:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eOqBE-0003r4-68
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 14:25:28 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20170911110623.24981-1-marcandre.lureau@redhat.com>
	<20170911110623.24981-31-marcandre.lureau@redhat.com>
Date: Tue, 12 Dec 2017 20:25:22 +0100
In-Reply-To: <20170911110623.24981-31-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 11 Sep 2017
	13:06:03 +0200")
Message-ID: <87shcflpel.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 30/50] qapi: add #if conditions to
 generated alternate variants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Mostly covered by previous patches already.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi-introspect.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi-introspect.py b/scripts/qapi-introspect.py
> index ef2d5577db..d6194ff702 100644
> --- a/scripts/qapi-introspect.py
> +++ b/scripts/qapi-introspect.py
> @@ -172,7 +172,7 @@ const QLitObject %(c_name)s =3D %(c_string)s;
>=20=20
>      def visit_alternate_type(self, name, info, ifcond, variants):
>          self._gen_qlit(name, 'alternate',
> -                       {'members': [{'type': self._use_type(m.type)}
> +                       {'members': [({'type': self._use_type(m.type)}, m=
.ifcond)
>                                      for m in variants.variants]}, ifcond)
>=20=20
>      def visit_command(self, name, info, ifcond, arg_type, ret_type,

Adds blank lines to qmp-introspect.c, just like PATCH 12, which see.
