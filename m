Received: from eggs.gnu.org ([2001:4830:134:3::10]:42029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZzai-0002ts-It
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:46:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZzaf-0006Gh-CJ
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:46:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gZzaf-0006GH-6a
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 09:46:21 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5B8095D698
	for <qemu-devel@nongnu.org>; Thu, 20 Dec 2018 14:46:20 +0000 (UTC)
References: <20181220141553.24098-1-marcandre.lureau@redhat.com>
	<20181220141553.24098-11-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <461252a9-b095-9441-054c-bb9dd00f8cf5@redhat.com>
Date: Thu, 20 Dec 2018 08:46:13 -0600
MIME-Version: 1.0
In-Reply-To: <20181220141553.24098-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/12] qapi: document DisplayType enum
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

On 12/20/18 8:15 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   qapi/ui.json | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>=20
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 5ad13248d5..3f2f662dca 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1075,6 +1075,30 @@
>   #
>   # Display (user interface) type.
>   #
> +# @default: The default user interface.

Any more hints on how this default is determined?  Is it a compile-time=20
decision, based on what libraries were linked in?  Does the work on=20
adding #if support to qapi make it introspectible what the default is?

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
> +#                VNC or Spice. (Since 3.1)

s/need/needs/

> +#
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
>   # Since: 2.12
>   #
>   ##
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
