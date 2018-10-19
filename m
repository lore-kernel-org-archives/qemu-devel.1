Received: from eggs.gnu.org ([2001:4830:134:3::10]:47211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gDVME-0006Za-PA
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gDVM9-0006za-54
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 10:02:30 -0400
References: <20181018143042.29588-1-eric.auger@redhat.com>
	<20181018143042.29588-3-eric.auger@redhat.com>
	<872eeab2-7f0d-6cba-fd05-c75a32aac81b@arm.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <3b307a39-a7ad-3de5-71ea-84cf0a98cf67@redhat.com>
Date: Fri, 19 Oct 2018 16:02:05 +0200
MIME-Version: 1.0
In-Reply-To: <872eeab2-7f0d-6cba-fd05-c75a32aac81b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 02/16] linux-headers: header update for
 KVM/ARM KVM_ARM_GET_MAX_VM_PHYS_SHIFT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, kwangwoo.lee@sk.com, imammedo@redhat.com, david@redhat.com
Cc: drjones@redhat.com, dgilbert@redhat.com

Hi Suzuki,

On 10/19/18 10:49 AM, Suzuki K Poulose wrote:
> Hi Eric,
>=20
> On 10/18/2018 03:30 PM, Eric Auger wrote:
>> This is a header update against kvmarm next branch
>>
>> git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm kvmarm/nex=
t
>>
>> to get the KVM_ARM_GET_MAX_VM_PHYS_SHIFT ioctl. This allows to retriev=
e
>> the IPA address range KVM supports.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v3 -> v4:
>> - update against kvmarm next
>> ---
>> =C2=A0 linux-headers/linux/kvm.h | 10 ++++++++++
>> =C2=A0 1 file changed, 10 insertions(+)
>>
>> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
>> index 83ba4eb571..9647ce4fcb 100644
>> --- a/linux-headers/linux/kvm.h
>> +++ b/linux-headers/linux/kvm.h
>> @@ -750,6 +750,15 @@ struct kvm_ppc_resize_hpt {
>> =C2=A0 =C2=A0 #define KVM_S390_SIE_PAGE_OFFSET 1
>> =C2=A0 +/*
>> + * On arm64, machine type can be used to request the physical
>> + * address size for the VM. Bits[7-0] are reserved for the guest
>> + * PA size shift (i.e, log2(PA_Size)). For backward compatibility,
>> + * value 0 implies the default IPA size, 40bits.
>> + */
>> +#define KVM_VM_TYPE_ARM_IPA_SIZE_MASK=C2=A0=C2=A0=C2=A0 0xffULL
>> +#define KVM_VM_TYPE_ARM_IPA_SIZE(x)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 ((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
>> =C2=A0 /*
>> =C2=A0=C2=A0 * ioctls for /dev/kvm fds:
>> =C2=A0=C2=A0 */
>> @@ -953,6 +962,7 @@ struct kvm_ppc_resize_hpt {
>> =C2=A0 #define KVM_CAP_NESTED_STATE 157
>> =C2=A0 #define KVM_CAP_ARM_INJECT_SERROR_ESR 158
>> =C2=A0 #define KVM_CAP_MSR_PLATFORM_INFO 159
>> +#define KVM_CAP_ARM_VM_IPA_SIZE 160 /* returns maximum IPA bits for a
>> VM */
>=20
> Please be aware that there have been multiple merge conflicts with
> the kvmarm-tree onto kvm tree upstream and the numbers have changed.
> I assume that you will be rebasing this to mainline anyways.

Thank you for the heads up. Yes I will respin this header update against
the master branch later on.

Thanks

Eric
>=20
> Cheers
> Suzuki
>=20
