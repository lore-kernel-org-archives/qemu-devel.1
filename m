Received: from eggs.gnu.org ([2001:4830:134:3::10]:41751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dskgg-0001Ta-Ch
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:05:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dskgd-0001yJ-4U
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:05:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49522
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dskgc-0001xa-Vm
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 03:05:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8F74uI5032248
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 03:05:14 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d08u8jxv2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 03:05:13 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Fri, 15 Sep 2017 03:05:13 -0400
References: <20170913091038.2900-1-cohuck@redhat.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Fri, 15 Sep 2017 15:04:56 +0800
MIME-Version: 1.0
In-Reply-To: <20170913091038.2900-1-cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <d72eb721-18de-af12-0ac7-62889a3f7b24@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] iotests: cure s390x failures by
 switching to ccw/aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com

Reviewed-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>

for the series of patches.

Thanks


=D4=DA 2017/9/13 17:10, Cornelia Huck =D0=B4=B5=C0:
> Recent changes in s390x made pci support dependant on the zpci cpu
> feature, which is not provided on all models (and not on by default).
> This means we cannot instatiate pci devices on a standard qemu
> invocation for s390x. Moreover, the zpci instructions are not even
> wired up for tcg yet, so actually doing anything with those pci devices
> is bound to fail on tcg.
>
> For 040, 051, 139, and 182, this can be fixed by switching to virtio-cc=
w
> from virtio-pci on s390x. 051 also needs a bit of post-processing on
> the output.
>
> For 067, it is easier to switch to virtio aliases, which will pick
> virtio-ccw on s390x and virtio-pci elsewhere. It also exercises the
> aliasing path.
>
> v1->v2:
> - avoid adding new reference output by adding post-processing to 051
>    and switching to aliases for 067
>
> Cornelia Huck (3):
>    iotests: use -ccw on s390x for 040, 139, and 182
>    iotests: use -ccw on s390x for 051
>    iotests: use virtio aliases for 067
>
>   tests/qemu-iotests/040        |  6 +++++-
>   tests/qemu-iotests/051        | 12 +++++++++++-
>   tests/qemu-iotests/051.out    |  2 +-
>   tests/qemu-iotests/051.pc.out |  2 +-
>   tests/qemu-iotests/067        |  3 ++-
>   tests/qemu-iotests/067.out    |  2 +-
>   tests/qemu-iotests/139        | 12 ++++++++++--
>   tests/qemu-iotests/182        | 13 +++++++++++--
>   8 files changed, 42 insertions(+), 10 deletions(-)
>

--=20
Regards
QingFeng Hao
