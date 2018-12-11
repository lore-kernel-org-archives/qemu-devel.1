Received: from eggs.gnu.org ([2001:4830:134:3::10]:52322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWgnb-000504-EU
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:06:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWgnY-0005x8-5l
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:06:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWgnX-0005wW-TW
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 07:06:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-18-marcandre.lureau@redhat.com>
Date: Tue, 11 Dec 2018 13:05:54 +0100
In-Reply-To: <20181208111606.8505-18-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 8 Dec 2018 15:15:56 +0400")
Message-ID: <87o99ss1y5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 17/27] qapi: simplify
 make_enum_members()
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

> The function only receives the dictionary form of enum expressions
> now, so we can make it shorter.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/common.py | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index fd622313cb..44020779dd 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1714,16 +1714,7 @@ class QAPISchema(object):
>                                              qtype_values, 'QTYPE'))
>=20=20
>      def _make_enum_members(self, values):
> -        enum =3D []
> -        for v in values:
> -            if isinstance(v, dict):
> -                name =3D v['name']
> -                ifcond =3D v.get('if')
> -            else:
> -                name =3D v
> -                ifcond =3D None
> -            enum.append(QAPISchemaMember(name, ifcond))
> -        return enum
> +        return [QAPISchemaMember(v['name'], v.get('if')) for v in values]
>=20=20
>      def _make_implicit_enum_type(self, name, info, ifcond, values):
>          # See also QAPISchemaObjectTypeMember._pretty_owner()

We may want to squash this one into PATCH 08 as mentioned in that
patch's review.

In case we don't:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
