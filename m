Received: from eggs.gnu.org ([2001:4830:134:3::10]:39676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUc3t-0000WH-A4
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 13:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gUbwL-0001WE-RW
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 13:30:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gUbwF-0000jN-6D
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 13:30:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86900C049581
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 18:30:22 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706105753.26700-1-marcandre.lureau@redhat.com>
	<20180706105753.26700-15-marcandre.lureau@redhat.com>
Date: Wed, 05 Dec 2018 19:30:18 +0100
In-Reply-To: <20180706105753.26700-15-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 6 Jul 2018
	12:57:40 +0200")
Message-ID: <87pnufomh1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 14/27] qapi-event: add 'if' condition to
 implicit event enum
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

> Add condition to QAPIEvent enum members based on the event 'if'.
>
> Generated code is not changed by this patch, but with "qapi: add #if
> conditions to generated code" patch.
>
> There is no coverage of this change in qapi-schema-test.out since the
> event_names enum is an implicit type created by qapi-event.py.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/events.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index ea4dac6a05..c9beef8b4b 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -189,7 +189,7 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
>              self._genh.add(gen_event_send_decl(name, arg_type, boxed))
>              self._genc.add(gen_event_send(name, arg_type, boxed,
>                                            self._enum_name))
> -        self._event_names.append(QAPISchemaMember(name))
> +        self._event_names.append(QAPISchemaMember(name, ifcond))
>=20=20
>=20=20
>  def gen_events(schema, output_dir, prefix):

Reviewed-by: Markus Armbruster <armbru@redhat.com>
