Received: from eggs.gnu.org ([2001:4830:134:3::10]:41933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drhEZ-0002Tt-G8
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1drhEY-00013s-HZ
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:11:55 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:33684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1drhEY-00012s-Br
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:11:54 -0400
Received: by mail-wr0-x22a.google.com with SMTP id a43so19470456wrc.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 02:11:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170912094001.04e7a84a@nial.brq.redhat.com>
References: <CAFEAcA_sk792HSvX7=6hnd2PEZ+FoVz=JEcBKu5CbLW5drzMhQ@mail.gmail.com>
	<20170904213851.107ed8c8@Igors-MacBook-Pro.local>
	<CAFEAcA8H==oJGm=rkjHUG-DPTo+PhqLcb=RG-Gb6oG+dUYVi3Q@mail.gmail.com>
	<20170911141016.2352b022@nial.brq.redhat.com>
	<CAFEAcA_41Dkh4EdvCWWcnFHZaspOBA0FewKKK22kQ0v97pKG0Q@mail.gmail.com>
	<20170912094001.04e7a84a@nial.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Sep 2017 10:11:32 +0100
Message-ID: <CAFEAcA-swU6nuw2LHFxT2MEzACGcR4SP6+EU-TtWbm6LvPKzyA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qdev_get_machine() can return something non-NULL
 but not TYPE_MACHINE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 12 September 2017 at 08:40, Igor Mammedov <imammedo@redhat.com> wrote:
> On Mon, 11 Sep 2017 14:33:03 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> It's not possible in all cases to set a CPU property from the
>> top level board code. In quite a lot of cases the CPU
>> object is created by an SoC object which is in turn
>> created by the board code, and there is no plumbing
>> there to pass arbitrary properties through to the CPU
>> object...
> there is a cleaner way without cpu accessing machine,
> make it property of cpu and use compat machinery that
> was invented for fixing up stuff of this kind.
>
> SET_MACHINE_COMPAT(MachineClass,
>                    { .driver = "arm-cpu",
>                      .property = "foo",
>                      .value    = "off",
>                    }
>                   )

It looks like we only use that machine-compat stuff on
our versioned boards, which is pretty much the only place
where we don't need to set this particular flag...

thanks
-- PMM
