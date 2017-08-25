Received: from eggs.gnu.org ([2001:4830:134:3::10]:57324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlCj1-0002j3-RJ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:24:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dlCj0-0008Uc-Ol
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:24:31 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:32770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dlCj0-0008UF-If
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:24:30 -0400
Received: by mail-vk0-x244.google.com with SMTP id j189so828764vka.0
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 04:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-15-git-send-email-armbru@redhat.com>
In-Reply-To: <1503602048-12268-15-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 25 Aug 2017 11:24:19 +0000
Message-ID: <CAJ+F1C+hvcjn1MZqJprk1aV0n1F1CLDQBPyyEwSYpoDMo=tUnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 14/16] qapi-schema: Make block-core.json
 self-contained
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Thu, Aug 24, 2017 at 9:15 PM Markus Armbruster <armbru@redhat.com> wrote=
:

> Except for block-core.json, the sub-schemas are self-contained: if
> they use a symbol defined in another sub-schema, they include that
> sub-schema.  To check, feed the sub-schema to qapi2texi (or any other
> QAPI generator) along with the pragma from qapi-schema.json.
>

Nice tip


> Fix up things to make block-core.json self-contained, too.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
>  qapi-schema.json     | 14 --------------
>  qapi/block-core.json |  1 +
>  qapi/common.json     | 14 ++++++++++++++
>  3 files changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 4964d92..80c15da 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -2816,20 +2816,6 @@
>       'data': { 'info': 'ACPIOSTInfo' } }
>
>  ##
> -# @IoOperationType:
> -#
> -# An enumeration of the I/O operation types
> -#
> -# @read: read operation
> -#
> -# @write: write operation
> -#
> -# Since: 2.1
> -##
> -{ 'enum': 'IoOperationType',
> -  'data': [ 'read', 'write' ] }
> -
> -##
>  # @rtc-reset-reinjection:
>  #
>  # This command will reset the RTC interrupt reinjection backlog.
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5379674..f4caa5c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -5,6 +5,7 @@
>  ##
>
>  { 'include': 'common.json' }
> +{ 'include': 'crypto.json' }
>  { 'include': 'sockets.json' }
>
>  ##
> diff --git a/qapi/common.json b/qapi/common.json
> index e2c5856..fc72d7e 100644
> --- a/qapi/common.json
> +++ b/qapi/common.json
> @@ -132,6 +132,20 @@
>  { 'command': 'query-commands', 'returns': ['CommandInfo'] }
>
>  ##
> +# @IoOperationType:
> +#
> +# An enumeration of the I/O operation types
> +#
> +# @read: read operation
> +#
> +# @write: write operation
> +#
> +# Since: 2.1
> +##
> +{ 'enum': 'IoOperationType',
> +  'data': [ 'read', 'write' ] }
> +
> +##
>  # @OnOffAuto:
>  #
>  # An enumeration of three options: on, off, and auto
> --
> 2.7.5
>
>
> --
Marc-Andr=C3=A9 Lureau
