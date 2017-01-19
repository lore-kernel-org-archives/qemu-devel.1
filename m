Received: from eggs.gnu.org ([2001:4830:134:3::10]:45272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU9Kp-000368-2S
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:48:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cU9Kl-0006N3-W8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:48:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cU9Kl-0006MX-Q8
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 04:48:43 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E4084274860
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 09:48:43 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-7-eblake@redhat.com>
Date: Thu, 19 Jan 2017 10:48:41 +0100
In-Reply-To: <20170118161653.19296-7-eblake@redhat.com> (Eric Blake's message
	of "Wed, 18 Jan 2017 10:16:53 -0600")
Message-ID: <8737gffkhy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> Having a named rather than anonymous C type will make it easier
> to improve the testsuite in a later patch.

Post it together with said later patch then.

>                                            No semantic change,
> to any of the existing code or to the introspection output.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
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
>  # @device:          #optional Block device name (deprecated, use @id instead)
>  #
>  # @id:              #optional The name or QOM path of the guest device
   #                   (since: 2.8)
   #
   # @filename:        filename of the new image to be loaded
   #
   # @format:          #optional, format to open the new image with (defaults to
   #                   the probed format)
   #
   # @read-only-mode:  #optional, change the read-only mode of the device; defaults
   #                   to 'retain'
   #
   # Since: 2.5

Isn't Since: 2.5 misleading?  The anonymous type goes back to 2.5, but
the name doesn't.

> @@ -3165,7 +3174,7 @@
>  # <- { "return": {} }
>  #
>  ##
> -{ 'command': 'blockdev-change-medium',
> +{ 'struct': 'BlockdevChangeMedium',
>    'data': { '*device': 'str',
>              '*id': 'str',
>              'filename': 'str',
