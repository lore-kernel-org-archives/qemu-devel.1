Received: from eggs.gnu.org ([2001:4830:134:3::10]:41087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d3fOI-0001kz-9H
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1d3fOH-00021l-76
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:07:10 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1d3fOG-00020i-Qz
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 05:07:09 -0400
Received: by mail-lf0-x243.google.com with SMTP id 75so3308832lfs.3
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 02:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
	<1493282486-28338-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1493282486-28338-2-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 27 Apr 2017 09:06:57 +0000
Message-ID: <CAJ+F1CLUm-QWKgP6R_r=72aP=7j6D-jP8eRdcO3JJUjtHUe1iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] qmp: Improve QMP dispatch error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On Thu, Apr 27, 2017 at 12:46 PM Markus Armbruster <armbru@redhat.com>
wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  qapi/qmp-dispatch.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index dc50212..5ad36f8 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject
> *request, Error **errp)
>
>      dict =3D qobject_to_qdict(request);
>      if (!dict) {
> -        error_setg(errp, "Expected '%s' in QMP input", "object");
> +        error_setg(errp, "QMP input must be a JSON object");
>          return NULL;
>      }
>
> @@ -41,26 +41,26 @@ static QDict *qmp_dispatch_check_obj(const QObject
> *request, Error **errp)
>
>          if (!strcmp(arg_name, "execute")) {
>              if (qobject_type(arg_obj) !=3D QTYPE_QSTRING) {
> -                error_setg(errp, "QMP input object member '%s' expects
> '%s'",
> -                           "execute", "string");
> +                error_setg(errp,
> +                           "QMP input member 'execute' must be a string"=
);
>                  return NULL;
>              }
>              has_exec_key =3D true;
>          } else if (!strcmp(arg_name, "arguments")) {
>              if (qobject_type(arg_obj) !=3D QTYPE_QDICT) {
> -                error_setg(errp, "QMP input object member '%s' expects
> '%s'",
> -                           "arguments", "object");
> +                error_setg(errp,
> +                           "QMP input member 'arguments' must be an
> object");
>                  return NULL;
>              }
>          } else {
> -            error_setg(errp, "QMP input object member '%s' is unexpected=
",
> +            error_setg(errp, "QMP input member '%s' is unexpected",
>                         arg_name);
>              return NULL;
>          }
>      }
>
>      if (!has_exec_key) {
> -        error_setg(errp, "Expected '%s' in QMP input", "execute");
> +        error_setg(errp, "QMP input lacks member 'execute'");
>          return NULL;
>      }
>
> --
> 2.7.4
>
>
> --
Marc-Andr=C3=A9 Lureau
