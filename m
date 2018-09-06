Received: from eggs.gnu.org ([2001:4830:134:3::10]:37997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fxxzy-0007yD-3y
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fxxzt-0008Ql-QY
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:23:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34764 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fxxzt-0008MN-Er
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 13:23:13 -0400
Date: Thu, 6 Sep 2018 18:23:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180906172304.GF2639@work-vm>
References: <20180831172424.12029-1-marcandre.lureau@redhat.com>
	<20180831172424.12029-7-marcandre.lureau@redhat.com>
	<20180904084648.680c564b@redhat.com>
	<CAJ+F1CLDPQr04Khj-B4UXMzEV-Cu_J2e4S4j2c43NT-s3HwywQ@mail.gmail.com>
	<20180906095802.7dffbf1b@redhat.com>
	<CAJ+F1CJymU2J+5T2pHd=bC1FDnEQZxAAWKEt_E_fPnUjQRb_dQ@mail.gmail.com>
	<20180906085937.GA2639@work-vm>
	<CAJ+F1CKeo2fGc5fLUG7Ezpk0OTkMATioqQ64A3gKT7jXvULTkA@mail.gmail.com>
	<20180906094245.GB2639@work-vm>
	<CAJ+F1C+b8Q3P7=s4W+-GCbWeLqhVCvs_xei_LTw22YWTJ16Bmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+b8Q3P7=s4W+-GCbWeLqhVCvs_xei_LTw22YWTJ16Bmg@mail.gmail.com>
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
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

* Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> Hi
>=20
> On Thu, Sep 6, 2018 at 1:42 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > Hi
> > >
> > > On Thu, Sep 6, 2018 at 12:59 PM Dr. David Alan Gilbert
> > > <dgilbert@redhat.com> wrote:
> > > >
> > > > * Marc-Andr=E9 Lureau (marcandre.lureau@gmail.com) wrote:
> > > > > Hi
> > > > >
> > > > > On Thu, Sep 6, 2018 at 11:58 AM Igor Mammedov <imammedo@redhat.=
com> wrote:
> > > > > >
> > > > > > On Thu, 6 Sep 2018 07:50:09 +0400
> > > > > > Marc-Andr=E9 Lureau <marcandre.lureau@gmail.com> wrote:
> > > > > >
> > > > > > > Hi
> > > > > > >
> > > > > > > On Tue, Sep 4, 2018 at 10:47 AM Igor Mammedov <imammedo@red=
hat.com> wrote:
> > > > > > > >
> > > > > > > > On Fri, 31 Aug 2018 19:24:24 +0200
> > > > > > > > Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com> wrote:
> > > > > > > >
> > > > > > > > > This allows to pass the last failing test from the Wind=
ows HLK TPM 2.0
> > > > > > > > > TCG PPI 1.3 tests.
> > > > > > > > >
> > > > > > > > > The interface is described in the "TCG Platform Reset A=
ttack
> > > > > > > > > Mitigation Specification", chapter 6 "ACPI _DSM Functio=
n". According
> > > > > > > > > to Laszlo, it's not so easy to implement in OVMF, he su=
ggested to do
> > > > > > > > > it in qemu instead.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@re=
dhat.com>
> > > > > > > > > ---
> > > > > > > > >  hw/tpm/tpm_ppi.h     |  2 ++
> > > > > > > > >  hw/i386/acpi-build.c | 46 ++++++++++++++++++++++++++++=
++++++++++++++++
> > > > > > > > >  hw/tpm/tpm_crb.c     |  1 +
> > > > > > > > >  hw/tpm/tpm_ppi.c     | 23 ++++++++++++++++++++++
> > > > > > > > >  hw/tpm/tpm_tis.c     |  1 +
> > > > > > > > >  docs/specs/tpm.txt   |  2 ++
> > > > > > > > >  hw/tpm/trace-events  |  3 +++
> > > > > > > > >  7 files changed, 78 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/hw/tpm/tpm_ppi.h b/hw/tpm/tpm_ppi.h
> > > > > > > > > index f6458bf87e..3239751e9f 100644
> > > > > > > > > --- a/hw/tpm/tpm_ppi.h
> > > > > > > > > +++ b/hw/tpm/tpm_ppi.h
> > > > > > > > > @@ -23,4 +23,6 @@ typedef struct TPMPPI {
> > > > > > > > >  bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion =
*m,
> > > > > > > > >                    hwaddr addr, Object *obj, Error **er=
rp);
> > > > > > > > >
> > > > > > > > > +void tpm_ppi_reset(TPMPPI *tpmppi);
> > > > > > > > > +
> > > > > > > > >  #endif /* TPM_TPM_PPI_H */
> > > > > > > > > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.=
c
> > > > > > > > > index c5e9a6e11d..2ab3e8fae7 100644
> > > > > > > > > --- a/hw/i386/acpi-build.c
> > > > > > > > > +++ b/hw/i386/acpi-build.c
> > > > > > > > > @@ -1824,6 +1824,13 @@ build_tpm_ppi(TPMIf *tpm, Aml *d=
ev)
> > > > > > > > >      pprq =3D aml_name("PPRQ");
> > > > > > > > >      pprm =3D aml_name("PPRM");
> > > > > > > > >
> > > > > > > > > +    aml_append(dev,
> > > > > > > > > +               aml_operation_region("TPP3", AML_SYSTEM=
_MEMORY,
> > > > > > > > > +                                    aml_int(TPM_PPI_AD=
DR_BASE + 0x15a),
> > > > > > > > > +                                    0x1));
> > > > > > > > > +    field =3D aml_field("TPP3", AML_BYTE_ACC, AML_NOLO=
CK, AML_PRESERVE);
> > > > > > > > > +    aml_append(field, aml_named_field("MOVV", 8));
> > > > > > > > > +    aml_append(dev, field);
> > > > > > > > >      /*
> > > > > > > > >       * DerefOf in Windows is broken with SYSTEM_MEMORY=
.  Use a dynamic
> > > > > > > > >       * operation region inside of a method for getting=
 FUNC[op].
> > > > > > > > > @@ -2166,7 +2173,46 @@ build_tpm_ppi(TPMIf *tpm, Aml *d=
ev)
> > > > > > > > >              aml_append(ifctx, aml_return(aml_buffer(1,=
 zerobyte)));
> > > > > > > > >          }
> > > > > > > > >          aml_append(method, ifctx);
> > > > > > > > > +
> > > > > > > > > +        ifctx =3D aml_if(
> > > > > > > > > +            aml_equal(uuid,
> > > > > > > > > +                      aml_touuid("376054ED-CC13-4675-9=
01C-4756D7F2D45D")));
> > > > > > > > > +        {
> > > > > > > > > +            /* standard DSM query function */
> > > > > > > > > +            ifctx2 =3D aml_if(aml_equal(function, zero=
));
> > > > > > > > > +            {
> > > > > > > > > +                uint8_t byte_list[1] =3D { 0x03 };
> > > > > > > > > +                aml_append(ifctx2, aml_return(aml_buff=
er(1, byte_list)));
> > > > > > > > > +            }
> > > > > > > > > +            aml_append(ifctx, ifctx2);
> > > > > > > > > +
> > > > > > > > > +            /*
> > > > > > > > > +             * TCG Platform Reset Attack Mitigation Sp=
ecification 1.0 Ch.6
> > > > > > > > > +             *
> > > > > > > > > +             * Arg 2 (Integer): Function Index =3D 1
> > > > > > > > > +             * Arg 3 (Package): Arguments =3D Package:=
 Type: Integer
> > > > > > > > > +             *                  Operation Value of the=
 Request
> > > > > > > > > +             * Returns: Type: Integer
> > > > > > > > > +             *          0: Success
> > > > > > > > > +             *          1: General Failure
> > > > > > > > > +             */
> > > > > > > > > +            ifctx2 =3D aml_if(aml_equal(function, one)=
);
> > > > > > > > > +            {
> > > > > > > > > +                aml_append(ifctx2,
> > > > > > > > > +                           aml_store(aml_derefof(aml_i=
ndex(arguments, zero)),
> > > > > > > > > +                                     op));
> > > > > > > > > +                {
> > > > > > > > > +                    aml_append(ifctx2, aml_store(op, a=
ml_name("MOVV")));
> > > > > > > > > +
> > > > > > > > > +                    /* 0: success */
> > > > > > > > > +                    aml_append(ifctx2, aml_return(zero=
));
> > > > > > > > > +                }
> > > > > > > > > +            }
> > > > > > > > > +            aml_append(ifctx, ifctx2);
> > > > > > > > > +        }
> > > > > > > > > +        aml_append(method, ifctx);
> > > > > > > > >      }
> > > > > > > > > +
> > > > > > > > >      aml_append(dev, method);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > > > > > > > > index b243222fd6..48f6a716ad 100644
> > > > > > > > > --- a/hw/tpm/tpm_crb.c
> > > > > > > > > +++ b/hw/tpm/tpm_crb.c
> > > > > > > > > @@ -233,6 +233,7 @@ static void tpm_crb_reset(void *dev=
)
> > > > > > > > >  {
> > > > > > > > >      CRBState *s =3D CRB(dev);
> > > > > > > > >
> > > > > > > > > +    tpm_ppi_reset(&s->ppi);
> > > > > > > > >      tpm_backend_reset(s->tpmbe);
> > > > > > > > >
> > > > > > > > >      memset(s->regs, 0, sizeof(s->regs));
> > > > > > > > > diff --git a/hw/tpm/tpm_ppi.c b/hw/tpm/tpm_ppi.c
> > > > > > > > > index 8b46b9dd4b..ce43bc5729 100644
> > > > > > > > > --- a/hw/tpm/tpm_ppi.c
> > > > > > > > > +++ b/hw/tpm/tpm_ppi.c
> > > > > > > > > @@ -16,8 +16,30 @@
> > > > > > > > >  #include "qapi/error.h"
> > > > > > > > >  #include "cpu.h"
> > > > > > > > >  #include "sysemu/memory_mapping.h"
> > > > > > > > > +#include "sysemu/reset.h"
> > > > > > > > >  #include "migration/vmstate.h"
> > > > > > > > >  #include "tpm_ppi.h"
> > > > > > > > > +#include "trace.h"
> > > > > > > > > +
> > > > > > > > > +void tpm_ppi_reset(TPMPPI *tpmppi)
> > > > > > > > > +{
> > > > > > > >
> > > > > > > >
> > > > > > > > > +    char *ptr =3D memory_region_get_ram_ptr(&tpmppi->r=
am);
> > > > > > > > nvdimm seems to use cpu_physical_memory_read() to access =
guest
> > > > > > > > accessible memory, so question is what's difference?
> > > > > > >
> > > > > > > cpu_physical_memory_read() is higher level, doing dispatch =
on address
> > > > > > > and length checks.
> > > > > > >
> > > > > > > This is a bit unnecessary, as ppi->buf could be accessed di=
rectly.
> > > > > > [...]
> > > > > > > > > +            memset(block->host_addr, 0,
> > > > > > > > > +                   block->target_end - block->target_s=
tart);
> > > > > > > > > +        }
> > > > > > my concern here is that if we directly touch guest memory her=
e
> > > > > > we might get in trouble on migration without dirtying modifie=
d
> > > > > > ranges
> > > > >
> > > > > It is a read-only of one byte.
> > > > > by the time the reset handler is called, the memory must have b=
een
> > > > > already migrated.
> > > >
> > > > Looks like a write to me?
> > >
> > > the PPI RAM memory is read for the "memory clear" byte
> > > The whole guest RAM is reset to 0 if set.
> >
> > Oh, I see; hmm.
> > How do you avoid zeroing things like persistent memory? Or ROMs? Or E=
FI
> > pflash?
>=20
> guest_phys_blocks_append() only cares about RAM (see
> guest_phys_blocks_region_add)

Hmm, promising; it uses:
    if (!memory_region_is_ram(section->mr) ||
        memory_region_is_ram_device(section->mr)) {
        return;
    }

so ram_device is used by vfio and vhost-user; I don't see anything else.
pflash init's as a rom_device so that's probably OK.
But things like backends/hostmem-file.c just use
memory_region_init_ram_from_file even if they're shared or PMEM.
So, I think this would wipe an attached PMEM device - do you want to or
not?

> >
> > > > Also, don't forget that a guest reset can happen during a migrati=
on.
> > >
> > > Hmm, does cpu_physical_memory_read()  guarantee the memory has been=
 migrated?
> > > Is there a way to wait for migration to be completed in a reset han=
dler?
> >
> > No; remember that migration can take a significant amount of time (ma=
ny
> > minutes) as you stuff many GB of RAM down a network.
> >
> > So you can be in the situation where:
> >      a) Migration starts
> >      b) Migration sends a copy of most of RAM across
> >      c) Guest dirties lots of RAM in parallel with b
> >      d) migration sends some of the RAM again
> >      e) guest reboots
> >      f) migration keeps sending ram across
> >      g) Migration finally completes and starts on destination
> >
> > a-f are all happening on the source side as the guest is still runnin=
g
> > and doing whatever it wants (including reboots).
> >
> > Given something like acpi-build.c's acpi_ram_update's call to
> > memory_region_set_dirty, would that work for you?
>=20
> after the memset(), it should then call:
>=20
> memory_region_set_dirty(block->mr, 0, block->target_end - block->target=
_start);
>=20
> looks about right?

