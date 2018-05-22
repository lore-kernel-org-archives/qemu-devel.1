Received: from eggs.gnu.org ([2001:4830:134:3::10]:52055)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fL3g6-0003bj-DD
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fL3g2-00038Q-EY
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:33:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fL3g2-00038I-AI
	for qemu-devel@nongnu.org; Tue, 22 May 2018 05:33:54 -0400
Date: Tue, 22 May 2018 11:33:53 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180522093353.cihzspv526teme4m@sirius.home.kraxel.org>
References: <20180517092513.735-1-kraxel@redhat.com>
	<20180517092513.735-5-kraxel@redhat.com>
	<CAJ+F1CJ85w4hgeDGCvNjs0TvfEcGprW1GYW6q4Hk=Wy4phHkxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJ85w4hgeDGCvNjs0TvfEcGprW1GYW6q4Hk=Wy4phHkxw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] bochs-display: add pcie support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Fri, May 18, 2018 at 05:13:27PM +0200, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Thu, May 17, 2018 at 11:25 AM, Gerd Hoffmann <kraxel@redhat.com> wro=
te:
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
>=20
> Could you explain where the 0x80 offset comes from?

Pulled out of thin air.  Standard pci cfg space header size is 0x40, so
it must be between 0x40 and 0xff - sizeof(capability).  And it must not
overlap with other pci(e) capabilities (easy as this is the only one).
That are the only constrains I'm aware of.

cheers,
  Gerd
