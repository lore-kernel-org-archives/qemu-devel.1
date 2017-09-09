Received: from eggs.gnu.org ([2001:4830:134:3::10]:58749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqa7K-0000Vp-U3
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 03:23:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqa7J-0005gB-St
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 03:23:50 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:44011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1dqa7J-0005f4-4O
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 03:23:49 -0400
Date: Sat, 9 Sep 2017 17:18:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170909071846.GU2735@umbus.fritz.box>
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-3-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hLTC+yGFJlatjToQ"
Content-Disposition: inline
In-Reply-To: <20170907092010.3605-3-aik@ozlabs.ru>
Subject: Re: [Qemu-devel] [RFC PATCH qemu 2/4] memory: Prepare for shared
 flat views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>


--hLTC+yGFJlatjToQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 07:20:08PM +1000, Alexey Kardashevskiy wrote:
> We are going to share flat views and dispatch trees between address
> spaces. This moves bits around but no change in behaviour is expected
> here. The following patch will implement sharing.
>=20
> This switches from AddressSpace to AddressSpaceDispatch as in many
> places this is what is used actually. Also, since multiple address
> spaces will be sharing a flat view, MemoryRegionSection cannot store
> the address space pointer, this changes it to AddressSpaceDispatch
> as well. As a not very obvious result, IOMMUTLBEntry also switched
> from AddressSpace to AddressSpaceDispatch to make
> address_space_get_iotlb_entry() work.

So, mostly this seems to be exposing AddressSpaceDispatch in more
places.  It's not obvious to me why that's useful.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--hLTC+yGFJlatjToQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmzldMACgkQbDjKyiDZ
s5KEkw/7B8JgZwmk1+kJRE8GTeRv304pjWj/x4eOG+ZHAd/fW6PlSsnYke/EmChp
tVy8QZnmxxYD+H7HbfcNxjzH7y2w5Fg6Nh9JfE9HShzofeVAdH3zQDykQck9mvAP
/hOECurudw7+5UGJKPd3HyTEfZ6bYmIevOBvE5t9r6tbm8tRlin0PiAM3+5oFkHU
c3uy+Y/JoGWyaS36x04pZKgx3NuBEbx3RftAXMJgpz0JjT1UOJUmkfzdEpkQ09Bd
lsykWcN0Oq2EbqbQA0RdJ8TQGP6hIzbI3UE/vKhXYuwmtXyFHq35zhEroRivResX
f6MhPeR7jQYJYOxeo+/3cvecEqT9650p66XddP3dCTNZqNF3lPQO1svocDqhKdHN
dKxxKO9Bnd+mNyodBvLKyLzO4rJ4ZDLMuanwj27xxBilGI+a/oxDeh6kC4nIiRG7
UW87hzZnD/kU9yiE96z4HKjO+9nuoIHiD0N+4oRLy/qapIq2NGBhv1wQ571R2l5i
NBV02XCREeCeOKmDm8fT2qARFWDOZbT4NOnGNSpKphJyJ2+ecEmFWLckKL05jRii
PxOayHPuknHpR3ERLlVQJwa1RhQnrFBSAFohlzE8tz/LZqVqBzbpCcnaHd+7uaKc
Wee5N83wUbsm5fNQYDIaNTaRzZ3pXj06gFpWDeqZalfSwA+aNBU=
=ntR0
-----END PGP SIGNATURE-----

--hLTC+yGFJlatjToQ--
