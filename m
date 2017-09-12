Received: from eggs.gnu.org ([2001:4830:134:3::10]:54212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drhsp-0001RK-Ap
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drhsm-0002Ow-A6
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:53:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1drhsm-0002OO-2u
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 05:53:28 -0400
Date: Tue, 12 Sep 2017 11:53:24 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170912115324.3c60a6b0@nial.brq.redhat.com>
In-Reply-To: <CAFEAcA-swU6nuw2LHFxT2MEzACGcR4SP6+EU-TtWbm6LvPKzyA@mail.gmail.com>
References: <CAFEAcA_sk792HSvX7=6hnd2PEZ+FoVz=JEcBKu5CbLW5drzMhQ@mail.gmail.com>
	<20170904213851.107ed8c8@Igors-MacBook-Pro.local>
	<CAFEAcA8H==oJGm=rkjHUG-DPTo+PhqLcb=RG-Gb6oG+dUYVi3Q@mail.gmail.com>
	<20170911141016.2352b022@nial.brq.redhat.com>
	<CAFEAcA_41Dkh4EdvCWWcnFHZaspOBA0FewKKK22kQ0v97pKG0Q@mail.gmail.com>
	<20170912094001.04e7a84a@nial.brq.redhat.com>
	<CAFEAcA-swU6nuw2LHFxT2MEzACGcR4SP6+EU-TtWbm6LvPKzyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 12 Sep 2017 10:11:32 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 12 September 2017 at 08:40, Igor Mammedov <imammedo@redhat.com> wrote:
> > On Mon, 11 Sep 2017 14:33:03 +0100
> > Peter Maydell <peter.maydell@linaro.org> wrote:  
> >> It's not possible in all cases to set a CPU property from the
> >> top level board code. In quite a lot of cases the CPU
> >> object is created by an SoC object which is in turn
> >> created by the board code, and there is no plumbing
> >> there to pass arbitrary properties through to the CPU
> >> object...  
> > there is a cleaner way without cpu accessing machine,
> > make it property of cpu and use compat machinery that
> > was invented for fixing up stuff of this kind.
> >
> > SET_MACHINE_COMPAT(MachineClass,
> >                    { .driver = "arm-cpu",
> >                      .property = "foo",
> >                      .value    = "off",
> >                    }
> >                   )  
> 
> It looks like we only use that machine-compat stuff on
> our versioned boards, which is pretty much the only place
> where we don't need to set this particular flag...
typically, yes it's used for versioned boards to, because
it's where we have to fixup/override defaults to keep compatibility.
But it's does not mean that it's limited to it.

in this case it allows to keep clean separation of device model
and not add an extra member to generic MachineClass which is used
by some old boards.


> thanks
> -- PMM
> 
