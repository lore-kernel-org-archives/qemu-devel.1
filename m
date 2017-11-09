Received: from eggs.gnu.org ([2001:4830:134:3::10]:51785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCneV-0005Ai-84
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:17:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eCneP-0000bt-DM
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:17:55 -0500
References: <20171108165519.8931-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <deee0973-665c-c170-1248-e99331b68272@redhat.com>
Date: Thu, 9 Nov 2017 08:17:43 -0600
MIME-Version: 1.0
In-Reply-To: <20171108165519.8931-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LK0wnlEnCm1x3hRjbVbJPMwtVSbVHW5pD"
Subject: Re: [Qemu-devel] [PATCH v2] coroutine: Fix documentation of
 co_aio_sleep_ns()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com, Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LK0wnlEnCm1x3hRjbVbJPMwtVSbVHW5pD
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, pbonzini@redhat.com,
 Kevin Wolf <kwolf@redhat.com>, stefanha@redhat.com
Message-ID: <deee0973-665c-c170-1248-e99331b68272@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] coroutine: Fix documentation of
 co_aio_sleep_ns()
References: <20171108165519.8931-1-eblake@redhat.com>
In-Reply-To: <20171108165519.8931-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/08/2017 10:55 AM, Eric Blake wrote:
> co_sleep_ns() was removed in commit 0b9caf9b, leaving behind a
> stale comment.  Update the documentation to match the current
> usage of this function.
>=20
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v2: instead of just blindly cribbing from Paolo's email, try to incorpo=
rate
> the feedback given on the wording
> ---
>  include/qemu/coroutine.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Self-NAK; superseded by:
https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg01681.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LK0wnlEnCm1x3hRjbVbJPMwtVSbVHW5pD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloEY4cACgkQp6FrSiUn
Q2rkxgf/QOX51KbwsGwss5HRE2wuAuoK5tYl3o3ZL5TCvcNNg6UTATEoU0ROIImw
7ChpJHaUlyf9n6hTADYoneEeSx9E8h9X535MTypNJOPDgBxIuXh6GsxjUDbJWCiT
Tktk2MCJtDqmE2kvtn65k4PMsRglYZe7MyMtDIVghyu3BTGclYrRWSjmGRca0L4N
MkHaum/r0itOp1aQ89yOtefp9bQ6xw2mCH1VAsp41WxaYWAg2Qgkz1QiJCrCScyx
KA0sTF6/X9fNUrWChhPks9MzrwZ9z3eJQqBxo4ohBeoZpFpHOiUNX0K/XyYK90d7
ZIGXLx+LCt4h05nG0ptmPzjeoAwVxg==
=eKXD
-----END PGP SIGNATURE-----

--LK0wnlEnCm1x3hRjbVbJPMwtVSbVHW5pD--
