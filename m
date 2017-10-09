Received: from eggs.gnu.org ([2001:4830:134:3::10]:47352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1YaK-0008Nr-O0
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.vnet.ibm.com>) id 1e1YaF-0000wt-QB
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:59:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.vnet.ibm.com>)
	id 1e1YaF-0000wj-Ge
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:59:03 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v99DwjFA051211
	for <qemu-devel@nongnu.org>; Mon, 9 Oct 2017 09:58:59 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dg3jddvpe-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 09:58:58 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.vnet.ibm.com>;
	Mon, 9 Oct 2017 14:58:54 +0100
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1507124979-8880-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171009110949.6246e351.cohuck@redhat.com>
From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Date: Mon, 9 Oct 2017 15:58:50 +0200
MIME-Version: 1.0
In-Reply-To: <20171009110949.6246e351.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <49bbaaab-99db-056c-ef15-6bf8d446f3bd@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/5] s390x/kvm: Enable AIS from CPU
 model always
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de

On 09/10/2017 11:09, Cornelia Huck wrote:
> On Wed,  4 Oct 2017 15:49:35 +0200
> Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
>=20
>> As this patchset will introduce AIS emulation, we always enable
>> Adapter Interrupt Suppression, depending only from the CPU model.
>>
>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
>> ---
>>   target/s390x/kvm.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>> index 931b85f..06fe56d 100644
>> --- a/target/s390x/kvm.c
>> +++ b/target/s390x/kvm.c
>> @@ -2807,6 +2807,7 @@ void kvm_s390_get_host_cpu_model(S390CPUModel *m=
odel, Error **errp)
>>       if (pci_available) {
>>           set_bit(S390_FEAT_ZPCI, model->features);
>>       }
>> +    set_bit(S390_FEAT_ADAPTER_INT_SUPPRESSION, model->features);
>>       set_bit(S390_FEAT_ADAPTER_EVENT_NOTIFICATION, model->features);
>>  =20
>>       if (s390_known_cpu_type(cpu_type)) {
>=20
> I would move that patch until after emulation has actually been
> provided.
>=20

Yes, clear.

Thanks,
Pierre

--=20
Pierre Morel
Linux/KVM/QEMU in B=C3=B6blingen - Germany
