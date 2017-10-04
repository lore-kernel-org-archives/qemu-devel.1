Received: from eggs.gnu.org ([2001:4830:134:3::10]:42565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfN-0003oO-K7
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfM-0000Ry-CU
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:37 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:57341)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgfM-0000RP-80
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:36 -0400
Received: by mail-qt0-x243.google.com with SMTP id 34so995130qtb.13
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:12:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-8-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-8-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:12:35 +0200
Message-ID: <CAJ+F1CKEr+3w5i3FcX_TCNNXoaDiVesU3nQMTXfeC57Nr2y3cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/8] qemu-options: Polish section
 "Character device options"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Oct 2, 2017 at 4:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> CC: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qemu-options.hx | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 615cb230ab..b792c65149 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -2492,11 +2492,6 @@ ETEXI
>  DEFHEADING()
>
>  DEFHEADING(Character device options:)
> -STEXI
> -
> -The general form of a character device option is:
> -@table @option
> -ETEXI
>
>  DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev help\n"
> @@ -2542,6 +2537,9 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>  )
>
>  STEXI
> +
> +The general form of a character device option is:
> +@table @option
>  @item -chardev @var{backend} ,id=3D@var{id} [,mux=3Don|off] [,@var{optio=
ns}]
>  @findex -chardev
>  Backend is one of:
> @@ -2565,7 +2563,7 @@ Backend is one of:
>  @option{spiceport}.
>  The specific backend will determine the applicable options.
>
> -Use "-chardev help" to print all available chardev backend types.
> +Use @code{-chardev help} to print all available chardev backend types.
>
>  All devices must have an id, which can be any string up to 127 character=
s long.
>  It is used to uniquely identify this device in other command line direct=
ives.
> @@ -2620,8 +2618,11 @@ to a file to record all data transmitted via the b=
ackend. The @option{logappend}
>  option controls whether the log file will be truncated or appended to wh=
en
>  opened.
>
> -Further options to each backend are described below.
> +@end table
>
> +The available backends are:
> +
> +@table @option
>  @item -chardev null ,id=3D@var{id}
>  A void device. This device will not emit any data, and will drop any dat=
a it
>  receives. The null backend does not take any options.
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
