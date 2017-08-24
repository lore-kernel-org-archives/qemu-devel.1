Received: from eggs.gnu.org ([2001:4830:134:3::10]:50367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkqvU-0007jU-Hz
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkqvT-0004Dc-Lo
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:07:56 -0400
Received: from mail-vk0-x241.google.com ([2607:f8b0:400c:c05::241]:32768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dkqvT-0004DR-GI
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:07:55 -0400
Received: by mail-vk0-x241.google.com with SMTP id g12so940287vkf.0
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 05:07:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503576178-23966-3-git-send-email-armbru@redhat.com>
References: <1503576178-23966-1-git-send-email-armbru@redhat.com>
	<1503576178-23966-3-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Aug 2017 14:07:54 +0200
Message-ID: <CAJ+F1CJViO6B4pf2LF2cWDoXkAugnashkw1cG1JSUcgvJXGqmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qapi-schema: Introspection doc is in
 the wrong section, fix
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
> Bug: introspection documentation is in section "Tracing commands".
>
> Cause: sub-schema qapi/introspect.json lacks a section header, and
> therefore goes into whatever section precedes its include.
>
> Fix: add a section header.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qapi/introspect.json | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/qapi/introspect.json b/qapi/introspect.json
> index cf77ff0..5b3e6e9 100644
> --- a/qapi/introspect.json
> +++ b/qapi/introspect.json
> @@ -1,7 +1,5 @@
>  # -*- Mode: Python -*-
>  #
> -# QAPI/QMP introspection
> -#
>  # Copyright (C) 2015 Red Hat, Inc.
>  #
>  # Authors:
> @@ -11,6 +9,10 @@
>  # See the COPYING file in the top-level directory.
>
>  ##
> +# =3D QMP introspection
> +##
> +
> +##
>  # @query-qmp-schema:
>  #
>  # Command query-qmp-schema exposes the QMP wire ABI as an array of
> --
> 2.7.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
