Received: from eggs.gnu.org ([2001:4830:134:3::10]:57524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1eLwvB-0004IV-PS
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1eLwv8-0007wa-Nr
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:00:57 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34456
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1eLwv8-0007wK-HM
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 15:00:54 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB4JsCjx121717
	for <qemu-devel@nongnu.org>; Mon, 4 Dec 2017 15:00:52 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2enbd9cd4d-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 15:00:50 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Mon, 4 Dec 2017 15:00:49 -0500
References: <20171201151538.6844-1-farman@linux.vnet.ibm.com>
	<20171201151538.6844-2-farman@linux.vnet.ibm.com>
	<77147a49-b8b3-d94d-80ab-5ab279fbc8b9@redhat.com>
	<4f6e5359-2aee-64c3-332f-b60bb1c9af1f@linux.vnet.ibm.com>
	<CAFEAcA-=+p=fYwU2byXhSG96Hnc5M4R4A-QK0Yivga81g1E2SQ@mail.gmail.com>
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Mon, 4 Dec 2017 15:00:45 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-=+p=fYwU2byXhSG96Hnc5M4R4A-QK0Yivga81g1E2SQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <f6ca783b-bd13-8d5e-cdec-a3d7e00d9b20@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] vhost-scsi: add missing virtqueue_size
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Richard W . M . Jones" <rjones@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>



On 12/04/2017 01:05 PM, Peter Maydell wrote:
> On 4 December 2017 at 17:52, Eric Farman <farman@linux.vnet.ibm.com> wrote:
>> On 12/01/2017 10:16 AM, Paolo Bonzini wrote:
>>>
>>> On 01/12/2017 16:15, Eric Farman wrote:
>>>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>>>> index cd4ab05233..9c1bea8ff3 100644
>>>> --- a/hw/scsi/vhost-scsi.c
>>>> +++ b/hw/scsi/vhost-scsi.c
>>>> @@ -233,6 +233,8 @@ static Property vhost_scsi_properties[] = {
>>>>        DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
>>>>        DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt,
>>>> 0),
>>>>        DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
>>>> 1),
>>>> +    DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon,
>>>> conf.virtqueue_size,
>>>> +                       128),
>>>>        DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon,
>>>> conf.max_sectors,
>>>>                           0xFFFF),
>>>>        DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon,
>>>> conf.cmd_per_lun, 128),
> 
>> Wow, super quick, thank you!  Seeing conversations today, is this queued for
>> -rc4, or 2.12 and backport to qemu-stable?
> 
> If people can come to a consensus on whether this is -rc4 material
> by Tuesday 12:00 GMT that would be helpful.

I'd vote for -rc4, since it's a new guest crash since 2.10.  But I also 
won't complain if it waits for 2.11.1 since I was out of the office 
during the whole freeze period and no one else noticed it.

  - Eric
