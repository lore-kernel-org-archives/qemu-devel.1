Received: from eggs.gnu.org ([2001:4830:134:3::10]:49465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpat7-0004F4-1r
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:01:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpat2-0007hD-7U
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:01:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpat1-0007gg-V2
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 10:01:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1F8EC0587F8
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 14:00:58 +0000 (UTC)
References: <20170906115143.27451-1-quintela@redhat.com>
	<20170906115143.27451-2-quintela@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7e71d190-8e49-ca6b-ef44-522100b27b8c@redhat.com>
Date: Wed, 6 Sep 2017 09:00:51 -0500
MIME-Version: 1.0
In-Reply-To: <20170906115143.27451-2-quintela@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cBfd0pQsELox7cDNIqu3KOtklMJjJwXQd"
Subject: Re: [Qemu-devel] [PATCH v7 01/22] Revert "io: add new
 qio_channel_{readv, writev, read, write}_all functions"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cBfd0pQsELox7cDNIqu3KOtklMJjJwXQd
From: Eric Blake <eblake@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com
Message-ID: <7e71d190-8e49-ca6b-ef44-522100b27b8c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 01/22] Revert "io: add new
 qio_channel_{readv, writev, read, write}_all functions"
References: <20170906115143.27451-1-quintela@redhat.com>
 <20170906115143.27451-2-quintela@redhat.com>
In-Reply-To: <20170906115143.27451-2-quintela@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/06/2017 06:51 AM, Juan Quintela wrote:
> This reverts commit d4622e55883211072621958d39ddaa73483d201e.

But with no reason why?  What bugs are you fixing by reverting this?

>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  include/io/channel.h       |  90 -------------------------------------=
--
>  io/channel.c               |  94 -------------------------------------=
----
>  tests/io-channel-helpers.c | 102 +++++++++++++++++++++++++++++++++++++=
++++----
>  3 files changed, 93 insertions(+), 193 deletions(-)
>

Looking ahead, I see 8/22 recreates qio_channel_readv_all (but not
qio_channel_read_all); how does that differ from this one?

Should you be squashing 1/22 and 8/22 into a single non-revert patch
that just fixes bugs on top of what is already in the tree?

Also, have you seen my patches, that also fix bugs in the _all functions?=

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01053.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cBfd0pQsELox7cDNIqu3KOtklMJjJwXQd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmv/5QACgkQp6FrSiUn
Q2oIXAf/WlbcUz36JWRMjFaVQi4+oCfZKyi4Eko+bMeote3BAP1OS/0v03AAPGe1
nJXwxifwe81QCD9YAC8RRE3goueCJ+vXBNb4JmpH6qcLOiBx4wARkS0D3vCqdYON
WDD8fAkDsWsXni3MS1gpiC7GZg2uBHq1ENQDyeftJb3IigbzkRC0YJOm4KTTTJKC
yJCgX4XYm89ulcvZyvt5DyU+F32fDFdVDXGBlTnBWO9WvBfgNyf2BIV37/NLk/zh
S/36lZWLXDOfsWxAzLLV5SjFUNjcJBWJJ34PUFtzZmTNVu1msgVnrm4y17s/3iYP
CGnBuFfMJY3b64RmhlUnuBM0Yd1Iww==
=ngMp
-----END PGP SIGNATURE-----

--cBfd0pQsELox7cDNIqu3KOtklMJjJwXQd--
