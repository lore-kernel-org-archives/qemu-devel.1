Received: from eggs.gnu.org ([2001:4830:134:3::10]:42510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgf9-0003cB-6S
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dzgf8-0000EE-9x
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:23 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:57340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dzgf8-0000DF-4k
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 06:12:22 -0400
Received: by mail-qt0-x244.google.com with SMTP id 34so994235qtb.13
	for <qemu-devel@nongnu.org>; Wed, 04 Oct 2017 03:12:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171002141341.24616-2-armbru@redhat.com>
References: <20171002141341.24616-1-armbru@redhat.com>
	<20171002141341.24616-2-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 4 Oct 2017 12:12:20 +0200
Message-ID: <CAJ+F1CL0Nfy-bjsz0XW1HhfqphUB5BdyyroiRweWfFsXDJVmOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/11] qapi-schema: Fix
 query-vm-generation-id's doc comment markup
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

On Mon, Oct 2, 2017 at 4:13 PM, Markus Armbruster <armbru@redhat.com> wrote=
:
> Reported-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

(reviweing this patch makes me realize that the last
expression/command in qapi-schema isn't in the generated doc..)

> ---
>  qapi-schema.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index a9dd043f65..3490a5edaf 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3188,7 +3188,7 @@
>  #
>  # Show Virtual Machine Generation ID
>  #
> -# Since 2.9
> +# Since: 2.9
>  ##
>  { 'command': 'query-vm-generation-id', 'returns': 'GuidInfo' }
>
> --
> 2.13.6
>
>



--=20
Marc-Andr=C3=A9 Lureau
