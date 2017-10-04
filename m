Received: from eggs.gnu.org ([2001:4830:134:3::10]:36187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgJr-0000d9-RU
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgJq-0006Hs-Ad
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:50:23 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:32989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgJq-0006H6-1S
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 05:50:22 -0400
Received: by mail-oi0-x241.google.com with SMTP id n129so6766384oia.0
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 02:50:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002134538.23332-3-armbru@redhat.com>
References: <20171002134538.23332-1-armbru@redhat.com>
	<20171002134538.23332-3-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 11:50:19 +0200
Message-ID: <CAJ+F1CKf2yXZ=+bfv+c0+tBpTGgyLmMi_jg+L+f6J=m1keoJgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] hmp-commands-info: Move Texinfo
 stanzas to conventional place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Oct 2, 2017 at 3:45 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> A command's STEXI..ETEXI stanza follows the command's initializer.
> Two commands got them backwards.  Correct that.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

> ---
>  hmp-commands-info.hx | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 574db7d24e..d27d3b1227 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -837,12 +837,6 @@ STEXI
>  Show information about hotpluggable CPUs
>  ETEXI
>
> -STEXI
> -@item info vm-generation-id
> -@findex vm-generation-id
> -Show Virtual Machine Generation ID
> -ETEXI
> -
>      {
>          .name       =3D "vm-generation-id",
>          .args_type  =3D "",
> @@ -852,10 +846,9 @@ ETEXI
>      },
>
>  STEXI
> -@item info memory_size_summary
> -@findex memory_size_summary
> -Display the amount of initially allocated and present hotpluggable (if
> -enabled) memory in bytes.
> +@item info vm-generation-id
> +@findex vm-generation-id
> +Show Virtual Machine Generation ID
>  ETEXI
>
>      {
> @@ -868,6 +861,13 @@ ETEXI
>      },
>
>  STEXI
> +@item info memory_size_summary
> +@findex memory_size_summary
> +Display the amount of initially allocated and present hotpluggable (if
> +enabled) memory in bytes.
> +ETEXI
> +
> +STEXI
>  @end table
>  ETEXI
>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
