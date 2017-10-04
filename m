Received: from eggs.gnu.org ([2001:4830:134:3::10]:42529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfE-0003iO-Mp
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgfD-0000J6-Ol
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:28 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgfD-0000IV-KC
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:27 -0400
Received: by mail-qt0-x241.google.com with SMTP id a43so12208216qta.0
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:12:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002140307.5292-9-armbru@redhat.com>
References: <20171002140307.5292-1-armbru@redhat.com>
	<20171002140307.5292-9-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:12:26 +0200
Message-ID: <CAJ+F1CLbup0C719pHn84CUVMv=Yg37-nJ87avO3kQztoUEZs-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 8/8] qemu-options: Belatedly document
 --watchdog-action inject-nmi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Mon, Oct 2, 2017 at 4:03 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Missed in commit 795dc6e46d, v2.4.0.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qemu-options.hx | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index b792c65149..32afc11296 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3596,7 +3596,7 @@ A virtual watchdog for s390x backed by the diagnose=
 288 hypercall
>  ETEXI
>
>  DEF("watchdog-action", HAS_ARG, QEMU_OPTION_watchdog_action, \
> -    "-watchdog-action reset|shutdown|poweroff|pause|debug|none\n" \
> +    "-watchdog-action reset|shutdown|poweroff|inject-nmi|pause|debug|non=
e\n" \
>      "                action when watchdog fires [default=3Dreset]\n",
>      QEMU_ARCH_ALL)
>  STEXI
> @@ -3610,6 +3610,7 @@ The default is
>  Other possible actions are:
>  @code{shutdown} (attempt to gracefully shutdown the guest),
>  @code{poweroff} (forcefully poweroff the guest),
> +@code{inject-nmi} (inject a NMI into the guest),
>  @code{pause} (pause the guest),
>  @code{debug} (print a debug message and continue), or
>  @code{none} (do nothing).
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
