Received: from eggs.gnu.org ([2001:4830:134:3::10]:49562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZBwk-0002iF-F5
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZBwi-0006Fj-T2
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:45:50 -0500
Date: Tue, 18 Dec 2018 20:36:32 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181218093632.GK23604@umbus.fritz.box>
References: <20181217223445.28594-1-clg@kaod.org>
	<20181217223445.28594-3-clg@kaod.org>
	<20181218022339.GD23604@umbus.fritz.box>
	<e441c825-ed91-0c36-f319-9e1a473ff2cb@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cy+5HEalSgyXkpVS"
Content-Disposition: inline
In-Reply-To: <e441c825-ed91-0c36-f319-9e1a473ff2cb@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v9 2/7] target/ppc: replace
 __builtin_ffssl() by the equivalent ctz routines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--Cy+5HEalSgyXkpVS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 09:07:47AM +0100, C=E9dric Le Goater wrote:
> On 12/18/18 3:23 AM, David Gibson wrote:
> > On Mon, Dec 17, 2018 at 11:34:40PM +0100, C=E9dric Le Goater wrote:
> >> And remove the intermediate MASK_TO_LSH macro which does not add any v=
alue.
> >>
> >> This fixes a compile breakage on windows.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > It's an improvement over what's there, but it still leaves macros
> > whose primary use would be for guest registers, but are typed
> > according to host values, which doesn't make much sense.
> >=20
> > I think instead we should redefine your BE64 / BE32 variants in terms
> > of the existing extract*() and deposit*() primitives, and get rid of
> > the GETFIELD / SETFIELD macros.
>=20
> I will get rid of the GETFIELD/SETFIELD macros and rewrite the BE64/BE32=
=20
> variants but I won't use the extract*() and deposit*(). I prefer to keep
> the same pattern, which is similar to shpc_get/set_status(). I will make=
=20
> the code clearer with static inlines.

That's fine.

> I don't really like the names also. what about
> xive_(get/set)_field(32/64) ?

Sure, works for me.  Since these will now be strictly fixed width, you
can probably make them inlines instead of macros too, so we get type
checking.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Cy+5HEalSgyXkpVS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwYv54ACgkQbDjKyiDZ
s5I9ABAA3ur9tm7Vkb8xVWs4hGEVeqaZNxPNfjJffT4DfBoVy/ogucOAtU//neCl
8nQgej2TcKsjUj5KK9vbqIIi7Hg3+z/Xswc0E1SsSfRNJUg8cVvDxM7WMppXJwjQ
bXh4XNbTCDGiBQASg9uGDtp30pORWkSaiIAiShnRmtZvLChVb1rcmXfqGn8eFqDJ
qLUqJqLqGUiw0iLOTYvlzN6VJ/Fbr1zUAWxux3LeqZXYXKIPgkhAbtlIzRdDcsoq
JSZHwoCpGA157zR2attaeiMbwUMZdD/gmPkhqDotwLgGjbYu7evDRU9BtNsiY0fm
7lPRbmGZvsInXedTeWDxeiBdHNz3DT0BRNmo0YS/XpsTsDASF7XdRNOMPQnwb5EI
TIbDB7QRddwesVAkeq/b6JIt9SaELw8FFRBYZPpb/fHNl+Vu9X3RwXFZ+AjHbwGj
yI55ndfmeCHXvX3kh6+klspVg1QimXuPpsabUlFjjyfT/w/5RdAwFam7yGo+cCcZ
AfmhG0ya5BfRYJNLrc3rsJiDIR3W7k2CnKZ2THxcxorKNByLOY2oobvwI/7h3kkT
WUnumRdUpsWfqxj9/aVKUhz0B3oTkXu5F+lchCcsYOgKtSyxShi0T9j2YqNO3lDU
AStWqlp7zSXwQza0vDkMDqrjpAF6ePitiSVBtnXc0jgFNDtQKP0=
=5Db8
-----END PGP SIGNATURE-----

--Cy+5HEalSgyXkpVS--
