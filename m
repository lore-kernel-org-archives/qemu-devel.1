Received: from eggs.gnu.org ([2001:4830:134:3::10]:51862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAEyK-0007a3-4M
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAEyG-0003DG-Ux
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:19:32 -0400
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:50193)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAEyG-0003Ct-O8
	for qemu-devel@nongnu.org; Mon, 15 May 2017 08:19:28 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 791BB1F9F8
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 14:19:27 +0200 (CEST)
Date: Mon, 15 May 2017 14:19:20 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170515141910.4e80fd7a@bahia>
In-Reply-To: <149485041417.489.11034345945561703613@c05f1edc8ed1>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149485041417.489.11034345945561703613@c05f1edc8ed1>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/FU._8H/xLRa1OVMCvT7ACMO";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 0/6] spapr/xics: fix migration of older
 machine types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, clg@kaod.org, bharata@linux.vnet.ibm.com

--Sig_/FU._8H/xLRa1OVMCvT7ACMO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 15 May 2017 05:13:34 -0700 (PDT)
no-reply@patchew.org wrote:

> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Subject: [Qemu-devel] [PATCH 0/6] spapr/xics: fix migration of older mach=
ine types
> Message-id: 149484833874.20089.4164801378197848306.stgit@bahia.lan
> Type: series
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
>=20
> BASE=3Dbase
> n=3D1
> total=3D$(git log --oneline $BASE.. | wc -l)
> failed=3D0
>=20
> git config --local diff.renamelimit 0
> git config --local diff.renames True
>=20
> commits=3D"$(git log --format=3D%H --reverse $BASE..)"
> for c in $commits; do
>     echo "Checking PATCH $n/$total: $(git log -n 1 --format=3D%s $c)..."
>     if ! git show $c --format=3Demail | ./scripts/checkpatch.pl --mailbac=
k -; then
>         failed=3D1
>         echo
>     fi
>     n=3D$((n+1))
> done
>=20
> exit $failed
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  - [tag update]      patchew/149484833874.20089.4164801378197848306.stgit=
@bahia.lan -> patchew/149484833874.20089.4164801378197848306.stgit@bahia.lan
> Switched to a new branch 'test'
> 3c3824a spapr: fix migration of ICP objects from/to older QEMU
> 280164f spapr-cpu-core: release ICP object when realization fails
> 5bc72eb spapr: sanitize error handling in spapr_ics_create()
> fa15d00 spapr: fix error reporting in xics_system_init()
> ecbe234 spapr: fix error path of required kernel-irqchip
> b7cf73d ppc/xics: simplify prototype of xics_spapr_init()
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/6: ppc/xics: simplify prototype of xics_spapr_init()...
> Checking PATCH 2/6: spapr: fix error path of required kernel-irqchip...
> Checking PATCH 3/6: spapr: fix error reporting in xics_system_init()...
> Checking PATCH 4/6: spapr: sanitize error handling in spapr_ics_create().=
..
> Checking PATCH 5/6: spapr-cpu-core: release ICP object when realization f=
ails...
> Checking PATCH 6/6: spapr: fix migration of ICP objects from/to older QEM=
U...
> ERROR: "foo* bar" should be "foo *bar"
> #50: FILE: hw/ppc/spapr.c:167:
> +            void* obj =3D &spapr->legacy_icps[i];
>=20

Oops, I'll fix that.

> total: 1 errors, 0 warnings, 122 lines checked
>=20
> Your patch has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org

--Sig_/FU._8H/xLRa1OVMCvT7ACMO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkZnMgACgkQAvw66wEB28KjjgCcD0Zac+7gWSxb3D+6XZRVv+9w
Jg8AmwUvE9tSH0iF7WwOlLQAdKQjfNDb
=2qsa
-----END PGP SIGNATURE-----

--Sig_/FU._8H/xLRa1OVMCvT7ACMO--
