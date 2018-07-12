Received: from eggs.gnu.org ([2001:4830:134:3::10]:37436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdagt-0007Jb-9A
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:27:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdagq-0006m4-5l
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:27:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdagq-0006iS-1J
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:27:20 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CFCB859AA
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 12:27:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-3-marcandre.lureau@redhat.com>
Date: Thu, 12 Jul 2018 14:27:08 +0200
In-Reply-To: <20180706121354.2021-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 14:13:44 +0200")
Message-ID: <87sh4omyg3.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/12] monitor: consitify
 qmp_send_response() QDict argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 3c9c97b73f..fc481d902d 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -504,9 +504,9 @@ int monitor_fprintf(FILE *stream, const char *fmt, ..=
.)
>      return 0;
>  }
>=20=20
> -static void qmp_send_response(Monitor *mon, QDict *rsp)
> +static void qmp_send_response(Monitor *mon, const QDict *rsp)
>  {
> -    QObject *data =3D QOBJECT(rsp);
> +    const QObject *data =3D QOBJECT(rsp);
>      QString *json;
>=20=20
>      json =3D mon->flags & MONITOR_USE_PRETTY ? qobject_to_json_pretty(da=
ta) :

Reviewed-by: Markus Armbruster <armbru@redhat.com>
