Received: from eggs.gnu.org ([2001:4830:134:3::10]:49700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cohhC-0007Rq-J3
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 22:32:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1cohh7-0000st-I6
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 22:32:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59073
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1cohh7-0000pE-BY
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 22:32:45 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2H2TGWw104262
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 22:32:42 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 297pv3n17f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 22:32:42 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Thu, 16 Mar 2017 22:32:41 -0400
References: <20170310044402.38880-1-haoqf@linux.vnet.ibm.com>
	<20170310044402.38880-2-haoqf@linux.vnet.ibm.com>
	<87efxxy7jh.fsf@secure.mitica>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Fri, 17 Mar 2017 10:32:30 +0800
MIME-Version: 1.0
In-Reply-To: <87efxxy7jh.fsf@secure.mitica>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <45c27b68-e5f1-bf94-fca2-ed862b026344@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/1] vmstate: fix failed iotests case 68
 and 91
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, cornelia.huck@de.ibm.com, pasic@linux.vnet.ibm.com, liujbjl@linux.vnet.ibm.com, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, dgilbert@redhat.com



=D4=DA 2017/3/16 16:01, Juan Quintela =D0=B4=B5=C0:
> QingFeng Hao <haoqf@linux.vnet.ibm.com> wrote:
>> This problem affects s390x only if we are running without KVM.
>> Basically, S390CPU.irqstate is unused if we do not use KVM,
>> and thus no buffer is allocated.
>> This causes size=3D0, first_elem=3DNULL and n_elems=3D1 in
>> vmstate_load_state and vmstate_save_state. And the assert fails.
>> With this fix we can go back to the old behavior and support
>> VMS_VBUFFER with size 0 and nullptr.
>>
>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> queued
Thanks!

--=20
Regards
QingFeng Hao
