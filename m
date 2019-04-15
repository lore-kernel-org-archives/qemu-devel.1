Received: from eggs.gnu.org ([209.51.188.92]:58960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4ZB-0002YN-QZ
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hG4ZA-0007D0-Sd
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 12:34:45 -0400
References: <20190415155452.5115-1-kwolf@redhat.com>
	<20190415155452.5115-5-kwolf@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f18c48b-2ca8-fa43-7f2a-f5f7a279a1c5@redhat.com>
Date: Mon, 15 Apr 2019 11:34:37 -0500
MIME-Version: 1.0
In-Reply-To: <20190415155452.5115-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sWUhu5LPz6gcn3ONavC9jxcO3mtIcl7sl"
Subject: Re: [Qemu-devel] [PATCH 4/4] qcow2: Fix full preallocation with
 external data file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sWUhu5LPz6gcn3ONavC9jxcO3mtIcl7sl
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: mreitz@redhat.com, qemu-devel@nongnu.org
Message-ID: <1f18c48b-2ca8-fa43-7f2a-f5f7a279a1c5@redhat.com>
Subject: Re: [PATCH 4/4] qcow2: Fix full preallocation with external data file
References: <20190415155452.5115-1-kwolf@redhat.com>
 <20190415155452.5115-5-kwolf@redhat.com>
In-Reply-To: <20190415155452.5115-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/15/19 10:54 AM, Kevin Wolf wrote:
> preallocate_co() already gave the data file the full size without
> forwarding the requested preallocation mode to the protocol. When
> bdrv_co_truncate() was called later with the preallocation mode, the
> file didn't actually grow any more, so the data file stayed unallocated=

> even if full preallocation was requested.
>=20
> Pass the right preallocation mode to preallocate_co() and remove the
> second bdrv_co_truncate() to fix this. As a side effect, the ugly
> one-byte write in preallocate_co() is replaced with a truncate call,
> now leaving the last block unallocated on the protocol level as it
> should be.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 41 +++++++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 18 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

Worth iotest coverage?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--sWUhu5LPz6gcn3ONavC9jxcO3mtIcl7sl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly0sp0ACgkQp6FrSiUn
Q2pJ7Qf+MFZzORg6P215M5x3l1BQrUB20pBK4GXFoAITt9Lr86hTTAJP83+Oy5RV
u3uaPgk2ING5GPpShaDZUfY0Fk3b1zzVgzoXytsgV/AIQnbjHAAqBzUdAxtWIDd2
meUIn97oZDS+DARz11lKLBtT1RNJ780C8S6INxFbCtTy0pDqdn8/q0uO550dx5Hs
Jf3vWp+bkZuKfh8HrTfNyUqdQwSXHwh2GvpuVk5r5uw1VUfkCoKKfP5NmcSZzpKA
q1JmL96y7vYK2XywQuNYNBV8ulq5OASC0FmCzTEdd5GuL3qunJfucg/VGSCUzorQ
nlY2tzyWryGWntsYoXNIR5tIv4+Z7A==
=YiMn
-----END PGP SIGNATURE-----

--sWUhu5LPz6gcn3ONavC9jxcO3mtIcl7sl--
