Received: from eggs.gnu.org ([2001:4830:134:3::10]:54197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fzJqk-0004zW-F5
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 06:55:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fzJg0-0008Uq-9G
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 06:44:20 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fzJg0-0008Ta-0C
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 06:44:16 -0400
Date: Mon, 10 Sep 2018 11:44:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180910104408.GE2482@work-vm>
References: <20180904084648.680c564b@redhat.com>
	<CAJ+F1CLDPQr04Khj-B4UXMzEV-Cu_J2e4S4j2c43NT-s3HwywQ@mail.gmail.com>
	<20180906095802.7dffbf1b@redhat.com>
	<CAJ+F1CJymU2J+5T2pHd=bC1FDnEQZxAAWKEt_E_fPnUjQRb_dQ@mail.gmail.com>
	<20180906085937.GA2639@work-vm>
	<CAJ+F1CKeo2fGc5fLUG7Ezpk0OTkMATioqQ64A3gKT7jXvULTkA@mail.gmail.com>
	<20180906094245.GB2639@work-vm>
	<CAJ+F1C+b8Q3P7=s4W+-GCbWeLqhVCvs_xei_LTw22YWTJ16Bmg@mail.gmail.com>
	<20180906172304.GF2639@work-vm>
	<43c91014-2ca4-681b-51e7-b8cde063014c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <43c91014-2ca4-681b-51e7-b8cde063014c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 6/6] tpm: add ACPI memory clear
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

