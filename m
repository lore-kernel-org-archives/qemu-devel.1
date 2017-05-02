Received: from eggs.gnu.org ([2001:4830:134:3::10]:53415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5Xdg-0004OF-Dh
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5Xdd-00070L-4R
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:14:48 -0400
Received: from mail-qk0-x22d.google.com ([2607:f8b0:400d:c09::22d]:33398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5Xdc-00070D-UX
	for qemu-devel@nongnu.org; Tue, 02 May 2017 09:14:45 -0400
Received: by mail-qk0-x22d.google.com with SMTP id u68so31865924qkd.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 06:14:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
	<1493282486-28338-2-git-send-email-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0df75be2-4002-ac49-5cff-41cd936325be@amsat.org>
Date: Tue, 2 May 2017 10:14:41 -0300
MIME-Version: 1.0
In-Reply-To: <1493282486-28338-2-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
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

On 04/27/2017 05:41 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  qapi/qmp-dispatch.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> index dc50212..5ad36f8 100644
> --- a/qapi/qmp-dispatch.c
> +++ b/qapi/qmp-dispatch.c
> @@ -30,7 +30,7 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>
>      dict = qobject_to_qdict(request);
>      if (!dict) {
> -        error_setg(errp, "Expected '%s' in QMP input", "object");
> +        error_setg(errp, "QMP input must be a JSON object");
>          return NULL;
>      }
>
> @@ -41,26 +41,26 @@ static QDict *qmp_dispatch_check_obj(const QObject *request, Error **errp)
>
>          if (!strcmp(arg_name, "execute")) {
>              if (qobject_type(arg_obj) != QTYPE_QSTRING) {
> -                error_setg(errp, "QMP input object member '%s' expects '%s'",
> -                           "execute", "string");
> +                error_setg(errp,
> +                           "QMP input member 'execute' must be a string");
>                  return NULL;
>              }
>              has_exec_key = true;
>          } else if (!strcmp(arg_name, "arguments")) {
>              if (qobject_type(arg_obj) != QTYPE_QDICT) {
> -                error_setg(errp, "QMP input object member '%s' expects '%s'",
> -                           "arguments", "object");
> +                error_setg(errp,
> +                           "QMP input member 'arguments' must be an object");
>                  return NULL;
>              }
>          } else {
> -            error_setg(errp, "QMP input object member '%s' is unexpected",
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
>
