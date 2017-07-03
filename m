Received: from eggs.gnu.org ([2001:4830:134:3::10]:36555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dRwrn-0001Qk-35
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:38:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1dRwrk-0004uJ-74
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:37:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54044
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1dRwrk-0004sh-0s
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 04:37:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v638Soew066122
	for <qemu-devel@nongnu.org>; Mon, 3 Jul 2017 04:37:52 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bem6g770t-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 04:37:52 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Mon, 3 Jul 2017 04:37:51 -0400
References: <20170703073836.72092-1-haoqf@linux.vnet.ibm.com>
	<20170703073836.72092-2-haoqf@linux.vnet.ibm.com>
	<cb96f282-2482-e085-1e94-62ba290fefe6@de.ibm.com>
	<f37b8414-165e-080b-276c-407ddebbce2b@linux.vnet.ibm.com>
	<7dbedc9d-7079-a766-36c9-addb49e8bece@de.ibm.com>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Mon, 3 Jul 2017 16:37:42 +0800
MIME-Version: 1.0
In-Reply-To: <7dbedc9d-7079-a766-36c9-addb49e8bece@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <73c8d807-deed-0f8d-3787-ca9421243f20@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] virtio-scsi-ccw: use ioeventfd even
 when KVM is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: zyimin@linux.vnet.ibm.com, stefanha@redhat.com, kwolf@redhat.com, famz@redhat.com, peterx@redhat.com



=E5=9C=A8 2017/7/3 16:21, Christian Borntraeger =E5=86=99=E9=81=93:
> On 07/03/2017 10:08 AM, QingFeng Hao wrote:
>>
>> =E5=9C=A8 2017/7/3 15:41, Christian Borntraeger =E5=86=99=E9=81=93:
>>> On 07/03/2017 09:38 AM, QingFeng Hao wrote:
>>>> Do not check kvm_eventfds_enabled() when KVM is disabled since it
>>>> always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d646=
2a6f
>>>> ("memory: emulate ioeventfd") it has been possible to use ioeventfds=
 in
>>>> qtest or TCG mode.
>>>>
>>>> This patch makes -device virtio-scsi-ccw,iothread=3Diothread0 work e=
ven
>>>> when KVM is disabled.
>>>>
>>>> I have tested that virtio-scsi-ccw works under tcg both with and wit=
hout
>>>> iothread.
>>>>
>>>> This patch fixes qemu-iotests 068, which was accidentally merged ear=
ly
>>>> despite the dependency on ioeventfd.
>>>>
>>>> Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
>>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> cut'n'paste mistake of adding Stefans signoff?
>>>
>>> Otherwise it looks good.
>> I just want to mark that this patch is related with the former one fro=
m Stefan.
>> Is that ok to add this sign-off? thanks!
> No, sign-off indicates who passes the patch along for integration, so o=
nly Stefan
> is allowed to add that - if he actually takes the patch. It is very imp=
ortant to
> not mangle the sign-off-chain as it is actually used to track how a pat=
ch moved from
> the developer into the tree.
>
> You can give credit to Stefan in the patch description - e.g. by saying=
 in the patch
> description something like
>
> based on a similar patch from Stefan Hajnoczi - commit c324fd0a39c (" v=
irtio-pci: use
> ioeventfd even when KVM is disabled)
Thanks for your good explanation and I'll change the commit message.
>
>
>
>>>> ---
>>>>    hw/s390x/virtio-ccw.c | 2 +-
>>>>    target/s390x/kvm.c    | 3 +++
>>>>    2 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
>>>> index 90d37cb9ff..35896eb007 100644
>>>> --- a/hw/s390x/virtio-ccw.c
>>>> +++ b/hw/s390x/virtio-ccw.c
>>>> @@ -711,7 +711,7 @@ static void virtio_ccw_device_realize(VirtioCcwD=
evice *dev, Error **errp)
>>>>            sch->cssid, sch->ssid, sch->schid, sch->devno,
>>>>            ccw_dev->devno.valid ? "user-configured" : "auto-configur=
ed");
>>>>
>>>> -    if (!kvm_eventfds_enabled()) {
>>>> +    if (kvm_enabled() && !kvm_eventfds_enabled()) {
>>>>            dev->flags &=3D ~VIRTIO_CCW_FLAG_USE_IOEVENTFD;
>>>>        }
>>>>
>>>> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
>>>> index a3d00196f4..c37f9c3b9e 100644
>>>> --- a/target/s390x/kvm.c
>>>> +++ b/target/s390x/kvm.c
>>>> @@ -2220,6 +2220,9 @@ int kvm_s390_assign_subch_ioeventfd(EventNotif=
ier *notifier, uint32_t sch,
>>>>            .addr =3D sch,
>>>>            .len =3D 8,
>>>>        };
>>>> +    if (!kvm_enabled()) {
>>>> +        return 0;
>>>> +    }
>>>>        if (!kvm_check_extension(kvm_state, KVM_CAP_IOEVENTFD)) {
>>>>            return -ENOSYS;
>>>>        }
>>>>

--=20
Regards
QingFeng Hao