* Laszlo Ersek (lersek@redhat.com) wrote:
> On 09/06/18 19:23, Dr. David Alan Gilbert wrote:
> > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> >> Hi
> >>
> >> On Thu, Sep 6, 2018 at 1:42 PM Dr. David Alan Gilbert
> >> <dgilbert@redhat.com> wrote:
> >>>
> >>> * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> >>>> Hi
> >>>>
> >>>> On Thu, Sep 6, 2018 at 12:59 PM Dr. David Alan Gilbert
> >>>> <dgilbert@redhat.com> wrote:
> >>>>>
> >>>>> * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> >>>>>> Hi
> >>>>>>
> >>>>>> On Thu, Sep 6, 2018 at 11:58 AM Igor Mammedov <imammedo@redhat.c=
om> wrote:
> >>>>>>>
> >>>>>>> On Thu, 6 Sep 2018 07:50:09 +0400
> >>>>>>> Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> wrote:
> >>>>>>>
> >>>>>>>> Hi
> >>>>>>>>
> >>>>>>>> On Tue, Sep 4, 2018 at 10:47 AM Igor Mammedov <imammedo@redhat=
.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Fri, 31 Aug 2018 19:24:24 +0200
> >>>>>>>>> Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> wrote:
> >>>>>>>>>
> >>>>>>>>>> This allows to pass the last failing test from the Windows H=
LK TPM 2.0
> >>>>>>>>>> TCG PPI 1.3 tests.
> >>>>>>>>>>
> >>>>>>>>>> The interface is described in the "TCG Platform Reset Attack
> >>>>>>>>>> Mitigation Specification", chapter 6 "ACPI _DSM Function". A=
ccording
> >>>>>>>>>> to Laszlo, it's not so easy to implement in OVMF, he suggest=
ed to do
> >>>>>>>>>> it in qemu instead.
> >>>>>>>>>>
> >>>>>>>>>> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.=
com>
> >>>>>>>>>> ---
> >>>>>>>>>>  hw/tpm/tpm_ppi.h     |  2 ++
> >>>>>>>>>>  hw/i386/acpi-build.c | 46 +++++++++++++++++++++++++++++++++=
+++++++++++
> >>>>>>>>>>  hw/tpm/tpm_crb.c     |  1 +
> >>>>>>>>>>  hw/tpm/tpm_ppi.c     | 23 ++++++++++++++++++++++
> >>>>>>>>>>  hw/tpm/tpm_tis.c     |  1 +
> >>>>>>>>>>  docs/specs/tpm.txt   |  2 ++
> >>>>>>>>>>  hw/tpm/trace-events  |  3 +++
> >>>>>>>>>>  7 files changed, 78 insertions(+)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> >>>>>>>>>> index f6458bf87e..3239751e9f 100644
> >>>>>>>>>> --- a/hw/tpm/tpm_ppi.h
> >>>>>>>>>> +++ b/hw/tpm/tpm_ppi.h
> >>>>>>>>>> @@ -23,4 +23,6 @@ typedef struct TPMPPI {
> >>>>>>>>>>  bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion *m,
> >>>>>>>>>>                    hwaddr addr, Object *obj, Error **errp);
> >>>>>>>>>>
> >>>>>>>>>> +void tpm_ppi_reset(TPMPPI *tpmppi);
> >>>>>>>>>> +
> >>>>>>>>>>  #endif /* TPM_TPM_PPI_H */
> >>>>>>>>>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> >>>>>>>>>> index c5e9a6e11d..2ab3e8fae7 100644
> >>>>>>>>>> --- a/hw/i386/acpi-build.c
> >>>>>>>>>> +++ b/hw/i386/acpi-build.c
> >>>>>>>>>> @@ -1824,6 +1824,13 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
> >>>>>>>>>>      pprq =3D aml_name("PPRQ");
> >>>>>>>>>>      pprm =3D aml_name("PPRM");
> >>>>>>>>>>
> >>>>>>>>>> +    aml_append(dev,
> >>>>>>>>>> +               aml_operation_region("TPP3", AML_SYSTEM_MEMO=
RY,
> >>>>>>>>>> +                                    aml_int(TPM_PPI_ADDR_BA=
SE + 0x15a),
> >>>>>>>>>> +                                    0x1));
> >>>>>>>>>> +    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, A=
ML_PRESERVE);
> >>>>>>>>>> +    aml_append(field, aml_named_field("MOVV", 8));
> >>>>>>>>>> +    aml_append(dev, field);
> >>>>>>>>>>      /*
> >>>>>>>>>>       * DerefOf in Windows is broken with SYSTEM_MEMORY.  Us=
e a dynamic
> >>>>>>>>>>       * operation region inside of a method for getting FUNC=
[op].
> >>>>>>>>>> @@ -2166,7 +2173,46 @@ build_tpm_ppi(TPMIf *tpm, Aml *dev)
> >>>>>>>>>>              aml_append(ifctx, aml_return(aml_buffer(1, zero=
byte)));
> >>>>>>>>>>          }
> >>>>>>>>>>          aml_append(method, ifctx);
> >>>>>>>>>> +
> >>>>>>>>>> +        ifctx =3D aml_if(
> >>>>>>>>>> +            aml_equal(uuid,
> >>>>>>>>>> +                      aml_touuid("376054ED-CC13-4675-901C-4=
756D7F2D45D")));
> >>>>>>>>>> +        {
> >>>>>>>>>> +            /* standard DSM query function */
> >>>>>>>>>> +            ifctx2 =3D aml_if(aml_equal(function, zero));
> >>>>>>>>>> +            {
> >>>>>>>>>> +                uint8_t byte_list[1] =3D { 0x03 };
> >>>>>>>>>> +                aml_append(ifctx2, aml_return(aml_buffer(1,=
 byte_list)));
> >>>>>>>>>> +            }
> >>>>>>>>>> +            aml_append(ifctx, ifctx2);
> >>>>>>>>>> +
> >>>>>>>>>> +            /*
> >>>>>>>>>> +             * TCG Platform Reset Attack Mitigation Specifi=
cation 1.0 Ch.6
> >>>>>>>>>> +             *
> >>>>>>>>>> +             * Arg 2 (Integer): Function Index =3D 1
> >>>>>>>>>> +             * Arg 3 (Package): Arguments =3D Package: Type=
: Integer
> >>>>>>>>>> +             *                  Operation Value of the Requ=
est
> >>>>>>>>>> +             * Returns: Type: Integer
> >>>>>>>>>> +             *          0: Success
> >>>>>>>>>> +             *          1: General Failure
> >>>>>>>>>> +             */
> >>>>>>>>>> +            ifctx2 =3D aml_if(aml_equal(function, one));
> >>>>>>>>>> +            {
> >>>>>>>>>> +                aml_append(ifctx2,
> >>>>>>>>>> +                           aml_store(aml_derefof(aml_index(=
arguments, zero)),
> >>>>>>>>>> +                                     op));
> >>>>>>>>>> +                {
> >>>>>>>>>> +                    aml_append(ifctx2, aml_store(op, aml_na=
me("MOVV")));
> >>>>>>>>>> +
> >>>>>>>>>> +                    /* 0: success */
> >>>>>>>>>> +                    aml_append(ifctx2, aml_return(zero));
> >>>>>>>>>> +                }
> >>>>>>>>>> +            }
> >>>>>>>>>> +            aml_append(ifctx, ifctx2);
> >>>>>>>>>> +        }
> >>>>>>>>>> +        aml_append(method, ifctx);
> >>>>>>>>>>      }
> >>>>>>>>>> +
> >>>>>>>>>>      aml_append(dev, method);
> >>>>>>>>>>  }
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> >>>>>>>>>> index b243222fd6..48f6a716ad 100644
> >>>>>>>>>> --- a/hw/tpm/tpm_crb.c
> >>>>>>>>>> +++ b/hw/tpm/tpm_crb.c
> >>>>>>>>>> @@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev)
> >>>>>>>>>>  {
> >>>>>>>>>>      CRBState *s =3D CRB(dev);
> >>>>>>>>>>
> >>>>>>>>>> +    tpm_ppi_reset(&s->ppi);
> >>>>>>>>>>      tpm_backend_reset(s->tpmbe);
> >>>>>>>>>>
> >>>>>>>>>>      memset(s->regs, 0, sizeof(s->regs));
> >>>>>>>>>> diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> >>>>>>>>>> index 8b46b9dd4b..ce43bc5729 100644
> >>>>>>>>>> --- a/hw/tpm/tpm_ppi.c
> >>>>>>>>>> +++ b/hw/tpm/tpm_ppi.c
> >>>>>>>>>> @@ -16,8 +16,30 @@
> >>>>>>>>>>  #include "qapi/error.h"
> >>>>>>>>>>  #include "cpu.h"
> >>>>>>>>>>  #include "sysemu/memory_mapping.h"
> >>>>>>>>>> +#include "sysemu/reset.h"
> >>>>>>>>>>  #include "migration/vmstate.h"
> >>>>>>>>>>  #include "tpm_ppi.h"
> >>>>>>>>>> +#include "trace.h"
> >>>>>>>>>> +
> >>>>>>>>>> +void tpm_ppi_reset(TPMPPI *tpmppi)
> >>>>>>>>>> +{
> >>>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +    char *ptr =3D memory_region_get_ram_ptr(&tpmppi->ram);
> >>>>>>>>> nvdimm seems to use cpu_physical_memory_read() to access gues=
t
> >>>>>>>>> accessible memory, so question is what's difference?
> >>>>>>>>
> >>>>>>>> cpu_physical_memory_read() is higher level, doing dispatch on =
address
> >>>>>>>> and length checks.
> >>>>>>>>
> >>>>>>>> This is a bit unnecessary, as ppi->buf could be accessed direc=
tly.
> >>>>>>> [...]
> >>>>>>>>>> +            memset(block->host_addr, 0,
> >>>>>>>>>> +                   block->target_end - block->target_start)=
;
> >>>>>>>>>> +        }
> >>>>>>> my concern here is that if we directly touch guest memory here
> >>>>>>> we might get in trouble on migration without dirtying modified
> >>>>>>> ranges
> >>>>>>
> >>>>>> It is a read-only of one byte.
> >>>>>> by the time the reset handler is called, the memory must have be=
en
> >>>>>> already migrated.
> >>>>>
> >>>>> Looks like a write to me?
> >>>>
> >>>> the PPI RAM memory is read for the "memory clear" byte
> >>>> The whole guest RAM is reset to 0 if set.
> >>>
> >>> Oh, I see; hmm.
> >>> How do you avoid zeroing things like persistent memory? Or ROMs? Or=
 EFI
> >>> pflash?
> >>
> >> guest_phys_blocks_append() only cares about RAM (see
> >> guest_phys_blocks_region_add)
> >=20
> > Hmm, promising; it uses:
> >     if (!memory_region_is_ram(section->mr) ||
> >         memory_region_is_ram_device(section->mr)) {
> >         return;
> >     }
> >=20
> > so ram_device is used by vfio and vhost-user; I don't see anything el=
se.
> > pflash init's as a rom_device so that's probably OK.
> > But things like backends/hostmem-file.c just use
> > memory_region_init_ram_from_file even if they're shared or PMEM.
> > So, I think this would wipe an attached PMEM device - do you want to =
or
> > not?
>=20
> I think that question could be put, "does the reset attack mitigation
> spec recommend / require clearing persistent memory"? I've got no idea.
> The reset attack is that the platform is re-set (forcibly, uncleanly)
> while the original OS holds some secrets in memory, then the attacker's
> OS (or firmware application) is loaded, and those scavenge the
> leftovers. Would the original OS keep secrets in PMEM? I don't know.

No, I don't know either; and I think part of the answer might depend
what PMEM is being used for; if it's being used as actual storage with
a filesystem or database on, you probably don't want to clear it - I
mean that's what the (P)ersistence is for.

> I guess all address space that a guest OS could consider as "read-write
> memory" should be wiped. I think guest_phys_blocks_append() is a good
> choice here; originally I wrote that for supporting guest RAM dump; see
> commit c5d7f60f06142. Note that the is_ram_device bit was added
> separately, see commits e4dc3f5909ab9 and 21e00fa55f3fd -- but that's a
> change in the "right" direction here, because it *restricts* what
> regions qualify (for dumping, and here for clearing).

Yem, I'm wondering if we should add a check for the pmem flag at the
same place.

Having said that; I don't think that's a question for this patch series;
if we agree that guest_phys_blocks* is the right thing to use then it's
a separate question about adding the pmem check to there.
(I didn't know about guest_phys_block* and would have probably just used
qemu_ram_foreach_block )

Dave


> >=20
> >>>
> >>>>> Also, don't forget that a guest reset can happen during a migrati=
on.
> >>>>
> >>>> Hmm, does cpu_physical_memory_read()  guarantee the memory has bee=
n migrated?
> >>>> Is there a way to wait for migration to be completed in a reset ha=
ndler?
> >>>
> >>> No; remember that migration can take a significant amount of time (=
many
> >>> minutes) as you stuff many GB of RAM down a network.
> >>>
> >>> So you can be in the situation where:
> >>>      a) Migration starts
> >>>      b) Migration sends a copy of most of RAM across
> >>>      c) Guest dirties lots of RAM in parallel with b
> >>>      d) migration sends some of the RAM again
> >>>      e) guest reboots
> >>>      f) migration keeps sending ram across
> >>>      g) Migration finally completes and starts on destination
> >>>
> >>> a-f are all happening on the source side as the guest is still runn=
ing
> >>> and doing whatever it wants (including reboots).
> >>>
> >>> Given something like acpi-build.c's acpi_ram_update's call to
> >>> memory_region_set_dirty, would that work for you?
> >>
> >> after the memset(), it should then call:
> >>
> >> memory_region_set_dirty(block->mr, 0, block->target_end - block->tar=
get_start);
> >>
> >> looks about right?
> >=20
> > I think so.
>=20
> I'll admit I can't follow the dirtying discussion. But, I'm reminded of
> another commit of Dave's, namely 90c647db8d59 ("Fix pflash migration",
> 2016-04-15). Would the same trick apply here?
>=20
> (
>=20
> BTW, I'm sorry about not having following this series closely -- I feel
> bad that we can't solve this within the firmware, but we really can't.
> The issue is that this memory clearing would have to occur really early
> into the firmware, at the latest in the PEI phase.
>=20
> However, both the 32-bit and the 64-bit variants of OVMF's PEI phase
> have access only to the lowest 4GB of the memory address space. Mapping
> all RAM (even with a "sliding bank") for clearing it would be a real
> mess. To that, add the fact that OVMF's PEI phase executes from RAM (no=
t
> from pflash -- in OVMF, only SEC executes from pflash, and it
> decompresses the PEI + DXE firmware volumes to RAM), so PEI would have
> to clear all RAM *except* the areas its own self occupies, such as code=
,
> global variables (static data), heap, stack, other processor data
> structures (IDT, GDT, page tables, ...). And, no gaps inside those
> should be left out either, because the previous OS might have left
> secrets there...
>=20
> This is actually easier for firmware that runs on physical hardware; fo=
r
> two reasons. First, on physical hardware, the PEI phase of the firmware
> runs from pflash (it might use CAR, Cache-As-RAM, for a small temporary
> r/w storage), so it doesn't have to worry about scribbling over itself.
> Second, on physical hardware, the memory controller too has to be boote=
d
> up -- the PEI code that does this is all vendors' most closely guarded
> secret, and *never* open source --; and when the firmware massages
> chipset registers for that, it can use non-architected means to get the
> RAM to clear itself.
>=20
> In comparison, in QEMU/KVM guests, the RAM just *is*. While that's a
> huge relief most of the time, in this case, the fact that the RAM can
> start out as nonzero, is a big problem. Hence my plea to implement the
> feature in QEMU.
>=20
> )
>=20
> Thanks,
> Laszlo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
