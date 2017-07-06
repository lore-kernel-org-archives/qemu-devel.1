Received: from eggs.gnu.org ([2001:4830:134:3::10]:50460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dSwOT-0006W3-MM
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dSwOO-0006M3-On
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:19:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34822
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dSwOO-0006Lj-IR
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 22:19:44 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v662JMGB085417
	for <qemu-devel@nongnu.org>; Wed, 5 Jul 2017 22:19:43 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bgvqkf0br-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 22:19:43 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Wed, 5 Jul 2017 22:19:42 -0400
References: <20170704132350.11874-1-haoqf@linux.vnet.ibm.com>
	<20170705151506.GH29910@stefanha-x1.localdomain>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Thu, 6 Jul 2017 10:19:28 +0800
MIME-Version: 1.0
In-Reply-To: <20170705151506.GH29910@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Message-Id: <1d870e0b-f182-b0c7-818e-ec011bfd2261@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 0/1] virtio-scsi-ccw: fix iotest 068 for
 s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, borntraeger@de.ibm.com, zyimin@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, peterx@redhat.com, cohuck@redhat.com



=E5=9C=A8 2017/7/5 23:15, Stefan Hajnoczi =E5=86=99=E9=81=93:
> On Tue, Jul 04, 2017 at 03:23:49PM +0200, QingFeng Hao wrote:
>> This commit fixes iotest 068 for s390x as s390x uses virtio-scsi-ccw.
>> It's based on commit c324fd0a39c by Stefan Hajnoczi.
>> Thanks!
>>
>> Change history:
>> v4:
>>      Got Cornelia Huck's Reviewed-by and take the comment to change th=
e
>>      commit message.
>>
>> v3:
>>      Take Christian Borntraeger and Cornelia Huck's comment to check
>>      if kvm is enabled in s390_assign_subch_ioeventfd instead of
>>      kvm_s390_assign_subch_ioeventfd to as the former is a general one.
>>
>> v2:
>>      Remove Stefan from sign-off list and change the patch's commit me=
ssage
>>      according to Christian Borntraeger's comment.
>>
>> QingFeng Hao (1):
>>    virtio-scsi-ccw: use ioeventfd even when KVM is disabled
>>
>>   hw/s390x/virtio-ccw.c | 2 +-
>>   target/s390x/cpu.h    | 6 +++++-
>>   2 files changed, 6 insertions(+), 2 deletions(-)
> I didn't realize s390 also has this old check.  Thanks for fixing it!
Thanks Stefan!
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--=20
Regards
QingFeng Hao
