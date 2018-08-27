Received: from eggs.gnu.org ([2001:4830:134:3::10]:40507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuCJq-00065g-TO
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:52:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fuC4y-0001ai-OQ
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:36:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fuC4x-0001Wf-Bs
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 03:36:52 -0400
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-2-marcandre.lureau@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <68f27a47-0b0c-3a9f-ca7f-f17ace40d7a5@redhat.com>
Date: Mon, 27 Aug 2018 09:36:46 +0200
MIME-Version: 1.0
In-Reply-To: <20180825135724.8981-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/9] monitor: consitify
 qmp_send_response() QDict argument
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
>  monitor.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/monitor.c b/monitor.c
> index 021c11b1bf..a1db4db487 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -503,9 +503,9 @@ int monitor_fprintf(FILE *stream, const char *fmt, =
...)
>      return 0;
>  }
> =20
> -static void qmp_send_response(Monitor *mon, QDict *rsp)
> +static void qmp_send_response(Monitor *mon, const QDict *rsp)
>  {
> -    QObject *data =3D QOBJECT(rsp);
> +    const QObject *data =3D QOBJECT(rsp);
>      QString *json;
> =20
>      json =3D mon->flags & MONITOR_USE_PRETTY ? qobject_to_json_pretty(=
data) :
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
