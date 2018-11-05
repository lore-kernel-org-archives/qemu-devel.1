Received: from eggs.gnu.org ([2001:4830:134:3::10]:39226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJa2v-0006BK-Mb
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:15:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gJa2s-0007D6-F8
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:15:41 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gJa2s-000702-4U
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 03:15:38 -0500
Received: by mail-qk1-f196.google.com with SMTP id n12so13148152qkh.11
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 00:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20181019164929.18404-1-mreitz@redhat.com>
	<20181019164929.18404-6-mreitz@redhat.com>
In-Reply-To: <20181019164929.18404-6-mreitz@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 5 Nov 2018 12:15:17 +0400
Message-ID: <CAMxuvazFwZW13hW_Q3KeEm9RMdSM40qjdYyTy_5rh+WnFtxFjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] fw_cfg: Drop newline in @file
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>, "Wolf, Kevin" <kwolf@redhat.com>

On Fri, Oct 19, 2018 at 8:50 PM Max Reitz <mreitz@redhat.com> wrote:
>
> There is no good reason why there should be a newline in this
> description, so remove it.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/vl.c b/vl.c
> index ecddbb6b8e..6604648570 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -529,7 +529,7 @@ static QemuOptsList qemu_fw_cfg_opts =3D {
>          }, {
>              .name =3D "file",
>              .type =3D QEMU_OPT_STRING,
> -            .help =3D "Sets the name of the file from which\n"
> +            .help =3D "Sets the name of the file from which "
>                      "the fw_cfg blob will be loaded",
>          }, {
>              .name =3D "string",
> --
> 2.17.1
>
