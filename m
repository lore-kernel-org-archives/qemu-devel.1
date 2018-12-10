Received: from eggs.gnu.org ([2001:4830:134:3::10]:39137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWOzS-0007Md-OF
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:05:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWOzP-000402-F0
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:05:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWOzP-0003z7-7m
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 12:05:03 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-12-marcandre.lureau@redhat.com>
Date: Mon, 10 Dec 2018 18:04:56 +0100
In-Reply-To: <20181208111606.8505-12-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Sat, 8 Dec 2018 15:15:50 +0400")
Message-ID: <87in01e2iv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 11/27] qapi: pass long form enum
 to make_enum_members
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

> This will allow to get rid of short form handling in a following
> patch.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/qapi/common.py | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> index fdc0fd69ef..557b413950 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1663,9 +1663,10 @@ class QAPISchema(object):
>          self.the_empty_object_type =3D QAPISchemaObjectType(
>              'q_empty', None, None, None, None, [], None)
>          self._def_entity(self.the_empty_object_type)
> -        qtype_values =3D self._make_enum_members(['none', 'qnull', 'qnum=
',
> -                                                'qstring', 'qdict', 'qli=
st',
> -                                                'qbool'])
> +
> +        qtypes =3D ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist'=
, 'qbool']

Long line.

> +        qtype_values =3D self._make_enum_members([{'name': n} for n in q=
types])
> +
>          self._def_entity(QAPISchemaEnumType('QType', None, None, None,
>                                              qtype_values, 'QTYPE'))

We may want to squash this one into PATCH 08 as mentioned in that
patch's review.

In case we don't:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
