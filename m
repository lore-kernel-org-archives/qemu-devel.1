Received: from eggs.gnu.org ([2001:4830:134:3::10]:50972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dpUcL-0007D0-L3
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dpUcH-0007VA-6G
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:19:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dpUcG-0007UU-Tz
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:19:17 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v867JE3B145621
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 03:19:14 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctcd50hsw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 03:19:14 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 03:19:12 -0400
References: <20170905151614.31303-1-cohuck@redhat.com>
	<20170905151614.31303-3-cohuck@redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Wed, 6 Sep 2017 15:19:01 +0800
MIME-Version: 1.0
In-Reply-To: <20170905151614.31303-3-cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <21f52be4-164c-ea1b-4d6e-802ea423d2a9@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: use -ccw on s390x for 051
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, bjsdjshi@linux.vnet.ibm.com



=D4=DA 2017/9/5 23:16, Cornelia Huck =D0=B4=B5=C0:
> The default cpu model on s390x does not provide zPCI, which is
> not yet wired up on tcg. Moreover, virtio-ccw is the standard
> on s390x, so use the -ccw instead of the -pci versions of virtio
> devices on s390x.
>
> Provide an output file for s390x.
>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   tests/qemu-iotests/051                     |   9 +-
>   tests/qemu-iotests/051.s390-ccw-virtio.out | 434 ++++++++++++++++++++=
+++++++++
>   2 files changed, 442 insertions(+), 1 deletion(-)
>   create mode 100644 tests/qemu-iotests/051.s390-ccw-virtio.out
>
> diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
> index c8cfc764bc..f6ad0f4f0b 100755
> --- a/tests/qemu-iotests/051
> +++ b/tests/qemu-iotests/051
> @@ -103,7 +103,14 @@ echo
>   echo =3D=3D=3D Device without drive =3D=3D=3D
>   echo
>
> -run_qemu -device virtio-scsi-pci -device scsi-hd
> +case "$QEMU_DEFAULT_MACHINE" in
> +  s390-ccw-virtio)
> +      run_qemu -device virtio-scsi-ccw -device scsi-hd
> +      ;;
> +  *)
> +      run_qemu -device virtio-scsi-pci -device scsi-hd
> +      ;;
> +esac
>
>   echo
>   echo =3D=3D=3D Overriding backing file =3D=3D=3D
Regarding the new output file, I have a doubt that why there is no=20
change on "check"
script where the result check is located:
if diff -w "$reference" $tmp.out >/dev/null 2>&1
Thanks!
> diff --git a/tests/qemu-iotests/051.s390-ccw-virtio.out b/tests/qemu-io=
tests/051.s390-ccw-virtio.out
> new file mode 100644
> index 0000000000..7555f0b73e
> --- /dev/null
> +++ b/tests/qemu-iotests/051.s390-ccw-virtio.out
[...]

--=20
Regards
QingFeng Hao
