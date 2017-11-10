Received: from eggs.gnu.org ([2001:4830:134:3::10]:34500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eD5WL-0001IY-Nr
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:22:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1eD5WI-0005ys-FS
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:22:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39598
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1eD5WI-0005y7-9t
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 04:22:38 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAA9Ja68076716
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 04:22:33 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e53pa7vns-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 04:22:33 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 02:22:32 -0700
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-3-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109175018.1c2f1b60.cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 17:22:26 +0800
MIME-Version: 1.0
In-Reply-To: <20171109175018.1c2f1b60.cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <9bd199cf-bc49-3030-5623-4f11a205429a@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/7] s390x/pci: rework PCI STORE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com



=D4=DA 2017/11/10 =C9=CF=CE=E712:50, Cornelia Huck =D0=B4=B5=C0:
> On Tue,  7 Nov 2017 18:24:34 +0100
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>
>> Enhance the fault detection, correction of the fault reporting.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
>> ---
>>   hw/s390x/s390-pci-inst.c | 41 ++++++++++++++++++++++++--------------=
---
>>   1 file changed, 24 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
>> index 8fcb02d..4a2f996 100644
>> --- a/hw/s390x/s390-pci-inst.c
>> +++ b/hw/s390x/s390-pci-inst.c
>> @@ -469,6 +469,12 @@ int pcistg_service_call(S390CPU *cpu, uint8_t r1,=
 uint8_t r2)
>>       pcias =3D (env->regs[r2] >> 16) & 0xf;
>>       len =3D env->regs[r2] & 0xf;
>>       offset =3D env->regs[r2 + 1];
>> +    data =3D env->regs[r1];
>> +
>> +    if (!(fh & FH_MASK_ENABLE)) {
> This covers the reserved/standby/disabled states, right?
yes

[...]
