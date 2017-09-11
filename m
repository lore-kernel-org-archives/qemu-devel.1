Received: from eggs.gnu.org ([2001:4830:134:3::10]:41994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drMVp-0003qG-BZ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:04:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drMVj-0004vZ-KY
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:04:21 -0400
Received: from 17.mo1.mail-out.ovh.net ([87.98.179.142]:59892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drMVj-0004uS-Dw
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 07:04:15 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 6BA3493311
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 13:04:13 +0200 (CEST)
Date: Mon, 11 Sep 2017 13:04:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170911130408.3225bbbe@bahia.lan>
In-Reply-To: <150512506547.225.9476838140098482777@6d89bd104fc3>
References: <150512483616.8642.15831240906912354238.stgit@bahia.lan>
	<150512506547.225.9476838140098482777@6d89bd104fc3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/nZrH+iY3wyVoz5=wpPQOVkN";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 0/2] spapr_pci: some more cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

--Sig_/nZrH+iY3wyVoz5=wpPQOVkN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Sep 2017 03:17:45 -0700 (PDT)
no-reply@patchew.org wrote:

> Hi,
>=20
> This series seems to have some coding style problems. See output below for
> more information:
>=20
> Subject: [Qemu-devel] [PATCH 0/2] spapr_pci: some more cleanup
> Message-id: 150512483616.8642.15831240906912354238.stgit@bahia.lan
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
>  * [new tag]               patchew/150512483616.8642.15831240906912354238=
.stgit@bahia.lan -> patchew/150512483616.8642.15831240906912354238.stgit@ba=
hia.lan
> Switched to a new branch 'test'
> da1ec6583a spapr_pci: don't create 64-bit MMIO window if we don't need to
> f9e9150977 spapr_pci: convert sprintf() to g_strdup_printf()
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> Checking PATCH 1/2: spapr_pci: convert sprintf() to g_strdup_printf()...
> Checking PATCH 2/2: spapr_pci: don't create 64-bit MMIO window if we don'=
t need to...
> ERROR: spaces required around that '-' (ctx:VxV)
> #54: FILE: hw/ppc/spapr_pci.c:1650:
> +    if (sphb->mem64_win_pciaddr !=3D (hwaddr)-1) {
>                                             ^
>=20
> ERROR: spaces required around that '-' (ctx:VxV)
> #61: FILE: hw/ppc/spapr_pci.c:1657:
> +        if (sphb->mem64_win_addr !=3D (hwaddr)-1) {
>=20

False positive... Fixable with:

--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -213,6 +213,7 @@ our @typeList =3D (
        qr{${Ident}_handler},
        qr{${Ident}_handler_fn},
        qr{target_(?:u)?long},
+       qr{hwaddr},
 );
=20
 # This can be modified by sub possible.  Since it can be empty, be careful

                                             ^


>=20
> total: 2 errors, 0 warnings, 26 lines checked
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

--Sig_/nZrH+iY3wyVoz5=wpPQOVkN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbZtqAAKCRAC/DrrAQHb
woAbAJ4z/WVZbMR0Jy3+irboCvNCOxf2EwCfckJR0aC2Wf9jCqpQbxEFxkjS/uA=
=WpY/
-----END PGP SIGNATURE-----

--Sig_/nZrH+iY3wyVoz5=wpPQOVkN--
