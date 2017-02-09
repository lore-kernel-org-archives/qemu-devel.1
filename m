Received: from eggs.gnu.org ([2001:4830:134:3::10]:34142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbrJw-00052D-AW
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:11:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cbrJt-0007oX-6p
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:11:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1cbrJt-0007oQ-1G
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:11:41 -0500
Message-ID: <1486656698.3641.49.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 09 Feb 2017 17:11:38 +0100
In-Reply-To: <20170209153535.tnhhy3bvxocqwnzv@kamzik.brq.redhat.com>
References: <1486575331-14455-1-git-send-email-abologna@redhat.com>
	<1486575331-14455-3-git-send-email-abologna@redhat.com>
	<20170209094259.nmli6yd5swxdujkm@kamzik.brq.redhat.com>
	<CAFEAcA8bRHuF_to0+whEhNF5oXp5_O63H8EV2JTXBngffufz9Q@mail.gmail.com>
	<1486637473.3641.36.camel@redhat.com>
	<20170209122819.ajgatpsnxj7cdjq2@kamzik.brq.redhat.com>
	<1486653043.3641.47.camel@redhat.com>
	<20170209153535.tnhhy3bvxocqwnzv@kamzik.brq.redhat.com>
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

On Thu, 2017-02-09 at 16:35 +0100, Andrew Jones wrote:
> > Please propose the alternative wording you'd like to see
> > so we can discuss it :)
>=C2=A0
> I guess I did above with "... -nodefaults ensures no non-builtin
> peripherals are automatically added, but builtin peripherals,
> such as the PL011, will remain..."

Trying to work your proposal into my most recent stab at
this, I ended up with:

=C2=A0 Using -nodefaults is required to have full control over
=C2=A0 the virtual hardware: when it's specified, QEMU will
=C2=A0 populate the board with only the builtin peripherals,
=C2=A0 such as the PL011 UART, plus a small selection of core
=C2=A0 PCI devices and controllers; the user will then have to
=C2=A0 esplicitly add further devices.

=C2=A0 More specifically, the PCI devices that will always be
=C2=A0 present in the guest are:

=C2=A0=C2=A0=C2=A0=C2=A000:00.0 Host bridge

=C2=A0 This configuration file adds a number of other...

Does it look acceptable?

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
