Received: from eggs.gnu.org ([2001:4830:134:3::10]:40392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuCJq-0005zV-CC
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuC5E-0001mj-0Y
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:37:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fuC5D-0001mb-Re
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:37:07 -0400
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-3-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e5ab0f3d-358e-ef4d-0bf3-c700e050b1f6@redhat.com>
Date: Mon, 27 Aug 2018 09:37:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180825135724.8981-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/9] qmp: constify qmp_is_oob()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 2018-08-25 15:57, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
>  include/qapi/qmp/dispatch.h | 2 +-
>  qapi/qmp-dispatch.c         | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
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
> =20
>  typedef void (*qmp_cmd_callback_fn)(QmpCommand *cmd, void *opaque);
> =20
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index d8da1a62de..1d922e04f7 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -155,7 +155,7 @@ QDict *qmp_error_response(Error *err)
>  /*
>   * Does @qdict look like a command to be run out-of-band?
>   */
> -bool qmp_is_oob(QDict *dict)
> +bool qmp_is_oob(const QDict *dict)
>  {
>      return qdict_haskey(dict, "exec-oob")
>          && !qdict_haskey(dict, "execute");
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
