Received: from eggs.gnu.org ([2001:4830:134:3::10]:58751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cy8kh-0001S0-CP
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cy8kg-0002vW-A7
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:15:27 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cy8kg-0002vC-6S
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 23:15:26 -0400
Received: by mail-qt0-x242.google.com with SMTP id c45so2276445qtb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 20:15:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170411185034.13460-1-eblake@redhat.com>
	<20170411185034.13460-12-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <98efc4a3-8140-3131-eeb9-8d795d9bf3f0@amsat.org>
Date: Wed, 12 Apr 2017 00:15:22 -0300
MIME-Version: 1.0
In-Reply-To: <20170411185034.13460-12-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 11/13] QemuOpts: Simplify
 qemu_opts_to_qdict()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

On 04/11/2017 03:50 PM, Eric Blake wrote:
> Noticed while investigating Coccinelle cleanups. There is no need
> for a temporary variable when we can use the new macro to do the
> same thing with less typing.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  util/qemu-option.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index a36cafa..5977bfc 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -1054,7 +1054,6 @@ void qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qdict, Error **errp)
>  QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
>  {
>      QemuOpt *opt;
> -    QObject *val;
>
>      if (!qdict) {
>          qdict = qdict_new();
> @@ -1063,8 +1062,7 @@ QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
>          qdict_put_str(qdict, "id", opts->id);
>      }
>      QTAILQ_FOREACH(opt, &opts->head, next) {
> -        val = QOBJECT(qstring_from_str(opt->str));
> -        qdict_put_obj(qdict, opt->name, val);
> +        qdict_put_str(qdict, opt->name, opt->str);
>      }
>      return qdict;
>  }
>
