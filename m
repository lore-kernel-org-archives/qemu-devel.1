Received: from eggs.gnu.org ([2001:4830:134:3::10]:53687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leo@gaspard.io>) id 1dDIvJ-0003o6-S2
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:09:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leo@gaspard.io>) id 1dDIvG-0002h2-Ms
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:09:05 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:53911
	helo=smtp.smtpout.orange.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leo@gaspard.io>) id 1dDIvG-0002fJ-55
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:09:02 -0400
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<149554996230.23396.14573553304393992709.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<5222368e-d0de-457b-7f07-5f104860ec56@redhat.com>
From: Leo Gaspard <leo@gaspard.io>
Message-ID: <d74d2235-97e8-e529-9bf7-3e5c7b09830b@gaspard.io>
Date: Wed, 24 May 2017 01:08:55 +0200
MIME-Version: 1.0
In-Reply-To: <5222368e-d0de-457b-7f07-5f104860ec56@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SaOXWPWw8tBs1f1wRI2qIh0bMd5MvKxKH"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] 9pfs: local: metadata file for the
 VirtFS root
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SaOXWPWw8tBs1f1wRI2qIh0bMd5MvKxKH
From: Leo Gaspard <leo@gaspard.io>
To: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>,
 qemu-devel@nongnu.org
Message-ID: <d74d2235-97e8-e529-9bf7-3e5c7b09830b@gaspard.io>
Subject: Re: [PATCH v2 4/4] 9pfs: local: metadata file for the VirtFS root
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <149554996230.23396.14573553304393992709.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
 <5222368e-d0de-457b-7f07-5f104860ec56@redhat.com>
In-Reply-To: <5222368e-d0de-457b-7f07-5f104860ec56@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 07:13 PM, Eric Blake wrote:> We have to block
VIRTFS_META_DIR at any depth in the hierarchy, but
> can/should we change the blocking of VIRTFS_META_ROOT_FILE to only
> happen at the root directory, rather than at all directories?  On the
> other hand, if you can simultaneously map /path/to/a for one mount
> point, and /path/to/a/b for another, then the root file for B is visibl=
e
> at a lower depth than the root file for A, and blocking the metafile
> name everywhere means that the mount A can't influence the behavior on
> the mount for B.

If you take this kind of vulnerabilities into account, then you also
have to consider a mix of mapped-file and mapped-attr mounts, or even
worse a proxy with a mapped-file mount (which I think is currently
vulnerable to this threat if the "proxy" path points above the
"local,security_model=3Dmapped-file" path, as the check is done in
"local_" functions, which are I guess not used for proxy-type virtfs)

I'm clearly not saying it's an invalid attack (there is no explicit
documentation stating it's insecure to "nest" virtual mounts"), just
saying it's a much larger attack surface than one internal to virtfs
mapped-file only. Then the question of what is reasonably possible to
forbid to the user arises, and that's not one I could answer.

Cheers & HTH,
Leo


--SaOXWPWw8tBs1f1wRI2qIh0bMd5MvKxKH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEplquSIS+CbvsrRWvilWEi2CQ+c8FAlkkwQcACgkQilWEi2CQ
+c+lggwA1Ld4yrydmx6R/C43Z/veFg48Yl1hVWr03qC2hsNMKmXvzf2QcKUOAq3h
FMKd54E3wEprmBQyZmcw0STEUChEqdmigkyz4m/rsxpaJf9WU9jzSeGJ5ixqLQAk
9yf2dUiKePf4Mn2epP0M9UxNdHF3Is1txrW8hkxlHGONYld1TmUVV6t/4e2XDY/G
zgIYmyKkwEfp2Bm967uyVaFiRnuqhl7l5P7YKHfBOerzznDu5+KQyfVytHqKeG+F
zMkLN8Qp72f0qAD84xgL0850CEodxG3XhbYr64sFTLMImON7TnQXPwC3gT7jJm9y
gEHS9SfBjQ/hnshQwmcCU9ywyEJNRtzigxBFnldjwT4BS/iX5XlMzP0gd+YR6Oty
W/5DhCm1dh66fwjgk25Q3WJGvniqssto/nEjkyC3PCoYyEAXpu3ja8M0pBj5nndF
xWFVItyMd7dBzOYDgR9M0/MmeIPWhOFUwT90dp2vh+TXET4odjQ8XfgN+zaGAp03
ifvt5roa
=FEDD
-----END PGP SIGNATURE-----

--SaOXWPWw8tBs1f1wRI2qIh0bMd5MvKxKH--
