Received: from eggs.gnu.org ([2001:4830:134:3::10]:53775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFmVW-0002OX-BD
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFmVR-0004i1-NJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:08:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFmVR-0004gv-DO
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:08:37 -0400
References: <20170530184013.31044-1-ehabkost@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0daee0d-ad21-1fbf-ce72-be47227f62d5@redhat.com>
Date: Tue, 30 May 2017 14:08:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170530184013.31044-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pU331oHIQeEJI2egXQhCCN1PkccMS0taN"
Subject: Re: [Qemu-devel] [PATCH] numa: Fix format string for "Invalid node"
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, He Chen <he.chen@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pU331oHIQeEJI2egXQhCCN1PkccMS0taN
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, He Chen
 <he.chen@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <d0daee0d-ad21-1fbf-ce72-be47227f62d5@redhat.com>
Subject: Re: [PATCH] numa: Fix format string for "Invalid node" message
References: <20170530184013.31044-1-ehabkost@redhat.com>
In-Reply-To: <20170530184013.31044-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 01:40 PM, Eduardo Habkost wrote:
> Some compilers complain about the PRIu16 format string with the
> MAX(src, dst) and MAX_NODES arguments.  Example output from Apple LLVM
> version 7.3.0 (clang-703.0.31):

>                     ^~~
> MAX(src, dst) promotes the src and dst arguments to int, and MAX_NODES
> is an int.  Use %d to silence those warnings.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  numa.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pU331oHIQeEJI2egXQhCCN1PkccMS0taN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLcMqAAoJEKeha0olJ0NqaRsIAKeHQHF7QbBzUrWEPTQfLNk/
dg5zXWJpkaF81/J699JBwTZZeRD1t6D8oD3h00qKwsXKmt7xJA9crTMMfa0RNkg9
s0J7Fe1YGVn5KiNsgQNLTGnGjdVqw4ulON9UFu6Hikv4FnMnazCtSvb8Kcpvygzs
cTJpu0soA2iigphs3AjdCaBArF0h8GwxgEKEMQ7cRQuxKQvwb86GTiKsAPuRzfsj
m4kWOb1P1wWkzUwMUYGv6WI0Fu9JZJAuXQs3ezvrrYGdtOYQrt5O4uY3aBpX863r
Dqc5WEQixwrrfBgQiHxlCoED4k0kzwUoaJxuMN4ju09vl2vdjL4IVlcv+tzvDaA=
=MkHa
-----END PGP SIGNATURE-----

--pU331oHIQeEJI2egXQhCCN1PkccMS0taN--
