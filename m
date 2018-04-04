Received: from eggs.gnu.org ([2001:4830:134:3::10]:59984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f3cOJ-0003yq-M6
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:59:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f3cOF-0000Vu-Pa
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:59:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1f3cOF-0000Vo-Ge
	for qemu-devel@nongnu.org; Wed, 04 Apr 2018 02:59:27 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w346x8IP119435
	for <qemu-devel@nongnu.org>; Wed, 4 Apr 2018 02:59:26 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h4puhxr1q-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 04 Apr 2018 02:59:25 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Wed, 4 Apr 2018 02:59:24 -0400
References: <20180403140314.8795-1-stefanha@redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Wed, 4 Apr 2018 14:59:14 +0800
MIME-Version: 1.0
In-Reply-To: <20180403140314.8795-1-stefanha@redhat.com>
Content-Type: text/plain; charset=gbk
Message-Id: <a8c52de6-14a4-a5c4-4186-3c49c9a0b6b9@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: update 185 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>



=D4=DA 2018/4/3 22:03, Stefan Hajnoczi =D0=B4=B5=C0:
> Commit 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce
> vm_shutdown()") added a bdrv_drain_all() call.  As a side-effect of the
> drain operation the block job iterates one more time than before.  The
> 185 output no longer matches and the test is failing now.
>=20
> It may be possible to avoid the superfluous block job iteration, but
> that type of patch is not suitable late in the QEMU 2.12 release cycle.
>=20
> This patch simply updates the 185 output file.  The new behavior is
> correct, just not optimal, so make the test pass again.
>=20
> Fixes: 4486e89c219c0d1b9bd8dfa0b1dd5b0d51ff2268 ("vl: introduce vm_shut=
down()")
> Cc: Kevin Wolf <kwolf@redhat.com>
> Cc: QingFeng Hao <haoqf@linux.vnet.ibm.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/qemu-iotests/185.out | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
> index 57eaf8d699..2c4b04de73 100644
> --- a/tests/qemu-iotests/185.out
> +++ b/tests/qemu-iotests/185.out
> @@ -20,7 +20,7 @@ Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D671=
08864 backing_file=3DTEST_DIR/t.q
>  {"return": {}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "SHUTDOWN", "data": {"guest": false}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, =
"offset": 524288, "speed": 65536, "type": "commit"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 67108864, =
"offset": 1048576, "speed": 65536, "type": "commit"}}
Need we add the comment in 185.out that this change is to make the test p=
ass for the superfluous block job iteration?
thanks
>=20
>  =3D=3D=3D Start active commit job and exit qemu =3D=3D=3D
>=20
> @@ -28,16 +28,18 @@ Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D6=
7108864 backing_file=3DTEST_DIR/t.q
>  {"return": {}}
>  {"return": {}}
>  {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "SHUTDOWN", "data": {"guest": false}}
> -{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_CANCELLED", "data": {"device": "disk", "len": 4194304, "=
offset": 4194304, "speed": 65536, "type": "commit"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_READY", "data": {"device": "disk", "len": 4194304, "offs=
et": 4194304, "speed": 65536, "type": "commit"}}
> +{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "ev=
ent": "BLOCK_JOB_COMPLETED", "data": {"device": "disk", "len": 4194304, "=
offset": 4194304, "speed": 65536, "type": "commit"}}

[...]
>=20

--=20
Regards
QingFeng Hao
