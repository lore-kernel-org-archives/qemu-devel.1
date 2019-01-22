Received: from eggs.gnu.org ([209.51.188.92]:45028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1nd-0007fO-VC
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:33:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gm1h6-00062p-F0
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:26:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gm1h6-000600-4V
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:26:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E5B77C00F09F
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 16:58:40 +0000 (UTC)
References: <20181219120904.17643-1-kraxel@redhat.com>
	<20181219120904.17643-3-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <082fa9be-d1d1-4bab-2df8-acac309d707a@redhat.com>
Date: Tue, 22 Jan 2019 10:58:36 -0600
MIME-Version: 1.0
In-Reply-To: <20181219120904.17643-3-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uMwxdbVXBs5cJmOGCDRbn0D2T9D86o9Hm"
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/7] kbd-state: use state tracker
 for sdl2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uMwxdbVXBs5cJmOGCDRbn0D2T9D86o9Hm
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <082fa9be-d1d1-4bab-2df8-acac309d707a@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/7] kbd-state: use state tracker for
 sdl2
References: <20181219120904.17643-1-kraxel@redhat.com>
 <20181219120904.17643-3-kraxel@redhat.com>
In-Reply-To: <20181219120904.17643-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/19/18 6:08 AM, Gerd Hoffmann wrote:
> Use the new keyboard state tracked for sdl2.  We can drop the modifier

s/tracked/tracker/ ?

> state tracking from sdl2.  Also keyup code is simpler, the state tracke=
r
> will take care to not send suspious keyup events to the guest.

s/suspious/suspicious/

>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/sdl2.h |  2 ++
>  ui/sdl2-input.c   | 40 +++-------------------------------------
>  ui/sdl2.c         | 12 +++---------
>  3 files changed, 8 insertions(+), 46 deletions(-)
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--uMwxdbVXBs5cJmOGCDRbn0D2T9D86o9Hm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxHS7wACgkQp6FrSiUn
Q2rZ1AgAmJEmBX4tWKHBX5mGShsxhuI1+FJtSloES2SG3PlEjf1u2qS2GZhBK7jn
621HiK1B07u5To7izlqe/COp82FEwAKDW+o+TM+8i7dEfh4E+cNSQUzXJ0eSafmL
3w2qwCSb+SscD5EhfyP2cxwgwjnNLCeB5+kXVWuUcxhizBydJi0zy5moZ3EtMWZ3
o+LfmW5r+L2EOfZ+hEHWLBmCsh1Fi9+/oJVQcYzKfv2W2OEAlqGqIIt5UNCC3R2D
7QbVSRp2YM8QTrMvd1mxxm9DpNoqQ/3Np1IwNw11ePujvLlHZUX52196EG2h2Sqx
n0GChlNXeXSBmek+xlqwmAxnUbyMuQ==
=8r+J
-----END PGP SIGNATURE-----

--uMwxdbVXBs5cJmOGCDRbn0D2T9D86o9Hm--
