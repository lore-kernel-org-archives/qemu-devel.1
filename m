Received: from eggs.gnu.org ([2001:4830:134:3::10]:48959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1da3VB-00045M-7j
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1da3VA-0001Vl-Bz
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:20:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1da3VA-0001RW-4j
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 13:20:08 -0400
References: <20170725150951.16038-1-ldoktor@redhat.com>
	<20170725150951.16038-11-ldoktor@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <8f540eb9-ea3c-2e0a-e754-fa50554ea282@redhat.com>
Date: Tue, 25 Jul 2017 13:19:53 -0400
MIME-Version: 1.0
In-Reply-To: <20170725150951.16038-11-ldoktor@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/10] qtest.py: Few pylint/style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, ehabkost@redhat.com, armbru@redhat.com, apahim@redhat.com, f4bug@amsat.org, mreitz@redhat.com



On 07/25/2017 11:09 AM, Luk=C3=A1=C5=A1 Doktor wrote:
> No actual code changes, just few pylint/style fixes.
>=20

More than welcome, given the state of our python scripts.

> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
> ---
>   scripts/qtest.py | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/scripts/qtest.py b/scripts/qtest.py
> index ab183c0..df0daf2 100644
> --- a/scripts/qtest.py
> +++ b/scripts/qtest.py
> @@ -11,14 +11,11 @@
>   # Based on qmp.py.
>   #
>  =20
> -import errno
>   import socket
> -import string
>   import os
> -import subprocess
> -import qmp.qmp
>   import qemu
>  =20
> +
>   class QEMUQtestProtocol(object):
>       def __init__(self, address, server=3DFalse):
>           """
> @@ -83,8 +80,10 @@ class QEMUQtestMachine(qemu.QEMUMachine):
>                    socket_scm_helper=3DNone):
>           if name is None:
>               name =3D "qemu-%d" % os.getpid()
> -        super(QEMUQtestMachine, self).__init__(binary, args, name=3Dna=
me, test_dir=3Dtest_dir,
> -                                               socket_scm_helper=3Dsoc=
ket_scm_helper)
> +        super(QEMUQtestMachine,
> +              self).__init__(binary, args, name=3Dname, test_dir=3Dtes=
t_dir,
> +                             socket_scm_helper=3Dsocket_scm_helper)
> +        self._qtest =3D None
>           self._qtest_path =3D os.path.join(test_dir, name + "-qtest.so=
ck")
>  =20
>       def _base_args(self):
>=20

Reviewed-by: John Snow <jsnow@redhat.com>
