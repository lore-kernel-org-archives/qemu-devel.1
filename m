Received: from eggs.gnu.org ([2001:4830:134:3::10]:39649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dvKRU-0000K4-KP
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dvKRT-00051E-RK
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:40:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1dvKRT-00050J-Lj
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 05:40:15 -0400
Date: Fri, 22 Sep 2017 11:40:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170922094007.GB12295@localhost.localdomain>
References: <20170921162234.847-1-ehabkost@redhat.com>
	<94b1569d-806a-98f3-7056-8f6a1b78e55c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <94b1569d-806a-98f3-7056-8f6a1b78e55c@redhat.com>
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
To: =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Fam Zheng <famz@redhat.com>, stefanha@gmail.com, armbru@redhat.com, mreitz@redhat.com


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.09.2017 um 10:37 hat Luk=C3=A1=C5=A1 Doktor geschrieben:
> But we should focus on fixing all the entry points (either initialize
> from all of them, or force-create the root logger based on the
> entry-point requirements). Kevin, could you please share the exact
> reproducer? I used a custom file importing QEMUMachine() with a some
> added LOG calls.

I was running qemu-iotests 030 on a development branch that had a bug
that made qemu segfault. This should result in a logged 'qemu received
signal 6' message, but only prints the logging error now. The same kind
of problem affects all Python-based tests in the tree, git grep didn't
find any that initialise the logger manually.

In order to reproduce, you can fake such a crash by inserting an HMP
command like 'qemu-io ide0-hd0 abort' somewhere in a Python-based test.

Kevin

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZxNp3AAoJEH8JsnLIjy/WD0YQAMYmMEwIeR7u/qJCZfBfiY7A
ukG6tp6nKViPeeI5KIbRY2UKfRkIjaBTzRt9wMXbQuSDNwIWwgRA3lQuDcGUnc1W
UwMf+0ceB2BkhCvnMW3kuIrRKIB5GQx+yfY/v3Oaflra8FbyyK+/z0VLLnyuaIZq
xz7aonaeYJqnuJJHmBUv7HFIkOj/WLnm5WR//gJQN1YL1LcjWRrYen0l60QKV2vO
Swd9A5ZN4alLZsN3owChCL05EnJ0w4Z81YLg2ufL2U4Zsi8//n/2++Fz0eqG+0z0
QDduV6Uz+IDs5hBqeB7O8rZ2mtMcr9BKu5GMwsXyI0LLrjqbRahvb9TZ0SLi9R/x
USgp4zx/0bLeUjK82V5++yBllXgBl/n4dRfDImx5dLnoJSP9PEtco1kJsdbdmSnM
pHHgD1Jpb/QSpRR89nEi0dykWajm6J9g4/0tbkMsIUjIGB2bonJcsYJBfzjweVZC
DLazzjVQ2cZHkqCQR93xlxBDR+qTK+ytlUsmgkUbZb6nTufGjC6Cc32nuyh7o48v
oWr4t3YGiawZErZIVezO8p2hAe7nIAxiEP0GIHHPsV86NEfGynZteCEt+QPrx0ds
5gs0LXXKIqh2ZrIV6B/lsT1rjWz7SwqDWef4X3GJfqEsH6gFzoL5XLfvJEqQ77ky
Nu1qZefiyPqQjE9ZUC2U
=Xzmq
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
