Received: from eggs.gnu.org ([2001:4830:134:3::10]:46798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX7rB-0000YL-8L
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX7rA-00005O-Ar
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:22:45 -0400
References: <20170717151207.24919-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1c8802d4-d8e3-1a9e-d5e9-885f8ef050f3@redhat.com>
Date: Mon, 17 Jul 2017 10:22:37 -0500
MIME-Version: 1.0
In-Reply-To: <20170717151207.24919-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rvEtU8vXrxeXBVHejM8HIC4qtl719kOLT"
Subject: Re: [Qemu-devel] [PATCH] block/vvfat: Fix compiler warning with gcc
 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rvEtU8vXrxeXBVHejM8HIC4qtl719kOLT
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>, qemu-devel@nongnu.org
Message-ID: <1c8802d4-d8e3-1a9e-d5e9-885f8ef050f3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block/vvfat: Fix compiler warning with gcc 7
References: <20170717151207.24919-1-mreitz@redhat.com>
In-Reply-To: <20170717151207.24919-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/17/2017 10:12 AM, Max Reitz wrote:
> gcc 7 complains that the sprintf() might write a null byte beyond the
> end of the tail buffer.  That is wrong, but we can silence it by making=

> i unsigned (it can never be negative anyway, see the if condition right=

> before).  For some reason, this allows gcc to suddenly accurately
> calculate the range of i so we can give the tail[] array the exact size=

> it needs to have (which is 8 bytes) without gcc complaining.
>=20
> In addition, let us convert the sprintf() to snprintf(), because that i=
s
> always nicer, and add an assertion about the range of the return value
> afterwards so we can see that "8 - len" will never be negative and thus=

> "entry->name + MIN(j, 8 - len)" will never be out of bounds.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/vvfat.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rvEtU8vXrxeXBVHejM8HIC4qtl719kOLT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlls1j0ACgkQp6FrSiUn
Q2oVoggAiyjzlkYHcLyyhFIiNbN5h1pXqLFYbaOP/WWFq7njAt1OHH0Fx3PEVxOA
v11SjD8WqJ6zCsIMOVy5ctX3AXixnkBmchW5jn9jz5T4BPwsmjASgzY+73AoDmFW
OwgQEEhOOg9OLMvvHRWffMwwn6fKlndhO42237fl7m+ZwjiHCK6Aw8ikGxfwE24Z
/GkxT8FTYMLwkG7gE2xDB7QnkB9zqcJ096Z34QYWLDT5rSp/PZbHBfPCuD8dIcSn
bD/IdU0s+0O+DRVacCzya49hX+PmmpxHJWBNIN34O0GSYhfKvrzf+Ft9kxrAPICs
H/RU6P4OdNGFKDtpe06Zim1wB62CSQ==
=TE8n
-----END PGP SIGNATURE-----

--rvEtU8vXrxeXBVHejM8HIC4qtl719kOLT--
