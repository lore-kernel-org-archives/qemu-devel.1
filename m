Received: from eggs.gnu.org ([209.51.188.92]:34995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gorMZ-0000DH-TC
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:01:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gorMY-0001LS-0z
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:01:15 -0500
References: <1548769067-20792-1-git-send-email-thuth@redhat.com>
	<20190129145156.6719b8a4.cohuck@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e3dfae55-8733-bd01-1f13-422f343fb258@redhat.com>
Date: Wed, 30 Jan 2019 09:01:01 -0600
MIME-Version: 1.0
In-Reply-To: <20190129145156.6719b8a4.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uJpQ5UZ3pVQDnBqqqV75RfYNJwrtZo6J4"
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Fix LGPL version in the file
 header comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uJpQ5UZ3pVQDnBqqqV75RfYNJwrtZo6J4
From: Eric Blake <eblake@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Message-ID: <e3dfae55-8733-bd01-1f13-422f343fb258@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Fix LGPL version in the file
 header comments
References: <1548769067-20792-1-git-send-email-thuth@redhat.com>
 <20190129145156.6719b8a4.cohuck@redhat.com>
In-Reply-To: <20190129145156.6719b8a4.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/29/19 7:51 AM, Cornelia Huck wrote:
> On Tue, 29 Jan 2019 14:37:47 +0100
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> It's either "GNU *Library* General Public License version 2" or
>> "GNU Lesser General Public License version *2.1*", but there was
>> no "version 2.0" of the "Lesser" license. So assume that version
>> 2.1 is meant here.
>=20
> I think we can assume that.
>=20
> Given that there have been several of these cases (and that there's a
> lot of boilerplate in general): Should we adopt SPDX license
> identifiers for QEMU, as the Linux kernel did? They also discovered and=

> fixed some problems/oddities while at it.

I'm also in favor of SPDX license identifiers - their brevity and
machine-parsability favors more accurate usage and fewer copy/paste
mistake propagation.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--uJpQ5UZ3pVQDnBqqqV75RfYNJwrtZo6J4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxRvC0ACgkQp6FrSiUn
Q2pjyQf8CXc1r8WFH52ZnS4sAhopLr9EEQ+HPopE9PFv43DEj/Q2a3zRCHIYZrr4
7QzOt5LioTM+IA9zzzOkWsFeznJTxzqrdaRxcStk+6d9fWXZaxhacdfrQ4UNcLaP
JBJQwUWu1sc8yY093UyOOG6aJdskM/nHKx6/PX/+rQP185PClQYO8owrbyyAXDbo
5q6lMcYynTdL5Uz5Et6dG0r7UcAsZ+sChZtsi40ubhzjyHCFvjiI7c2/0e9de8WK
pt/euGLgnP48EsvRc6sauwfboJZPqdmPyL4mW2kjYO3GmbQaLofrPPKxyMeP0E90
Zri4rP9IIXb5TuLpngVtCWjUTa4Ssg==
=mzN6
-----END PGP SIGNATURE-----

--uJpQ5UZ3pVQDnBqqqV75RfYNJwrtZo6J4--
