Received: from eggs.gnu.org ([2001:4830:134:3::10]:34868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1euFAK-0008Ek-7s
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:22:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1euFAG-0008Kn-8n
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:22:20 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42610 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1euFAG-0008KI-36
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:22:16 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5672D8D6D7
	for <qemu-devel@nongnu.org>; Fri,  9 Mar 2018 10:22:11 +0000 (UTC)
Date: Fri, 9 Mar 2018 10:22:04 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180309102204.GD9668@stefanha-x1.localdomain>
References: <20180308155524.5082-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <20180308155524.5082-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Avoid QEMU specific types in trace
 probes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 08, 2018 at 03:55:22PM +0000, Daniel P. Berrang=E9 wrote:
> Changed in v2:
>=20
>  - Split into 2 patches
>  - Added ptrdiff_t type to whitelist
>=20
> Daniel P. Berrang=E9 (2):
>   trace: remove use of QEMU specific types from trace probes
>   trace: only permit standard C types and fixed size integer types
>=20
>  scripts/tracetool/__init__.py | 46 +++++++++++++++++++++++++++++++++++++=
++++++
>  trace-events                  |  6 +++---
>  2 files changed, 49 insertions(+), 3 deletions(-)
>=20
> --=20
> 2.14.3
>=20

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaomBMAAoJEJykq7OBq3PImAIH/Ahm24Co23yR5boNON8gc7GX
Jh02q60MDhSay92aMiAJcCeHHlkp6PmSnaZljMK/0hn4aXCDIfA8tk+tU1p0LJ+z
23YxN09RS6Vg1z+7g5HJXTk2idtgcNnn5lS6Cm3pFruT7vwC2G3dmulG3ELeZYse
WaOgqrQi9Y6zqDFnz1ZzoxLaYUrUC28fUmrpeCKDFqayMRjtmhSbEsx4gC65CB7m
5Fanp62N8XbVgw9AGBqX0yQLo8aKXd7kEw4OOZiGU1sqfFuGFpW333/i0HpOIVYr
+aMxpugg19YR80BfE6er/WoXzDDdx6JxFQdvkCz4mEGimV/TG/TZdCz4Xp4FL6I=
=I4Kr
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
