Received: from eggs.gnu.org ([2001:4830:134:3::10]:56095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRdSH-0007NS-Rg
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1cRdSD-0004cJ-Qt
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 06:22:05 -0500
References: <20170103191933.19416-1-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <3699459d-f069-252f-4295-a13af1f01dac@msgid.tls.msk.ru>
Date: Thu, 12 Jan 2017 14:22:00 +0300
MIME-Version: 1.0
In-Reply-To: <20170103191933.19416-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] win32: use glib gpoll if glib >= 2.50
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: sw@weilnetz.de, QEMU Trivial <qemu-trivial@nongnu.org>

03.01.2017 22:19, Marc-Andr=C3=A9 Lureau wrote:
> A fix has been committed in upstream glib commit
> 210a9796f78eb90f76f1bd6a304e9fea05e97617.
> (See also related bug https://bugzilla.gnome.org/show_bug.cgi?id=3D7644=
15)
>=20
> It is desirable to use the glib version instead of qemu copy, since it
> provides more debugging facilities (G_MAIN_POLL_DEBUG etc), and
> hopefully has a better maintainance. Hopefully, we can drop the qemu
> copy in a few years.

Applied to -trivial, thank you!

/mjt
