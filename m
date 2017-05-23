Received: from eggs.gnu.org ([2001:4830:134:3::10]:51864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leo@gaspard.io>) id 1dDIme-0002A1-Ge
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:00:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leo@gaspard.io>) id 1dDImY-0007iq-Lq
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:00:08 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:32633
	helo=smtp.smtpout.orange.fr)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leo@gaspard.io>) id 1dDImY-0007EV-59
	for qemu-devel@nongnu.org; Tue, 23 May 2017 19:00:02 -0400
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
From: Leo Gaspard <leo@gaspard.io>
Message-ID: <c3f72497-76d9-7400-d701-0a6446463600@gaspard.io>
Date: Wed, 24 May 2017 00:59:29 +0200
MIME-Version: 1.0
In-Reply-To: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="qG89tMlNQ7oaoawuOF5gpRKdxHlL1OMhk"
Subject: Re: [Qemu-devel] [PATCH v2 0/4] 9pfs: local: fix metadata of
 mapped-file security mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qG89tMlNQ7oaoawuOF5gpRKdxHlL1OMhk
From: Leo Gaspard <leo@gaspard.io>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>
Message-ID: <c3f72497-76d9-7400-d701-0a6446463600@gaspard.io>
Subject: Re: [PATCH v2 0/4] 9pfs: local: fix metadata of mapped-file security
 mode
References: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <149554993519.23396.2947622015408783770.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 04:32 PM, Greg Kurz wrote:
> v2: - posted patch for CVE-2017-7493 separately
>     - other changes available in each patch changelog
>=20
> Leo,
>=20
> If you find time to test this series, I'll gladly add your Tested-by: t=
o
> it before merging.

Just tested with a base of 2.9.0 with patches [1] [2] (from my
distribution), [3] (required to apply cleanly) and this patchset.

Things appear to work as expected, and .virtfs_metadata{,_root} appear
to be neither readable nor writable by any user.

That said, one thing still bothering me with the fix in [3] is that it
still "leaks" the host's uid/gid to the guest when a corresponding file
in .virtfs_metadata is not present (while I'd have expected it to appear
as root:root in the guest), but that's a separate issue, and I guess
retro-compatibility prevents any fixing it.

Thanks for these patches!
Leo


[1]
https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/virtualiza=
tion/qemu/force-uid0-on-9p.patch

[2]
https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/virtualiza=
tion/qemu/no-etc-install.patch

[3] https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg03663.html


--qG89tMlNQ7oaoawuOF5gpRKdxHlL1OMhk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEplquSIS+CbvsrRWvilWEi2CQ+c8FAlkkvtEACgkQilWEi2CQ
+c8SjQv9EpshJZHZA/mBEo7nhcc4CbohjhIcNOUPtTUTUCUCFkz7sPUH7efV2HCE
jTLIWRHDl4+dr5NJcJVvSvo/K4kRfv07zSyz96xrQq82DyfzHndvdN7f9exV1PH1
4D10LFh24frPMtGvd+Mb/GQDa1oB1ceQRrw1iwGIdtMsEp8ROAnzyqZdlhu0mo4x
6UPnenQ9yhiiLYNFQHru4Wh18AUBDSmDbWf18nLBHq1f7FYShWOSfpYp8yNSUGxn
NkUJEsUB++70OBAc/77KLiJgDjcmvjaKTHX5myCMJWXdhDu19iNWGHL9pJs82QhA
NO0hu1I6L57YLc6EUS5+LcE8hBxGqvH7j3TQaQwqYNtzJTv4zSPUh5fEmaHm7qLd
FV4q6h4V2vDnJHU5xKPH9YM1qR3mITTiow8mIW//t9ObpoXDOSqiMSOCPzW5tQxn
XWyImeAe5ICpenJrtpyLBKNztdnHLBf3LXMJlBK9LtXQS4glTLKGi+I/KWcm3rwv
pTGEGKiU
=hNof
-----END PGP SIGNATURE-----

--qG89tMlNQ7oaoawuOF5gpRKdxHlL1OMhk--
