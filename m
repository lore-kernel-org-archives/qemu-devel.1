Received: from eggs.gnu.org ([2001:4830:134:3::10]:49730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtHd-0008Pi-Kg
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:04:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dwtHX-0005gI-Mq
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 13:04:33 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <cbcf25a4-db9c-910f-fdbc-b7620d013b14@redhat.com>
References: <1506441116-16627-1-git-send-email-thuth@redhat.com>
	<CAKmqyKOCsyCHnaNzo_zrRQjZi30ENdPoSc+dFehHvevm-9nrZg@mail.gmail.com>
	<cbcf25a4-db9c-910f-fdbc-b7620d013b14@redhat.com>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 26 Sep 2017 10:03:41 -0700
Message-ID: <CAKmqyKO2jfVZ9d1epxVWKMy9FUfByCoVXMV4JQ-qGAV=vzKwnQ@mail.gmail.com>
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
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Tue, Sep 26, 2017 at 9:52 AM, Thomas Huth <thuth@redhat.com> wrote:
> On 26.09.2017 18:36, Alistair Francis wrote:
>> On Tue, Sep 26, 2017 at 8:51 AM, Thomas Huth <thuth@redhat.com> wrote:
>>> The device uses serial_hds in its realize function and thus can't be
>>> used twice. Apart from that, the comma in its name makes it quite hard
>>> to use for the user anyway, since a comma is normally used to separate
>>> the device name from its properties when using the "-device" parameter
>>> or the "device_add" HMP command.
>>
>> Is it worth changing the name now then as well?
>
> Not sure, was there a reason for this name? E.g. is it used in a device
> tree somewhere somehow? Anyway, with user_creatable = false, I think it
> is not so urgent anymore to change it.

I don't think there was a specific reason. Maybe it was copied from a
device tree, but I'm not tied to keeping the comma. Maybe that's
something we can investigate in the future.

Thanks,
Alistair

>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>
>> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
>
> Thanks!
>
>  Thomas
>
