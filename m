Received: from eggs.gnu.org ([2001:4830:134:3::10]:52849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwtTz-0003D1-C4
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:17:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dwtTy-0006Of-C8
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:17:19 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:47247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dwtTy-0006O1-5d
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:17:18 -0400
Received: by mail-wm0-x229.google.com with SMTP id r136so10199894wmf.2
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 10:17:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKO2jfVZ9d1epxVWKMy9FUfByCoVXMV4JQ-qGAV=vzKwnQ@mail.gmail.com>
References: <1506441116-16627-1-git-send-email-thuth@redhat.com>
	<CAKmqyKOCsyCHnaNzo_zrRQjZi30ENdPoSc+dFehHvevm-9nrZg@mail.gmail.com>
	<cbcf25a4-db9c-910f-fdbc-b7620d013b14@redhat.com>
	<CAKmqyKO2jfVZ9d1epxVWKMy9FUfByCoVXMV4JQ-qGAV=vzKwnQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2017 18:16:56 +0100
Message-ID: <CAFEAcA_Q4xqSekX4vRVNGCeD+iSvoe73pxaNB=vKpmc8u+AGMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/xlnx-zynqmp: Mark the "xlnx,
 zynqmp" device with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 26 September 2017 at 18:03, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Tue, Sep 26, 2017 at 9:52 AM, Thomas Huth <thuth@redhat.com> wrote:
>> On 26.09.2017 18:36, Alistair Francis wrote:
>>> On Tue, Sep 26, 2017 at 8:51 AM, Thomas Huth <thuth@redhat.com> wrote:
>>>> The device uses serial_hds in its realize function and thus can't be
>>>> used twice. Apart from that, the comma in its name makes it quite hard
>>>> to use for the user anyway, since a comma is normally used to separate
>>>> the device name from its properties when using the "-device" parameter
>>>> or the "device_add" HMP command.
>>>
>>> Is it worth changing the name now then as well?
>>
>> Not sure, was there a reason for this name? E.g. is it used in a device
>> tree somewhere somehow? Anyway, with user_creatable = false, I think it
>> is not so urgent anymore to change it.
>
> I don't think there was a specific reason. Maybe it was copied from a
> device tree, but I'm not tied to keeping the comma. Maybe that's
> something we can investigate in the future.

I vaguely recall that the comma was part of an attempt to be consistent
about device names by making them follow the device tree names for them
rather than just making up our own. Some of the imx devices and boards
follow the same convention.

thanks
-- PMM
