Received: from eggs.gnu.org ([2001:4830:134:3::10]:46030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cJGa5-0006wm-K5
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cJGa2-00064T-Dw
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 04:19:33 -0500
Message-ID: <1482225561.3732.12.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Tue, 20 Dec 2016 10:19:21 +0100
In-Reply-To: <20161219234717.GG23176@umbus.fritz.box>
References: <20161215061128.30792-1-david@gibson.dropbear.id.au>
	<1482160529.3732.2.camel@redhat.com>
	<20161219234717.GG23176@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCHv3 for-2.9 0/6] HPT resizing for
 pseries guests (qemu part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Tue, 2016-12-20 at 10:47 +1100, David Gibson wrote:
> > Do we want to expose a knob for controlling this
> > to the user at the libvirt level, or should we just enable
> > resize-hpt unconditionally whenever we detect that the QEMU
> > binary supports it?
>=C2=A0
> I'm not sure if we need a knob.=C2=A0=C2=A0I think in general enabling =
for
> pseries-2.9 and later machine types is correct.=C2=A0=C2=A0The difficul=
ty is
> that for HV guests, we can only enable it if the host kernel also has
> support.=C2=A0=C2=A0Explicitly setting "resize-hpt=3Denable" means qemu=
 will not
> start if the kernel doesn't support it.

I thought that would be the case for resize-hpt=3Drequired,
not resized-hpt=3Denabled.

> My inclination would be to enable unconditionally for pseries-2.9 and
> later machine types.

So I guess the question is, will users want to enable this
manually for older machine types, or is it reasonable to
expect them to simply switch to pseries-2.9 if they want
the feature?

Moreover, do you foresee any situation in which users
might reasonably want to turn the feature off even though
the entire stack (host kernel, QEMU, guest kernel)
understands it?

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
