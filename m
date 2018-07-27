Received: from eggs.gnu.org ([2001:4830:134:3::10]:51878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fiwHW-0004k3-Jy
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fiwHV-0001vF-N2
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:31:18 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:43666)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fiwHV-0001uv-GZ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:31:17 -0400
Received: by mail-io0-x241.google.com with SMTP id y10-v6so3333800ioa.10
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 23:31:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-Zv5xV2VwMCfGXUv8oT+gC_dgn8Q3M1v3FBjry7TbXVA@mail.gmail.com>
References: <20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvCKkzim+-Z4Y69fWg6igZ7V6gaWhjKJZ0m0G0dhbwOFyw@mail.gmail.com>
	<20180725112621.imdzdkntpmh3n5og@kamzik.brq.redhat.com>
	<CAHmQWvCfHFSU7RGKG5t6=m7ZSWZjf3TeqOo3cX2KT-GSiN3mPw@mail.gmail.com>
	<20180726102855.x6ffdoqjpejpyae7@kamzik.brq.redhat.com>
	<CAKv+Gu-ffZRNmACH6YieNsg=AHxJxYoXHsBGf6C=nOvFfTu7Sg@mail.gmail.com>
	<20180726111109.w24jk6ehklimige7@kamzik.brq.redhat.com>
	<CAKv+Gu80KfwZft4t1HtOXPuijuPLV80K9iW+BsTgs7WcnosMXA@mail.gmail.com>
	<20180726114158.am7kgc3jekxg55i5@kamzik.brq.redhat.com>
	<CAFEAcA8YH4p__zT1o0s3vNZOsyWZn3XPLgkNeT+jSJpmjvFTUw@mail.gmail.com>
	<20180726123509.qyadwbz4skwashcj@kamzik.brq.redhat.com>
	<CAFEAcA-Zv5xV2VwMCfGXUv8oT+gC_dgn8Q3M1v3FBjry7TbXVA@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Fri, 27 Jul 2018 14:31:15 +0800
Message-ID: <CAHmQWvC2J_-GsMhSiEHcsN=fkp8fCe0PKtUT5Ed_UxMyNr530Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 26 July 2018 at 20:43, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 26 July 2018 at 13:35, Andrew Jones <drjones@redhat.com> wrote:
>> On Thu, Jul 26, 2018 at 01:10:34PM +0100, Peter Maydell wrote:
>>> On 26 July 2018 at 12:41, Andrew Jones <drjones@redhat.com> wrote:
>>> > The patch guards the generation. It'll only modify DT and ACPI for the
>>> > new machine type. But, while modifying the DT makes sense, as that
>>> > generated DT will get consumed
>>>
>>> ...will it? Why would we want the firmware to read the
>>> QEMU-generated DT? Real hardware doesn't work that way.
>>>
>>
>> Good point. If the plan for this reference software is to always
>> prepare its own DTB and ACPI tables, then this patch shouldn't
>> touch the DT generation either. Of course a lot of the device
>> and fdt node creation is intertwined in mach-virt, so it's going
>> to create a DTB anyway.
>
> I haven't yet looked at this patch so I might change my mind
> once I've had time to look at the code, but my initial
> thought is to prefer it to be in its own file rather than
> trying to share code with the virt board. There's a lot
> of stuff 'virt' needs that this doesn't (DT generation,
> ACPI generation, switches to disable virtualization or
> trustzone support, options to select GICv2, etc etc).
>
> Q: is this new board model intended to be able to work
> under KVM, or is that out of scope? (You wouldn't be able
> to run guest EL3 firmware under KVM, certainly.)
>
KVM is out of scope.

> thanks
> -- PMM
