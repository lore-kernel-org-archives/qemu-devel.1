Received: from eggs.gnu.org ([2001:4830:134:3::10]:34746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHHRB-0006sJ-Py
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:50:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cHHR7-0001zf-Q5
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 16:50:09 -0500
Date: Wed, 14 Dec 2016 17:12:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161214061201.GH32647@umbus>
References: <20161212040603.27295-1-david@gibson.dropbear.id.au>
	<20161212040603.27295-3-david@gibson.dropbear.id.au>
	<4431c63f-7ecc-d38b-df05-a428c0b98a63@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RwGu8mu1E+uYXPWP"
Content-Disposition: inline
In-Reply-To: <4431c63f-7ecc-d38b-df05-a428c0b98a63@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 2/5] pseries: Stubs for HPT resizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: paulus@samba.org, sjitindarsingh@gmail.com, agraf@suse.de, mdroth@linux.vnet.ibm.com, thuth@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--RwGu8mu1E+uYXPWP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 03:29:05PM +0100, Laurent Vivier wrote:
>=20
>=20
> On 12/12/2016 05:06, David Gibson wrote:
> > This introduces stub implementations of the H_RESIZE_HPT_PREPARE and
> > H_RESIZE_HPT_COMMIT hypercalls which we hope to add in a PAPR
> > extension to allow run time resizing of a guest's hash page table.  It
> > also adds a new machine property for controlling whether this new
> > facility is available, and logic to check that against availability
> > with KVM (only supported with KVM PR for now).
> >=20
> > Finally, it adds a new string to the hypertas property in the device
> > tree, advertising to the guest the availability of the HPT resizing
> > hypercalls.  This is a tentative suggested value, and would need to be
> > standardized by PAPR before being merged.
>=20
> Could you explain somewhere what is the aim of the "flags" parameter?
> It could help to understand why we have it as it is not used.

It's mostly just there on the general principle that have some way of
extending is a good idea.

As an example of a possible extension, we could have a flag which
caused all the valid HPTEs to be rehashed, instead of just the bolted
ones - we'd need to do tests to see if that was worthwhile (probably a
tradeoff between commit downtime and post-resize performance).

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--RwGu8mu1E+uYXPWP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUOKwAAoJEGw4ysog2bOSPgAQAJezTm175nVQpp7tPOOA7tTE
hGlN6Ix41DHGdNpwajctxLFYnb9tSS7baFcoGeB0fJxclvR3Oz5IPxLYPt1ttBRe
TUtRCa7Titdh1DidpbS8gzFcW8KpQ5adX0pJdNtHvGbXg0HavI1b6eIDcPcaJDXf
+ZE1Uib7ZC/mjVnrnlKosYSlKipjaY944UwoqUVQl27Knbzi4nSb0SQcQQJvA242
DTm/g/KsXmbeRzdKjLBpBdzdrj1T2pW0MWITv2l+1Q7z2bSwn9jdkjYU9atWxTwn
0jW1XoFxaKoxZvoNo0Uyia/ERONfX6YTOjfLXcgWGQDuWTkWk2+1wC3g4njiKZ8b
wOAQ9czGwuUQYevqLTeCITJC7HPissVd36dvEGo5xctaa0A+d0lA+OM11NjJ9WC1
vLgbIuoqVk7i1FxmhntbLPKC2EMjRH/G926FlvdIToa5SKQzUWg0+DfErQCEpgMU
YjXwsAVG9p8C0eR4GPbRox449AuQPj5Ty3/BxDNdwljKkB/YuwzMVIl9nUyedoLB
Ak0YpTXLl1Usr8ihnY9FJNJBysXq2OsX4hZrKaOOC38kEapZAgaftziVES6wPyJ+
ozm5WJYFMUlz/eUfMefEXfcHc6VwXUHj//qV9hyJLsLE3ZM8TPlWOOCOxdAONdwl
zKFcTysaezzhRy6aDhjy
=Bimc
-----END PGP SIGNATURE-----

--RwGu8mu1E+uYXPWP--
