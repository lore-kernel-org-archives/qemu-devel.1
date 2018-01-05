Received: from eggs.gnu.org ([2001:4830:134:3::10]:58009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXVec-0002ec-S3
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eXVeZ-0007wp-OR
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:19:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eXVeZ-0007w4-Ev
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 12:19:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7102078238
	for <qemu-devel@nongnu.org>; Fri,  5 Jan 2018 17:19:34 +0000 (UTC)
References: <20180105170138.23357-1-dgilbert@redhat.com>
	<20180105170138.23357-3-dgilbert@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9926ed69-39de-4a56-17ca-c447fe57582c@redhat.com>
Date: Fri, 5 Jan 2018 11:19:31 -0600
MIME-Version: 1.0
In-Reply-To: <20180105170138.23357-3-dgilbert@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AKOqPzx7SnZmBOc7WALugRWjFzkHyRdOu"
Subject: Re: [Qemu-devel] [PATCH 2/2] find_ram_offset: Align ram_addr_t
 allocation on long boundaries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AKOqPzx7SnZmBOc7WALugRWjFzkHyRdOu
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Message-ID: <9926ed69-39de-4a56-17ca-c447fe57582c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] find_ram_offset: Align ram_addr_t
 allocation on long boundaries
References: <20180105170138.23357-1-dgilbert@redhat.com>
 <20180105170138.23357-3-dgilbert@redhat.com>
In-Reply-To: <20180105170138.23357-3-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2018 11:01 AM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> The dirty bitmaps are built from 'long'sand there is fast-path code

s/'long'sand/'long's, and/

> for synchronising the case where the RAMBlock is aligned to the start
> of a long boundary.  Align the allocation to this boundary
> to cause the fast path to be used.
>=20

> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  exec.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/exec.c b/exec.c
> index 7966570231..644603f05e 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1694,6 +1694,11 @@ static ram_addr_t find_ram_offset(ram_addr_t siz=
e)
>              }
>          }
> =20
> +        /* Align blocks to start on a 'long' in the bitmap
> +         * which makes the bitmap sync'ing take the fast path.
> +         */
> +        end =3D ROUND_UP(end, BITS_PER_LONG << TARGET_PAGE_BITS);
> +
>          /* If it fits remember our place and remember the size
>           * of gap, but keep going so that we might find a smaller
>           * gap to fill so avoiding fragmentation.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AKOqPzx7SnZmBOc7WALugRWjFzkHyRdOu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpPs6MACgkQp6FrSiUn
Q2qGgQgAhAgKXKGtAJA27PP4HCu0FIPiUuFrimrHwnXaE8NkK02V079wqFYhscXJ
yPe3doDKkNVxTFKvsFAFZoUsLDwZHYB2IjORntnskJWpUYcrArNIMutIt5wcbs+7
rpuLs6IeGUPlmqe4SR7ext3YmCq9m/oTN/mCeVmT0ZkKg7Yo2vds5uckKnv4KD6a
TjY1j6Cgl+Zjjbemyc3Q0tGT4h5Rl9F+6hSRZhYTztGf2dc2EKYteQiAOBh/Kefs
+D7+HaAjLFu1xq3yVMCGVkqmydrrWScVJ37Y2j0VfVjB4Xjll6B7Sv7dE/uyY+63
VDDhOLrQV9I9LtzODXQ0a89vZzkAcA==
=qylX
-----END PGP SIGNATURE-----

--AKOqPzx7SnZmBOc7WALugRWjFzkHyRdOu--
