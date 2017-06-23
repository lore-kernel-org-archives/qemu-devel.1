Received: from eggs.gnu.org ([2001:4830:134:3::10]:47827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dOQoI-0005jk-EH
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dOQoH-0008NZ-Oc
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 11:47:50 -0400
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
	<20170613121639.17853-5-pbutsykin@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1f6f2cd3-f4f8-1e3c-09d0-4f56c770828b@redhat.com>
Date: Fri, 23 Jun 2017 17:47:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170613121639.17853-5-pbutsykin@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LMmeex6P5gRLAh7WSCChq7N5X6VTINQVI"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] qemu-iotests: add shrinking image
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LMmeex6P5gRLAh7WSCChq7N5X6VTINQVI
From: Max Reitz <mreitz@redhat.com>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, armbru@redhat.com, den@openvz.org
Message-ID: <1f6f2cd3-f4f8-1e3c-09d0-4f56c770828b@redhat.com>
Subject: Re: [PATCH v2 4/4] qemu-iotests: add shrinking image test
References: <20170613121639.17853-1-pbutsykin@virtuozzo.com>
 <20170613121639.17853-5-pbutsykin@virtuozzo.com>
In-Reply-To: <20170613121639.17853-5-pbutsykin@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-13 14:16, Pavel Butsykin wrote:
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
> ---
>  tests/qemu-iotests/163     | 113 +++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/163.out |   5 ++
>  tests/qemu-iotests/group   |   1 +
>  3 files changed, 119 insertions(+)
>  create mode 100644 tests/qemu-iotests/163
>  create mode 100644 tests/qemu-iotests/163.out

Ideally this test should contain tests for how the L1 and refcount table
shrinking functions actually behave (like what we have for growing
images). Right now we don't know whether they do anything in these test
cases at all.

Max


--LMmeex6P5gRLAh7WSCChq7N5X6VTINQVI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZTTgbEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQOiV
B/0ff1bGfaj+9ewyQvplkYHidI/M2e30T5nidAA6A7u2YtGxM9JY+2YI1fg+Ytxr
IJE7nyggXYKl6ymV8c85hkh641TRQ7JbJ7X6rKukPSVjKDO+5uNt4gCIE/W1/4Mb
pf2n7UPVs5ETidqU/XJYrxEzFM9nlD0uTTx2lex32FFbvcc/RQLTlVcLLrXimaWd
G1no/qpG/oyXq97eXo1lDvtx+RR+HsQrxN43YBh9akTj2MF05o/rRe/1LbPSAOIf
qwpBGcS5Wvv8G0WjtlXXpqHa4BkQC5AjjasC1+0w0tnxyeFaSyUxpN7N9Bb536kL
ZtzEfP8b8pTqAkLsRBzIqNbE
=zjVR
-----END PGP SIGNATURE-----

--LMmeex6P5gRLAh7WSCChq7N5X6VTINQVI--
