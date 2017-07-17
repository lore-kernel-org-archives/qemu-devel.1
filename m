Received: from eggs.gnu.org ([2001:4830:134:3::10]:47779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX3ag-0000db-9L
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:49:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dX3ad-0005Qr-4W
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:49:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dX3ac-0005Qk-UY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 06:49:23 -0400
Message-ID: <1500288560.12570.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 17 Jul 2017 12:49:20 +0200
In-Reply-To: <CAJ+F1C+1pVwXxAH=g_5hx25VXBeMU7irpvkJ+guaqMEc7yS2Ag@mail.gmail.com>
References: <20170717101700.23552-1-kraxel@redhat.com>
	<CAJ+F1C+1pVwXxAH=g_5hx25VXBeMU7irpvkJ+guaqMEc7yS2Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] add scripts/indent.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org

On Mon, 2017-07-17 at 10:36 +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Jul 17, 2017 at 12:18 PM Gerd Hoffmann <kraxel@redhat.com>
> wrote:
> > Script to reformat sources in qemu style.
> >=20
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>=20
> A quite powerful approach would be to use clang-format: https://lists
> .gnu.org/archive/html/qemu-devel/2015-10/msg01278.html=C2=A0
>=20
> It comes with a bunch of editor integration and scripts. My config
> could use a bit more tweaking though, I haven't been using it for a
> while, and newer version have more options.

Hmm, I want reformat all audio stuff to qemu code style some day, the
current situation where patches are either break qemu code style or
lead to mixed-style in the audio source files isn't very good.

I don't mind much which tool we use for that, I picked indent mostly
because I know that one.  If clang-format can do that too, fine with
me.  I'm missing documentation though, there is no man-page and there
isn't anything in /usr/share/doc/clang-3.4.2 either ...

cheers,
  Gerd
