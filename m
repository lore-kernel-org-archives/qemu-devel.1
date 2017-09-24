Received: from eggs.gnu.org ([2001:4830:134:3::10]:58350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dw4v3-0006gU-Dt
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 07:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dw4uz-0003J2-FW
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 07:17:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36784)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dw4uz-0003II-5b
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 07:17:49 -0400
References: <20170921162234.847-1-ehabkost@redhat.com>
	<94b1569d-806a-98f3-7056-8f6a1b78e55c@redhat.com>
	<20170922094007.GB12295@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <4e531137-e22a-d47e-d4ea-5729704f5248@redhat.com>
Date: Sun, 24 Sep 2017 13:17:40 +0200
MIME-Version: 1.0
In-Reply-To: <20170922094007.GB12295@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oKPotiMrNsvDv05gH0eWm7aVjhJkPlSIv"
Subject: Re: [Qemu-devel] [PATCH] qemu.py: Call logging.basicConfig()
 automatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Fam Zheng <famz@redhat.com>, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oKPotiMrNsvDv05gH0eWm7aVjhJkPlSIv
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>,
 Fam Zheng <famz@redhat.com>, stefanha@gmail.com, armbru@redhat.com,
 mreitz@redhat.com
Message-ID: <4e531137-e22a-d47e-d4ea-5729704f5248@redhat.com>
Subject: Re: [PATCH] qemu.py: Call logging.basicConfig() automatically
References: <20170921162234.847-1-ehabkost@redhat.com>
 <94b1569d-806a-98f3-7056-8f6a1b78e55c@redhat.com>
 <20170922094007.GB12295@localhost.localdomain>
In-Reply-To: <20170922094007.GB12295@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 22.9.2017 v 11:40 Kevin Wolf napsal(a):
> Am 22.09.2017 um 10:37 hat Luk=C3=A1=C5=A1 Doktor geschrieben:
>> But we should focus on fixing all the entry points (either initialize
>> from all of them, or force-create the root logger based on the
>> entry-point requirements). Kevin, could you please share the exact
>> reproducer? I used a custom file importing QEMUMachine() with a some
>> added LOG calls.
>=20
> I was running qemu-iotests 030 on a development branch that had a bug
> that made qemu segfault. This should result in a logged 'qemu received
> signal 6' message, but only prints the logging error now. The same kind=

> of problem affects all Python-based tests in the tree, git grep didn't
> find any that initialise the logger manually.
>=20
> In order to reproduce, you can fake such a crash by inserting an HMP
> command like 'qemu-io ide0-hd0 abort' somewhere in a Python-based test.=

>=20
OK, that's basically what I did. As a proper fix would require all tests =
to initialize logging (even if as an extra call to `iotests.initialize_lo=
gging` or `qemu.initialize_logging` I think Eduardo's patch actually fits=
 the usage within qemu/scripts. Sorry for over-thinking this.

Luk=C3=A1=C5=A1

> Kevin
>=20



--oKPotiMrNsvDv05gH0eWm7aVjhJkPlSIv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZx5RUExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsFq
EQf/dMmxGoQ7v915IsSxEVxKrpVJemSBCqiKqLE1lCQnkaWg1neTuhbm14xkQM+S
uvVmC7KMDVaIywBJmrbkj6qiiLrg7Sfw19dmi5Nrxjzlz47jK44ID7ejkUesp6FQ
Bl78TtR0/9j3axaZF8GbdenQKzh0+MJxcbdHRQT97CFOyxldy6Iq7jY60kzdxKJY
pxPTxHr7KWkC80UTlTmZ11bpmTIh967jBers3pnL9Fl92BgomgL7ocCt6ycJD0PL
W/5rQz0CCUYXK/KiZLRA2I5x5R5VbswSrEXIla3W95Zo8s1+/41TSfY+QmLW5Mbq
TAf1JL2ptdMD6LRpSb1Fhe3CeA==
=5D+o
-----END PGP SIGNATURE-----

--oKPotiMrNsvDv05gH0eWm7aVjhJkPlSIv--
