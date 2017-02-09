Received: from eggs.gnu.org ([2001:4830:134:3::10]:60632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbmJr-0004ke-Sk
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbmJo-0005oG-SG
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:51:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbmJo-0005nl-MD
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 05:51:16 -0500
Message-ID: <1486637473.3641.36.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 09 Feb 2017 11:51:13 +0100
In-Reply-To: <CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
	<CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, 2017-02-09 at 09:57 +0000, Peter Maydell wrote:
> > I see Peter and you are discussing what to document here. IMO,
> > we should simply state -nodefaults provides us a base mach-virt
> > board with no peripherals.
>=C2=A0
> The thing about saying that is that it's not actually
> correct -- you get the UART, etc etc peripherals whether
> you say -nodefaults or not. I agree that listing them
> in multiple places isn't a good idea though. Maybe
> there's some wording that will work here.

Agreed, we just have to find the right wording. Would
something like

=C2=A0 Using -nodefaults is required to have full control over
=C2=A0 the virtual hardware: when it's specified, QEMU will
=C2=A0 only automatically add a small selection of core PCI
=C2=A0 devices, and leave the user in charge of adding more as
=C2=A0 they see fit. More specifically, the PCI devices that
=C2=A0 will always be present are:

=C2=A0=C2=A0=C2=A0=C2=A000:00.0 Host bridge

=C2=A0 This configuration file adds a number of other...

work for you? Please keep in mind that I want to be able
to use the very same paragraph both for q35 and mach-virt.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
