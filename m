Received: from eggs.gnu.org ([2001:4830:134:3::10]:52696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkr3Q-0006mb-FT
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkr3K-0008MZ-QV
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:16:08 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:32992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dkr3K-0008ME-Lv
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:16:02 -0400
Received: by mail-vk0-x241.google.com with SMTP id g12so948882vkf.0
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 05:16:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503576178-23966-2-git-send-email-armbru@redhat.com>
References: <1503576178-23966-1-git-send-email-armbru@redhat.com>
	<1503576178-23966-2-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Aug 2017 14:16:01 +0200
Message-ID: <CAJ+F1C+qVbDBspOpEkZubDuZ98RVaLMWa6ZwNirEHFEug8+ekA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] qapi-schema: Document how generated
 documentation is ordered
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

On Thu, Aug 24, 2017 at 2:02 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Documentation generated with qapi2texi.py is in textual order, with
> included sub-schemas inserted at the first include directive
> (subsequent include directives have no effect).  To get a sane and
> stable order, it's best to include each sub-schema just once, or
> include it first in qapi-schema.json.  Document that.
>
> While there, drop a few redundant comments.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qapi-schema.json | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 802ea53..76b5888 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -72,22 +72,17 @@
>          'q_obj_CpuInfo-base'    # CPU, visible through query-cpu
>      ] } }
>
> -# QAPI common definitions
> +# Documentation generated with qapi2texi.py is in textual order, with
> +# included sub-schemas inserted at the first include directive
> +# (subsequent include directives have no effect).  To get a sane and
> +# stable order, it's best to include each sub-schema just once, or
> +# include it first in qapi-schema.json.
> +
>  { 'include': 'qapi/common.json' }
> -
> -# QAPI crypto definitions
>  { 'include': 'qapi/crypto.json' }
> -
> -# QAPI block definitions
>  { 'include': 'qapi/block.json' }
> -
> -# QAPI event definitions
>  { 'include': 'qapi/event.json' }
> -
> -# Tracing commands
>  { 'include': 'qapi/trace.json' }
> -
> -# QAPI introspection
>  { 'include': 'qapi/introspect.json' }
>
>  ##
> --
> 2.7.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
