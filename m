Received: from eggs.gnu.org ([2001:4830:134:3::10]:49946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3SIT-0006TW-Qj
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3SIS-0006H1-MX
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:08:17 -0400
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
	<1493192202-3184-5-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83a3c9fd-a19b-a579-116c-c87b03101ab4@redhat.com>
Date: Wed, 26 Apr 2017 14:08:06 -0500
MIME-Version: 1.0
In-Reply-To: <1493192202-3184-5-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8W8JwwMQW4xkxamVhhi1CbeCsoEVa1hSU"
Subject: Re: [Qemu-devel] [PATCH 4/7] sockets: Rename SocketAddress to
 SocketAddressLegacy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8W8JwwMQW4xkxamVhhi1CbeCsoEVa1hSU
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org
Message-ID: <83a3c9fd-a19b-a579-116c-c87b03101ab4@redhat.com>
Subject: Re: [PATCH 4/7] sockets: Rename SocketAddress to SocketAddressLegacy
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
 <1493192202-3184-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1493192202-3184-5-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 02:36 AM, Markus Armbruster wrote:
> The next commit will rename SocketAddressFlat to SocketAddress, and
> the commit after that will replace most uses of SocketAddressLegacy by
> SocketAddress, replacing most of this commit's renames right back.
>=20
> Note that checkpatch emits a few "line over 80 characters" warnings.
> The long lines are all temporary; the SocketAddressLegacy replacement
> will shorten them again.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> @@ -530,17 +530,17 @@ static void sd_aio_setup(SheepdogAIOCB *acb, BDRV=
SheepdogState *s,
>      QLIST_INSERT_HEAD(&s->inflight_aiocb_head, acb, aiocb_siblings);
>  }
> =20
> -static SocketAddress *sd_socket_address(const char *path,
> +static SocketAddressLegacy *sd_socket_address(const char *path,
>                                          const char *host, const char *=
port)

And the indentation will get fixed up later, too.


> @@ -205,12 +205,12 @@ void qio_channel_socket_dgram_async(QIOChannelSoc=
ket *ioc,
>   * Get the string representation of the local socket
>   * address. A pointer to the allocated address information
>   * struct will be returned, which the caller is required to
> - * release with a call qapi_free_SocketAddress when no
> + * release with a call qapi_free_SocketAddressLegacy() when no

I see you did slightly more than just a mechanical change. That's okay.

Mostly mechanical (since the compiler complains if you still use the old
name of the struct or enum values), but I'm glad you also corrected
comments.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8W8JwwMQW4xkxamVhhi1CbeCsoEVa1hSU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAPAWAAoJEKeha0olJ0Nq41wH/jKfc3pudSHdmg3vNRTw4wGR
BXEzuHNfvJi0PE++DzkMeETEpfbaxUtHYoks2D910VDWqlzH64MxF2IHLkR7Tw5V
pl84mV9I52K3Lhe/0ZOS0o4ge8R8fyfltl296GK1m/DVNqPzBHxT/6a1evNMuGAM
MIgoc3kJOw4NT+z4nNO4zUBXCwtFgGCHCe6UzzTq8iakP53XHrBOYi2Ne3ZE5y+D
9Hu37T12UJIGqDOJJk+KjF52oZiGD/ZqFB9Nf+G3gtaZeR+j7Bboshxa9XEd3E3u
0YgvOMALHFpAz8UCeK8zxXlohe4bt87Epyo/ZC5jVE4SHeD8uW9GgQK4kBOAG00=
=FZ9A
-----END PGP SIGNATURE-----

--8W8JwwMQW4xkxamVhhi1CbeCsoEVa1hSU--
