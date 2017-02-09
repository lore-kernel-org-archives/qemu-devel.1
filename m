Received: from eggs.gnu.org ([2001:4830:134:3::10]:55450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbsAt-0003jc-EN
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:06:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbsAo-00013R-CO
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:06:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbsAo-00013L-6P
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 12:06:22 -0500
Message-ID: <1486659979.3641.51.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 09 Feb 2017 18:06:19 +0100
In-Reply-To: <20170209163626.rfrwk2mt6gtoc3lb@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
	<CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
	<1486637473.3641.36.camel@redhat.com>
	<20170209122819.ajgatpsnxj7cdjq2@kamzik.brq.redhat.com>
	<1486653043.3641.47.camel@redhat.com>
	<20170209153535.tnhhy3bvxocqwnzv@kamzik.brq.redhat.com>
	<1486656698.3641.49.camel@redhat.com>
	<20170209163626.rfrwk2mt6gtoc3lb@kamzik.brq.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/2] mach-virt: Provide sample
 configuration files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, 2017-02-09 at 17:36 +0100, Andrew Jones wrote:
> On Thu, Feb 09, 2017 at 05:11:38PM +0100, Andrea Bolognani wrote:
> >=C2=A0
> > On Thu, 2017-02-09 at 16:35 +0100, Andrew Jones wrote:
> > >=C2=A0
> > > >=C2=A0
> > > > Please propose the alternative wording you'd like to see
> > > > so we can discuss it :)
> > >=C2=A0=C2=A0
> > > I guess I did above with "... -nodefaults ensures no non-builtin
> > > peripherals are automatically added, but builtin peripherals,
> > > such as the PL011, will remain..."
> >=C2=A0
> > Trying to work your proposal into my most recent stab at
> > this, I ended up with:
> >=C2=A0
> >=C2=A0=C2=A0=C2=A0Using -nodefaults is required to have full control o=
ver
> >=C2=A0=C2=A0=C2=A0the virtual hardware: when it's specified, QEMU will
> >=C2=A0=C2=A0=C2=A0populate the board with only the builtin peripherals=
,
> >=C2=A0=C2=A0=C2=A0such as the PL011 UART, plus a small selection of co=
re
> >=C2=A0=C2=A0=C2=A0PCI devices and controllers; the user will then have=
 to
>=C2=A0
> Well, mach-virt doesn't currently add any pci devices with
> -nodefault; just the host bridge. Personally, I'd state it that
> way to avoid confusion, but I know you're trying to keep the
> paragraph similar to the q35 one, and you're not technically
> wrong...

Okay, one more try! ;)

=C2=A0 Using -nodefaults is required to have full control over
=C2=A0 the virtual hardware: when it's specified, QEMU will
=C2=A0 populate the board with only the builtin peripherals,
=C2=A0 such as the PL011 UART, plus a PCI Express Root Bus; the
=C2=A0 user will then have to explicitly add further devices.

=C2=A0 The PCI Express Root Bus shows up in the guest as:

=C2=A0=C2=A0=C2=A0=C2=A000:00.0 Host bridge

=C2=A0 This configuration file adds a number of...

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
