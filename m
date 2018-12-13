Received: from eggs.gnu.org ([2001:4830:134:3::10]:55277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXS0F-0005Bl-KO
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gXS07-0001pB-5W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:30:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:65179)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gXS03-0001kz-O3
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:30:04 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D52D33081D90
	for <qemu-devel@nongnu.org>; Thu, 13 Dec 2018 14:30:01 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20181213123724.4866-1-marcandre.lureau@redhat.com>
	<20181213123724.4866-8-marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 15:29:57 +0100
In-Reply-To: <20181213123724.4866-8-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Thu, 13 Dec 2018 16:37:09 +0400")
Message-ID: <87sgz1pkii.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 07/22] qapi: pass long form enum to
 make_enum_members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

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
> index bb928d2f7d..569e397147 100644
> --- a/scripts/qapi/common.py
> +++ b/scripts/qapi/common.py
> @@ -1648,9 +1648,10 @@ class QAPISchema(object):
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

pycodestyle-3 complains:

    scripts/qapi/common.py:1652:80: E501 line too long (80 > 79 characters)

Can tidy up when I apply.

> +        qtype_values =3D self._make_enum_members([{'name': n} for n in q=
types])
> +
>          self._def_entity(QAPISchemaEnumType('QType', None, None, None,
>                                              qtype_values, 'QTYPE'))
