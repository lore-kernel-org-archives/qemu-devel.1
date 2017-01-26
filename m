Received: from eggs.gnu.org ([2001:4830:134:3::10]:35813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cWpCV-000780-MC
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:55:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cWpCS-00038w-TO
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:55:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cWpCS-00038j-Kt
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 13:55:12 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 644A87FB8F
	for <qemu-devel@nongnu.org>; Thu, 26 Jan 2017 18:55:12 +0000 (UTC)
References: <20170126171613.1399-1-stefanha@redhat.com>
	<20170126171613.1399-3-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3bbf9804-ce99-0ce5-e6f4-7a1b3f96e055@redhat.com>
Date: Thu, 26 Jan 2017 12:55:10 -0600
MIME-Version: 1.0
In-Reply-To: <20170126171613.1399-3-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xTixOxIMto6KAxncqKcRhmfAqrOpSfJe2"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] trace: clean up trace-events files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xTixOxIMto6KAxncqKcRhmfAqrOpSfJe2
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Message-ID: <3bbf9804-ce99-0ce5-e6f4-7a1b3f96e055@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] trace: clean up trace-events files
References: <20170126171613.1399-1-stefanha@redhat.com>
 <20170126171613.1399-3-stefanha@redhat.com>
In-Reply-To: <20170126171613.1399-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/26/2017 11:16 AM, Stefan Hajnoczi wrote:
> There are a number of unused trace events that
> scripts/cleanup-trace-events.pl finds.  The "hw/vfio/pci-quirks.c"
> filename was typoed and "qapi/qapi-visit-core.c" was missing the qapi/
> directory prefix.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/trace-events      | 2 --
>  hw/block/trace-events   | 1 -
>  hw/display/trace-events | 1 -
>  hw/i386/trace-events    | 1 -
>  hw/input/trace-events   | 2 --
>  hw/intc/trace-events    | 1 -
>  hw/net/trace-events     | 8 --------
>  hw/usb/trace-events     | 1 -
>  hw/vfio/trace-events    | 2 +-
>  migration/trace-events  | 3 ---
>  qapi/trace-events       | 2 +-
>  trace-events            | 1 -
>  12 files changed, 2 insertions(+), 23 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xTixOxIMto6KAxncqKcRhmfAqrOpSfJe2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYikYOAAoJEKeha0olJ0NqV7YH/iUliA2ZMscuQbQqR/aZxi+B
pwMWxUj3wAg6f9J3kxSPhGj8ZPkNmMM1KwIv6dj6DeBIw82sBWIhX6X4t+TFBtPy
oBifg79eu0J/1PNWhhVzJcmTQBgfMsU01sNDY1x7Ncr698vbR4Te06zIC2pwagZ8
NlCj/CHNm9ULMNE/u69LEr4MEmL83pVMdF8RCuyzbdWlt18u+BJdo11GwA2g6idw
WFpcmSEMaDh4cgSfv9r4PNlpQvU0zeFArgMnK1x9ii908/iJ462ajiUZZbwRH4qe
AyLCUxIeBoDe0sMGz/aAVrrzmQhboGSSCTY03puKqHyfWUAlWijCv+1MJyvtgZ0=
=5WbF
-----END PGP SIGNATURE-----

--xTixOxIMto6KAxncqKcRhmfAqrOpSfJe2--
