Received: from eggs.gnu.org ([2001:4830:134:3::10]:35660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtzYq-0007Xo-HB
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:10:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtzYm-0003Sm-GW
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:10:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dtzYm-0003SH-7D
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 13:10:16 -0400
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <23a3b68e-efa5-5daa-363e-f697e3d8ae2f@redhat.com>
Date: Mon, 18 Sep 2017 12:10:13 -0500
MIME-Version: 1.0
In-Reply-To: <1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6BESh3RGtQM7O6LMFRvvI50BSjP6jT2FP"
Subject: Re: [Qemu-devel] [PATCH v11 2/6] qmp: Use ThrottleLimits structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6BESh3RGtQM7O6LMFRvvI50BSjP6jT2FP
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 alberto garcia <berto@igalia.com>, jani kokkonen <jani.kokkonen@huawei.com>,
 qemu-devel@nongnu.org
Message-ID: <23a3b68e-efa5-5daa-363e-f697e3d8ae2f@redhat.com>
Subject: Re: [PATCH v11 2/6] qmp: Use ThrottleLimits structure
References: <1505385610-35529-1-git-send-email-pradeep.jagadeesh@huawei.com>
 <1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1505385610-35529-3-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/14/2017 05:40 AM, Pradeep Jagadeesh wrote:
> This patch factors out code to use the ThrottleLimits
> strurcture.

s/strurcture/structure/

>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Echoing the sentiments made elsewhere - this is a significant rewrite
from the earlier version, so you WANT reviewers to look at it fresh
rather than assuming that previous reviews still apply.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6BESh3RGtQM7O6LMFRvvI50BSjP6jT2FP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm//fUACgkQp6FrSiUn
Q2rIjwf/cW2jUvmjs5aswmPTd9i+UYnlVWAmh1GLcbkdi31mGJihejGrz4pQL7ur
odCJu4mXwzKJqjEAbBpaD2p0GDjK3m6SK8anDVTEbNUvL7Igw0JHmTcXNjLynp/e
+LJaICBhS75j/AqXss62pIZ63MjSX/eTti5RKuWPxLwMnwUOr9zcie4ZJXydeShF
gQzz0yP29fpg/tZ05J2oXc1YyyXURetUfIkUWY0XPz+zuqkJETuL5esPZhazoBm8
19LT+QuL7AP+qHvAoGSuMNyNHSk0PJowKGmW2FE2ppXBM85uvqr5tGtQ10B/nJpn
WMRCb3Eeu0/ew83He0A92gTbjAWLLw==
=Az/7
-----END PGP SIGNATURE-----

--6BESh3RGtQM7O6LMFRvvI50BSjP6jT2FP--
