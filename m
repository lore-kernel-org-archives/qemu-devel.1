Received: from eggs.gnu.org ([209.51.188.92]:54924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gty5r-0005la-7q
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:13:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1gty5q-0000ho-BC
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:13:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1gty5p-0000g2-Uo
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:13:06 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1DGxGFT109523
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 12:13:03 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qmny3n0j1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 12:13:03 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 13 Feb 2019 17:13:00 -0000
References: <20190205001835.25660-1-philmd@redhat.com>
	<20190205001835.25660-9-philmd@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 13 Feb 2019 18:12:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190205001835.25660-9-philmd@redhat.com>
Content-Language: en-US
Message-Id: <567d617e-fdda-8aa6-5848-3ebfb03bcdf7@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] RFC iotests: Disable 236 and 238 on
 OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, Brad Smith <brad@comstyle.com>

FWIW 238 also fails on my s390 box:

qemu-iotests]$ ./check -qcow2 238
QEMU          -- "/home/cborntra/REPOS/qemu/build/tests/qemu-iotests/../.=
./s390x-softmmu/qemu-system-s390x" -nodefaults -machine accel=3Dqtest
QEMU_IMG      -- "/home/cborntra/REPOS/qemu/build/tests/qemu-iotests/../.=
./qemu-img"=20
QEMU_IO       -- "/home/cborntra/REPOS/qemu/build/tests/qemu-iotests/../.=
./qemu-io"  --cache writeback -f qcow2
QEMU_NBD      -- "/home/cborntra/REPOS/qemu/build/tests/qemu-iotests/../.=
./qemu-nbd"=20
IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/s390x s38lp08 5.0.0-rc5+
TEST_DIR      -- /home/cborntra/REPOS/qemu/build/tests/qemu-iotests/scrat=
ch
SOCKET_SCM_HELPER -- /home/cborntra/REPOS/qemu/build/tests/qemu-iotests/s=
ocket_scm_helper

238         - output mismatch (see 238.out.bad)
--- /home/cborntra/REPOS/qemu/tests/qemu-iotests/238.out	2019-02-13 15:02=
:49.595468321 +0100
+++ /home/cborntra/REPOS/qemu/build/tests/qemu-iotests/238.out.bad	2019-0=
2-13 18:02:22.006360869 +0100
@@ -1,6 +1,6 @@
 {"return": {}}
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"return": {}}
-{"return": {}}
+None
+None
+None
+None
+None
Failures: 238
Failed 1 of 1 tests



Have not looked into that yet.


On 05.02.2019 01:18, Philippe Mathieu-Daud=C3=A9 wrote:
> These tests explode on OpenBSD:
>=20
>   $ gmake check-block
>   [...]
>   238                [17:16:09] [17:16:09] [failed, exit status 1] - ou=
tput mismatch (see 238.out.bad)
>   --- /tmp/qemu-test.VKNS07/tests/qemu-iotests/238.out    Tue Jan 29 17=
:09:03 2019
>   +++ /tmp/qemu-test.VKNS07/tests/qemu-iotests/238.out.bad        Tue J=
an 29 17:16:09 2019
>   @@ -1,6 +1,14 @@
>   -{"return": {}}
>   -{"return": {}}
>   -{"return": {}}
>   -{"return": {}}
>   -{"return": {}}
>   -{"return": {}}
>   +Traceback (most recent call last):
>   +  File "238", line 37, in <module>
>   +    vm.launch()
>   +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qemu.=
py", line 295, in launch
>   +    self._launch()
>   +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qemu.=
py", line 321, in _launch
>   +    self._post_launch()
>   +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qemu.=
py", line 266, in _post_launch
>   +    self._qmp.accept()
>   +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qmp/q=
mp.py", line 157, in accept
>   +    return self.__negotiate_capabilities()
>   +  File "/tmp/qemu-test.VKNS07/tests/qemu-iotests/../../scripts/qmp/q=
mp.py", line 73, in __negotiate_capabilities
>   +    raise QMPConnectError
>   +qmp.qmp.QMPConnectError
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> This might be due to these tests requiring KVM?...
> Maybe we need a has_kvm argument to iotests.verify_platform()?
> ---
>  tests/qemu-iotests/236 | 1 +
>  tests/qemu-iotests/238 | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/236 b/tests/qemu-iotests/236
> index 79a6381f8e..b98df35ca4 100755
> --- a/tests/qemu-iotests/236
> +++ b/tests/qemu-iotests/236
> @@ -23,6 +23,7 @@ import iotests
>  from iotests import log
> =20
>  iotests.verify_image_format(supported_fmts=3D['generic'])
> +iotests.verify_platform(unsupported_oses=3D['openbsd']) # FIXME
>  size =3D 64 * 1024 * 1024
>  granularity =3D 64 * 1024
> =20
> diff --git a/tests/qemu-iotests/238 b/tests/qemu-iotests/238
> index f81ee1112f..c62ff9a6dc 100755
> --- a/tests/qemu-iotests/238
> +++ b/tests/qemu-iotests/238
> @@ -23,6 +23,8 @@ import os
>  import iotests
>  from iotests import log
> =20
> +iotests.verify_platform(unsupported_oses=3D['openbsd']) # FIXME
> +
>  sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 's=
cripts'))
> =20
>  from qemu import QEMUMachine
>=20
