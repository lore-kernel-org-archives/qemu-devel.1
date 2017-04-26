Received: from eggs.gnu.org ([2001:4830:134:3::10]:51566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3SPI-0001q8-3o
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3SPH-0003L7-6F
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:15:20 -0400
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
	<1493192202-3184-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dea849b3-1b75-73c3-e4b8-00b910eddc57@redhat.com>
Date: Wed, 26 Apr 2017 14:15:09 -0500
MIME-Version: 1.0
In-Reply-To: <1493192202-3184-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TEGfMO1f0GBBfxhrPaPsqgaUkNorsXTji"
Subject: Re: [Qemu-devel] [PATCH 5/7] sockets: Rename SocketAddressFlat to
 SocketAddress
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
--TEGfMO1f0GBBfxhrPaPsqgaUkNorsXTji
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, kraxel@redhat.com, pbonzini@redhat.com,
 qemu-block@nongnu.org
Message-ID: <dea849b3-1b75-73c3-e4b8-00b910eddc57@redhat.com>
Subject: Re: [PATCH 5/7] sockets: Rename SocketAddressFlat to SocketAddress
References: <1493192202-3184-1-git-send-email-armbru@redhat.com>
 <1493192202-3184-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1493192202-3184-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/26/2017 02:36 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/gluster.c        | 48 ++++++++++++++++++++++++------------------=
------
>  block/nbd.c            | 26 +++++++++++++-------------
>  block/sheepdog.c       |  6 +++---
>  include/qemu/sockets.h |  4 ++--
>  qapi-schema.json       | 14 +++++++-------
>  qapi/block-core.json   |  6 +++---
>  util/qemu-sockets.c    | 10 +++++-----
>  7 files changed, 57 insertions(+), 57 deletions(-)
>=20
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TEGfMO1f0GBBfxhrPaPsqgaUkNorsXTji
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAPG9AAoJEKeha0olJ0NqBPQH/0AP0SYuIzB78382atmgNe6i
RINDhNYo0WEhNlaa9wah1r7JgyWBmPu6eCSYA4/wJbWviXUIBxjp93rUC2F4GjC8
3AfgbvSCls9M92dIYW+2I9hWh9y4O8cliJbarzuERzY6maLCBMMaTgGlJsga0Tpu
n38jtCizdkN9JgWQzKuElyuHOzQedlGWC3gvwNRQU6WBn8Z4kcloeEwXDdt6ykQR
twL8niR49FmNl0gBqbUoDmVnaxg/HTzbNtAOfRONFtPP4rqES6tGuyX45/bcJUt9
yuQ67Vwzn/WgxHTD7kB/RoCpD4gKLwnujXhBr3TAiOB/PI1LI62l+ZKOGikXSDg=
=7ICC
-----END PGP SIGNATURE-----

--TEGfMO1f0GBBfxhrPaPsqgaUkNorsXTji--
