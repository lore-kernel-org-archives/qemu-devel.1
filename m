Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69456C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2663020838
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 06:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="jnApZ6PR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2663020838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmuR0-0007QM-5w
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 02:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43164)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hmuQG-0004nl-ET
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hmuQE-0004mR-Al
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 02:25:16 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:40177)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hmuQD-0004ga-AM; Mon, 15 Jul 2019 02:25:14 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45nD6B0crCz9sND; Mon, 15 Jul 2019 16:25:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1563171906;
 bh=1ozPKDD58QoqFkDMJe7srXYEGNtmqTD7OqMp71jD4/s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jnApZ6PRKLlfcF/QpEleXCflnGKM5pb26mRbxiCycKMZyOfiV6KK9wqR2B6ijQ8+b
 8mseTbIcnwTAIOlv58li5UuXe7/d2srBDZQ0+YEc7u6bK8zHS6VkRmEjQsVcO0EFmT
 y2SPbsw2lgH5kLSBaGUzP3E21juOW7Wi1yUF58zk=
Date: Mon, 15 Jul 2019 12:25:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <20190715022524.GA3440@umbus.fritz.box>
References: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
 <20190712011934.29863-3-mdroth@linux.vnet.ibm.com>
 <20190712064619.GH2561@umbus.fritz.box>
 <156294208686.22588.14626783330276025418@sif>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
