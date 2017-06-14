Received: from eggs.gnu.org ([2001:4830:134:3::10]:34420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dL5od-0006kk-Fa
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:46:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dL5ob-0002RM-RC
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:46:23 -0400
Received: from mail-lf0-x231.google.com ([2a00:1450:4010:c07::231]:36672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dL5ob-0002R5-D8
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 06:46:21 -0400
Received: by mail-lf0-x231.google.com with SMTP id o83so88820427lff.3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 03:46:20 -0700 (PDT)
MIME-Version: 1.0
References: <20170424130355.31324-1-marcandre.lureau@redhat.com>
	<CABdb736pFG7yK+C_J-WWRbX+e-bk62TejQ_GtObxyFmV5t350w@mail.gmail.com>
	<CAJ+F1CJPEZNUPrYseN3JD+gAtwJ-rLQVRBLdXTQVSwaBTdNGHA@mail.gmail.com>
	<20170502091723.3a3b4e42@nial.brq.redhat.com>
	<CAJ+F1CJ-tvPdX1QLYKWg6M_cattYcBDO25Hfp+rfBpnCZbwFtA@mail.gmail.com>
	<20170504154103.69a8eaa8@nial.brq.redhat.com>
	<CAJ+F1C+z7aizkCJOsYnzjhgU7cXGkKy3HzejE_Yv_NzoRvcmZQ@mail.gmail.com>
	<20170529144435.79b23666@nial.brq.redhat.com>
In-Reply-To: <20170529144435.79b23666@nial.brq.redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 14 Jun 2017 10:46:08 +0000
Message-ID: <CAJ+F1CKdE2QX4-wV0W1KTBumEe0zjDXiKfh7igtPT4D2WSn87g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] RFC: vmcoreinfo device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ladi Prosek <lprosek@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, anderson@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>

Hi

On Mon, May 29, 2017 at 4:44 PM Igor Mammedov <imammedo@redhat.com> wrote:

> On Fri, 26 May 2017 13:59:09 +0000
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
>
> > Hi
> >
> > On Thu, May 4, 2017 at 5:41 PM Igor Mammedov <imammedo@redhat.com>
> wrote:
> >
> > > On Tue, 02 May 2017 19:03:15 +0000
> > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > >
> > > > Hi
> > > >
> > > > On Tue, May 2, 2017 at 11:17 AM Igor Mammedov <imammedo@redhat.com>
> > > wrote:
> > > >
> > > > > On Fri, 28 Apr 2017 14:28:38 +0000
> > > > > Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:
> > > > >
> > > > > > Hi
> > > > > >
> > > > > > On Fri, Apr 28, 2017 at 6:12 PM Ladi Prosek <lprosek@redhat.com=
>
> > > wrote:
> > > > > >
> > > > > > > On Mon, Apr 24, 2017 at 3:03 PM, Marc-Andr=C3=A9 Lureau
> > > > > > > <marcandre.lureau@redhat.com> wrote:
> > > > > > > > The VM coreinfo (vmcoreinfo) device is an emulated device
> which
> > > > > > > > exposes a 4k memory range to the guest to store various
> > > informations
> > > > > > > > useful to debug the guest OS. (it is greatly inspired by th=
e
> > > VMGENID
> > > > > > > > device implementation)
> > > > > > > >
> > > > > > > > This is an early-boot alternative to the qemu-ga VMDUMP_INF=
O
> > > event
> > > > > > > > proposed in "[PATCH 00/21] WIP: dump: add kaslr support".
> > > > > > > >
> > > > > > > > If deemed more appropriate, we can consider writing to fw_c=
fg
> > > > > directly
> > > > > > > > instead of guest memory, now that qemu 2.9 supports it agai=
n.
> > > > > > > >
> > > > > > > > The proof-of-concept kernel module:
> > > > > > > >
> > > https://github.com/elmarco/vmgenid-test/blob/master/qemuvmci-test.c
> > > > > > >
> > > > > > > Here's a proof-of-concept Windows driver:
> > > > > > >
> > > > > > >
> > > > >
> > >
> https://github.com/ladipro/kvm-guest-drivers-windows/tree/vmcoreinfo/vmco=
reinfo
> > > > > > >
> > > > > > > I just wanted to be sure that it's possible to evaluate the
> ADDR
> > > > > > > method in Windows.
> > > > > > >
> > > > > > > From a practical point of view it is unfortunate that this
> would
> > > be a
> > > > > > > completely new device. For Windows guests it means another
> driver
> > > > > > > binary and all the overhead associated with deploying it on
> VMs.
> > > Would
> > > > > > > it be too crazy to add this functionality to the pvpanic
> device?
> > > The
> > > > > > > mechanics could stay the same but it would be done under the
> > > existing
> > > > > > > ACPI\QEMU0001 device.
> > > > > > >
> > > > > >
> > > > > > pvpanic is under _SB.PCI0.ISA, that could be problematic
> > > > > >
> > > > > > and _STA is a name field.
> > > > > >
> > > > > > Someone with more experience with ACPI could tell us if that ma=
ke
> > > sense
> > > > > to
> > > > > > merge both and how.
> > > > > >
> > > > > > Can't you handle 2 ACPI devices in the same windows driver
> instead?
> > > > > we use QEMU0001 to reserve IO ports for pvpanic device,
> > > > > ASL wise there shouldn't problems with adding _ADDR method to it
> > > > >
> > > > > but then we probably should fold vmcoreinfo into pvpanic device
> > > > > as well (QEMU and linux driver)
> > > > >
> > > > >
> > > > pvpanic is x86-only afaict.
> > > There is nothing that forces it to be x86 specific (beside being ISA
> > > device),
> > > ARM also can benefit from/use pvpanic if you make it pci device or ju=
st
> > > plain
> > > Device.
> > >
> >
> > Could someone advise on a recommended solution here?
> >
> > Should we make a PCI variant of pvpanic and add the proposed vmcoreinfo
> > ACPI/mem to it ?
> >
> > Tbh, I think I prefer to have seperate devices since they work
> differently
> > and vmcoreinfo doesn't require any bus device.
> Considering pvpanic and vmcore are closely related, I'd prefer
> it being one device. But I won't insist on it.
>
> Also instead of PCI device, I'd use plain Device as vmgenid does,
> that would leave open question how to make legacy ISA based pvpanic
> on top of it in case both are merged.
>
>
Can we instead try to fit pvpanic functionality in the proposed vmcoreinfo
device? This could be done in a future revision of the device. This way we
don't have to deal with legacy ISA, and can make pvpanic functionality more
portable.

Tbh, I have no idea how to do the merging of the legacy ISA pvpanic with
vmcoreinfo without breaking things, nor do I have the motivation to do so.

More comments welcome (I would like to resend the patch as non-rfc this
time, I hope we can make it in 2.10)

Thanks

--=20
Marc-Andr=C3=A9 Lureau
