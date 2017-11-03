Received: from eggs.gnu.org ([2001:4830:134:3::10]:49242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vrozenfe@redhat.com>) id 1eAXaL-0004Ri-32
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vrozenfe@redhat.com>) id 1eAXaG-0004YA-7u
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:44:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vrozenfe@redhat.com>) id 1eAXaG-0004Wu-15
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 04:44:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4979D81138
	for <qemu-devel@nongnu.org>; Fri,  3 Nov 2017 08:44:10 +0000 (UTC)
References: <20171102133115.19195-1-lprosek@redhat.com>
	<20171102163348-mutt-send-email-mst@kernel.org>
	<CABdb734XVCNxyyRUfFtU5cm=34K28zsuRgyuj6F2SEBjPUu27w@mail.gmail.com>
	<1509693637.31823.7.camel@redhat.com>
	<CABdb734MR3vMCSBH-JhD8vWYKLBx6QOxrVZFYUyDbuQJg8mZ6Q@mail.gmail.com>
From: Vadim Rozenfeld <vrozenfe@redhat.com>
Message-ID: <68095228-36e5-986f-58c4-f502d478084e@redhat.com>
Date: Fri, 3 Nov 2017 19:44:01 +1100
MIME-Version: 1.0
In-Reply-To: <CABdb734MR3vMCSBH-JhD8vWYKLBx6QOxrVZFYUyDbuQJg8mZ6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Don't force Subsystem Vendor
 ID = Vendor ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>



On 03/11/17 19:23, Ladi Prosek wrote:
> On Fri, Nov 3, 2017 at 8:20 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>>>> I wonder whether it's a problem that legacy devices ignore
>>>> the subsystem ID (that's part of spec).
>>> I don't understand this comment. I don't see anything in the spec
>>> related to ignoring the subsystem ID.
>> Well, the subsystem *device* id is defined to be the virtio device id,
>> so it is certainly not ignored.  The subsystem *vendor* id is not used
>> as far I know (or ignored in the sense that it doesn't change driver
>> behavior), allowing to set that makes sense to me.
> Yes, thanks, I'm assuming that Michael meant the subsystem device ID.
> The PCI spec seems to be using "subsystem ID" for the name of this
> field. I understand that this ID must not change in legacy devices.
>
> Interestingly, Windows appears to allow matching drivers only on the
> full subsystem device ID + subsystem vendor ID 32-bit value, not on
> only one of the two.
>
> PCI\VEN_v(4)&DEV_d(4)&SUBSYS_s(4)n(4)&REV_r(2)
>
> This might be a potential problem for a legacy driver that wants to
> stay vendor-agnostic but I'm pretty sure there would be a reasonable
> way of working around it. Actually, the device must use a designated
> device ID (like 0x1000) in addition to the subsystem device ID so this
> should be a non-issue altogether.
>
For legacy drivers running on modified qemu it can be a problem.
For new virtio-win build we can keep both compatible (VID/DID) together
with full (VID/DID/SID/SVID) specified in .inf file

>> Possibly not only for virtio devices, most pci devices have 1af4:1100
>> as subsystem id, other vendors might want set it too for consistency.
>>
>> cheers,
>>    Gerd
