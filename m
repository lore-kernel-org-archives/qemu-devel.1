Received: from eggs.gnu.org ([2001:4830:134:3::10]:54179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eX9WQ-0007Gz-MW
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eX9WP-0004k8-Ni
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:41:42 -0500
References: <20180104024228.11780-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9b5c0137-837a-99ee-7887-996c5dba69fa@redhat.com>
Date: Thu, 4 Jan 2018 11:41:32 -0600
MIME-Version: 1.0
In-Reply-To: <20180104024228.11780-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VmfVJFEGgN9StJp1y290zpAakRYFAsMKO"
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't deference in_buf if NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VmfVJFEGgN9StJp1y290zpAakRYFAsMKO
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Message-ID: <9b5c0137-837a-99ee-7887-996c5dba69fa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi: Don't deference in_buf if NULL
References: <20180104024228.11780-1-famz@redhat.com>
In-Reply-To: <20180104024228.11780-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/03/2018 08:42 PM, Fam Zheng wrote:
> scsi_disk_emulate_command passes in_buf=3DNULL and in_len=3D0 in the
> REQUEST_SENSE branch. Inline the fixed_in evaluation and put it after
> the in_len test.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  scsi/utils.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Does this patch duplicate
https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg04964.html ?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--VmfVJFEGgN9StJp1y290zpAakRYFAsMKO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpOZ0wACgkQp6FrSiUn
Q2qi6wf+Lw49+B+3mTMW868x7NpIGpSCeYULfsfIsIdaV8YP3lhIShXg7QCZsTWi
kpjfqd9BqGvlu1Wc8kOx2gNtmvrkXW2W7r22kZvdCQ2pQHfkICOlvrmuTyHb9+mP
4EmLe6rJB3PmzfxHfzxiQ5EJau/R0ANsuAfC8ndSE0EHQr81dYeOc7HlxXbIoklj
VcNtnUl17hCLOTct/VZA81p+4wo4aKFZL9VNaWT8cp0GwQZCGrOOzst66ANwITRt
aEWWGIs/Dsi+rkAwlwW2CPs0FYMiChO/CtTQ69Y+x2GzxOdcdfVOfLuGiC05sAJ3
LH1406e3hl+T3RCvH6qdaOEPRZGv0w==
=HLVW
-----END PGP SIGNATURE-----

--VmfVJFEGgN9StJp1y290zpAakRYFAsMKO--
