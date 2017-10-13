Received: from eggs.gnu.org ([2001:4830:134:3::10]:54077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e35F2-00053d-NT
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 15:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e35F1-0000HB-LN
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 15:03:28 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-12-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6d3f5370-ee6c-ca57-dfea-86532a33fd38@redhat.com>
Date: Fri, 13 Oct 2017 14:03:17 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-12-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ITRjT6f4fnhvT0i0BDBBIc52S9nDEk4xS"
Subject: Re: [Qemu-devel] [PATCH v3 11/13] nbd: share some nbd entities to
 be reused in block/nbd-client.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ITRjT6f4fnhvT0i0BDBBIc52S9nDEk4xS
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <6d3f5370-ee6c-ca57-dfea-86532a33fd38@redhat.com>
Subject: Re: [PATCH v3 11/13] nbd: share some nbd entities to be reused in
 block/nbd-client.c
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
 <20171012095319.136610-12-vsementsov@virtuozzo.com>
In-Reply-To: <20171012095319.136610-12-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 04:53 AM, Vladimir Sementsov-Ogievskiy wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  include/block/nbd.h | 48 +++++++++++++++++++++++++++++++++++++++++++++=
+++
>  nbd/nbd-internal.h  | 25 -------------------------
>  nbd/client.c        | 32 --------------------------------
>  3 files changed, 48 insertions(+), 57 deletions(-)
>=20

Another thing I noticed looking at this patch:

> diff --git a/include/block/nbd.h b/include/block/nbd.h
> index dd261f66f0..09e4592971 100644
> --- a/include/block/nbd.h
> +++ b/include/block/nbd.h
> @@ -77,6 +77,9 @@ typedef struct NBDStructuredReplyChunk {
>      uint32_t length; /* length of payload */
>  } QEMU_PACKED NBDStructuredReplyChunk;
> =20
> +#define NBD_SIMPLE_REPLY_MAGIC      0x67446698
> +#define NBD_STRUCTURED_REPLY_MAGIC  0x668e33ef

We have some churn here, as we defined this earlier in the series.
Also, in an ideal world (although I don't know if we're quite there), we
should be able to backport patches for JUST the server, or for JUST the
client, in isolation, to talk to an independent implementation on the
other side of the wire.  To do that, it may be better to define all our
new constants in a standalone patch, rather than embedded as part of the
server implementation in 9/13.

I think at this point, I will take 1-8 as amended, and even prepare a
pull request for those, and then post a v4 series based on your work but
with some things moved around, and get consensus on my changes, before
worrying about the pull request for the second half.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ITRjT6f4fnhvT0i0BDBBIc52S9nDEk4xS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnhDfUACgkQp6FrSiUn
Q2pU4wf/VSHIwnpuNugEVbJTxJIaj10z9evU+epHE8ndpJYV/qYe3SYeY22n6qMB
SIa1j4kQ003m8lRe7jXNQXA5CX/+ANyf9EgzaGGQ6RB+ZPXHYLF54uUEwjO5uBqa
cXJe7ezkRcJw683E1C0cC+7mgw7PKyoAxzzTVtH7j9tHsyaQhn4RDvxOknoSbkeh
28ObNfQntQ9oxOctPV2niRQYXqiAfRutxF9gwSe4PMsd7tnvxP8b66xe+40uh/k7
Cw+tNCMG3e2mY0WQ7srNIsiUWAWnMccLDtpvXMNoVk2yy+ytuutxAWxB6cv+Cuu6
Yk6xL5mWZCRwT0tHNuAm+N/wYrImpw==
=D108
-----END PGP SIGNATURE-----

--ITRjT6f4fnhvT0i0BDBBIc52S9nDEk4xS--
