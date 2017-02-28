Received: from eggs.gnu.org ([2001:4830:134:3::10]:48030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cir6F-0000UN-36
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cir6A-0008U4-0s
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:22:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cir69-0008TG-RH
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 18:22:25 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11253BAEF
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 23:22:26 +0000 (UTC)
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
	<20170221141451.28305-30-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7896ee35-d154-aebb-88e7-cbead616b874@redhat.com>
Date: Tue, 28 Feb 2017 17:22:23 -0600
MIME-Version: 1.0
In-Reply-To: <20170221141451.28305-30-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vGVh118XTobkDFjX1X6QwagaefoaoSRVG"
Subject: Re: [Qemu-devel] [PATCH v2 29/30] tests: fix virtio-blk-test leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vGVh118XTobkDFjX1X6QwagaefoaoSRVG
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <7896ee35-d154-aebb-88e7-cbead616b874@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 29/30] tests: fix virtio-blk-test leaks
References: <20170221141451.28305-1-marcandre.lureau@redhat.com>
 <20170221141451.28305-30-marcandre.lureau@redhat.com>
In-Reply-To: <20170221141451.28305-30-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/21/2017 08:14 AM, Marc-Andr=C3=A9 Lureau wrote:
> Use qvirtio_pci_device_find_slot() to avoid leaking the non-hp
> device. Add assert() to avoid further leaks in the future.
>=20
> Use qvirtio_pci_device_free() to correctly free QVirtioPCIDevice.

Yep, the hunk I mentioned in 28/30 probably belongs here, alongside the
other instances of this fix.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/libqos/virtio-pci.c |  1 +
>  tests/virtio-blk-test.c   | 14 +++++++-------
>  2 files changed, 8 insertions(+), 7 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vGVh118XTobkDFjX1X6QwagaefoaoSRVG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtgYvAAoJEKeha0olJ0NqzgQH/2zBdmXeDSqbURf/AMRfRkRG
4L2nPTzH1MAUOudcI9gHZ1aI9rNLR9DNJWmnvRThr68e3rqcchqs4ZrbPszZDs70
TU5muQLqBVX4YyUaqMpY5raHOiBX0zX6/PtLpmAIhSa79Rdr4auTK0wQuGjOSRpT
WL6mrAsUyuA5X3ljAPt3dFFO9szV3b1f/u+/SD2Ipxw5QXs6xqsESVCsOOQX937m
z0H7OStkGtPIKlIabG9I+lpdAjG1Vb2US2sM8oC/Tkze7G6tMjUm2x2mwuCElGeV
YmIbOPHcgEFq23h9YKmHRqAVbmQqlZv6IPKkmLJzjSXAwcfspldCI8wLwHe3T4E=
=ANoU
-----END PGP SIGNATURE-----

--vGVh118XTobkDFjX1X6QwagaefoaoSRVG--
