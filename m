Received: from eggs.gnu.org ([2001:4830:134:3::10]:52517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flej3-0005i1-71
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:22:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1flej0-0006iD-1N
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:22:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42886 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fleiz-0006hy-Rn
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 14:22:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 708C07A7EF
	for <qemu-devel@nongnu.org>; Fri,  3 Aug 2018 18:22:53 +0000 (UTC)
References: <20180803173614.12358-1-marcandre.lureau@redhat.com>
	<20180803173614.12358-11-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7992e41b-c061-a079-24f5-cbfda213bfce@redhat.com>
Date: Fri, 3 Aug 2018 13:22:47 -0500
MIME-Version: 1.0
In-Reply-To: <20180803173614.12358-11-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/10] display: add -display app launching
 external application
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On 08/03/2018 12:36 PM, Marc-Andr=C3=A9 Lureau wrote:
> Add a new display backend that will configure Spice to allow a remote
> client to control QEMU in a similar fashion as other display backend
> like GTK.
>=20
> For this to work, we set up Spice server with a unix socket, and
> register a VC chardev that will be exposed as Spice ports. A QMP
> monitor is also exposed as a Spice port, this allows the remote client
> fuller qemu control and state handling.
>=20
> - doesn't handle VC set_echo() - this doesn't seem a strong
>    requirement, very few front-end use it
> - spice options can be tweaked with other -spice arguments
> - Windows support shouldn't be hard to do, but will probably use a TCP
>    port instead
> - we may want to watch the child process to quit automatically if it
>    crashed
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   qapi/ui.json     |   3 +-
>   ui/app.c         | 179 ++++++++++++++++++++++++++++++++++++++++++++++=
+
>   qemu-options.hx  |   5 ++
>   ui/Makefile.objs |   5 ++
>   4 files changed, 191 insertions(+), 1 deletion(-)
>   create mode 100644 ui/app.c
>=20
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 4ca91bb45a..9b96f1f9d7 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1057,7 +1057,8 @@
>   ##
>   { 'enum'    : 'DisplayType',
>     'data'    : [ 'default', 'none', 'gtk', 'sdl',
> -                'egl-headless', 'curses', 'cocoa' ] }
> +                'egl-headless', 'curses', 'cocoa',
> +                'app'] }

Missing documentation for 'app' (at a minimum, it should mention since 3.=
1)
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
