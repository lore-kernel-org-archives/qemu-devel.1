Received: from eggs.gnu.org ([2001:4830:134:3::10]:57435)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds0L9-0005kJ-K4
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 01:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds0L8-0004Ow-KN
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 01:35:59 -0400
Date: Wed, 13 Sep 2017 15:34:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913053436.GE7550@umbus.fritz.box>
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912164644.2a0b6977@bahia.lan>
	<6198350f-a694-cf1b-ec00-4c42ccce39a6@redhat.com>
	<20170912153630.GC2225@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
In-Reply-To: <20170912153630.GC2225@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] hmp: fix "dump-quest-memory"
 segfault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, ehabkost@redhat.com


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 04:36:30PM +0100, Dr. David Alan Gilbert wrote:
> * Thomas Huth (thuth@redhat.com) wrote:
> > On 12.09.2017 16:46, Greg Kurz wrote:
> > > On Tue, 12 Sep 2017 16:01:46 +0200
> > > Laurent Vivier <lvivier@redhat.com> wrote:
> > >=20
> > >> Fix aarch64 and ppc when dump-guest-memory is
> > >> used with none machine type and no CPU.
> > >>
> > >> The other machine types don't have the problem.
> > >>
> > >> Update test-hmp, to test none machine type
> > >> with (2 MB) and without memory, and add a test
> > >> to test dump-quest-memory without filter parameters
> > >> (it needs the fix from Cornelia Huck to work)
> > >>
> > >> v3:
> > >>   - remove blank line after a comment
> > >>   - forbid memory dump when there is no CPU
> > >>
> > >=20
> > > So in the end, we would forbid dump on aarch64 and
> > > ppc, while it is allowed on i386... I don't really
> > > care about which behavior is more appropriate but
> > > I guess they should be consistent at least.
> >=20
> > It's kind of consistent: Allow it on architectures with fixed endianess,
> > but disallow it on architectures without fixed endianess ;-)
>=20
> Another way to put it is that you can dump unless you need
> information about the CPU.
>=20
> It also makes me wonder what happens on those CPUs that can
> change their endianness dynamically.

We already have code for that on ppc, we actually look in on the CPU's
mode register at dump time to decide which.  Theoretically that could
still be tricked, but in the almost-always case of boot an OS which
sets the endianness then leaves it there, it should be fine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm4w2kACgkQbDjKyiDZ
s5IbOBAAu1WdgmLUwkUkOXwdzzpdBYR9AIUZmRe0DATQhPWiaEBbDJxA70EtKRj2
4+1AdvVzhP1oIcmVUr1sEy/WQHscccGJOrOT74G0Y5wdKfrnMd/0LiIIPHo2tDhz
4R1xjSwGBm2zbk4EZN641y5op+9Ihv2ejKkIc6DengXh5+yjKbN42W4Wxa65U9Xc
qsHvrVSEMbjejlA/2RDa01Ifc5p8pZ0tRgNZj3Lt4W6tmKkw55AjpAuptL2ITf0O
ldSRWuxIXv703lX41jtZOv6VT4Et5SO0UUmirt52psEOvz/xjFOwL/hA6GNqAOPL
/Iy24c6k4USugyvyRy/z8Z4ngkXZdJkl3HV75OldnTtZCYDSW1PhxIdvowNGXRnE
UoHfuGs+jjpkzyKRBItHcgyxR0A2QP0dEWABxpsVIKW5Xpmg4yUIMcCR81YBMhPx
jP4T6IfFcqSS1fSxXHYfGY0Ab81MtDvt1Ob53FVm2TtzS/0uN76PLzMZGDUYbnjz
G1/56aBGZHlZBl+XzQgiSYhCBTCHnjTEWUCMssnC7MQbO4L1DleFRBrV8MwNqmm7
/BSmCxTHPz2yWue789dFAXL4Mxm9wUqSGkUaEcWTWDBpS1VM83LA5vkqpQEXNwjz
vj4xngANVrfyvznseUwDk9uhXLyBmAyP/dsIvEjU+b2wr8UYh2g=
=Vapc
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
