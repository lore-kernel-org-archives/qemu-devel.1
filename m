Received: from eggs.gnu.org ([2001:4830:134:3::10]:53352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxvnC-0007Dg-J7
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxvnB-0001Zv-EL
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:25:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cxvnB-0001ZA-5b
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 09:25:09 -0400
References: <20170411125205.23121-1-sameeh@daynix.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2e13b99-77e3-b889-1edd-b52053e270ba@redhat.com>
Date: Tue, 11 Apr 2017 08:25:06 -0500
MIME-Version: 1.0
In-Reply-To: <20170411125205.23121-1-sameeh@daynix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3415wSa1caIKfAvarSoIIte9t0C4S5nCx"
Subject: Re: [Qemu-devel] [PATCH for-2.9?] qga-win: Enable 'can-offline'
 field in 'guest-get-vcpus' reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3415wSa1caIKfAvarSoIIte9t0C4S5nCx
From: Eric Blake <eblake@redhat.com>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>
Message-ID: <c2e13b99-77e3-b889-1edd-b52053e270ba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9?] qga-win: Enable 'can-offline' field
 in 'guest-get-vcpus' reply
References: <20170411125205.23121-1-sameeh@daynix.com>
In-Reply-To: <20170411125205.23121-1-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 07:52 AM, Sameeh Jubran wrote:
> The QGA schema states:
>=20
> @can-offline: Whether offlining the VCPU is possible. This member
>                is always filled in by the guest agent when the structur=
e
>                is returned, and always ignored on input (hence it can b=
e
>                omitted then).
>=20
> Currently 'can-offline' is missing entirely from the reply. This causes=

> errors in libvirt which is expecting the reply to be compliant with the=

> schema docs.
>=20
> BZ#1438735: https://bugzilla.redhat.com/show_bug.cgi?id=3D1438735
>=20
> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> ---
>  qga/commands-win32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Appropriate as a bug fix in 2.9 if there is still time for the
maintainer to submit a pull request, although we are late enough that if
it slips into 2.10 it is not a big deal.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3415wSa1caIKfAvarSoIIte9t0C4S5nCx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7NkyAAoJEKeha0olJ0NqdMcH/33H+HSGv21pwwDGG0T7b2Ep
6UfAvgXsGm4a1avOMUey37N28g0Fmqz4ib0c6x92xX3ieIRIxE6jPaNjURnZVAAM
+h9n+pLAslewYWLHo908X4FeSHN2zSUiPDO4VxP3q/wNcMVtqWBcJoAAbWedqy/R
GHGQ1D2HB4tsaddspmaeMDD1wtqipjl9M7dTQtfHfHfg9axzCh/GXeLlN3sqZKTQ
7Qpg/s9SP24q1szk8mkHGQbu9d1/nENBZRIAY3b0Cw964zonaePl09wJ1OwvzXm+
uy4ii0EpZkL2pdLJNZgyfwmK9krdusETZZiqVJ6XQgRQ8HuMc18kl0jKtEsSZVA=
=2MrN
-----END PGP SIGNATURE-----

--3415wSa1caIKfAvarSoIIte9t0C4S5nCx--
