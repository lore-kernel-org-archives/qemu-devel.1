Received: from eggs.gnu.org ([2001:4830:134:3::10]:51619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyICC-0006LT-KT
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:20:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyIC9-0001lD-RD
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:20:28 -0400
References: <1492002476-26784-1-git-send-email-lidongchen@tencent.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d702a370-8dc4-9178-8213-739a611ce168@redhat.com>
Date: Wed, 12 Apr 2017 08:19:49 -0500
MIME-Version: 1.0
In-Reply-To: <1492002476-26784-1-git-send-email-lidongchen@tencent.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1o3TAHEvoi0u2uR786Tmxnvivu7qBw4nc"
Subject: Re: [Qemu-devel] [PATCH v5] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, Lidong Chen <lidongchen@tencent.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1o3TAHEvoi0u2uR786Tmxnvivu7qBw4nc
From: Eric Blake <eblake@redhat.com>
To: jemmy858585@gmail.com, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, quintela@redhat.com,
 dgilbert@redhat.com, stefanha@redhat.com,
 Lidong Chen <lidongchen@tencent.com>
Message-ID: <d702a370-8dc4-9178-8213-739a611ce168@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5] migration/block: use blk_pwrite_zeroes
 for each zero cluster
References: <1492002476-26784-1-git-send-email-lidongchen@tencent.com>
In-Reply-To: <1492002476-26784-1-git-send-email-lidongchen@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 08:07 AM, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
> this maybe cause the qcow2 file size is bigger after migration.

s/maybe/may/
s/is bigger/to be bigger/

> This patch check each cluster, use blk_pwrite_zeroes for each

s/check/checks/
s/use/using/

> zero cluster.
>=20
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---

Please use this space (after the ---) to state how v5 differs from v4,
in order to save reviewers some time.

>  migration/block.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--1o3TAHEvoi0u2uR786Tmxnvivu7qBw4nc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7il1AAoJEKeha0olJ0Nq9y0H/357DMgpLczcg2weEbMQSGA0
Q8rZJmansSF0ZpTPD56SHxKMRFKOgOT4NH0Sb+DXaZKdEPHAQPeeaj7K2HM+FQf3
7fNYODGCSBNkMM1tf2x9VQ+Q/+lkHedC/E35OBagSszCGzdMhWsYDa+4ETbVX1jT
xcssWSmwa36I2te0DVVvvl1/ZBBX3mektHoTNZnQiNhg41YzCmgScT4T8iIomKhl
tzztDBhCOr84IFOgbEr8ch1pYb7JHYsDOGBCjiBcYKOKf8Z9Vz1NLRXXHrefE5wD
j7ocPYR2Oc/1BEaWyt5U6d54TLSAs499awFa1HQfvNx41pRnaIdLKbRZ2WsCxTM=
=nHGG
-----END PGP SIGNATURE-----

--1o3TAHEvoi0u2uR786Tmxnvivu7qBw4nc--
