Received: from eggs.gnu.org ([2001:4830:134:3::10]:43990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg5ld-0004H1-As
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:25:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg5la-0002P4-3w
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:25:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg5lZ-0002Ox-Ur
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 03:25:46 -0500
Message-ID: <1487665541.2694.33.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 09:25:41 +0100
In-Reply-To: <CAJ+F1CLG+WsjD=L5B2sj6Oj15Xx0ihVG7QfaoSHGweGsKv+8GA@mail.gmail.com>
References: <1487663871-11859-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CLG+WsjD=L5B2sj6Oj15Xx0ihVG7QfaoSHGweGsKv+8GA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] spice: set merge-lists
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

On Di, 2017-02-21 at 08:15 +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Feb 21, 2017 at 12:00 PM Gerd Hoffmann <kraxel@redhat.com>
> wrote:
>=20
>         This way you can use -spice multiple times on the command line
>         and qemu will actually pick up all options.
>        =20
>=20
>=20
> Is this actually a good thing to have? vnc doesn't have it for
> example. Perhaps some day we may want to have -spice for difference
> server instances?

Is that likely?  The use case for multiple vnc server instances is
multiple displays, which is not a problem for spice because it has
better multihead support.  Also spice-server library doesn't support
multiple instances today, are there plans to actually change that?

But, yes, if we want multiple instances some day this is probably a bad
idea ...

cheers,
  Gerd
