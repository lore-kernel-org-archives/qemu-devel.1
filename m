Received: from eggs.gnu.org ([2001:4830:134:3::10]:59526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGVPw-000707-PD
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fGVPv-0007nu-TE
	for qemu-devel@nongnu.org; Wed, 09 May 2018 16:10:28 -0400
References: <20180502140359.18222-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <8efe25d9-c89e-9582-e2a0-57812441556e@redhat.com>
Date: Wed, 9 May 2018 22:10:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180502140359.18222-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2JmkDyjfOU2vbHaBCYiDYGgoxUpVYSt8n"
Subject: Re: [Qemu-devel] [PATCH] block: Document BDRV_REQ_WRITE_UNCHANGED
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2JmkDyjfOU2vbHaBCYiDYGgoxUpVYSt8n
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <8efe25d9-c89e-9582-e2a0-57812441556e@redhat.com>
Subject: Re: [PATCH] block: Document BDRV_REQ_WRITE_UNCHANGED support
References: <20180502140359.18222-1-mreitz@redhat.com>
In-Reply-To: <20180502140359.18222-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 16:03, Max Reitz wrote:
> Add BDRV_REQ_WRITE_UNCHANGED to the list of flags honored during pwrite=

> and pwrite_zeroes, and also add a note on when you absolutely need to
> support it.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> I did not include a note on how this might be useful to protocol
> drivers, because BDRV_REQ_WRITE_UNCHANGED requests will usually not end=

> up on the protocol level anyway.
> (I suppose it would be possible in theory if a protocol driver reports =
a
>  certain range as unallocated and the user installs a copy-on-read
>  driver on top, but I think every protocol driver currently reports
>  everything as allocated.)
> ---
>  include/block/block_int.h | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Thanks for the review, applied to my block branch.

Max


--2JmkDyjfOU2vbHaBCYiDYGgoxUpVYSt8n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrzVaoACgkQ9AfbAGHV
z0BtWwf/TcyC+SIMs+9v7iarT1k6tD+jZUQCDwQXaFICc5ikkax6OtWRWU2IG03+
cb+yhdiUq/4f4yMcHFiBAeagWE+JQA+clQ7N5dLBT06CB2Ny5Iwu8JITRMHbNyPf
UfYjLSCOlgK7tLPJTTUeI1Ff+XXzf8TAz6w6JUZTgShQyAUb0QD/CbSNs0IRjDqs
E5ngnU76L6yu5SJ0+0UmCiKp7v/hZhbi83+J+Z7ZflBsRT+Qjw71Sw1KuKQYstXa
Sru/7BbvsI5P0TyGxFagpr4ziQKWFhAm1QbNgkxcpthX/pQT3ON6kAuxjSt7Buou
jDOnN1VmSZDrP38Ra5sUI1KGvKsfug==
=oZgp
-----END PGP SIGNATURE-----

--2JmkDyjfOU2vbHaBCYiDYGgoxUpVYSt8n--
