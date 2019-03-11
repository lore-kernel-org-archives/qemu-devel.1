Received: from eggs.gnu.org ([209.51.188.92]:49699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1h3Rje-0000Lt-41
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:41:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1h3RUW-0005qC-MO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 16:25:45 -0400
Date: Mon, 11 Mar 2019 21:25:34 +0100
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20190311202534.GB21327@angien.pipo.sk>
References: <20190311165017.32247-1-kwolf@redhat.com>
	<20190311165017.32247-11-kwolf@redhat.com>
	<2f72f4e8-879a-62a5-d131-8c6562bd4043@redhat.com>
	<20190311195925.GA21327@angien.pipo.sk>
	<74cc34ed-a60b-75fd-3cf1-122ba485917e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <74cc34ed-a60b-75fd-3cf1-122ba485917e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/10] file-posix: Make auto-read-only
 dynamic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, mreitz@redhat.com, berto@igalia.com, qemu-devel@nongnu.org, "stefanha@redhat.com" <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2019 at 15:10:36 -0500, Eric Blake wrote:
> On 3/11/19 2:59 PM, Peter Krempa wrote:
>=20
> >> auto-read-only was introduced in 3.1, at which point we intentionally
> >> had sufficiently loose wording to permit (but not require) dynamic sta=
te
> >> checking; so you are not breaking the interface.  On the other hand, is
> >> libvirt going to have problems introspecting whether it can use
> >> auto-read-only and get the dynamic behavior it needs?  Or is there
> >> enough else in the way of libvirt's switch to -blockdev that it won't
> >> attempt anything that needs auto-read-only without other 4.0 interfaces
> >> anyway, at which point detecting the presence of the field (but not
> >> whether the field has a guarantee of dynamic behavior) on 3.1 doesn't
> >> matter?
> >=20
> > I think we can use Stefan's capability detection mechanism he introduced
> > for the migration with cache enabled for local files to add a flag for
> > this as well.
>=20
> Except I thought we decided that the most recent version of his QMP
> changes was now fully-introspectible, thanks to using conditional
> compilation.
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg02510.html

Oh, bummer, I missed that it was no longer needed. I still think it's
worth adding that for future use once it will be necessary to detect
that certain things were patched and require libvirt to change behaviour
if that's the case.

> Well, that may prove to be a short-lived hiatus, if libvirt would
> happily attempt to use qemu 3.1 and fail without some other
> introspectible hook to know whether auto-read-only has required semantics.
>=20
> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>=20




--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAlyGxDwACgkQHGwCByjY
1Gq31w/+MSEsSvfloUXWwOUtJCYrw0bGOerLFFoM/08T5L9G4wUUJOKPcqHePsWW
56OkeZDMYwTCq586Ybj0MoIgLbbVX6smKl+Wh9O44/IBVrK8dB2teX2qMKA90PoB
hy96D67o0qV83k7H5c/U25TNlniCSOlcj2k7pGkPbhu1dgiLjsieeFqEF2Z7I1kc
QQsg8VbF+HGf8/anvKMwDdRZQ+FOVNOltGlFzSTFrMnBSo15n04H/+L8Z8syPCdC
cRyewDlWC5HyLl/yvMlN+ELSBBEMKM1Kyi4gzCBb65ewxpDTL62GxIg8Vw2xB9pJ
54b2kkAa+k7VJ+IKJUDQaU5/0d7nPF1SYQvBviLq6GIV1QAqycRXxoAlMSV8STSr
HpNqWSAL3qjsH3+URgo7kW3r0YT7fl3t9w9ckyEtvgybX98YVrB/lTIFNsaFrNpR
t/Deavr4wm1iUjzPDopDVbqw5MRiOSL2NDHRz4/TbThV88MYoIzKbz/spA8hucNb
kqO539xxh/oy2+6O5R7AopQrAcW6e9KLTvXCb6+NJOWKK0nKu+RaLO4UaYnsY0ki
qS57Qt7eLVJkXCpNnQhxB4cjeIEwaKPU0tsgVQprLAkNLC4liPltRkmRe0aezAL1
GQd6oywELATb4JkLjBDFGqQClUZlbuljfh3zl6rjTHd5RXbCSoU=
=vp+5
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
