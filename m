Received: from eggs.gnu.org ([2001:4830:134:3::10]:53489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cbnpq-0006m3-L1
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cbnpn-000835-Id
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:28:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cbnpn-00082p-DC
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 07:28:23 -0500
Date: Thu, 9 Feb 2017 13:28:19 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170209122819.ajgatpsnxj7cdjq2@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
	<CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
	<1486637473.3641.36.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1486637473.3641.36.camel@redhat.com>
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
To: Andrea Bolognani <abologna@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Feb 09, 2017 at 11:51:13AM +0100, Andrea Bolognani wrote:
> On Thu, 2017-02-09 at 09:57 +0000, Peter Maydell wrote:
> > > I see Peter and you are discussing what to document here. IMO,
> > > we should simply state -nodefaults provides us a base mach-virt
> > > board with no peripherals.
> >=A0
> > The thing about saying that is that it's not actually
> > correct -- you get the UART, etc etc peripherals whether
> > you say -nodefaults or not. I agree that listing them
> > in multiple places isn't a good idea though. Maybe
> > there's some wording that will work here.
>=20
> Agreed, we just have to find the right wording. Would
> something like
>=20
> =A0 Using -nodefaults is required to have full control over
> =A0 the virtual hardware: when it's specified, QEMU will
> =A0 only automatically add a small selection of core PCI
> =A0 devices, and leave the user in charge of adding more as
> =A0 they see fit. More specifically, the PCI devices that
> =A0 will always be present are:
>=20
> =A0=A0=A0=A000:00.0 Host bridge
>=20
> =A0 This configuration file adds a number of other...
>=20
> work for you? Please keep in mind that I want to be able
> to use the very same paragraph both for q35 and mach-virt.

I'm not sure having the exact same paragraph is a reasonable
goal. Does q35 have platform devices like mach-virt? The
devices we get on a 'qemu -nodefaults -machine virt' instance
are MMIO driven devices on the board, rather than devices
hung off the pcie host bridge.

Perhaps we can list the uart as an example; I don't suppose
it'll ever be removed. If we use wording such as "such as",
then it allows expansion to the board without a commitment to
update the list.

BTW, when I stated "-nodefaults provides us a base mach-virt
board with no peripherals.", I meant no _additional_
peripherals plugged into the board's virtio-mmio transports,
nor hung off the host bridge. Is there a word for those?
Maybe just non-builtin peripherals?

Thanks,
drew

>=20
> --=A0
> Andrea Bolognani / Red Hat / Virtualization
>=20
