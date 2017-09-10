Received: from eggs.gnu.org ([2001:4830:134:3::10]:56035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqwQM-0000km-5X
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 03:12:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqwQK-0000RE-Ve
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 03:12:58 -0400
Date: Sun, 10 Sep 2017 17:12:45 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170910071245.GB17405@umbus.fritz.box>
References: <150496954641.9654.1998704077006846521.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <150496954641.9654.1998704077006846521.stgit@bahia>
Subject: Re: [Qemu-devel] [PATCH 0/5] spapr_pci: various cleanups and
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 09, 2017 at 05:05:46PM +0200, Greg Kurz wrote:
> Before resuming the huge work on PHB hotplug, here are some patches
> that maybe worth to apply.
>=20
> Patches 1 to 3 are basic improvements.
>=20
> Patch 4 and 5 may be a bit controversial. Everywhere in the spapr
> code where we build an FDT portion, libfdt failures cause QEMU to
> exit, even on hotplug paths. Only spapr_pci doesn't do that and
> propagates the error instead. My understanding is that a failure
> when building the FDT is likely to happen because of a bug in QEMU.
>=20
> Hence the choice to convert spapr_pci to do like the others. We may
> even consider changing _FDT() to abort() instead of exit().
>=20
> Alternatively, if libfdt failures shouldn't be necessarily fatal,
> especially on post-realize paths, then we should probably introduce
> an _FDT_ERR() helper to propagate errors. And use it in may places
> where we currently terminate QEMU: memory hotplug, CPU hotplug, CAS,
> machine reset...

I've applied 4 & 5 as well now.  If I get to it, I hope to make them
obsolete by replacing most of the fdt wrangling with a qemu internal
live tree representation, but in the meantime it's still a reasonable
cleanup.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm05eoACgkQbDjKyiDZ
s5I6GQ/8D9VIVwGt19HTdQoQoWOFk3VDvQxsveyAl9+zicsu8XPzF1OInuw8XUiE
9tmFc5bXnEzKCotEPaGDmUGvBa/EfxxZPLRPPJxktG5qLFp6wbOgGCWTztSETsXD
DDbgoEBS1nWQ3Pt3dmTuYXI6eWFB5osDCtf1A6G2C1e7YCtEztuDaCWACfPG35Xk
4Fp/nqvtC/lvwSd/r2sSUpDr/Ig/hoio5Aj6CJ92/PblqcFyiqAsJ09ThlhPilwX
q4uHcDfNmlnumoy3gcn8u4cJPTurRYFEqOnyxRWxbDkD9ZsBEJ0MwZ7ipSVtSFTI
XmKlcRu1mipGVBJn7hKt6iw4OB4lxZv4VT2SCVr1iHUYkvxlofv5sgh1jxYRW4nS
EqzSb1lQwm3Cr6yc8TZAsYhZddE42318DmbtG9YXzx9L85paUObpOS/007jpAUzn
GeneNjWp5tRuF30AIuxS97uU6GVY6ZuKKMm4Se6SIUDc4+QAIZ4fsdxTAPHLndE4
zRIROukJE63aSJSNIcTF6vuvg04l+Yun7eloEExYxYrFDYwJEGvUYfFtnQFX3N2N
lFyFFzvmxIkOeZAKrtXN8Q4le6oJzbIDoc0olo4p1kybdG2oG48fR58UwGeI6cS8
zTKS+Fk2FhDIWjanQVe9dBzI47BUMSB6mhhfClBxMPyKosntqVA=
=DLxA
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
