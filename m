Received: from eggs.gnu.org ([2001:4830:134:3::10]:50948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cldGF-0006wX-Sn
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:12:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cldGC-0003DN-F7
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 10:12:19 -0500
References: <20170307184517.21521-1-eblake@redhat.com>
	<32c14d52-e8d0-09a7-4232-52dab2ae3e8c@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8dda4d42-59ed-5ed3-2037-ca1202df87a6@redhat.com>
Date: Wed, 8 Mar 2017 09:12:13 -0600
MIME-Version: 1.0
In-Reply-To: <32c14d52-e8d0-09a7-4232-52dab2ae3e8c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oh54W3q65IbssfXdjV9jJNtoOJ19kLSHA"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH for-2.9?] tests: Ignore more
 test executables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oh54W3q65IbssfXdjV9jJNtoOJ19kLSHA
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <8dda4d42-59ed-5ed3-2037-ca1202df87a6@redhat.com>
Subject: Re: [Qemu-trivial] [PATCH for-2.9?] tests: Ignore more test
 executables
References: <20170307184517.21521-1-eblake@redhat.com>
 <32c14d52-e8d0-09a7-4232-52dab2ae3e8c@redhat.com>
In-Reply-To: <32c14d52-e8d0-09a7-4232-52dab2ae3e8c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/08/2017 04:00 AM, Laurent Vivier wrote:
> and tests/test-arm-mptimer?

Introduced in commit 882fac37. Looks like my usual subset build focusing
on x86 doesn't see it, but indeed an all-targets build shows it. I'll
spin a v2.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oh54W3q65IbssfXdjV9jJNtoOJ19kLSHA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYwB9NAAoJEKeha0olJ0NqH5AH/R8o0hmRnYz7zgBOiZeylxB9
9Wr1Lk8ziG91lAL11yJq4G/Sw8dRK7KQ1JfqAJJI1IXxvVZs4Icnwu5ojXd0BWrm
RJNOPJ3WHBUYBXIGcQSFTaqY5IxT3RqPRJC4QSNCtGCkopbOJjd6pORVNdSealMF
T4AWjXfdYdZRMQm+IP4KjKGC452bRkWruSUVw4ZCu0WzbYbhxGFoB1ilEMUcIoR2
Mo2flm76oJn8q3oZImnr8Einweuu6+A+hTkp5Eavg45dMjWqnuh/z/7/GntRnTBL
eh0L0Z5JXL2ma5Ib5+wln/Q3/zsNSZpSCfFxISSJgfLngk7+AtSDDynTeOLTvNI=
=aUj4
-----END PGP SIGNATURE-----

--oh54W3q65IbssfXdjV9jJNtoOJ19kLSHA--