I think so.

Dave

>=20
> thanks
>=20
> > Dave
> >
> > > >
> > > > Dave
> > > >
> > > > > >
> > > > > > PS:
> > > > > > feel free it ignore since I don't have a clue what I'm talkin=
g about :)
> > > > > >
> > > > > > > > > +        guest_phys_blocks_free(&guest_phys_blocks);
> > > > > > > > > +    }
> > > > > > > > > +}
> > > > > > > > >
> > > > > > > > >  bool tpm_ppi_init(TPMPPI *tpmppi, struct MemoryRegion =
*m,
> > > > > > > > >                    hwaddr addr, Object *obj, Error **er=
rp)
> > > > > > > > > @@ -27,5 +49,6 @@ bool tpm_ppi_init(TPMPPI *tpmppi, str=
uct MemoryRegion *m,
> > > > > > > > >      vmstate_register_ram(&tpmppi->ram, DEVICE(obj));
> > > > > > > > >
> > > > > > > > >      memory_region_add_subregion(m, addr, &tpmppi->ram)=
;
> > > > > > > > > +
> > > > > > > > >      return true;
> > > > > > > > >  }
> > > > > > > > > diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
> > > > > > > > > index 70432ffe8b..d9bfa956cc 100644
> > > > > > > > > --- a/hw/tpm/tpm_tis.c
> > > > > > > > > +++ b/hw/tpm/tpm_tis.c
> > > > > > > > > @@ -868,6 +868,7 @@ static void tpm_tis_reset(DeviceSta=
te *dev)
> > > > > > > > >      s->be_buffer_size =3D MIN(tpm_backend_get_buffer_s=
ize(s->be_driver),
> > > > > > > > >                              TPM_TIS_BUFFER_MAX);
> > > > > > > > >
> > > > > > > > > +    tpm_ppi_reset(&s->ppi);
> > > > > > > > >      tpm_backend_reset(s->be_driver);
> > > > > > > > >
> > > > > > > > >      s->active_locty =3D TPM_TIS_NO_LOCALITY;
> > > > > > > > > diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> > > > > > > > > index 332c2ae597..ce9bda3c89 100644
> > > > > > > > > --- a/docs/specs/tpm.txt
> > > > > > > > > +++ b/docs/specs/tpm.txt
> > > > > > > > > @@ -121,6 +121,8 @@ layout:
> > > > > > > > >   +----------+--------+--------+-----------------------=
--------------------+
> > > > > > > > >   | next_step|   0x1  |  0x159 | Operation to execute a=
fter reboot by      |
> > > > > > > > >   |          |        |        | firmware. Used by firm=
ware.               |
> > > > > > > > > + +----------+--------+--------+-----------------------=
--------------------+
> > > > > > > > > + | movv     |   0x1  |  0x15a | Memory overwrite varia=
ble                 |
> > > > > > > > >   +----------+--------+--------+-----------------------=
--------------------+
> > > > > > > > >
> > > > > > > > >     The following values are supported for the 'func' f=
ield. They correspond
> > > > > > > > > diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> > > > > > > > > index 25bee0cecf..920d32ad55 100644
> > > > > > > > > --- a/hw/tpm/trace-events
> > > > > > > > > +++ b/hw/tpm/trace-events
> > > > > > > > > @@ -51,3 +51,6 @@ tpm_tis_mmio_write_init_abort(void) "=
Initiating abort"
> > > > > > > > >  tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
> > > > > > > > >  tpm_tis_mmio_write_data2send(uint32_t value, unsigned =
size) "Data to send to TPM: 0x%08x (size=3D%d)"
> > > > > > > > >  tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "l=
octy: %d, rw_offset =3D %u"
> > > > > > > > > +
> > > > > > > > > +# hw/tpm/tpm_ppi.c
> > > > > > > > > +tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p =
%zu"
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > >
> > > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Marc-Andr=E9 Lureau
> > > > --
> > > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > >
> > >
> > >
> > > --
> > > Marc-Andr=E9 Lureau
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20
>=20
>=20
> --=20
> Marc-Andr=E9 Lureau
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
