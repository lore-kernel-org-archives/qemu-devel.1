Received: from eggs.gnu.org ([2001:4830:134:3::10]:53621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gAskV-00010J-Rc
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:24:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gAskR-00046b-Qi
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:24:43 -0400
Received: from 5.mo7.mail-out.ovh.net ([178.32.120.239]:45052)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gAskR-00041f-K6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 04:24:39 -0400
Received: from player737.ha.ovh.net (unknown [10.109.160.40])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 7F0CBE30DB
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 10:24:30 +0200 (CEST)
Date: Fri, 12 Oct 2018 10:24:24 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181012102424.6fa1ba91@bahia.lan>
In-Reply-To: <20181012001731.GO7004@umbus.fritz.box>
References: <153924123502.3669683.1365591120394690822.stgit@bahia.lan>
	<3b91d4bf-58b2-55b6-d41d-348865b7542a@redhat.com>
	<20181011150408.56213443@bahia.lab.toulouse-stg.fr.ibm.com>
	<20181012001731.GO7004@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/rYg0h7hwCrJXp2q6orjDk+U";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] spapr_pci: rename some structured types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

--Sig_/rYg0h7hwCrJXp2q6orjDk+U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 12 Oct 2018 11:17:32 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, Oct 11, 2018 at 03:04:08PM +0200, Greg Kurz wrote:
> > On Thu, 11 Oct 2018 13:02:50 +0200
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> > > Hi Greg,
> > >=20
> > > On 11/10/2018 09:00, Greg Kurz wrote: =20
> > > > According to CODING_STYLE, structured types names are expected to be
> > > > in CamelCase. PCI is dropped from the name for better =20
> > > readability. =20
>=20
> I'd prefer you didn't drop PCI from the name.  These specifically
> *are* PCI MSIs, whereas lots of PAPR documentation (particularly for
> the interrupt controller) uses MSIs to indicate general message
> interrupts, such as those from VIO and firmware event reporting.
>=20

So, if we follow the CamelCase style used in the spapr code, this would give
sPAPRPCIMSI and sPAPRPCIMSIMig. I personally find that it's uneasy to read:
so many upper case letters in a row kinda defeat the purpose of CamelCase.

Looking at the rest of the QEMU code base, I see that there is no definitive
rule for acronyms. They're sometimes all upper-case (eg, AIOCBInfo) or conv=
erted
to CamelCase (eg, LinuxAioState)... but I couldn't find any other example w=
here
the type name only contains acronyms.

Maybe we need to twist the rule some more to handle this case.

I'll give a try with sPAPRpciMSI and sPAPRpciMSImig.

> > > >=20
> > > > While here, this also converts a call to g_malloc(n * sizeofi(foo))=
 to   =20
> > >  =20
> >=20
> > Oops finger slipped on its way to the left parenthesis :)
> >  =20
> > > sizeof(foo)
> > >  =20
> > > > g_new(n, foo), which is a recommended good practice.   =20
> > >=20
> > > Clearly 2 different patches...
> > >  =20
> >=20
> > You're right in theory. I added the g_new conversion in the same patch
> > for simplicity mostly. I'll let David decide :) =20
>=20
> I'd prefer them separate.
>=20

Ok.

