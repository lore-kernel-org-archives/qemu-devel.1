Received: from eggs.gnu.org ([2001:4830:134:3::10]:42421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiIuo-0005Yb-J1
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1fiIul-0003vn-JE
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:29:14 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:43866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1fiIul-0003vQ-6W
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 08:29:11 -0400
Received: by mail-io0-x242.google.com with SMTP id y10-v6so6160299ioa.10
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 05:29:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8wi2QV9cVg_Hp=8MYw_zfxvVciR2CbRZiGJNiQNPdHqg@mail.gmail.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<20180725095426.f7kv4ftngeje6pkx@kamzik.brq.redhat.com>
	<CAHmQWvDu+P26Y5CJfcQ=1_9C=hej_B8w7dLMbmuOmCV-+pYOJQ@mail.gmail.com>
	<20180725114404.6g335n3rfjt23hjc@kamzik.brq.redhat.com>
	<CAFEAcA8wi2QV9cVg_Hp=8MYw_zfxvVciR2CbRZiGJNiQNPdHqg@mail.gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 25 Jul 2018 14:29:09 +0200
Message-ID: <CAKv+Gu9n5Y9tghjR7VJcnH96-rzDWvhY4UCkPtFP9hNUh=LK=Q@mail.gmail.com>
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
Cc: Andrew Jones <drjones@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 25 July 2018 at 14:19, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 25 July 2018 at 12:44, Andrew Jones <drjones@redhat.com> wrote:
>> On Wed, Jul 25, 2018 at 06:46:59PM +0800, Hongbo Zhang wrote:
>>> For Armv7, there is one typical platform 'vexpress', but for Armv8, no
>>
>> Wasn't the vexpress model designed for a specific machine?
>
> Yes.
>
>> Namely for
>> Arm's simulator?
>
> No.
>
>> Is the vexpress model really something typical among
>> all the Armv7 platforms?
>
> No.
>
> "Vexpress" is a model specifically of a development board
> produced by Arm (the versatile express). It's useful if you
> want to run code that runs on that devboard, but (as with
> most of the devboards we model), it's not necessarily ideal,
> because it has all the limitations of the real hardware it's
> modelling (in this case the big ones are limited memory, no PCI).
> The hardware it models is also quite old now (maybe 7 or 8 years)
> and it's not really "typical" of anything. (In the primarily
> embedded space where most v7 CPUs are there's not really anything
> that could be described as "typical" anyway: everything is
> different.)
>
> For most people who just want to run Linux on an emulated v7 CPU,
> I would recommend the "virt" board, for the same reasons I
> recommend it for v8 cores.
>
>>> such typical one, the 'virt' is typically for running workloads, one
>>> example is using it under OpenStack.
>>> So a 'typical' one for Armv8 is needed for firmware and OS
>>> development, similar like 'vexpress' for Armv7.
>>
>> What is a "typical" Armv8 machine? What will a typical Armv8 machine be in
>> two years?
>>
>> Note, I'm not actually opposed to the current definition (because I don't
>> really have one myself). I'm just opposed to hard coding one.
>
> AIUI the aim here is to provide an emulated platform that is
> set up in the way that server-style armv8 machines are
> recommended to be set up, so it can be used as a testbed and
> demonstration for the firmware/OS software stack. The hope
> is that following "best practices" results in a "typical"
> machine :-)  But the word "typical" is probably not really
> very helpful here...
>
> I would expect that in the future we'd want this machine type
> to evolve with the recommendations for how to build server
> platform hardware, which might indeed be different in two years,
> since it would be the development platform for writing/testing
> the firmware/OS stack for that two-years-time hardware.
>

To prevent spending a disproportionate amount of time on inventing
ways to parameterize these 'models', which includes interfaces not
only between UEFI and QEMU but also between ARM-TF and QEMU (and
potentially between UEFI and ARM-TF as well), could we please consider
fixed configurations for the non-discoverable bits? If there is a new
and improved sbsa model in the future, we could call it sbsa-2.0, no?

On the firmware side, I would like to implement this using build time
configuration options only, with the exception of memory size and
other things that are expected to be runtime discoverable on the real
world counterparts of our model.

I should also note that Hongbo's remark about running such firmware on
real hardware as well is slightly off the mark: we want to *model*
real hardware rather than a guest machine abstraction, but we have no
intention to share firmware builds between the sbsa model and physical
hardware.
