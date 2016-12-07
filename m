Received: from eggs.gnu.org ([2001:4830:134:3::10]:39379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEe2P-0005m5-Ak
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cEe2M-0002gR-5u
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:21:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cEe2L-0002gC-TU
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 10:21:38 -0500
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6c9a32a1-9984-6ae6-bbdc-6843938ee2fd@redhat.com>
Date: Wed, 7 Dec 2016 09:21:31 -0600
MIME-Version: 1.0
In-Reply-To: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tDTrHdISLMKex0wTHfg6KdtqmadETLqSg"
Subject: Re: [Qemu-devel] [PATCH for-2.9 v2] virtio-crypto: zeroize the key
 material before free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tDTrHdISLMKex0wTHfg6KdtqmadETLqSg
From: Eric Blake <eblake@redhat.com>
To: Gonglei <arei.gonglei@huawei.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com
Message-ID: <6c9a32a1-9984-6ae6-bbdc-6843938ee2fd@redhat.com>
Subject: Re: [PATCH for-2.9 v2] virtio-crypto: zeroize the key material before
 free
References: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
In-Reply-To: <1481077751-106192-1-git-send-email-arei.gonglei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/06/2016 08:29 PM, Gonglei wrote:
> Common practice with sensitive information (key material, passwords,
> etc). Prevents sensitive information from being exposed by accident lat=
er in
> coredumps, memory disclosure bugs when heap memory is reused, etc.
>=20
> Sensitive information is sometimes also held in mlocked pages to preven=
t
> it being swapped to disk but that's not being done here.

I also think that pointing to earlier commit ids with similar behavior
is a good idea; in other words, call out commit 8813800b.  So maybe
rework this second paragraph to:

Sensitive information is sometimes also held in mlocked pages to prevent
it being swapped to disk, but qemu in general is not currently taking
that level of precaution (see also commit 8813800b).

>=20
> Let's zeroize the memory of CryptoDevBackendSymOpInfo structure pointed=

> for key material security.
>=20
> [v2: Stefan perfects the commit message, thanks]

The v2 blurb should appear after the --- line, as it is nice for
reviewers but a year from now when reading 'git log' we won't care how
many versions were on the list, only about the one version in git.

> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/virtio/virtio-crypto.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20

The commit message may still need improvement, but the maintainer might
be willing to do that without needing a v3.  At any rate,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--tDTrHdISLMKex0wTHfg6KdtqmadETLqSg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSCj7AAoJEKeha0olJ0NqdgcH/2GjY0gYx+Qk2h/4GBxebljL
+IRv92gvSDLyjxYvSHpap26A58P4mt5CtOI4Ve16daVKHI3Y6mINBTk+8z2aOGos
lnxIs0ULSxcQGfXF0+e3aJDxkbIx26bNq5BFyFLhImr8iqGMxjs2Zqo7tiTFQafx
MihWtRP2zGZGE/ugOvpGxExSHUZeLxwyYi5SucJvYUxx+MqvBv65wKTFyh+XqNNi
NqCSZWcO168kDCNBBJE2SO2g2BcDU5ukJs4N3JyZFu3Qu8npQ1b+aib6gYnKUzbM
DuSLGV2nYgU94/IcXgWOdBkOOIoIRCZTxP/kg56StSpDhsZ57HALVeVlWgv3Mzo=
=rRBT
-----END PGP SIGNATURE-----

--tDTrHdISLMKex0wTHfg6KdtqmadETLqSg--
