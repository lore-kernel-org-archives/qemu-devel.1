Received: from eggs.gnu.org ([2001:4830:134:3::10]:45948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e38XM-0007b5-Jz
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 18:34:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e38XL-0002G0-JY
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 18:34:36 -0400
References: <20171012095319.136610-1-vsementsov@virtuozzo.com>
	<20171012095319.136610-12-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <190b8cd5-9efc-3a25-ab94-64281daed584@redhat.com>
Date: Fri, 13 Oct 2017 17:34:26 -0500
MIME-Version: 1.0
In-Reply-To: <20171012095319.136610-12-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rAETFm5rBQ459MWG25F5FScLC6jK8MQKl"
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
--rAETFm5rBQ459MWG25F5FScLC6jK8MQKl
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org
Message-ID: <190b8cd5-9efc-3a25-ab94-64281daed584@redhat.com>
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

By the end of your series, I still don't see any use of

> +++ b/include/block/nbd.h

> @@ -235,4 +272,15 @@ void nbd_client_put(NBDClient *client);
>  void nbd_server_start(SocketAddress *addr, const char *tls_creds,
>                        Error **errp);
> =20
> +/* nbd_read
> + * Reads @size bytes from @ioc. Returns 0 on success.
> + */
> +static inline int nbd_read(QIOChannel *ioc, void *buffer, size_t size,=

> +                           Error **errp)
> +{
> +    return qio_channel_read_all(ioc, buffer, size, errp) < 0 ? -EIO : =
0;
> +}
> +
> +int nbd_drop(QIOChannel *ioc, size_t size, Error **errp);

either of these functions in block/nbd-client.c.  I think that's a good
thing (we refactored it so that nbd/client.c is doing ALL the reading
from the wire, and block/nbd-client.c is relying on nbd/client.c to do
the work), but it means this part of the patch is no longer necessary,
unless I'm missing something.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--rAETFm5rBQ459MWG25F5FScLC6jK8MQKl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnhP3IACgkQp6FrSiUn
Q2oRcwf/ZWZgj+b++5seJ9C7MPUgzn5FjEH2A+U2YufSgOHuX8Onfs02zFB++8ez
eeJwQu9D08Y9fAEmRR/PrUlJvVa+EZnGdiQMQcUfU0xlrFNZVs4zHYPDsRTI4nsH
GbGzzcdhOwKnR0Ho6LKomYZ5iPgr14+WLLuEpjfakk+rZVrneKbyrHBbpGSEWSl1
UkVHNncb5PLChtoBV8n/gW1uMPwINnBBAGwtIzhKavXHQ9wxDyRSjCjSfvZuANEb
gMw/HSZ0aOmlIw6S2y43C5aUuyfURNomT0MId8EHW0EwnFepklNjMhETw40dw9iZ
YJrgYCCnUH30Sq8y6H0DM02xGepfCQ==
=aqD8
-----END PGP SIGNATURE-----

--rAETFm5rBQ459MWG25F5FScLC6jK8MQKl--
