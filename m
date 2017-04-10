Received: from eggs.gnu.org ([2001:4830:134:3::10]:41565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxbEy-0005Qs-Us
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxbEu-0002NM-BB
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:28:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cxbEu-0002Mu-4U
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 11:28:24 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 017A880F8D
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 15:28:23 +0000 (UTC)
References: <20170410142112.11550-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <01d19d9a-b809-c300-bc83-ffe344175cea@redhat.com>
Date: Mon, 10 Apr 2017 10:28:14 -0500
MIME-Version: 1.0
In-Reply-To: <20170410142112.11550-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lDsLq0evFutUkwDBQ5NLUh4UvNAQ5ENQQ"
Subject: Re: [Qemu-devel] [PATCH] test-keyval: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lDsLq0evFutUkwDBQ5NLUh4UvNAQ5ENQQ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <01d19d9a-b809-c300-bc83-ffe344175cea@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] test-keyval: fix leaks
References: <20170410142112.11550-1-marcandre.lureau@redhat.com>
In-Reply-To: <20170410142112.11550-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/10/2017 09:21 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/test-keyval.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

Leaks in the testsuite are not showstoppers, so I'm okay if we defer it
to 2.10 to minimize churn now that we are late in hard freeze.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lDsLq0evFutUkwDBQ5NLUh4UvNAQ5ENQQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY66SOAAoJEKeha0olJ0Nqn8QH/0+0qvLoZhAMbNvshKqrvVpY
OqXs4BvcTsh/3RGkIpTOnMdQzmTchCTxnnezfAhZ0TXVeakG9A9J8cg+EwIPPpPf
LZT5d3itMXuacLSuvodCjtagkpocVbokm4tB//Ma5uyWODddaT6njNvrSrytUEKc
KsY9vfdRbUrRdrrlYqCukGC/SI4G/SSdU9ffgyYkbD+Ud2M8UkWS6IGPOEc5GX+e
XIDoxn0d8Bqjud7Y+ZICGZTgdsEzC3t6nLRhcakwJTY1aflU3eZUIKkzAvVHhxry
OZQeAdGctJNgRsTluaQjAGrpKgNbIb98pfpjSu/+y7EO8a+q3YcVlgHp0L3d5Sk=
=Wqcn
-----END PGP SIGNATURE-----

--lDsLq0evFutUkwDBQ5NLUh4UvNAQ5ENQQ--
