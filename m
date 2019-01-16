Received: from eggs.gnu.org ([209.51.188.92]:56580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjpjw-0002ZF-HS
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjpZF-0001OH-3v
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:05:34 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-5-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <027e129f-ff0c-c466-bbd1-92542ab937ed@redhat.com>
Date: Wed, 16 Jan 2019 12:05:09 -0600
MIME-Version: 1.0
In-Reply-To: <20190112175812.27068-5-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9LWAr3X6tHymp2Ah2ERSfBFEAbRni9MMU"
Subject: Re: [Qemu-devel] [PATCH v3 04/19] nbd/server: Hoist length check to
 qemp_nbd_server_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, rjones@redhat.com, Max Reitz <mreitz@redhat.com>, nsoffer@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9LWAr3X6tHymp2Ah2ERSfBFEAbRni9MMU
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, rjones@redhat.com, Max Reitz <mreitz@redhat.com>,
 nsoffer@redhat.com, jsnow@redhat.com
Message-ID: <027e129f-ff0c-c466-bbd1-92542ab937ed@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 04/19] nbd/server: Hoist length check to
 qemp_nbd_server_add
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-5-eblake@redhat.com>
In-Reply-To: <20190112175812.27068-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/12/19 11:57 AM, Eric Blake wrote:

s/qemp/qmp/ in the subject line

> We only had two callers to nbd_export_new; qemu-nbd.c always
> passed a valid offset/length pair (because it already checked
> the file length, to ensure that offset was in bounds), while
> blockdev-nbd always passed 0/-1.  Then nbd_export_new reduces
> the size to a multiple of BDRV_SECTOR_SIZE (can only happen
> when offset is not sector-aligned, since bdrv_getlength()
> currently rounds up), which can result in offset being greater
> than the enforced length, but that's not fatal (the server
> rejects client requests that exceed the advertised length).
>=20
> However, I'm finding it easier to work with the code if we are
> consistent on having both callers pass in a valid length, and
> just assert that things are sane in nbd_export_new.
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--9LWAr3X6tHymp2Ah2ERSfBFEAbRni9MMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw/clUACgkQp6FrSiUn
Q2q1iggAkNDYmuxIs+454KritdDKDLZhgP0R6F8F2CpA5f1Vum5jZX7SJ2SZ7wlC
xmhAoE4ZrtkgcoSAjRgKrsiEDSNm7CLuUt5Hef23nSZ8khYLdimdjvkx1sJQMZvQ
9qG7s1kRb6XfcEi9ANC0Oe9FEU6xkmIDAOy7vAylocZq5FGpLIxkjs1eEd5wy6Id
k+aG4EFcGeib9KdgVBtXRNH0xy8BhAnuz/ccP5ySPWrI25C0ytd8R9WFvvcW1F4i
0bl067xxRGBfmBV6O4u6Q114MK6a0x4hlRz5wtnwLcuSjuaGRPZDurnn+Fk+Egmp
NgbTxpDQrxadLwLud2gtEn52sefUzQ==
=YVVf
-----END PGP SIGNATURE-----

--9LWAr3X6tHymp2Ah2ERSfBFEAbRni9MMU--
