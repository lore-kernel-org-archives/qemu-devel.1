Received: from eggs.gnu.org ([2001:4830:134:3::10]:37471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdahH-0007UK-FB
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdahE-0008JW-Ba
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:27:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdahE-0008IU-6s
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:27:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CC8B5401C876
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 12:27:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-4-marcandre.lureau@redhat.com>
Date: Thu, 12 Jul 2018 14:27:39 +0200
In-Reply-To: <20180706121354.2021-4-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 14:13:45 +0200")
Message-ID: <87o9fcmyf8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/12] qmp: constify qmp_is_oob()
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
>  include/qapi/qmp/dispatch.h | 2 +-
>  qapi/qmp-dispatch.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp/dispatch.h
> index 4e2e749faf..68a528a9aa 100644
> --- a/include/qapi/qmp/dispatch.h
> +++ b/include/qapi/qmp/dispatch.h
> @@ -50,7 +50,7 @@ bool qmp_has_success_response(const QmpCommand *cmd);
>  QDict *qmp_error_response(Error *err);
>  QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
>                      bool allow_oob);
> -bool qmp_is_oob(QDict *dict);
> +bool qmp_is_oob(const QDict *dict);
>=20=20
>  typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
>=20=20
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index 6f2d466596..90ba5e3074 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -156,7 +156,7 @@ QDict *qmp_error_response(Error *err)
>  /*
>   * Does @qdict look like a command to be run out-of-band?
>   */
> -bool qmp_is_oob(QDict *dict)
> +bool qmp_is_oob(const QDict *dict)
>  {
>      return qdict_haskey(dict, "exec-oob")
>          && !qdict_haskey(dict, "execute");

Reviewed-by: Markus Armbruster <armbru@redhat.com>
