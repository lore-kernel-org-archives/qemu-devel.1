Received: from eggs.gnu.org ([209.51.188.92]:40527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwot9-0006r6-I5
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gwot8-0006kn-CE
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:59:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38088)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gwot8-0006ht-2m
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 08:59:46 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DEE73097089
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 13:59:41 +0000 (UTC)
References: <20190221110703.5775-1-marcandre.lureau@redhat.com>
	<20190221110703.5775-10-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e5cbaf80-6f06-668f-a8a5-379a43e3f3eb@redhat.com>
Date: Thu, 21 Feb 2019 07:59:35 -0600
MIME-Version: 1.0
In-Reply-To: <20190221110703.5775-10-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 09/11] qapi: document DisplayType enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 2/21/19 5:07 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Tested-by: Victor Toso <victortoso@redhat.com>
> ---
>  qapi/ui.json | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>=20
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 7d9c4bddaf..7702ddf583 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1085,6 +1085,31 @@
>  #
>  # Display (user interface) type.
>  #
> +# @default: The default user interface, selecting from the first avail=
able
> +#           of gtk, sdl, cocoa, and vnc.
> +#
> +# @none: No user interface or video output display. The guest will
> +#        still see an emulated graphics card, but its output will not
> +#        be displayed to the QEMU user.
> +#
> +# @gtk: The GTK user interface.
> +#
> +# @sdl: The SDL user interface.
> +#
> +# @egl-headless: No user interface, offload GL operations to a local
> +#                DRI device. Graphical display need to be paired with

s/need/needs/

> +#                VNC or Spice. (Since 3.1)
> +#

Are these retroactive documentation for things that existed in 3.1 or
2.12, or should any of them have '(since 4.0)' tags?  The commit message
should probably mention that.

> +# @curses: Display video output via curses.  For graphics device
> +#          models which support a text mode, QEMU can display this
> +#          output using a curses/ncurses interface. Nothing is
> +#          displayed when the graphics device is in graphical mode or
> +#          if the graphics device does not support a text
> +#          mode. Generally only the VGA device models support text
> +#          mode.
> +#
> +# @cocoa: The Cocoa user interface.
> +#
>  # Since: 2.12
>  #
>  ##
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
