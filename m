Received: from eggs.gnu.org ([2001:4830:134:3::10]:35560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fW0lS-0001n9-QL
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fW0lP-0005Rx-N1
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:40:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44142 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fW0lP-0005Qa-In
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:40:43 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 952854023344
	for <qemu-devel@nongnu.org>; Thu, 21 Jun 2018 14:40:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180321115211.17937-1-marcandre.lureau@redhat.com>
	<20180321115211.17937-13-marcandre.lureau@redhat.com>
Date: Thu, 21 Jun 2018 16:40:39 +0200
In-Reply-To: <20180321115211.17937-13-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 21 Mar 2018
	12:51:34 +0100")
Message-ID: <87lgb8kxso.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 12/49] qapi/events: add #if conditions
 to events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Wrap generated code with #if/#endif using an 'ifcontext' on
> QAPIGenCSnippet objects.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qapi/events.py | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
> index 26ae00f6f7..dae03e3d88 100644
> --- a/scripts/qapi/events.py
> +++ b/scripts/qapi/events.py
> @@ -185,8 +185,9 @@ class QAPISchemaGenEventVisitor(QAPISchemaModularCVis=
itor):
>          genc.add(gen_enum_lookup(self._enum_name, self._event_names))
>=20=20
>      def visit_event(self, name, info, ifcond, arg_type, boxed):
> -        self._genh.add(gen_event_send_decl(name, arg_type, boxed))
> -        self._genc.add(gen_event_send(name, arg_type, boxed, self._enum_=
name))
> +        with ifcontext(ifcond, self._genh, self._genc):
> +            self._genh.add(gen_event_send_decl(name, arg_type, boxed))
> +            self._genc.add(gen_event_send(name, arg_type, boxed, self._e=
num_name))

events.py:190:80: E501 line too long (82 > 79 characters)

>          self._event_names.append(name)
