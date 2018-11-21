Received: from eggs.gnu.org ([2001:4830:134:3::10]:34102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gPOWn-0003SG-KE
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gPOWl-0007Iq-KB
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 04:10:33 -0500
Date: Wed, 21 Nov 2018 10:10:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181121101004.6405408a@redhat.com>
In-Reply-To: <d84bafe2-184b-bc62-9cde-0d1421cb484d@redhat.com>
References: <20181107123652.23417-1-marcandre.lureau@redhat.com>
	<20181107123652.23417-3-marcandre.lureau@redhat.com>
	<20181120173324.64a36d8e@redhat.com>
	<d84bafe2-184b-bc62-9cde-0d1421cb484d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 02/14] qom: make interface types
 abstract
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Stefano Stabellini <sstabellini@kernel.org>, Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>, Amit Shah <amit@kernel.org>, qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, dgilbert@redhat.com, qemu-arm@nongnu.org, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, Richard Henderson <rth@twiddle.net>, Andreas =?UTF-8?B?RsOkcmJlcg==?= <afaerber@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Stefan Berger <stefanb@linux.ibm.com>

On Tue, 20 Nov 2018 19:54:23 +0100
Laszlo Ersek <lersek@redhat.com> wrote:

> On 11/20/18 17:33, Igor Mammedov wrote:
> > On Wed,  7 Nov 2018 16:36:40 +0400
> > Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> wrote:
> >  =20
> >> Interfaces don't have instance, let's make the interface type really
> >> abstract to avoid confusion.
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  include/hw/acpi/acpi_dev_interface.h | 6 +-----
> >>  include/hw/arm/linux-boot-if.h       | 5 +----
> >>  include/hw/fw-path-provider.h        | 4 +---
> >>  include/hw/hotplug.h                 | 6 +-----
> >>  include/hw/intc/intc.h               | 4 +---
> >>  include/hw/ipmi/ipmi.h               | 4 +---
> >>  include/hw/isa/isa.h                 | 4 ----
> >>  include/hw/mem/memory-device.h       | 4 +---
> >>  include/hw/nmi.h                     | 4 +---
> >>  include/hw/stream.h                  | 4 +---
> >>  include/hw/timer/m48t59.h            | 4 +---
> >>  include/qom/object_interfaces.h      | 6 +-----
> >>  include/sysemu/tpm.h                 | 4 +---
> >>  target/arm/idau.h                    | 4 +---
> >>  tests/check-qom-interface.c          | 4 +---
> >>  15 files changed, 14 insertions(+), 53 deletions(-)
> >>
> >> diff --git a/include/hw/acpi/acpi_dev_interface.h b/include/hw/acpi/ac=
pi_dev_interface.h
> >> index dabf4c4fc9..43ff119179 100644
> >> --- a/include/hw/acpi/acpi_dev_interface.h
> >> +++ b/include/hw/acpi/acpi_dev_interface.h
> >> @@ -25,11 +25,7 @@ typedef enum {
> >>       INTERFACE_CHECK(AcpiDeviceIf, (obj), \
> >>                       TYPE_ACPI_DEVICE_IF)
> >> =20
> >> -
> >> -typedef struct AcpiDeviceIf {
> >> -    /* <private> */
> >> -    Object Parent;
> >> -} AcpiDeviceIf;
> >> +typedef struct AcpiDeviceIf AcpiDeviceIf;
> >> =20
> >>  void acpi_send_event(DeviceState *dev, AcpiEventStatusBits event);
> >> =20
> >> diff --git a/include/hw/arm/linux-boot-if.h b/include/hw/arm/linux-boo=
t-if.h
> >> index aba4479a14..7bbdfd1cc6 100644
> >> --- a/include/hw/arm/linux-boot-if.h
> >> +++ b/include/hw/arm/linux-boot-if.h
> >> @@ -16,10 +16,7 @@
> >>  #define ARM_LINUX_BOOT_IF(obj) \
> >>      INTERFACE_CHECK(ARMLinuxBootIf, (obj), TYPE_ARM_LINUX_BOOT_IF)
> >> =20
> >> -typedef struct ARMLinuxBootIf {
> >> -    /*< private >*/
> >> -    Object parent_obj;
> >> -} ARMLinuxBootIf;
> >> +typedef struct ARMLinuxBootIf ARMLinuxBootIf; =20
> > I like how it makes interface truly opaque and removes the need for
> > structure declaration but:
> >=20
> >  1: I'm not sure if it's acceptable thing to do from language point of =
view =20
>=20
> Yeah, it's fine. If you have just
>=20
> struct ARMLinuxBootIf;
>=20
> (and, optionally, a typedef to it,) then this type is called an
> "incomplete type" (for translation units that don't see the actual type
> definition). You can't apply the "sizeof" operator to it, you can't put
> it in other structs and arrays etc. I'm too lazy to look up the exact
> details in the C standard now. :) But, importantly,
> "pointer-to-ARMLinuxBootIf" is a complete type, and you can do all the
> usual things with that. (Define variables of that pointer type, embed
> them in other structures, use it as an array element type, pass them to
> functions, and so on.)

Thanks Laszlo, that's the answer I was looking for.

> Thanks
> Laszlo
>=20
> >  2: For a reader not aware of a trick, it's sort of confusing to have f=
orward declaration but without structure itself. So if #1 is acceptable we =
probably should document interface trick in object.h
> >=20
> > [...]
> >  =20
>=20
>=20
