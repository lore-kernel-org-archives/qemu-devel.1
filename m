Received: from eggs.gnu.org ([2001:4830:134:3::10]:58317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIlvz-00023q-9m
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dIlvu-0004bR-WE
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 21:08:23 -0400
Date: Thu, 8 Jun 2017 11:07:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170608010727.GN13397@umbus.fritz.box>
References: <20170607032018.19588-1-david@gibson.dropbear.id.au>
	<149687773632.5725.15561233501001316710@loki>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zfsaV+LVqEQKX7k4"
Content-Disposition: inline
In-Reply-To: <149687773632.5725.15561233501001316710@loki>
Subject: Re: [Qemu-devel] [PATCHv2 0/7] spapr: DRC cleanups (part III)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: bharata@linux.vnet.ibm.com, sursingh@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--zfsaV+LVqEQKX7k4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2017 at 06:22:16PM -0500, Michael Roth wrote:
> Quoting David Gibson (2017-06-06 22:20:11)
> > A third batch of cleanups to the DRC code.  This continues to clear
> > away relatively simple cruft, to get a clearer look at the fundamental
> > state handling.
> >=20
> > Changes since v1:
> >   * Some comment updates suggested by Mike Roth
> >   * Changed approach to the get_name cleanup, using generated on the
> >     fly names, instead of externally assigned names
> >   * Added in some cleanups to hotplug code in spapr_pci.c
>=20
> Series:
>=20
> Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> Acked-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Thanks.  Patches merged into ppc-for-2.10.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--zfsaV+LVqEQKX7k4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZOKNMAAoJEGw4ysog2bOSCcAQANUF69Q4TeuDjY2/WpyTcLPH
5JWQe14MpNTMhL0Njj8fFgL3nJyB+HkA/maWcyMtCrxEe9gByxVlI2Qp1srKGjmc
N5x8vUMw9vNz00c+O/l5lPRNJBx/3M8cov5OvB8qiMeQnVeapa8x5tSj1U5ANrXJ
MBw8ZGH9WkqmLEW0q78frudNZZcOg6W2m+q2xSmHyUbTQovS1+ZTLf/xUSMPnaf7
0RWaz0fCisEHf/29LoVYNyKY3J9/VaEQ8Gp9P7i83vxxevxCG3U0igUjqi9mLqgU
Wpzbes/s9yqzPb4QSwSLjWMKWT9fGH+B46t6PlnaPu3TxMnfjQDorZhmJW8+EZld
x8khcOHYZZ7ZN22fljvsVTP+YlX9tbn3ElU+SdERWBsHJqLRPTTQwA/FMDTZQvN1
z31ONno40yyNTgHUP2cDBEkkuf9eXqV1HzrNOKGqp2/R53acqxImwfQH3WOpyYKa
sUdy111TKDHTHwxFEe5S2QOUWJa0CQh+4RmNIMZ/Js8ZVP2QIJWP8yifyvDGATT8
XSaObPMe2Lzlr8Odz3Z6piCIZP5nwsW3x0kLPcJaW3uhTuZiXbtvwiQ604xzZYav
jiJ4el9jQDdEpFy153SYg1UDcLqe2pwLawDjGG2ruLpeZU2X5deiV9LPddLwpLP9
0QOr+ecbFl7QhBMZW9GS
=P+qH
-----END PGP SIGNATURE-----

--zfsaV+LVqEQKX7k4--
