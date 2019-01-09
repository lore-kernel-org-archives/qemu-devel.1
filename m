Received: from eggs.gnu.org ([209.51.188.92]:34384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghEZN-00076y-A2
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghEZM-0007ZD-E5
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:10:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ghEZM-0007YY-59
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 09:10:56 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
Date: Wed, 9 Jan 2019 15:10:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180906111107.30684-1-danielhb413@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YundUH3aPE2kGHFMn3YJDK2kANmLmXkTv"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, armbru@redhat.com, muriloo@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--YundUH3aPE2kGHFMn3YJDK2kANmLmXkTv
From: Max Reitz <mreitz@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, kwolf@redhat.com, armbru@redhat.com,
 muriloo@linux.ibm.com
Message-ID: <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
Subject: Re: [PATCH v2 0/3] HMP/snapshot changes - do not use ID anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
In-Reply-To: <20180906111107.30684-1-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.09.18 13:11, Daniel Henrique Barboza wrote:
> changes in v2:
> - removed the "RFC" marker;
> - added a new patch (patch 2) that removes
> bdrv_snapshot_delete_by_id_or_name from the code;
> - made changes in patch 1 as suggested by Murilo;
> - previous patch set link:
> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg04658.html
>=20
>=20
> It is not uncommon to see bugs being opened by testers that attempt to
> create VM snapshots using HMP. It turns out that "0" and "1" are quite
> common snapshot names and they trigger a lot of bugs. I gave an example=

> in the commit message of patch 1, but to sum up here: QEMU treats the
> input of savevm/loadvm/delvm sometimes as 'ID', sometimes as 'name'. It=

> is documented as such, but this can lead to strange situations.
>=20
> Given that it is strange for an API to consider a parameter to be 2 fie=
lds
> at the same time, and inadvently treating them as one or the other, and=

> that removing the ID field is too drastic, my idea here is to keep the
> ID field for internal control, but do not let the user set it.
>=20
> I guess there's room for discussion about considering this change an AP=
I
> change or not. It doesn't affect users of HMP and it doesn't affect Lib=
virt,
> but simplifying the meaning of the parameters of savevm/loadvm/delvm.

(Yes, very late reply, I'm sorry...)

I do think it affects users of HMP, because right now you can delete
snapshots with their ID, and after this series you cannot.

I think we had a short discussion about just disallowing numeric
snapshot names.  How bad would that be?

Max


--YundUH3aPE2kGHFMn3YJDK2kANmLmXkTv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw2AOoACgkQ9AfbAGHV
z0DkGgf+Kwd7TeA8/3JjzXQ/KSnC4ZzXvCY9y66+/1/Jm7rirTWUyuWxWlZr7Xft
STTLEF6jq6Ty4e5knQR3ujfInWn1sMhMyPNUfP9+D5GK4Q0hVDe9hcFefnhXx4BB
+ppACTSYBaP9DFsXFznsrZQ33zlXqEvWt/Vc8Eys3sElnSQMTqyVtCNx5FYehNEQ
FDjhUFQKSKNJC2bp0CMNBD6xRg21TGvF2IvWWhHGmAfxex/Nh4SQSqiqWAOkUZzu
FVUTRQqHsZ6WhKvnuE0+/E9odtfbgxmXPLwg5yxY/GloWGz5lpk8CxRlXtTsHqAw
KD5lZmEMqHL5xyzHyMmmrQ5Mz2Ticw==
=mkN6
-----END PGP SIGNATURE-----

--YundUH3aPE2kGHFMn3YJDK2kANmLmXkTv--
