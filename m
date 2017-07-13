Received: from eggs.gnu.org ([2001:4830:134:3::10]:35390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVbXi-0004wU-Uw
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVbXh-0002DT-Vm
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:40:22 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:34100)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVbXh-0002DE-NS
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:40:21 -0400
Received: by mail-wr0-x230.google.com with SMTP id 77so51051661wrb.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:40:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNR269fZpVz5zqyMbkU7JDKGswnyq10+zud0FxA5_m4Qg@mail.gmail.com>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-2-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKMO4GQB1Cgy5rZw8pJawO_kWFZ7PiLGzWPch5CqkOKp=Q@mail.gmail.com>
	<CAFEAcA9xOEX3p0H2=GfYbGXwJkfYYXkVfZH=h0GbM_-bZ4auSA@mail.gmail.com>
	<CAKmqyKNR269fZpVz5zqyMbkU7JDKGswnyq10+zud0FxA5_m4Qg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 11:39:59 +0100
Message-ID: <CAFEAcA9s3+OYpvrriGu9CVaJHZhkaZ+Wq47PY2Ky0w-yCMWK_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/7] hw/arm/mps2: Implement skeleton
 mps2-an385 and mps2-an511 board models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On 13 July 2017 at 08:27, Alistair Francis <alistair23@gmail.com> wrote:
> On Tue, Jul 11, 2017 at 6:35 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 11 July 2017 at 15:33, Alistair Francis <alistair23@gmail.com> wrote:
>>> On Tue, Jul 11, 2017 at 1:17 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>>> +#define TYPE_MPS2_MACHINE "mps2"
>>>
>>> This public name seems too common as well. I am just worried it'll
>>> conflict with something one day.
>>
>> I can see the issue, but on the other hand the type name is not
>> external ABI, so we can always rename it later if we have to.
>
> That's true, but it's still not ideal to be changing device names willy nilly.
>
>> The board names themselves (mps2-an385 and mps2-an511) on the
>> other hand we have to get right from the start. I'm not sure
>> tacking an arm- on the front of those helps; they're already
>> pretty ungainly.
>
> I think the boards are already long enough to be unique and probably
> don't need an 'arm-'. Although I think having the vendor name does
> clarify what the board is. Imagine a user is querying QEMU for what
> boards it supports and sees a board name they don't recognise. It will
> be a lot easier to figure out what board this is is you search "ARM
> MPS2" instead of just MPS2.

"ARM" is in the long description you get from -M help:
mps2-an385           ARM MPS2 with AN385 FPGA image for Cortex-M3
mps2-an511           ARM MPS2 with AN511 DesignStart FPGA image for Cortex-M3

(compare existing
realview-pb-a8       ARM RealView Platform Baseboard for Cortex-A8
etc)

Having thought about it a bit I think there are two options:
(1) stick with what we have here, just using "mps2" in type
and filenames
(2) use "arm-mps2" instead (in filenames, typenames and the board
names)
since I don't much like having the base machine type be 'arm-mps2'
but the board names just 'mps2-an385' &c.

But of the two I overall prefer (1) still.

thanks
-- PMM
