Received: from eggs.gnu.org ([2001:4830:134:3::10]:38341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRhkG-0004Ve-8l
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:56:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cRhkB-0002of-Td
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:56:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cRhkB-0002oT-Of
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:56:51 -0500
Message-ID: <1484236609.5151.16.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 12 Jan 2017 16:56:49 +0100
In-Reply-To: <a277b56c-3bb9-dcb1-eafc-0844cd77b8eb@weilnetz.de>
References: <1483967385-12891-1-git-send-email-kraxel@redhat.com>
	<1483967385-12891-6-git-send-email-kraxel@redhat.com>
	<a277b56c-3bb9-dcb1-eafc-0844cd77b8eb@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PULL v2 05/11] sdl2: set window ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <stefan.weil@weilnetz.de>
Cc: qemu-devel@nongnu.org, Samuel Thibault <samuel.thibault@ens-lyon.org>

On Do, 2017-01-12 at 16:10 +0100, Stefan Weil wrote:
> This commit breaks builds for Windows. See below for details.

> Windows does not use X11. gcc fails:
>=20
>   CC      ui/sdl2.o
> /qemu/ui/sdl2.c: In function =E2=80=98sdl_display_init=E2=80=99:
> /qemu/ui/sdl2.c:821:54: error: =E2=80=98union <anonymous>=E2=80=99 has no=
 member named =E2=80=98x11=E2=80=99
>              qemu_console_set_window_id(con, info.info.x11.window);

Oops.  Any chance you can look into this?  sdl1 builds, and IIRC it has
#ifdefs to support qemu_console_set_window_id on windows too, which can
possibly ported over to sdl2 ...

thanks,
  Gerd
