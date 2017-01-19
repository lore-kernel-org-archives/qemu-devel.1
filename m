Received: from eggs.gnu.org ([2001:4830:134:3::10]:36415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cU8hY-0003o2-M9
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cU8hX-00011G-Mn
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:12 -0500
Received: from mail-yw0-x244.google.com ([2607:f8b0:4002:c05::244]:36147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cU8hX-00010C-Hq
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:08:11 -0500
Received: by mail-yw0-x244.google.com with SMTP id l75so3256441ywb.3
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 01:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-7-eblake@redhat.com>
In-Reply-To: <20170118161653.19296-7-eblake@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 19 Jan 2017 09:07:58 +0000
Message-ID: <CAJ+F1CKTcqhcyxGzn=PC2aeunzzT3orTDhrG=M7-T=tJ-uD88Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] qapi: Promote
 blockdev-change-medium arguments to QAPI type
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

Hi

On Wed, Jan 18, 2017 at 9:02 PM Eric Blake <eblake@redhat.com> wrote:

> Having a named rather than anonymous C type will make it easier
> to improve the testsuite in a later patch. No semantic change,
> to any of the existing code or to the introspection output.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
>

You should move the "Example:" back to blockdev-change-medium command.

Otherwise,
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>



> ---
> v2: rebase to master
> ---
>  qapi/block-core.json | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 1b3e6eb..0e31d25 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3119,6 +3119,15 @@
>  # combines blockdev-open-tray, x-blockdev-remove-medium,
>  # x-blockdev-insert-medium and blockdev-close-tray).
>  #
> +# Since: 2.5
> +##
> +{ 'command': 'blockdev-change-medium',
> +  'data': 'BlockdevChangeMedium' }
> +
> +
> +##
> +# @BlockdevChangeMedium:
> +#
>  # @device:          #optional Block device name (deprecated, use @id
> instead)
>  #
>  # @id:              #optional The name or QOM path of the guest device
> @@ -3165,7 +3174,7 @@
>  # <- { "return": {} }
>  #
>  ##
> -{ 'command': 'blockdev-change-medium',
> +{ 'struct': 'BlockdevChangeMedium',
>    'data': { '*device': 'str',
>              '*id': 'str',
>              'filename': 'str',
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
