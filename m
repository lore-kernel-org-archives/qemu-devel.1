Received: from eggs.gnu.org ([2001:4830:134:3::10]:54567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPZ3I-0004Ea-Fi
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:15:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPZ3D-0006u4-Q3
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:15:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38210)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPZ3D-0006tn-DB
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 13:15:39 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 96DC3C03BD5B
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 18:15:39 +0000 (UTC)
References: <20170106155543.12827-1-berrange@redhat.com>
	<20170106155543.12827-48-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <de89a193-348a-d946-c8a3-b4db95b5719b@redhat.com>
Date: Fri, 6 Jan 2017 12:15:37 -0600
MIME-Version: 1.0
In-Reply-To: <20170106155543.12827-48-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dl3CRnqhL3pHfCLkFn4D67j4lQTe35Odm"
Subject: Re: [Qemu-devel] [PATCH v2 47/47] trace: improve error reporting
 when parsing simpletrace header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dl3CRnqhL3pHfCLkFn4D67j4lQTe35Odm
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <de89a193-348a-d946-c8a3-b4db95b5719b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 47/47] trace: improve error reporting when
 parsing simpletrace header
References: <20170106155543.12827-1-berrange@redhat.com>
 <20170106155543.12827-48-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-48-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/06/2017 09:55 AM, Daniel P. Berrange wrote:
> When loading a simpletrace binary file we just report
> "Not a valid trace file!" which is not very helpful. Report
> exactly which field we found to be invalid.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  scripts/simpletrace.py | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20

Could be applied independently, so:

Reviewed-by: Eric Blake <eblake@redhat.com>

I'll leave a review of the Makefile magic in 1/47 to someone more
comfortable with it, but if that gets approved, you are right that most
of this series is pretty boring and mechanical.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Dl3CRnqhL3pHfCLkFn4D67j4lQTe35Odm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb97JAAoJEKeha0olJ0Nq1OkH/RAP7yAVG2gz1POZICP7tYfc
V6PKShlCLb7xqxnc0z8hl8ub5HBI4EjYvmqnrg4a+OcezR5mXTM5r9AJyCSfLUgG
QTruLDx3PlG5p53Xmu+ji2LYdhMnhdsFUm7ZsF1RsBFqtPF/NBZHMkqCWMJjlXfS
P+EKal/uHwUlcPrD22RlR1kDLdKjbl5rmL8niJ9WVnE1tlwGgnx1zlb4c1G863Hw
nToPYgnfwdcwvgBwYf0LIrKuQ4F2ea+6wGvazRIZGU6qn7ZDBQw4ZT5QVOs8NYK1
p64yqij7CzvMcqfArRrFduF7e9szstw/Cbe1maYbYiWOJJKZGD9j/uhOomdGAhQ=
=/jYH
-----END PGP SIGNATURE-----

--Dl3CRnqhL3pHfCLkFn4D67j4lQTe35Odm--