> >  =20
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >  hw/ppc/spapr_pci.c          |   22 +++++++++++-----------
> > > >  include/hw/pci-host/spapr.h |   12 ++++++------
> > > >  2 files changed, 17 insertions(+), 17 deletions(-)
> > > >=20
> > > > diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> > > > index c2271e6ed462..bfb959f2b065 100644
> > > > --- a/hw/ppc/spapr_pci.c
> > > > +++ b/hw/ppc/spapr_pci.c
> > > > @@ -277,7 +277,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu=
, sPAPRMachineState *spapr,
> > > >      unsigned int irq, max_irqs =3D 0;
> > > >      sPAPRPHBState *phb =3D NULL;
> > > >      PCIDevice *pdev =3D NULL;
> > > > -    spapr_pci_msi *msi;
> > > > +    sPAPRMSI *msi;   =20
> > >=20
> > > In CamelCase this should be "SpaprMsi"...
> > > I however agree sPAPRMSI is nicer, the code is also easier to
> > > review. =20
>=20
> Yeah.. it's kind of a mangled combination of CamelCase with what's
> been done elsewhere in the spapr code.
>=20
> > >  =20
> > > >      int *config_addr_key;
> > > >      Error *err =3D NULL;
> > > >      int i;
> > > > @@ -325,7 +325,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu=
, sPAPRMachineState *spapr,
> > > >          return;
> > > >      }
> > > > =20
> > > > -    msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &confi=
g_addr);
> > > > +    msi =3D (sPAPRMSI *) g_hash_table_lookup(phb->msi, &config_add=
r);
> > > > =20
> > > >      /* Releasing MSIs */
> > > >      if (!req_num) {
> > > > @@ -414,7 +414,7 @@ static void rtas_ibm_change_msi(PowerPCCPU *cpu=
, sPAPRMachineState *spapr,
> > > >                       irq, req_num);
> > > > =20
> > > >      /* Add MSI device to cache */
> > > > -    msi =3D g_new(spapr_pci_msi, 1);
> > > > +    msi =3D g_new(sPAPRMSI, 1);
> > > >      msi->first_irq =3D irq;
> > > >      msi->num =3D req_num;
> > > >      config_addr_key =3D g_new(int, 1);
> > > > @@ -445,7 +445,7 @@ static void rtas_ibm_query_interrupt_source_num=
ber(PowerPCCPU *cpu,
> > > >      unsigned int intr_src_num =3D -1, ioa_intr_num =3D rtas_ld(arg=
s, 3);
> > > >      sPAPRPHBState *phb =3D NULL;
> > > >      PCIDevice *pdev =3D NULL;
> > > > -    spapr_pci_msi *msi;
> > > > +    sPAPRMSI *msi;
> > > > =20
> > > >      /* Find sPAPRPHBState */
> > > >      phb =3D spapr_pci_find_phb(spapr, buid);
> > > > @@ -458,7 +458,7 @@ static void rtas_ibm_query_interrupt_source_num=
ber(PowerPCCPU *cpu,
> > > >      }
> > > > =20
> > > >      /* Find device descriptor and start IRQ */
> > > > -    msi =3D (spapr_pci_msi *) g_hash_table_lookup(phb->msi, &confi=
g_addr);
> > > > +    msi =3D (sPAPRMSI *) g_hash_table_lookup(phb->msi, &config_add=
r);
> > > >      if (!msi || !msi->first_irq || !msi->num || (ioa_intr_num >=3D=
 msi->num)) {
> > > >          trace_spapr_pci_msi("Failed to return vector", config_addr=
);
> > > >          rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
> > > > @@ -1849,9 +1849,9 @@ static const VMStateDescription vmstate_spapr=
_pci_msi =3D {
> > > >      .version_id =3D 1,
> > > >      .minimum_version_id =3D 1,
> > > >      .fields =3D (VMStateField []) {
> > > > -        VMSTATE_UINT32(key, spapr_pci_msi_mig),
> > > > -        VMSTATE_UINT32(value.first_irq, spapr_pci_msi_mig),
> > > > -        VMSTATE_UINT32(value.num, spapr_pci_msi_mig),
> > > > +        VMSTATE_UINT32(key, sPAPRMSIMig),
> > > > +        VMSTATE_UINT32(value.first_irq, sPAPRMSIMig),
> > > > +        VMSTATE_UINT32(value.num, sPAPRMSIMig),
> > > >          VMSTATE_END_OF_LIST()
> > > >      },
> > > >  };
> > > > @@ -1883,12 +1883,12 @@ static int spapr_pci_pre_save(void *opaque)
> > > >      if (!sphb->msi_devs_num) {
> > > >          return 0;
> > > >      }
> > > > -    sphb->msi_devs =3D g_malloc(sphb->msi_devs_num * sizeof(spapr_=
pci_msi_mig));
> > > > +    sphb->msi_devs =3D g_new(sPAPRMSIMig, sphb->msi_devs_num);
> > > > =20
> > > >      g_hash_table_iter_init(&iter, sphb->msi);
> > > >      for (i =3D 0; g_hash_table_iter_next(&iter, &key, &value); ++i=
) {
> > > >          sphb->msi_devs[i].key =3D *(uint32_t *) key;
> > > > -        sphb->msi_devs[i].value =3D *(spapr_pci_msi *) value;
> > > > +        sphb->msi_devs[i].value =3D *(sPAPRMSI *) value;
> > > >      }
> > > > =20
> > > >      return 0;
> > > > @@ -1938,7 +1938,7 @@ static const VMStateDescription vmstate_spapr=
_pci =3D {
> > > >                               vmstate_spapr_pci_lsi, struct spapr_p=
ci_lsi),
> > > >          VMSTATE_INT32(msi_devs_num, sPAPRPHBState),
> > > >          VMSTATE_STRUCT_VARRAY_ALLOC(msi_devs, sPAPRPHBState, msi_d=
evs_num, 0,
> > > > -                                    vmstate_spapr_pci_msi, spapr_p=
ci_msi_mig),
> > > > +                                    vmstate_spapr_pci_msi, sPAPRMS=
IMig),
> > > >          VMSTATE_END_OF_LIST()
> > > >      },
> > > >  };
> > > > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spap=
r.h
> > > > index 7c66c3872f96..041126da573d 100644
> > > > --- a/include/hw/pci-host/spapr.h
> > > > +++ b/include/hw/pci-host/spapr.h
> > > > @@ -34,15 +34,15 @@
> > > > =20
> > > >  typedef struct sPAPRPHBState sPAPRPHBState;
> > > > =20
> > > > -typedef struct spapr_pci_msi {
> > > > +typedef struct sPAPRMSI {
> > > >      uint32_t first_irq;
> > > >      uint32_t num;
> > > > -} spapr_pci_msi;
> > > > +} sPAPRMSI;
> > > > =20
> > > > -typedef struct spapr_pci_msi_mig {
> > > > +typedef struct sPAPRMSIMig {
> > > >      uint32_t key;
> > > > -    spapr_pci_msi value;
> > > > -} spapr_pci_msi_mig;
> > > > +    sPAPRMSI value;
> > > > +} sPAPRMSIMig;
> > > > =20
> > > >  struct sPAPRPHBState {
> > > >      PCIHostState parent_obj;
> > > > @@ -70,7 +70,7 @@ struct sPAPRPHBState {
> > > >      GHashTable *msi;
> > > >      /* Temporary cache for migration purposes */
> > > >      int32_t msi_devs_num;
> > > > -    spapr_pci_msi_mig *msi_devs;
> > > > +    sPAPRMSIMig *msi_devs;
> > > > =20
> > > >      QLIST_ENTRY(sPAPRPHBState) list;
> > > > =20
> > > >=20
> > > >    =20
> >  =20
>=20


--Sig_/rYg0h7hwCrJXp2q6orjDk+U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlvAWjgACgkQcdTV5YIv
c9YsCxAAl4ICDCanicaHT7l0XFNihHw6ct9XIGEXSWnQVs7G7MenUjubD5M+DfSt
QP+Z6+AeH70DsiJLU8Po9dJv/RztocbwTI37/AGTI5C66ya5aP+RtbTkYDe+jGDM
u0xCK7SZyrTeT5IS5ccQMgfuctYpBs0WQD8Ux2hikMgigEJEU3+SiIkNlo8O8MLn
botnfS1hcwlaJN7Zmz9Ah1JNZPev8ccJ8h4QAc4xZXFo9mcd3FaDt2+Xj5LEPmaf
IkPkLUtEqYveyj4MeFDR2aCVZRD7S0EiquJojTm8A82AOx5L6h70yyzJdaqr9QJp
Z5uQEbJEoy3PG+K+n/QdmDkLO1jlLtYpXJoRgl3cKrq4723XMsg2W8rAMEkYXw4S
L3sLme96Vo1Orfb++Dh05sJNMWv3C3eEL3ZehwNtlMHehPmku9Y+ZnHXaQ8SpR7O
vU3brXXMsw3msb1nxmiLF8t6VTT6+oi9oGWdVhyd8okBXtYQImX8v5RpalrPNrap
c4vhNkcQEwLMF93nozQRNOVtO3UN9/RrbGS+IOctEcRAr95dhfDwTMiw99oQ3LWx
uQnAXLppy8srMwAw3qCmduvRRonZdrdTYTx9RLBfvYqQmeYxTNlL8rsW2+I2NPnz
FYK1hoDmnJjD6a7wb+oQTme7wcgX/cbQ7E7qX8qqgEX3ZyWNNWU=
=xhvF
-----END PGP SIGNATURE-----

--Sig_/rYg0h7hwCrJXp2q6orjDk+U--
