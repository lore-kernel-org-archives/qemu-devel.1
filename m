Received: from eggs.gnu.org ([2001:4830:134:3::10]:50081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1coq4U-00011R-1B
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1coq4Q-0001nD-SO
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:29:26 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:48380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1coq4Q-0001mb-Lh
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 07:29:22 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 25A481BACD
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 12:29:21 +0100 (CET)
Date: Fri, 17 Mar 2017 12:29:16 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170317122916.03be91fc@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <148974755554.99.94270344831504864@6c512846dbc7>
References: <148974701986.29545.5414999102981738774.stgit@bahia>
	<148974755554.99.94270344831504864@6c512846dbc7>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/VE4y_Iha4hw_J/R9DlEFgDQ";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: allow longer lines for logging
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com

--Sig_/VE4y_Iha4hw_J/R9DlEFgDQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Mar 2017 03:45:56 -0700 (PDT)
no-reply@patchew.org wrote:

> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Message-id: 148974701986.29545.5414999102981738774.stgit@bahia
> Subject: [Qemu-devel] [PATCH] checkpatch: allow longer lines for logging =
functions
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
> # Useful git options
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
>  * [new tag]         patchew/148974701986.29545.5414999102981738774.stgit=
@bahia -> patchew/148974701986.29545.5414999102981738774.stgit@bahia
>  * [new tag]         patchew/148974744281.30636.17973264008285415592.stgi=
t@bahia -> patchew/148974744281.30636.17973264008285415592.stgit@bahia
> Switched to a new branch 'test'
> 390d7c4 checkpatch: allow longer lines for logging functions
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/1: checkpatch: allow longer lines for logging functions.=
..
> ERROR: line over 90 characters

Ha ha ! Should checkpatch allow long regexp lines in itself ? ;)

> #38: FILE: scripts/checkpatch.pl:1349:
> +		    !($line =3D~ /^\+\s*$logFunctions\s*\(\s*(?:([^"]*))?"[X\t]*"\s*(?=
:,|\)\s*;)\s*$/ ||
>=20
> total: 1 errors, 0 warnings, 20 lines checked
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

--Sig_/VE4y_Iha4hw_J/R9DlEFgDQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljLyIwACgkQAvw66wEB28JnMwCfR2xHqiBjpQs40SqmAHooidbe
CGkAmwTTU+yjjeMsqmaAjmn6VsHAPEjm
=seC8
-----END PGP SIGNATURE-----

--Sig_/VE4y_Iha4hw_J/R9DlEFgDQ--
