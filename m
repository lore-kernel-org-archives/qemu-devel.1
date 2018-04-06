Received: from eggs.gnu.org ([2001:4830:134:3::10]:40561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f4TOJ-0007tn-O6
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f4TOI-0005Uc-TT
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:35:03 -0400
References: <20180406151731.4285-1-mreitz@redhat.com>
	<af728288-9d73-4a78-8fd1-40e93f566eaf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4d3ba88f-4156-4087-2115-e96c4e7131ee@redhat.com>
Date: Fri, 6 Apr 2018 17:34:53 +0200
MIME-Version: 1.0
In-Reply-To: <af728288-9d73-4a78-8fd1-40e93f566eaf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kgHtRzn9FNyWxW6E2EEYSe89az8uwBAgd"
Subject: Re: [Qemu-devel] [PATCH 0/2 for-2.12?] iotests: Skip 181 and 201
 without userfaultfd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kgHtRzn9FNyWxW6E2EEYSe89az8uwBAgd
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <4d3ba88f-4156-4087-2115-e96c4e7131ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2 for-2.12?] iotests: Skip 181 and 201
 without userfaultfd
References: <20180406151731.4285-1-mreitz@redhat.com>
 <af728288-9d73-4a78-8fd1-40e93f566eaf@redhat.com>
In-Reply-To: <af728288-9d73-4a78-8fd1-40e93f566eaf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-06 17:30, Eric Blake wrote:
> On 04/06/2018 10:17 AM, Max Reitz wrote:
>> My non-Fedora testing system does not have a kernel with userfaultfd
>> support which causes 181 and 201 to fail.  That is annoying.  This
>> series makes those tests recognize the issue and convert it into a
>> _notrun.
>=20
> As this is just testsuite fixes, is this worth including in 2.12?  Then=

> again, as we are now building for -rc3, missing the release merely mean=
s
> tests fail, and not a broken binary.

I usually merge test patches independently of freeze, but on the other
hand I prefer to only take the really necessary things for the later
RCs.  Sooo... I haven't decided yet. :-)

Max

>> Max Reitz (2):
>>   iotests: Add failure matching to common.qemu
>>   iotests: Skip 181 and 201 without userfaultfd
>>
>>  tests/qemu-iotests/181         | 13 ++++++++++
>>  tests/qemu-iotests/201         | 13 ++++++++++
>>  tests/qemu-iotests/common.qemu | 58 +++++++++++++++++++++++++++++++++=
++++-----
>>  3 files changed, 77 insertions(+), 7 deletions(-)
>>
>=20



--kgHtRzn9FNyWxW6E2EEYSe89az8uwBAgd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrHk54ACgkQ9AfbAGHV
z0CP3wgAvSPMmcPxkgZwCl3oHpCOc+dRHJ2AGzXw+qlBQyhisTOLd2CWPVUoIDRb
PHxYeLYa7lBX3BcTrDYGXL9XX3MoyDNW5iH366sA2SI161p2ADJEdU/PBV+5VYkN
ZoO31U1gHyMTtTmZ+lX40jFUCFaqZ0iKwAyV1xgCN8q0lU8Q1y6se9SREVsnOeV1
RXsquX3x3Kx8NPD1UV2WrZET8AU0umkFPQuG3FLbNR9NwEVPVns4HwWk4erpD9n5
jfTJDmGNx3tx3YgllWcPLXGIS/C14GAWu07Guy23R/s7R+XQnXHINwPlAB/UbxuW
tSTaU9KK/JgSdRpMAik3g77ZTQbLew==
=gdHT
-----END PGP SIGNATURE-----

--kgHtRzn9FNyWxW6E2EEYSe89az8uwBAgd--
