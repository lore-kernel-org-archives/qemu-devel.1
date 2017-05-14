Received: from eggs.gnu.org ([2001:4830:134:3::10]:58645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d9nJF-0005r1-Vp
	for qemu-devel@nongnu.org; Sun, 14 May 2017 02:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d9nJ9-0007Mq-Va
	for qemu-devel@nongnu.org; Sun, 14 May 2017 02:47:18 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:60513)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1d9nJ9-0007Kq-Nv
	for qemu-devel@nongnu.org; Sun, 14 May 2017 02:47:11 -0400
References: <VI1PR0601MB2479748C35B3C9F914896AEA9CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <69288f57-7802-d6e6-17ca-e5910a81ca18@msgid.tls.msk.ru>
Date: Sun, 14 May 2017 09:47:00 +0300
MIME-Version: 1.0
In-Reply-To: <VI1PR0601MB2479748C35B3C9F914896AEA9CE80@VI1PR0601MB2479.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] slirp: question about using SMB on windows host
 with linux guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: FONNEMANN Mark <mark.fonnemann@hexagon.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

07.05.2017 00:30, FONNEMANN Mark write:
> Hello-
>=20
> I am trying to shares files between Windows host and Linux guest using =
slirp=E2=80=99s built-in SMB server.

There's no such thing as "slirp built-in SMB Server". Qemu does not have =
an SMB server
built-in, qemu uses samba to provide smb functionality, it spawns smbd.  =
So you have
to have smbd on windows in order to use this functionality.

However, on windows, it's easy to use native CIFS server, just share the =
directory you
want to share and connect to your windows machine from within guest.

/mjt
