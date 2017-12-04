Received: from eggs.gnu.org ([2001:4830:134:3::10]:57242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLv7u-0000Tu-Q6
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:05:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eLv7u-0002Y8-29
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:05:58 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:33039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eLv7t-0002Y4-T0
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 13:05:57 -0500
Received: by mail-oi0-x235.google.com with SMTP id w131so12357645oiw.0
	for <qemu-devel@nongnu.org>; Mon, 04 Dec 2017 10:05:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4f6e5359-2aee-64c3-332f-b60bb1c9af1f@linux.vnet.ibm.com>
References: <20171201151538.6844-1-farman@linux.vnet.ibm.com>
	<20171201151538.6844-2-farman@linux.vnet.ibm.com>
	<77147a49-b8b3-d94d-80ab-5ab279fbc8b9@redhat.com>
	<4f6e5359-2aee-64c3-332f-b60bb1c9af1f@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Dec 2017 18:05:36 +0000
Message-ID: <CAFEAcA-=+p=fYwU2byXhSG96Hnc5M4R4A-QK0Yivga81g1E2SQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eric Farman <farman@linux.vnet.ibm.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Richard W . M . Jones" <rjones@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Felipe Franciosi <felipe@nutanix.com>, QEMU Developers <qemu-devel@nongnu.org>, Dariusz Stojaczyk <dariuszx.stojaczyk@intel.com>

On 4 December 2017 at 17:52, Eric Farman <farman@linux.vnet.ibm.com> wrote:
> On 12/01/2017 10:16 AM, Paolo Bonzini wrote:
>>
>> On 01/12/2017 16:15, Eric Farman wrote:
>>> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
>>> index cd4ab05233..9c1bea8ff3 100644
>>> --- a/hw/scsi/vhost-scsi.c
>>> +++ b/hw/scsi/vhost-scsi.c
>>> @@ -233,6 +233,8 @@ static Property vhost_scsi_properties[] = {
>>>       DEFINE_PROP_STRING("wwpn", VirtIOSCSICommon, conf.wwpn),
>>>       DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt,
>>> 0),
>>>       DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues,
>>> 1),
>>> +    DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon,
>>> conf.virtqueue_size,
>>> +                       128),
>>>       DEFINE_PROP_UINT32("max_sectors", VirtIOSCSICommon,
>>> conf.max_sectors,
>>>                          0xFFFF),
>>>       DEFINE_PROP_UINT32("cmd_per_lun", VirtIOSCSICommon,
>>> conf.cmd_per_lun, 128),

> Wow, super quick, thank you!  Seeing conversations today, is this queued for
> -rc4, or 2.12 and backport to qemu-stable?

If people can come to a consensus on whether this is -rc4 material
by Tuesday 12:00 GMT that would be helpful.

thanks
-- PMM
