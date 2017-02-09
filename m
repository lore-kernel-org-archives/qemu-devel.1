Received: from eggs.gnu.org ([2001:4830:134:3::10]:53451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cbql4-0002vt-QZ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cbql1-0005sp-MW
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:35:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cbql1-0005sQ-Dy
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 10:35:39 -0500
Date: Thu, 9 Feb 2017 16:35:35 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170209153535.tnhhy3bvxocqwnzv@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
	<CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
	<1486637473.3641.36.camel@redhat.com>
	<20170209122819.ajgatpsnxj7cdjq2@kamzik.brq.redhat.com>
	<1486653043.3641.47.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1486653043.3641.47.camel@redhat.com>
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
Cc: Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Feb 09, 2017 at 04:10:43PM +0100, Andrea Bolognani wrote:
> On Thu, 2017-02-09 at 13:28 +0100, Andrew Jones wrote:
> > > Please keep in mind that I want to be able
> > > to use the very same paragraph both for q35 and mach-virt.
> >=A0
> > I'm not sure having the exact same paragraph is a reasonable
> > goal.
>=20
> If not the exact same, there is no reason for it not to
> be at least 90% shareable IMHO.
>=20
> > Does q35 have platform devices like mach-virt?
>=20
> I don't know. And I'm not sure we need to talk about them
> or their aarch64 counterparts at all in the sample
> configuration file, because AFAIK with the exception of the
> GIC version they are not user configurable, or at the very
> least not something the user will actively want to
> configure (correct me if I'm wrong).

I'm OK with not mentioning them "too much" in this file. I
agree with Peter though that to be more accurate we shouldn't
state that '-nodefaults' results in a machine with nothing.
Therefore, some wording that states -nodefaults ensures no
non-builtin peripherals are automatically added, but builtin
peripherals, such as the PL011, will remain, seems like a
good idea.

>=20
> > The
> > devices we get on a 'qemu -nodefaults -machine virt' instance
> > are MMIO driven devices on the board, rather than devices
> > hung off the pcie host bridge.
>=20
> We want people to use PCIe instead of MMIO, though, so
> again why should we even mention those?

We want to use virtio-pci devices, as opposed to virtio-mmio
devices, which means using the PCIe ports you add vs. the
virtio-mmio transports. That doesn't mean we don't still
want to use the MMIO devices builtin to the board though,
the PL011 (UART) being a prime example.

>=20
> It's just a sample configuration file we're talking about,
> not a complete reference of the aarch64 architecture, so
> it's entirely okay to skimp on details that don't directly
> impact most users and be opinionated.

I agree with being skimpy, but we don't want to cross the line
into misleading.

>=20
> > Perhaps we can list the uart as an example; I don't suppose
> > it'll ever be removed. If we use wording such as "such as",
> > then it allows expansion to the board without a commitment to
> > update the list.
> >=A0
> > BTW, when I stated "-nodefaults provides us a base mach-virt
> > board with no peripherals.", I meant no _additional_
> > peripherals plugged into the board's virtio-mmio transports,
> > nor hung off the host bridge. Is there a word for those?
> > Maybe just non-builtin peripherals?
>=20
> Please propose the alternative wording you'd like to see
> so we can discuss it :)

I guess I did above with "... -nodefaults ensures no non-builtin
peripherals are automatically added, but builtin peripherals,
such as the PL011, will remain..."

Thanks,
drew
