Received: from eggs.gnu.org ([2001:4830:134:3::10]:36369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLfF7-0008Dt-HC
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eLfF6-0000PV-8Q
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 20:08:21 -0500
Date: Mon, 4 Dec 2017 11:45:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171204004526.GE2130@umbus.fritz.box>
References: <20171130134159.9697-1-eblake@redhat.com>
	<20171130134159.9697-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phCU5ROyZO6kBE05"
Content-Disposition: inline
In-Reply-To: <20171130134159.9697-4-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/3] maint: Fix macros with
 broken 'do/while(0); ' usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-trivial@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alistair Francis <alistair@alistair23.me>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>, "open list:Xilinx Zynq" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:New World" <qemu-ppc@nongnu.org>, Igor Mammedov <imammedo@redhat.com>


--phCU5ROyZO6kBE05
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2017 at 07:41:59AM -0600, Eric Blake wrote:
> The point of writing a macro embedded in a 'do { ... } while (0)'
> loop is so that the macro can be used as a drop-in statement with
> the caller supplying the trailing ';'.  Although our coding style
> frowns on brace-less 'if':
>   if (cond)
>     statement;
>   else
>     something else;
> the use of do/while (0) in a macro is absolutely essential for the
> purpose of avoiding a syntax error on the 'else' - but it only works
> if there is no trailing ';' in the macro (as the ';' in the code
> calling the macro would then be a second statement and cause the
> 'else' to not pair to the 'if').
>=20
> Many of the places touched in this code are examples of the ugly
> bit-rotting debug print statements; cleaning those up is left as
> a bite-sized task for another day.
>=20
> Found mechanically via: $ git grep -B1 'while (0);' | grep -A1 \\\\
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>

ppc related portions

Acked-by: David Gibson <david@gibson.dropbear.id.au>

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--phCU5ROyZO6kBE05
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlokmqYACgkQbDjKyiDZ
s5JlyRAAmG2FNrMuFZQkEx6DIjE6ZBj9SOYXPPwhesK5z/9JLbRDW9S0dmqWJg7a
XvPXWaKVKox1Rt7ikCIVKgaCepwQT+mQjbA5god5D+KqdTRj2cLGAGaceKK987c1
8WIMUTv4QLGQkxvZvhUsyCUFg3VBBIFR3xdKxMArSb+4zNwN3IBh6+yYPFrOwsg6
CxjxQ1mioi64Ucp94MuExQ62RxDO4TJ/0uKExhNsYhYSpPYpenNVxIrhqjNshbOD
PR3i7nSDU8Ip49E+AN9CaTAJ8kX8eGK6u7024gMXfvpAWOvuo/u4i+4EMAXkWrcP
IWpevm/F53+T1zOKNSCm9R4KMw4d0cGz+FV5U7HmE7H6C+OzuSx5KpLa6p3XKN5i
wPsco9WeHihaza6hnDVoF/Xqmmzq12NtU3CAsF+cmCTn84NY5stpLJQBdYo3qK+w
z4kX2zwIniENUEbdNqn/bOgd/vRcea1wWMSnlZTpr1PyvVRRBLtgxsZ2mp6h1t9t
IPmN5XwDyko3IxZ87jUgzOmoeLnVVnNe/5DiFtUMdUhACfGflXd8Xq2pww3WP48z
mujpyWwub7tmt4vkhP2p5iS5ea/THuFp/dP05ji32RUcdAAIfrKbKWv0WFB4y4u2
qdhceKxte/9X7DUa7QKfO3JW8sGtz+wxExQpVupbogqivvL/hZk=
=+q/8
-----END PGP SIGNATURE-----

--phCU5ROyZO6kBE05--
