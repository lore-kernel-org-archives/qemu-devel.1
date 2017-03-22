Received: from eggs.gnu.org ([2001:4830:134:3::10]:56977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqgyZ-0005oA-Bb
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cqgyU-0005hv-MX
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:10:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1cqgyU-0005ff-BS
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:10:54 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 858C1C05491E
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 14:10:53 +0000 (UTC)
References: <1490115473-24839-1-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dbbe78d8-2c09-2832-89f4-51b50ee6bb8f@redhat.com>
Date: Wed, 22 Mar 2017 15:10:47 +0100
MIME-Version: 1.0
In-Reply-To: <1490115473-24839-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pDLax4CrQ5QXfljVPrUrAKlHKI5qLUQbN"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pDLax4CrQ5QXfljVPrUrAKlHKI5qLUQbN
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com
Message-ID: <dbbe78d8-2c09-2832-89f4-51b50ee6bb8f@redhat.com>
Subject: Re: [PATCH for-2.9] block: Declare blockdev-add and blockdev-del
 supported
References: <1490115473-24839-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1490115473-24839-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.03.2017 17:57, Markus Armbruster wrote:
> It's been a long journey, but here we are.
>=20
> x-blockdev-remove-medium, x-blockdev-insert-medium and
> x-blockdev-change need a bit more work, so leave them alone for now.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  blockdev.c             |  4 ++--
>  qapi/block-core.json   | 14 +++++---------
>  tests/qemu-iotests/139 |  8 ++++----
>  tests/qemu-iotests/141 |  4 ++--
>  tests/qemu-iotests/147 |  2 +-
>  5 files changed, 14 insertions(+), 18 deletions(-)

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0f132fc..5d913d4 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2907,11 +2907,7 @@
>  # BlockBackend will be created; otherwise, @node-name is mandatory at =
the top
>  # level and no BlockBackend will be created.
>  #
> -# Note: This command is still a work in progress.  It doesn't support =
all
> -# block drivers among other things.  Stay away from it unless you want=

> -# to help with its development.
> -#
> -# Since: 1.7
> +# Since: 2.9
>  #
>  # Example:
>  #
> @@ -2957,7 +2953,7 @@
>  { 'command': 'blockdev-add', 'data': 'BlockdevOptions', 'boxed': true =
}
> =20
>  ##
> -# @x-blockdev-del:
> +# @blockdev-del:
>  #
>  # Deletes a block device that has been added using blockdev-add.
>  # The command will fail if the node is attached to a device or is
> @@ -2969,7 +2965,7 @@
>  # experimental. Stay away from it unless you want to help with its
>  # development.

This part of the comment very much looks like it should be removed.

Max

>  #
> -# Since: 2.5
> +# Since: 2.9
>  #
>  # Example:
>  #

[...]



--pDLax4CrQ5QXfljVPrUrAKlHKI5qLUQbN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljShecSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ACf0IAJZF2JrHoyBIBKGZ+y4l0UWRvEJXX47B
DCW5XvTNjgIcXTTjV3bpD6Yky4F7rqqxSzQb51Vh0xpuZRqx0oHUJBWj00FQDKRQ
r5lnInHJd3yn52FdKi3nUso80un1mJ5qrPhFM1wsD+DsVLuTHNDiTxtPsHCgaYpK
ci+MZ4O0OjRm79nK+yBjGk4KcJrGShNUxx1Wqq0alckK84WecmIihYeN8gyeipzv
CRf+opSoVBAvTk0x9Dc1EqjoQbtr/QA81d5kkCdS/xHvp9KKcTun9eRzMhfPlqRj
TuFBlOJXCMvipxRPEwXg6TQnf5RolRQtJlGIu2OQqkjdT5zv0arBi9g=
=tjkA
-----END PGP SIGNATURE-----

--pDLax4CrQ5QXfljVPrUrAKlHKI5qLUQbN--
