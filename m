Received: from eggs.gnu.org ([2001:4830:134:3::10]:53754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNYB-0004ao-0r
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:23:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNY8-0007Sm-Da
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:23:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWNY8-0007Sc-86
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:23:44 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6EB158124D
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 13:23:44 +0000 (UTC)
Date: Wed, 25 Jan 2017 13:23:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125132341.GE10664@stefanha-x1.localdomain>
References: <20170124180420.12430-1-pbonzini@redhat.com>
	<20170124180420.12430-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <20170124180420.12430-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/8] exec: make address_space_cache_destroy
 idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 07:04:16PM +0100, Paolo Bonzini wrote:
> Clear cache->mr so that address_space_cache_destroy does nothing
> the second time it is called.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiKbdAAoJEJykq7OBq3PISFMH/1GJD0Eo8Z0vveShm+rgn0af
zAWoFVsGOi44X5cQ2VAshrRvlhv1XGyEvtG5ZfVzC8HI7fhs25BX5fMqTC2YVXn7
pnaR4mMSrAokpKTUpVAJgpmUoAJJlhyVHw2XBbw4Y3BGaA9bCaVGtVGdC2EJMKai
ILGNvsKGsATSb+4b6mTLoSLEufFveqfltSW39JX2kTw4JxfdkFmUJvwzctGjIiPt
qwIO5XxwJOv0Eaf46fo9uxEvwEcdv8wnoc8VmG11mCG5BbT/74rCDN069lqMvwPF
W9flpDwPPuYcItQDmC88Y/9WBixr5dfwlqzFJcY76gvxkVH+79xjhK8UCld4E5M=
=UAmB
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
