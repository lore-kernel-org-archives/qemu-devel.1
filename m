Received: from eggs.gnu.org ([2001:4830:134:3::10]:60896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMG7p-00083x-Ax
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMG7k-000792-GB
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:31:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eMG7k-00078l-7R
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 11:31:12 -0500
Date: Tue, 5 Dec 2017 16:31:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171205163109.GC6712@stefanha-x1.localdomain>
References: <20171205063313.GB4102@yangzhon-Virtual>
	<20171205120623.GB31150@stefanha-x1.localdomain>
	<5f9f2835-5811-3ee0-9049-0d2cddc08958@redhat.com>
	<CAJSP0QVn0Uq_XO-22cz1JzbgEaFfwwX9yXBk1eKKkMfknADFmQ@mail.gmail.com>
	<876e5376-d729-72d7-3c04-3c6f52b745de@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Content-Disposition: inline
In-Reply-To: <876e5376-d729-72d7-3c04-3c6f52b745de@redhat.com>
Subject: Re: [Qemu-devel] About the light VM solution!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Yang Zhong <yang.zhong@intel.com>, qemu-devel <qemu-devel@nongnu.org>


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 03:00:10PM +0100, Paolo Bonzini wrote:
> On 05/12/2017 14:47, Stefan Hajnoczi wrote:
> > On Tue, Dec 5, 2017 at 1:35 PM, Paolo Bonzini <pbonzini@redhat.com> wro=
te:
> >> On 05/12/2017 13:06, Stefan Hajnoczi wrote:
> >>> On Tue, Dec 05, 2017 at 02:33:13PM +0800, Yang Zhong wrote:
> >>>> As you know, AWS has decided to switch to KVM in their clouds. This =
news make almost all
> >>>> china CSPs(clouds service provider) pay more attention on KVM/Qemu, =
especially light VM
> >>>> solution.
> >>>>
> >>>> Below are intel solution for light VM, qemu-lite.
> >>>> http://events.linuxfoundation.org/sites/events/files/slides/Light%20=
weight%20virtualization%20with%20QEMU%26KVM_0.pdf
> >>>>
> >>>> My question is whether community has some plan to implement light VM=
 or alternative solutions? If no, whether our
> >>>> qemu-lite solution is suitable for upstream again? Many thanks!
> >>>
> >>> What caused a lot of discussion and held back progress was the approa=
ch
> >>> that was taken.  The basic philosophy seems to be bypassing or
> >>> special-casing components in order to avoid slow operations.  This
> >>> requires special QEMU, firmware, and/or guest kernel binaries and cau=
ses
> >>> extra work for the management stack, distributions, and testers.
> >>
> >> I think having a special firmware (be it qboot or a special-purpose
> >> SeaBIOS) is acceptable.
> >=20
> > The work Marc Mari Barcelo did in 2015 showed that SeaBIOS can boot
> > guests quickly.  The guest kernel was entered in <35 milliseconds
> > IIRC.  Why is special firmware necessary?
>=20
> I thought that wasn't the "conventional" SeaBIOS, but rather one with
> reduced configuration options, but I may be remembering wrong.

Marc didn't spend much time on optimizing SeaBIOS, he used the build
options that were suggested.  An extra flag can be added in
qemu_preinit() to skip slow init that's unnecessary on optimized
machines.  That would allow a single SeaBIOS binary to run both full and
lite systems.

Stefan

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaJsnNAAoJEJykq7OBq3PI5QIH/315micZ0b9vrbuBdNYnYM/U
jBu6t8BCd+1RUlT+Zib0z5rdPJFY8xKaebUTabOd4plFUGzLOlZbgdv/jvaOUY5t
x9BbsmEiw5MSfi5PMIBZM+aucRNIbw+LHftRQKVG0+6r30QhQDVtRuU7cPMHz0se
Z79tsZ5L9cEgHIBaIByzKxOYN9Z1CSb/DleblxR+JN4jquHiO/1IE+uT/gA0RA/Q
SHgmMpNaGkxVOvXti5h/QIuII/mIo5LfkzHuOEhOxly37HNoyKqB3saVdCSJMFlR
N3lAa77Sa/l+68iRwFyldwxNI42ijm7+vtupSGddsSFrIZUB+gK3Um9SdMEoZuQ=
=w5Ym
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
