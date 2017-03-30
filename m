Received: from eggs.gnu.org ([2001:4830:134:3::10]:57594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctbC2-0007wP-2Z
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:36:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctbBw-0005A5-Hq
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 10:36:54 -0400
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
	<1490879707-6060-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <88188f21-a5b3-2e0f-99f1-66b13d772b96@redhat.com>
Date: Thu, 30 Mar 2017 09:36:40 -0500
MIME-Version: 1.0
In-Reply-To: <1490879707-6060-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IHe3I5OQaL3QIOHKLeM1wCfk1RSSq2GAT"
Subject: Re: [Qemu-devel] [RFC v2 for-2.9 06/10] qapi-schema:
 SocketAddressFlat variants 'vsock' and 'fd'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IHe3I5OQaL3QIOHKLeM1wCfk1RSSq2GAT
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com,
 pbonzini@redhat.com
Message-ID: <88188f21-a5b3-2e0f-99f1-66b13d772b96@redhat.com>
Subject: Re: [RFC v2 for-2.9 06/10] qapi-schema: SocketAddressFlat variants
 'vsock' and 'fd'
References: <1490879707-6060-1-git-send-email-armbru@redhat.com>
 <1490879707-6060-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1490879707-6060-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 08:15 AM, Markus Armbruster wrote:
> Note that the new variants are impossible in qemu_gluster_glfs_init(),
> because the gconf->server can only come from qemu_gluster_parse_uri()
> or qemu_gluster_parse_json(), and neither can create anything but
> 'inet' or 'unix'.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/gluster.c  |  2 ++
>  qapi-schema.json | 19 ++++++++-----------
>  2 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


> -# 2. SocketAddressFlat supports only types 'unix' and 'inet', because
> -#    that's what its current users need.
> +# This is just like SocketAddress, except it's a flat union rather
> +# than a simple union.  Nicer because it avoids nesting (i.e. more {})=

> +# on the wire.

I know that you are explaining that it is "nesting" which means "more
{}", but it is SocketAddress that has the extra {}, not
SocketAddressFlat.  I wonder if it reads any better as:

Nicer because it avoids nesting on the wire (i.e. this form has fewer {})=
=2E

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IHe3I5OQaL3QIOHKLeM1wCfk1RSSq2GAT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3Rf4AAoJEKeha0olJ0Nq9UMH/1MVQTXcQJdr6lQ80O0lSDD3
OJh1aXl/vMTNQaMnpMmk+BA8RyOXNrTDHOOdHFF9N17VGZyOtwRdzdomWgPbCRBk
psH5lrffBueb+fgAI8fW0oiGXs8L2eYNG9RfVFneXqBCSQoopM6qkrEyJLeu5v4D
AS2tKy1tSgD58KmQiMHCr4+MuGF4qkOkwof9AhSTGYt0dDiBN6We4wQY8UksRGS1
jRsyXeWJp7RNL5QOwClxCAAoTmI9MpUgvPtrdURPQo8P5FxG4irbSAgKfc5PpUCB
P818oHAwoSSUdgfiCbbl09sS+vRV6ZOOKhn6WfsT0RjJFCnB8q64ast+n2uMnko=
=RKHW
-----END PGP SIGNATURE-----

--IHe3I5OQaL3QIOHKLeM1wCfk1RSSq2GAT--
