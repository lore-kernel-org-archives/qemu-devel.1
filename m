Received: from eggs.gnu.org ([2001:4830:134:3::10]:39683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e5M0x-0001AB-TO
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:22:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e5M0w-00051y-U9
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:22:19 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:48301)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1e5M0w-0004zw-IS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 21:22:18 -0400
Date: Fri, 20 Oct 2017 12:21:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171020012130.GG13245@umbus>
References: <1508170976-96869-1-git-send-email-imammedo@redhat.com>
	<20171016163636.GI11975@redhat.com>
	<20171017092702.5b82103b@nial.brq.redhat.com>
	<20171017150759.GB31897@redhat.com>
	<20171017180635.6a900616@nial.brq.redhat.com>
	<20171018153010.GL9719@redhat.com>
	<20171018202240.GD2942@localhost.localdomain>
	<20171019114954.GC13245@umbus>
	<58846850-bbe2-e1c4-2235-58b3f6709ba6@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
In-Reply-To: <58846850-bbe2-e1c4-2235-58b3f6709ba6@redhat.com>
Subject: Re: [Qemu-devel] [RFC 0/6] enable numa configuration before
 machine_init() from HMP/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, peter.maydell@linaro.org, pkrempa@redhat.com, cohuck@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2017 at 02:23:04PM +0200, Paolo Bonzini wrote:
> On 19/10/2017 13:49, David Gibson wrote:
> > Note that describing socket/core/thread tuples as arch independent (or
> > even machine independent) is.. debatable.  I mean it's flexible enough
> > that most platforms can be fit to that scheme without too much
> > straining.  But, there's no arch independent way of defining what each
> > level means in terms of its properties.
> >=20
> > So, for example, on spapr - being paravirt - there's no real
> > distinction between cores and sockets, how you divide them up is
> > completely arbitrary.
>=20
> Same on x86, actually.
>=20
> It's _common_ that cores on the same socket share L3 cache and that a
> socket spans an integer number of NUMA nodes, but it doesn't have to be
> that way.
>=20
> QEMU currently enforces the former (if it tells the guest at all that
> there is an L3 cache), but not the latter.

Ok.  Correct me if I'm wrong, but doesn't ACPI describe the NUMA
architecture in terms of this thread/core/socket heirarchy?  That's
not true for PAPR, where the NUMA topology is described in an
independent set of (potentially arbitrarily nested) nodes.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnpT5oACgkQbDjKyiDZ
s5IKRhAAvRd8XlNBed63GzKSYXZUgKrHPxpyI7xQMmc36zAkXE4gXsaaQNsr37pl
m5ADtv+nfjU9Gkv344VQfim2Fb7+UoeTQOCnSZC1gX2mu1A5O3uXPaiNYE4JaBd5
uJf4vE8kFziBDUVPkXYCZEEuFdKMPRo3i3YHSTESvrpBSrSPzfXVYs5g94EaRJ7L
HC4Ft3KNe2SM3FYhS1BGGUmTc7LbM5No2Ofg8boI8wdNnsD4A5wrKqYr3opvjkXH
Lx+iNuimDSnbFzH0DB/dy4SsbypwifqhyEfy3+SOwOQ9qBjDSLCIZkNL87y5Av1A
MRLSkAv7rYxLu1PEyg+CTGNbGFq+99/JC+GDe2rwZfnK6731s8aIZpyOVZ0uPRG5
xcfv6zSIm28WySMJEFUhyKbfTkmlwWCd4V7y+mhraXqqDNkhI8rL5UlXuOT1a5JL
J1PncA3vnpRfyCa/Pfo1aQqXwcxdW2Nm/hM/R893EsJcTkgGqThl5VVVC7uG74d1
lPEaZ1c7MsZGgv6wvL2WyYKBvcOlpWbp+K84hNRl4TYdAPWZ+XYnE/rBmLTQofV5
jS+iqFtliZJIi3/V6dqIbTrElRC3pQxIiQjnXYRxuTizM04i0ySg57RCA25b1400
U+FSKfxFkqPS84cnFZUiqYkng2t38u3J73zEAhkUZuGfkcdZkU4=
=AFx1
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
