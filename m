Received: from eggs.gnu.org ([2001:4830:134:3::10]:46156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgEaf-0004At-7J
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgEab-0004bs-BW
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:51:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38118)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgEab-0004bk-5z
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 12:51:01 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27AAC468
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 17:51:01 +0000 (UTC)
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
	<1487363905-9480-10-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f92bf103-31aa-abb2-a057-1417daa551aa@redhat.com>
Date: Tue, 21 Feb 2017 11:50:58 -0600
MIME-Version: 1.0
In-Reply-To: <1487363905-9480-10-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x8TRSNFDVt0qvIvjESOpBCvGD1K6dOx27"
Subject: Re: [Qemu-devel] [PATCH 09/14] tests: Don't check qobject_type()
 before qobject_to_qstring()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x8TRSNFDVt0qvIvjESOpBCvGD1K6dOx27
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <f92bf103-31aa-abb2-a057-1417daa551aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/14] tests: Don't check qobject_type()
 before qobject_to_qstring()
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
 <1487363905-9480-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-10-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 02:38 PM, Markus Armbruster wrote:
> qobject_to_qstring(obj) returns NULL when obj isn't a QString.  Check
> that instead of qobject_type(obj) =3D=3D QTYPE_QSTRING.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  tests/check-qjson.c                 | 31 ++++++++---------------------=
--
>  tests/test-qobject-output-visitor.c | 37 +++++++++++++++++------------=
--------
>  2 files changed, 25 insertions(+), 43 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--x8TRSNFDVt0qvIvjESOpBCvGD1K6dOx27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYrH4CAAoJEKeha0olJ0Nqgl8IAIzJLYvAtny0x9RHqYeVrA09
K4aenYfE5mJwjwBF1Yba1vA/sXo7uos5woBTppjjHR5c3XH86y46htAgT1B+rBfb
RZDANXh+t4LuukCdkhu7iGvDRH5FHaJm/yr6geFNW85+RlrDbSy1O/gem9VHHmC2
PlOdBOi0n1g2jvyWalrZw1riSAa1Fs4qXug4dpmXKP0VuBCrvdY3t0XBN8TDaNDM
KVsqAZVJpj/ngMT7t32RswUSfqWdmIXmb23Ed51Z8TIzXNpolewyylwa/weItffM
W5vF9Jy77QxpNegMlpLQnh61jxa6FwLFTORTJ48IvtjaFLmTii6HKk4ewZ65BQQ=
=2sIo
-----END PGP SIGNATURE-----

--x8TRSNFDVt0qvIvjESOpBCvGD1K6dOx27--
