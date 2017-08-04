Received: from eggs.gnu.org ([2001:4830:134:3::10]:56813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddgju-0000qJ-SO
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:50:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ddgjq-0008Va-S9
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:50:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48360)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ddgjq-0008Tr-IC
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 13:50:18 -0400
References: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
	<150142394076.12995.15066917056319876922.stgit@frigg.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fcbf012b-5e29-3fdd-d3ac-9b84c367bc44@redhat.com>
Date: Fri, 4 Aug 2017 12:50:06 -0500
MIME-Version: 1.0
In-Reply-To: <150142394076.12995.15066917056319876922.stgit@frigg.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PUDp84UKl0DIIBLILw7JcmmTsmdfn9eMn"
Subject: Re: [Qemu-devel] [PATCH v8 1/5] hypertrace: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PUDp84UKl0DIIBLILw7JcmmTsmdfn9eMn
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 qemu-devel@nongnu.org
Cc: Daniel P Berrange <berrange@redhat.com>,
 Luiz Capitulino <lcapitulino@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <fcbf012b-5e29-3fdd-d3ac-9b84c367bc44@redhat.com>
Subject: Re: [PATCH v8 1/5] hypertrace: Add documentation
References: <150142369849.12995.11229612194223213120.stgit@frigg.lan>
 <150142394076.12995.15066917056319876922.stgit@frigg.lan>
In-Reply-To: <150142394076.12995.15066917056319876922.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/30/2017 09:12 AM, Llu=C3=ADs Vilanova wrote:
> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
> ---
>  docs/devel/tracing.txt |    3 +
>  docs/hypertrace.txt    |  225 ++++++++++++++++++++++++++++++++++++++++=
++++++++

Do we want the new document directly in docs/, or does it live in one of
the subdirectories?

>  2 files changed, 228 insertions(+)
>  create mode 100644 docs/hypertrace.txt
>=20
> diff --git a/docs/devel/tracing.txt b/docs/devel/tracing.txt
> index 5768a0b7a2..9178a308da 100644
> --- a/docs/devel/tracing.txt
> +++ b/docs/devel/tracing.txt
> @@ -5,6 +5,9 @@
>  This document describes the tracing infrastructure in QEMU and how to =
use it
>  for debugging, profiling, and observing execution.
> =20
> +See "docs/hypertrace.txt" to correlate guest tracing events with those=
 in the
> +QEMU host.

Depending on where it should live, this may need a tweak.


> +
> +The hypertrace channel allows guest code to emit events in QEMU (the h=
ost) using
> +its tracing infrastructure (see "docs/trace.txt"). This works in both =
'system'

Stale filename; needs adjusting.

> +and 'user' modes. Therefore, hypertrace is to tracing what hypercalls =
are to
> +system calls.
> +


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PUDp84UKl0DIIBLILw7JcmmTsmdfn9eMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmEs84ACgkQp6FrSiUn
Q2r51Qf/Y4WeK+pIUGJMNj9P+2SbCanOh6RXPeqCBoo+07VrjsxTjjWYOE69FgAC
t+av4XVJAe4+k8uQy7s0bHLOsFp7aP/2q+QlQz0iLlv/4imHdBcLWw7YUX14sY8j
NEAMwxfK+xT8e3qm2/uYA+occMgnu1Ea3fyt3rvlV+NiMPP/cS5EdpOVWXglctV6
o3jvPzn0vO2ByLOr4yEIax4tK82YQbZoE5KLFRvKx+7YM6LWYwtpmQqO5+YkSFZN
nlnUfE04R8R/m08j7T0Qo6OVWV4I6QRsVG/QZeiiLwp0g2NYIlFGbgVzljfqUD8E
EemPPmiELYInuTSBQd45JA8CDtOJQQ==
=pas0
-----END PGP SIGNATURE-----

--PUDp84UKl0DIIBLILw7JcmmTsmdfn9eMn--
