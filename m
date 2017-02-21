Received: from eggs.gnu.org ([2001:4830:134:3::10]:56623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6UD-0003vV-8y
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg6UC-0006uM-Af
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:11:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg6UC-0006u5-52
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 04:11:52 -0500
Message-ID: <1487668309.2694.37.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 10:11:49 +0100
In-Reply-To: <CAJ+F1CLK3aPi+aDgHGUjCCF2Xbi1V=g5UjM_BAko_PSfau33KA@mail.gmail.com>
References: <1487663858-11731-1-git-send-email-kraxel@redhat.com>
	<CAJ+F1CLK3aPi+aDgHGUjCCF2Xbi1V=g5UjM_BAko_PSfau33KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] spice: add display & head options
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

On Di, 2017-02-21 at 08:52 +0000, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Feb 21, 2017 at 11:58 AM Gerd Hoffmann <kraxel@redhat.com>
> wrote:
>=20
>         This allows to specify display and head to use, simliar to
>         vnc.
>        =20
>=20
>=20
> Does "head" in qemu always match the head for multi-monitor spice?
> (with a single qxl/virtio).

Yes, head as specified in graphic_console_init().

cheers,
  Gerd
