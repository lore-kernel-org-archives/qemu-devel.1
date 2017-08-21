Received: from eggs.gnu.org ([2001:4830:134:3::10]:32960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djkIy-00062O-OL
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:51:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1djkIx-0001wD-JX
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:51:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1djkIx-0001v5-DE
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 06:51:35 -0400
Message-ID: <1503312229.26016.1.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 21 Aug 2017 12:43:49 +0200
In-Reply-To: <11bbf041-b0b8-00a6-6201-b4deb3ccf673@amsat.org>
References: <CAMM1KhhxQg8H8uYeGEHpXYgE=iTRyhik7pU+MdRr7HL6utpREg@mail.gmail.com>
	<11bbf041-b0b8-00a6-6201-b4deb3ccf673@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] nVidia emulation in QEMU?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Darius Goad <alegend45@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, 2017-08-17 at 23:11 -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> On 08/17/2017 10:01 PM, Darius Goad wrote:
> > Hello. I'm Melissa, a trans woman who is the main developer of the
> > nVidia
> > emulation code for 86Box. I'm interested in porting this code over
> > to QEMU
> > as QEMU has higher compatibility with newer operating systems, as
> > well as
> > expanding the developer base for nVidia graphics card emulation.
> >=20
> > The 86Box code currently only handles the RIVA 128, the RIVA TNT,
> > and a few
> > versions of the RIVA TNT2, and in a very incomplete state at that.
> > I have
> > not been able to progress further due to the fact that 86Box's
> > support of
> > modern Linux operating systems is poor, and due to the lack of a
> > debugger
> > in 86Box.
> >=20
> > I do need some help, however, as QEMU's code structure is not my
> > strong
> > suit.
> >=20
> > Anyway, my code is here:
> > https://github.com/MoochMcGee/86Box-experimental/blob/experimental/
> > src/VIDEO/vid_nv_riva128.c
>=20
> This code seems to match how devices are implemented in QEMU.

Partly.  From a very quick view it seems the register emulation works
very simliar but the graphics output side seems to be different.

Riva is pretty old, right?  Something like 15-20 years?  What
capabilities do these cards have?  3d accel?  Or 2d only?
Which features are emulated?
Which features are actually used by modern linux?

cheers,
  Gerd