In-Reply-To: <156294208686.22588.14626783330276025418@sif>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 2/2] spapr: initial implementation for
 H_TPM_COMM hcall
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2019 at 09:34:46AM -0500, Michael Roth wrote:
> Quoting David Gibson (2019-07-12 01:46:19)
> > On Thu, Jul 11, 2019 at 08:19:34PM -0500, Michael Roth wrote:
> > > This implements the H_TPM_COMM hypercall, which is used by an
> > > Ultravisor to pass TPM commands directly to the host's TPM device, or
> > > a TPM Resource Manager associated with the device.
> > >=20
> > > This also introduces a new pseries machine option which is used to
> > > configure what TPM device to pass commands to, for example:
> > >=20
> > >   -machine pseries,...,tpm-device-file=3D/dev/tmprm0
> >=20
> > Bolting this into yet another machine parameter seems kind of ugly.
> > Wouldn't it make more sense to treat this as an virtual device (say
> > "spapr-vtpm").  Adding that device would enable the hcall, and would
> > have properties for the back end host device.
>=20
> That does sound nicer.
>=20
> Originally I had SpaprMachineClass implement the TYPE_TPM_IF interface so
> we could define a TPM backend via -tpmdev passthrough,path=3D..., but aft=
er
> some discussion with the TPM maintainer it didn't quite work for the main
> use-case of passing through a TPM Resource Manager since it isn't suitable
> for full vTPM front-ends (since multiple guests can interfere with each
> other's operations when running the full gamut of TPM functionality).
>=20
> I hadn't consider a stand-alone -device implementation though. It's not
> a proper VIO or PCI device so there's no proper bus to attach it to. I
> guess we would just make it a direct child of SpaprMachineState (sort
> of like SpaprDrcClass), then we could define it via something like
> -object spapr-tpm-proxy,path=3D....

It should be -device not -object, but otherwise that looks ok.

How does the TPM appear in the device tree?

> I'll go ahead and give that a shot, assuming it seems reasonable to you.
>=20
> >=20
> > > By default, no tpm-device-file is defined and hcalls will return
> > > H_RESOURCE.
> >=20
> > Wouldn't H_FUNCTION make more sense?
>=20
> Yes, for this case it probably would.
>=20
> Thanks for the suggestions!
>=20
> >=20
> > >=20
> > > The full specification for this hypercall can be found in
> > > docs/specs/ppc-spapr-uv-hcalls.txt
> > >=20
> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com
> > > ---
> > >  hw/ppc/Makefile.objs     |   1 +
> > >  hw/ppc/spapr.c           |  27 ++++++++
> > >  hw/ppc/spapr_hcall_tpm.c | 135 +++++++++++++++++++++++++++++++++++++=
++
> > >  hw/ppc/trace-events      |   4 ++
> > >  include/hw/ppc/spapr.h   |   7 +-
> > >  5 files changed, 173 insertions(+), 1 deletion(-)
> > >  create mode 100644 hw/ppc/spapr_hcall_tpm.c
> > >=20
> > > diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> > > index 9da93af905..5aa120cae6 100644
> > > --- a/hw/ppc/Makefile.objs
> > > +++ b/hw/ppc/Makefile.objs
> > > @@ -5,6 +5,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr=
_vio.o spapr_events.o
> > >  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
> > >  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
> > >  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
> > > +obj-$(CONFIG_PSERIES) +=3D spapr_hcall_tpm.o
> > >  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
> > >  # IBM PowerNV
> > >  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pn=
v_psi.o pnv_occ.o pnv_bmc.o
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index 821f0d4a49..eb3421673b 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -1776,6 +1776,10 @@ static void spapr_machine_reset(MachineState *=
machine)
> > >       */
> > >      object_child_foreach_recursive(object_get_root(), spapr_reset_dr=
cs, NULL);
> > > =20
> > > +    if (spapr->tpm_device_file) {
> > > +        spapr_hcall_tpm_reset();
> > > +    }
> > > +
> > >      spapr_clear_pending_events(spapr);
> > > =20
> > >      /*
> > > @@ -3340,6 +3344,21 @@ static void spapr_set_host_serial(Object *obj,=
 const char *value, Error **errp)
> > >      spapr->host_serial =3D g_strdup(value);
> > >  }
> > > =20
> > > +static char *spapr_get_tpm_device_file(Object *obj, Error **errp)
> > > +{
> > > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +
> > > +    return g_strdup(spapr->tpm_device_file);
> > > +}
> > > +
> > > +static void spapr_set_tpm_device_file(Object *obj, const char *value=
, Error **errp)
> > > +{
> > > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > +
> > > +    g_free(spapr->tpm_device_file);
> > > +    spapr->tpm_device_file =3D g_strdup(value);
> > > +}
> > > +
> > >  static void spapr_instance_init(Object *obj)
> > >  {
> > >      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > > @@ -3396,6 +3415,14 @@ static void spapr_instance_init(Object *obj)
> > >          &error_abort);
> > >      object_property_set_description(obj, "host-serial",
> > >          "Host serial number to advertise in guest device tree", &err=
or_abort);
> > > +    object_property_add_str(obj, "tpm-device-file",
> > > +                            spapr_get_tpm_device_file,
> > > +                            spapr_set_tpm_device_file, &error_abort);
> > > +    object_property_set_description(obj, "tpm-device-file",
> > > +                 "Specifies the path to the TPM character device fil=
e to use"
> > > +                 " for TPM communication via hypercalls (usually a T=
PM"
> > > +                 " resource manager)",
> > > +                 &error_abort);
> > >  }
> > > =20
> > >  static void spapr_machine_finalizefn(Object *obj)
> > > diff --git a/hw/ppc/spapr_hcall_tpm.c b/hw/ppc/spapr_hcall_tpm.c
> > > new file mode 100644
> > > index 0000000000..75e2b6d594
> > > --- /dev/null
> > > +++ b/hw/ppc/spapr_hcall_tpm.c
> > > @@ -0,0 +1,135 @@
> > > +/*
> > > + * SPAPR TPM Hypercall
> > > + *
> > > + * Copyright IBM Corp. 2019
> > > + *
> > > + * Authors:
> > > + *  Michael Roth      <mdroth@linux.vnet.ibm.com>
> > > + *
> > > + * This work is licensed under the terms of the GNU GPL, version 2 o=
r later.
> > > + * See the COPYING file in the top-level directory.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qemu-common.h"
> > > +#include "qapi/error.h"
> > > +#include "qemu/error-report.h"
> > > +#include "cpu.h"
> > > +#include "hw/ppc/spapr.h"
> > > +#include "trace.h"
> > > +
> > > +#define TPM_SPAPR_BUFSIZE 4096
> > > +
> > > +enum {
> > > +    TPM_COMM_OP_EXECUTE =3D 1,
> > > +    TPM_COMM_OP_CLOSE_SESSION =3D 2,
> > > +};
> > > +
> > > +static int tpm_devfd =3D -1;
> >=20
> > A global?  Really?  You can do better.
> >=20
> > > +
> > > +static ssize_t tpm_execute(SpaprMachineState *spapr, target_ulong *a=
rgs)
> > > +{
> > > +    uint64_t data_in =3D ppc64_phys_to_real(args[1]);
> > > +    target_ulong data_in_size =3D args[2];
> > > +    uint64_t data_out =3D ppc64_phys_to_real(args[3]);
> > > +    target_ulong data_out_size =3D args[4];
> > > +    uint8_t buf_in[TPM_SPAPR_BUFSIZE];
> > > +    uint8_t buf_out[TPM_SPAPR_BUFSIZE];
> > > +    ssize_t ret;
> > > +
> > > +    trace_spapr_tpm_execute(data_in, data_in_size, data_out, data_ou=
t_size);
> > > +
> > > +    if (data_in_size > TPM_SPAPR_BUFSIZE) {
> > > +        error_report("invalid TPM input buffer size: " TARGET_FMT_lu=
 "\n",
> > > +                     data_in_size);
> > > +        return H_P3;
> > > +    }
> > > +
> > > +    if (data_out_size < TPM_SPAPR_BUFSIZE) {
> > > +        error_report("invalid TPM output buffer size: " TARGET_FMT_l=
u "\n",
> > > +                     data_out_size);
> > > +        return H_P5;
> > > +    }
> > > +
> > > +    if (tpm_devfd =3D=3D -1) {
> > > +        tpm_devfd =3D open(spapr->tpm_device_file, O_RDWR);
> > > +        if (tpm_devfd =3D=3D -1) {
> > > +            error_report("failed to open TPM device %s: %d",
> > > +                         spapr->tpm_device_file, errno);
> > > +            return H_RESOURCE;
> > > +        }
> > > +    }
> > > +
> > > +    cpu_physical_memory_read(data_in, buf_in, data_in_size);
> > > +
> > > +    do {
> > > +        ret =3D write(tpm_devfd, buf_in, data_in_size);
> > > +        if (ret > 0) {
> > > +            data_in_size -=3D ret;
> > > +        }
> > > +    } while ((ret >=3D 0 && data_in_size > 0) || (ret =3D=3D -1 && e=
rrno =3D=3D EINTR));
> > > +
> > > +    if (ret =3D=3D -1) {
> > > +        error_report("failed to write to TPM device %s: %d",
> > > +                     spapr->tpm_device_file, errno);
> > > +        return H_RESOURCE;
> > > +    }
> > > +
> > > +    do {
> > > +        ret =3D read(tpm_devfd, buf_out, data_out_size);
> > > +    } while (ret =3D=3D 0 || (ret =3D=3D -1 && errno =3D=3D EINTR));
> > > +
> > > +    if (ret =3D=3D -1) {
> > > +        error_report("failed to read from TPM device %s: %d",
> > > +                     spapr->tpm_device_file, errno);
> > > +        return H_RESOURCE;
> > > +    }
> > > +
> > > +    cpu_physical_memory_write(data_out, buf_out, ret);
> > > +    args[0] =3D ret;
> > > +
> > > +    return H_SUCCESS;
> > > +}
> > > +
> > > +static target_ulong h_tpm_comm(PowerPCCPU *cpu,
> > > +                               SpaprMachineState *spapr,
> > > +                               target_ulong opcode,
> > > +                               target_ulong *args)
> > > +{
> > > +    target_ulong op =3D args[0];
> > > +
> > > +    trace_spapr_h_tpm_comm(spapr->tpm_device_file ?: "null", op);
> > > +
> > > +    if (!spapr->tpm_device_file) {
> > > +        error_report("TPM device not specified");
> > > +        return H_RESOURCE;
> > > +    }
> > > +
> > > +    switch (op) {
> > > +        case TPM_COMM_OP_EXECUTE:
> > > +            return tpm_execute(spapr, args);
> > > +        case TPM_COMM_OP_CLOSE_SESSION:
> > > +            if (tpm_devfd !=3D -1) {
> > > +                close(tpm_devfd);
> > > +                tpm_devfd =3D -1;
> > > +            }
> > > +            return H_SUCCESS;
> > > +        default:
> > > +            return H_PARAMETER;
> > > +    }
> > > +}
> > > +
> > > +void spapr_hcall_tpm_reset(void)
> > > +{
> > > +    if (tpm_devfd !=3D -1) {
> > > +        close(tpm_devfd);
> > > +        tpm_devfd =3D -1;
> > > +    }
> > > +}
> > > +
> > > +static void hypercall_register_types(void)
> > > +{
> > > +    spapr_register_hypercall(H_TPM_COMM, h_tpm_comm);
> > > +}
> > > +
> > > +type_init(hypercall_register_types)
> > > diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> > > index f76448f532..96dad767a1 100644
> > > --- a/hw/ppc/trace-events
> > > +++ b/hw/ppc/trace-events
> > > @@ -25,6 +25,10 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
> > >  spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned=
 magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> > >  spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigne=
d magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> > > =20
> > > +# spapr_hcall_tpm.c
> > > +spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_d=
evice_path=3D%s operation=3D0x%"PRIu64
> > > +spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t da=
ta_out, uint64_t data_out_sz) "data_in=3D0x%"PRIx64", data_in_sz=3D%"PRIu64=
", data_out=3D0x%"PRIx64", data_out_sz=3D%"PRIu64
> > > +
> > >  # spapr_iommu.c
> > >  spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_=
t ret) "liobn=3D0x%"PRIx64" ioba=3D0x%"PRIx64" tce=3D0x%"PRIx64" ret=3D%"PR=
Id64
> > >  spapr_iommu_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_=
t tce) "liobn=3D0x%"PRIx64" ioba=3D0x%"PRIx64" ret=3D%"PRId64" tce=3D0x%"PR=
Ix64
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index 60553d32c4..7bd47575d7 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -198,6 +198,7 @@ struct SpaprMachineState {
> > >      SpaprXive  *xive;
> > >      SpaprIrq *irq;
> > >      qemu_irq *qirqs;
> > > +    char *tpm_device_file;
> > > =20
> > >      bool cmd_line_caps[SPAPR_CAP_NUM];
> > >      SpaprCapabilities def, eff, mig;
> > > @@ -490,8 +491,9 @@ struct SpaprMachineState {
> > >  #define H_INT_ESB               0x3C8
> > >  #define H_INT_SYNC              0x3CC
> > >  #define H_INT_RESET             0x3D0
> > > +#define H_TPM_COMM              0xEF10
> > > =20
> > > -#define MAX_HCALL_OPCODE        H_INT_RESET
> > > +#define MAX_HCALL_OPCODE        H_TPM_COMM
> > > =20
> > >  /* The hcalls above are standardized in PAPR and implemented by pHyp
> > >   * as well.
> > > @@ -864,6 +866,9 @@ int spapr_caps_post_migration(SpaprMachineState *=
spapr);
> > > =20
> > >  void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
> > >                            Error **errp);
> > > +
> > > +void spapr_hcall_tpm_reset(void);
> > > +
> > >  /*
> > >   * XIVE definitions
> > >   */
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0r5BEACgkQbDjKyiDZ
s5KmxBAAsa0BJ+JxS/14IPsfYm/GyJwUid5AQa4zyCplB4qapwCzyJn/iYm+IDto
sujR51Qh0O/5MJ239bSOcWp0LvqyUG/iC+DVPIYNQRyKNG12CuAwmTc+GVqJn+i4
R0DXQ+VVol44XgdKxI9w4laG/PgEC95YF8dprI9cB/pWVONt2iNT1P385uWbG8PC
HKGDIHL52J5CpjSXtK401XhqnD49He5sPhPSzhQMVGe6TY3/0aRiEOryU0XGySJR
ufQWGU6CO2R84eEwFq5Ejc5R3UnzuYI9tCHtg1ubFOvQmxE6HE9vvzRPU80b1mgk
6AkvTETcvMCSd3BGZPLf5I3FeKnxbw+UmRSKcGWEFGCLuqR9rzdcjPGIlH2uDPu/
UOBM7ZcwRrQ0FcPxmjedYsgeH5FBk3j8+ixK69jl1PzipUANeN4OZFK3RgHzbJqR
0dfazEmeo86H6Xm2VYVWocdX7nHkoZSkSAUlFM3jHSABGR1IFcAF3rsnTbysiniJ
Ei6Rgn7IdcJDoRNl2/2SqictQ/HjNIAUd4y80SkzgfY+3fvBs1QKIOzzhUUfCPfs
RaLyerW7VcVHIOYcb9ZEN/o/VjHgeAXmNnDp4kmvpNf5C/R/kghXUbIK9cpPvgA9
4CmHnGoluX3AIo0uXcXIawyUIEbnTO45iNSAbvk4+ZZYhluSunE=
=eTqh
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--

