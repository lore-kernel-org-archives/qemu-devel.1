Received: from eggs.gnu.org ([2001:4830:134:3::10]:56017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cJKXO-0000qk-Qn
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 08:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cJKXI-0001kK-Ph
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 08:33:02 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:33087)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cJKXI-0001k8-Ju
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 08:32:56 -0500
Received: by mail-ua0-x22a.google.com with SMTP id b56so16487484uaa.0
	for <qemu-devel@nongnu.org>; Tue, 20 Dec 2016 05:32:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNXugCpkY_oHv=256wP5nve9hcsGep21UQuwyLE_mm99A@mail.gmail.com>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<1481625384-15077-23-git-send-email-peter.maydell@linaro.org>
	<20161213161152.GN9606@toto>
	<CAKmqyKNXugCpkY_oHv=256wP5nve9hcsGep21UQuwyLE_mm99A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Dec 2016 13:32:35 +0000
Message-ID: <CAFEAcA8nJfyQZHQCrmNkjBHOF05qErh1OJeRzcM_8obYvYivbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 22/23] target-arm: Enable EL2 feature bit
 on A53 and A57
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Patch Tracking <patches@linaro.org>

On 19 December 2016 at 22:04, Alistair Francis <alistair23@gmail.com> wrote:
> On Tue, Dec 13, 2016 at 8:11 AM, Edgar E. Iglesias
> <edgar.iglesias@gmail.com> wrote:
>> On Tue, Dec 13, 2016 at 10:36:23AM +0000, Peter Maydell wrote:
>>> Enable the ARM_FEATURE_EL2 bit on Cortex-A52 and
>>> Cortex-A57, since this is all now sufficiently implemented
>>> to work with the GICv3. We provide the usual CPU property
>>> to disable it for backwards compatibility with the older
>>> virt boards.
>>>
>>> In this commit, we disable the EL2 feature on the
>>> virt and ZynpMP boards, so there is no overall effect.
>>> Another commit will expose a board-level property to
>>> allow the user to enable EL2.

>>> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
>>> index 0d86ba3..bc4e66b 100644
>>> --- a/hw/arm/xlnx-zynqmp.c
>>> +++ b/hw/arm/xlnx-zynqmp.c
>>> @@ -258,6 +258,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
>>>
>>>          object_property_set_bool(OBJECT(&s->apu_cpu[i]),
>>>                                   s->secure, "has_el3", NULL);
>>> +        object_property_set_bool(OBJECT(&s->apu_cpu[i]),
>>> +                                 false, "has_el2", NULL);
>
> Hey Peter,
>
> We would like this to be settable. I think just copying the s->secure
> (same as EL3) should be fine here.
>
> Let me know what is easier for you, if you want to just add an extra
> patch to enable it or if you want me to send a patch doing it?

I'm not really set up to test the xilinx boards, so I'd rather
let you test and send the extra patch to enable it for them.

thanks
-- PMM
