Received: from eggs.gnu.org ([2001:4830:134:3::10]:43098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzggL-0004hs-Ui
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzggG-0001MT-4g
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:13:37 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:35804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzggF-0001MK-WF
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:13:32 -0400
Received: by mail-qk0-x244.google.com with SMTP id w63so6109012qkd.2
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:13:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002134538.23332-2-armbru@redhat.com>
References: <20171002134538.23332-1-armbru@redhat.com>
	<20171002134538.23332-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:13:30 +0200
Message-ID: <CAJ+F1C+DoaezT0eZ81Hed2p3KWKg4T4y1Kr8ej-xmkSvFkEj6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] hmp-commands-info: Fix "info
 rocker-FOO" misspellings
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
> Screwed up in commit da76ee7.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hmp-commands-info.hx | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
> index 4f1ece93e5..574db7d24e 100644
> --- a/hmp-commands-info.hx
> +++ b/hmp-commands-info.hx
> @@ -730,8 +730,8 @@ ETEXI
>      },
>
>  STEXI
> -@item info rocker_ports @var{name}-ports
> -@findex ocker-ports
> +@item info rocker-ports @var{name}-ports
> +@findex rocker-ports
>  Show rocker ports.
>  ETEXI
>
> @@ -744,7 +744,7 @@ ETEXI
>      },
>
>  STEXI
> -@item info rocker_of_dpa_flows @var{name} [@var{tbl_id}]
> +@item info rocker-of-dpa-flows @var{name} [@var{tbl_id}]
>  @findex rocker-of-dpa-flows
>  Show rocker OF-DPA flow tables.
>  ETEXI
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
