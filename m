Received: from eggs.gnu.org ([2001:4830:134:3::10]:48262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAZRN-0001yP-Uq
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:43:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eAZRK-0000k4-Qt
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:43:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:26208)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eAZRK-0000jP-Ku
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 06:43:06 -0400
Message-ID: <1509705781.31823.18.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 03 Nov 2017 11:43:01 +0100
In-Reply-To: <20171103101055.GD20155@redhat.com>
References: <1509638660.11873.13.camel@redhat.com>
	<20171102161103.GU32533@redhat.com>
	<1509691743.31823.1.camel@redhat.com>
	<20171103101055.GD20155@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] seabios serial console vs. sgabios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: seabios <seabios@seabios.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

  Hi,

> > Hmm, why?=C2=A0=C2=A0The user asked for a serial console.=C2=A0=C2=A0=
Whenever that is
> > provided by seabios builtin support or the sgabios rom doesn't
> > really
> > matter, no?
>=20
> Surely it has ABI implications for the guest if we stop putting the
> sgabios option ROM into memory - changing layout of ROMS

Because of that changing -device sga behavior on the qemu side must be
tied to the qemu machine type.

> > Also, the question is what seabios should do in case both are
> > active.=C2=A0
> > Which I think can happen today with libvirt if you configure a
> > virtual
> > machine without vga (libvirt passes -machine graphics=3Doff which
> > activates builtin serial console) and with "<bios
> > useserial=3D'yes'/>"
> > (enables sgabios rom).
>=20
> Libvirt doesn't use=C2=A0=C2=A0'-machine graphics=3Doff' AFAIK, only '-
> nographic'.

I think that is pretty much the same.  Setting "graphichs=3Doff" is one
of the effects of passing -nographic, and the other effects (like
setting up default serial + monitor in a different way) don't happen
due to libvirt also using -nodefaults.

cheers,
  Gerd
