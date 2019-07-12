Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1CFC742C2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABB34206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 14:36:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkHpJIz8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB34206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50129 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlwfH-0004bJ-0g
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 10:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <flukshun@gmail.com>) id 1hlwdk-0006Ps-8I
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <flukshun@gmail.com>) id 1hlwdd-0003Ph-67
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 10:35:09 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34926)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <flukshun@gmail.com>)
 id 1hlwdZ-0003FD-Ez; Fri, 12 Jul 2019 10:35:02 -0400
Received: by mail-oi1-x241.google.com with SMTP id a127so7440608oii.2;
 Fri, 12 Jul 2019 07:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:to:from:in-reply-to
 :cc:references:message-id:user-agent:subject:date;
 bh=K6wJM17YHifIYIcj4tQNFdiBcqDA2W2TA2y6ZArnfV4=;
 b=fkHpJIz8QI+iDq6tNqB1AUHdm6b2j2d11nCUmM9+YFWIQy1Y6ijQTAf5eKeVXaAGjF
 ftiq8VU+PKeApAO9TypsXbiLI/8FVD6UYuAWsqKAAUlTkDD84FnamIOJH8o44ECTWExq
 nwMBw4Cq5QJFXiexOl5igjG9X9Q3MUWnnwqLCtyzYMF/DEN92GLPLEBKy+j4RtEriY2h
 23YcIBQhLbcXHGmZNRU9CR+RuE2BIF5h9IBvO/3aEkmMMEHf+JUzU8bq8e66VcrXp843
 HPF1XmzoLp6+/9xsYGAUE6UbTooi+SMH1HCydqaUzVFTURs1l4SDUATSO615YmyhIg9Z
 4EWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding:to
 :from:in-reply-to:cc:references:message-id:user-agent:subject:date;
 bh=K6wJM17YHifIYIcj4tQNFdiBcqDA2W2TA2y6ZArnfV4=;
 b=Dyz0BD4pmlVwemCVdSi6HpdR7gTo6jO5wMWRc8y5d5pKqnRy18LSoKBEMZGGxw86kY
 Ao+qxs7qF1I9Aa0KCR5ElICJBrWBRUWDRaOAy+e+hcnZHkPsztMNe5E0TbOpLN2q2iZQ
 aMMVPUSuHBBJ3Q/he2KvrGxhndmYDAMN/jc4Yx9dVPB91w07aKWEnDqgJIud4R2bnTLg
 CeLK1Qlat8lqs/qbHFj4tf5yWQfUXAJuudFrAuPxftxicZzbp++RZSfB5DtJDLiW9jDG
 AvryrjJjPf90DgtjWtuoCXI+CHcUsbHY/U1Hq6vlujSusuWRksw9qXceFrl0gYSFeTJN
 2c6g==
X-Gm-Message-State: APjAAAV+8p3j8ZnHV/9qIb1aBwV1Jj80W3xkwtl/ijC2apTeWuRT53te
 zga5xORFDT47k7AGMEoBikM=
X-Google-Smtp-Source: APXvYqxwH1fQAiM4jdefQQXcAhcxWWbqaJUF1CJvhIq2I2P1iOMmHm9RUKY7qUVZLKMbKKkCniPXSg==
X-Received: by 2002:aca:382:: with SMTP id 124mr5745074oid.80.1562942094367;
 Fri, 12 Jul 2019 07:34:54 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id b138sm3167981oii.7.2019.07.12.07.34.52
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 12 Jul 2019 07:34:53 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: David Gibson <david@gibson.dropbear.id.au>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20190712064619.GH2561@umbus.fritz.box>
References: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
 <20190712011934.29863-3-mdroth@linux.vnet.ibm.com>
 <20190712064619.GH2561@umbus.fritz.box>
Message-ID: <156294208686.22588.14626783330276025418@sif>
User-Agent: alot/0.7
Date: Fri, 12 Jul 2019 09:34:46 -0500
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

Quoting David Gibson (2019-07-12 01:46:19)
> On Thu, Jul 11, 2019 at 08:19:34PM -0500, Michael Roth wrote:
> > This implements the H_TPM_COMM hypercall, which is used by an
> > Ultravisor to pass TPM commands directly to the host's TPM device, or
> > a TPM Resource Manager associated with the device.
> > =

> > This also introduces a new pseries machine option which is used to
> > configure what TPM device to pass commands to, for example:
> > =

> >   -machine pseries,...,tpm-device-file=3D/dev/tmprm0
> =

> Bolting this into yet another machine parameter seems kind of ugly.
> Wouldn't it make more sense to treat this as an virtual device (say
> "spapr-vtpm").  Adding that device would enable the hcall, and would
> have properties for the back end host device.

That does sound nicer.

Originally I had SpaprMachineClass implement the TYPE_TPM_IF interface so
we could define a TPM backend via -tpmdev passthrough,path=3D..., but after
some discussion with the TPM maintainer it didn't quite work for the main
use-case of passing through a TPM Resource Manager since it isn't suitable
for full vTPM front-ends (since multiple guests can interfere with each
other's operations when running the full gamut of TPM functionality).

I hadn't consider a stand-alone -device implementation though. It's not
a proper VIO or PCI device so there's no proper bus to attach it to. I
guess we would just make it a direct child of SpaprMachineState (sort
of like SpaprDrcClass), then we could define it via something like
-object spapr-tpm-proxy,path=3D....

I'll go ahead and give that a shot, assuming it seems reasonable to you.

> =

> > By default, no tpm-device-file is defined and hcalls will return
> > H_RESOURCE.
> =

> Wouldn't H_FUNCTION make more sense?

Yes, for this case it probably would.

Thanks for the suggestions!

> =

> > =

> > The full specification for this hypercall can be found in
> > docs/specs/ppc-spapr-uv-hcalls.txt
> > =

> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com
> > ---
> >  hw/ppc/Makefile.objs     |   1 +
> >  hw/ppc/spapr.c           |  27 ++++++++
> >  hw/ppc/spapr_hcall_tpm.c | 135 +++++++++++++++++++++++++++++++++++++++
> >  hw/ppc/trace-events      |   4 ++
> >  include/hw/ppc/spapr.h   |   7 +-
> >  5 files changed, 173 insertions(+), 1 deletion(-)
> >  create mode 100644 hw/ppc/spapr_hcall_tpm.c
> > =

> > diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
> > index 9da93af905..5aa120cae6 100644
> > --- a/hw/ppc/Makefile.objs
> > +++ b/hw/ppc/Makefile.objs
> > @@ -5,6 +5,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr.o spapr_caps.o spapr_v=
io.o spapr_events.o
> >  obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o spapr_rtas.o
> >  obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o
> >  obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o spapr_irq.o
> > +obj-$(CONFIG_PSERIES) +=3D spapr_hcall_tpm.o
> >  obj-$(CONFIG_SPAPR_RNG) +=3D  spapr_rng.o
> >  # IBM PowerNV
> >  obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_=
psi.o pnv_occ.o pnv_bmc.o
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 821f0d4a49..eb3421673b 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1776,6 +1776,10 @@ static void spapr_machine_reset(MachineState *ma=
chine)
> >       */
> >      object_child_foreach_recursive(object_get_root(), spapr_reset_drcs=
, NULL);
> >  =

> > +    if (spapr->tpm_device_file) {
> > +        spapr_hcall_tpm_reset();
> > +    }
> > +
> >      spapr_clear_pending_events(spapr);
> >  =

> >      /*
> > @@ -3340,6 +3344,21 @@ static void spapr_set_host_serial(Object *obj, c=
onst char *value, Error **errp)
> >      spapr->host_serial =3D g_strdup(value);
> >  }
> >  =

> > +static char *spapr_get_tpm_device_file(Object *obj, Error **errp)
> > +{
> > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +
> > +    return g_strdup(spapr->tpm_device_file);
> > +}
> > +
> > +static void spapr_set_tpm_device_file(Object *obj, const char *value, =
Error **errp)
> > +{
> > +    SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > +
> > +    g_free(spapr->tpm_device_file);
> > +    spapr->tpm_device_file =3D g_strdup(value);
> > +}
> > +
> >  static void spapr_instance_init(Object *obj)
> >  {
> >      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> > @@ -3396,6 +3415,14 @@ static void spapr_instance_init(Object *obj)
> >          &error_abort);
> >      object_property_set_description(obj, "host-serial",
> >          "Host serial number to advertise in guest device tree", &error=
_abort);
> > +    object_property_add_str(obj, "tpm-device-file",
> > +                            spapr_get_tpm_device_file,
> > +                            spapr_set_tpm_device_file, &error_abort);
> > +    object_property_set_description(obj, "tpm-device-file",
> > +                 "Specifies the path to the TPM character device file =
to use"
> > +                 " for TPM communication via hypercalls (usually a TPM"
> > +                 " resource manager)",
> > +                 &error_abort);
> >  }
> >  =

> >  static void spapr_machine_finalizefn(Object *obj)
> > diff --git a/hw/ppc/spapr_hcall_tpm.c b/hw/ppc/spapr_hcall_tpm.c
> > new file mode 100644
> > index 0000000000..75e2b6d594
> > --- /dev/null
> > +++ b/hw/ppc/spapr_hcall_tpm.c
> > @@ -0,0 +1,135 @@
> > +/*
> > + * SPAPR TPM Hypercall
> > + *
> > + * Copyright IBM Corp. 2019
> > + *
> > + * Authors:
> > + *  Michael Roth      <mdroth@linux.vnet.ibm.com>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> > + * See the COPYING file in the top-level directory.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qemu-common.h"
> > +#include "qapi/error.h"
> > +#include "qemu/error-report.h"
> > +#include "cpu.h"
> > +#include "hw/ppc/spapr.h"
> > +#include "trace.h"
> > +
> > +#define TPM_SPAPR_BUFSIZE 4096
> > +
> > +enum {
> > +    TPM_COMM_OP_EXECUTE =3D 1,
> > +    TPM_COMM_OP_CLOSE_SESSION =3D 2,
> > +};
> > +
> > +static int tpm_devfd =3D -1;
> =

> A global?  Really?  You can do better.
> =

> > +
> > +static ssize_t tpm_execute(SpaprMachineState *spapr, target_ulong *arg=
s)
> > +{
> > +    uint64_t data_in =3D ppc64_phys_to_real(args[1]);
> > +    target_ulong data_in_size =3D args[2];
> > +    uint64_t data_out =3D ppc64_phys_to_real(args[3]);
> > +    target_ulong data_out_size =3D args[4];
> > +    uint8_t buf_in[TPM_SPAPR_BUFSIZE];
> > +    uint8_t buf_out[TPM_SPAPR_BUFSIZE];
> > +    ssize_t ret;
> > +
> > +    trace_spapr_tpm_execute(data_in, data_in_size, data_out, data_out_=
size);
> > +
> > +    if (data_in_size > TPM_SPAPR_BUFSIZE) {
> > +        error_report("invalid TPM input buffer size: " TARGET_FMT_lu "=
\n",
> > +                     data_in_size);
> > +        return H_P3;
> > +    }
> > +
> > +    if (data_out_size < TPM_SPAPR_BUFSIZE) {
> > +        error_report("invalid TPM output buffer size: " TARGET_FMT_lu =
"\n",
> > +                     data_out_size);
> > +        return H_P5;
> > +    }
> > +
> > +    if (tpm_devfd =3D=3D -1) {
> > +        tpm_devfd =3D open(spapr->tpm_device_file, O_RDWR);
> > +        if (tpm_devfd =3D=3D -1) {
> > +            error_report("failed to open TPM device %s: %d",
> > +                         spapr->tpm_device_file, errno);
> > +            return H_RESOURCE;
> > +        }
> > +    }
> > +
> > +    cpu_physical_memory_read(data_in, buf_in, data_in_size);
> > +
> > +    do {
> > +        ret =3D write(tpm_devfd, buf_in, data_in_size);
> > +        if (ret > 0) {
> > +            data_in_size -=3D ret;
> > +        }
> > +    } while ((ret >=3D 0 && data_in_size > 0) || (ret =3D=3D -1 && err=
no =3D=3D EINTR));
> > +
> > +    if (ret =3D=3D -1) {
> > +        error_report("failed to write to TPM device %s: %d",
> > +                     spapr->tpm_device_file, errno);
> > +        return H_RESOURCE;
> > +    }
> > +
> > +    do {
> > +        ret =3D read(tpm_devfd, buf_out, data_out_size);
> > +    } while (ret =3D=3D 0 || (ret =3D=3D -1 && errno =3D=3D EINTR));
> > +
> > +    if (ret =3D=3D -1) {
> > +        error_report("failed to read from TPM device %s: %d",
> > +                     spapr->tpm_device_file, errno);
> > +        return H_RESOURCE;
> > +    }
> > +
> > +    cpu_physical_memory_write(data_out, buf_out, ret);
> > +    args[0] =3D ret;
> > +
> > +    return H_SUCCESS;
> > +}
> > +
> > +static target_ulong h_tpm_comm(PowerPCCPU *cpu,
> > +                               SpaprMachineState *spapr,
> > +                               target_ulong opcode,
> > +                               target_ulong *args)
> > +{
> > +    target_ulong op =3D args[0];
> > +
> > +    trace_spapr_h_tpm_comm(spapr->tpm_device_file ?: "null", op);
> > +
> > +    if (!spapr->tpm_device_file) {
> > +        error_report("TPM device not specified");
> > +        return H_RESOURCE;
> > +    }
> > +
> > +    switch (op) {
> > +        case TPM_COMM_OP_EXECUTE:
> > +            return tpm_execute(spapr, args);
> > +        case TPM_COMM_OP_CLOSE_SESSION:
> > +            if (tpm_devfd !=3D -1) {
> > +                close(tpm_devfd);
> > +                tpm_devfd =3D -1;
> > +            }
> > +            return H_SUCCESS;
> > +        default:
> > +            return H_PARAMETER;
> > +    }
> > +}
> > +
> > +void spapr_hcall_tpm_reset(void)
> > +{
> > +    if (tpm_devfd !=3D -1) {
> > +        close(tpm_devfd);
> > +        tpm_devfd =3D -1;
> > +    }
> > +}
> > +
> > +static void hypercall_register_types(void)
> > +{
> > +    spapr_register_hypercall(H_TPM_COMM, h_tpm_comm);
> > +}
> > +
> > +type_init(hypercall_register_types)
> > diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> > index f76448f532..96dad767a1 100644
> > --- a/hw/ppc/trace-events
> > +++ b/hw/ppc/trace-events
> > @@ -25,6 +25,10 @@ spapr_update_dt(unsigned cb) "New blob %u bytes"
> >  spapr_update_dt_failed_size(unsigned cbold, unsigned cbnew, unsigned m=
agic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> >  spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned =
magic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> >  =

> > +# spapr_hcall_tpm.c
> > +spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_dev=
ice_path=3D%s operation=3D0x%"PRIu64
> > +spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data=
_out, uint64_t data_out_sz) "data_in=3D0x%"PRIx64", data_in_sz=3D%"PRIu64",=
 data_out=3D0x%"PRIx64", data_out_sz=3D%"PRIu64
> > +
> >  # spapr_iommu.c
> >  spapr_iommu_put(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t =
ret) "liobn=3D0x%"PRIx64" ioba=3D0x%"PRIx64" tce=3D0x%"PRIx64" ret=3D%"PRId=
64
> >  spapr_iommu_get(uint64_t liobn, uint64_t ioba, uint64_t ret, uint64_t =
tce) "liobn=3D0x%"PRIx64" ioba=3D0x%"PRIx64" ret=3D%"PRId64" tce=3D0x%"PRIx=
64
> > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > index 60553d32c4..7bd47575d7 100644
> > --- a/include/hw/ppc/spapr.h
> > +++ b/include/hw/ppc/spapr.h
> > @@ -198,6 +198,7 @@ struct SpaprMachineState {
> >      SpaprXive  *xive;
> >      SpaprIrq *irq;
> >      qemu_irq *qirqs;
> > +    char *tpm_device_file;
> >  =

> >      bool cmd_line_caps[SPAPR_CAP_NUM];
> >      SpaprCapabilities def, eff, mig;
> > @@ -490,8 +491,9 @@ struct SpaprMachineState {
> >  #define H_INT_ESB               0x3C8
> >  #define H_INT_SYNC              0x3CC
> >  #define H_INT_RESET             0x3D0
> > +#define H_TPM_COMM              0xEF10
> >  =

> > -#define MAX_HCALL_OPCODE        H_INT_RESET
> > +#define MAX_HCALL_OPCODE        H_TPM_COMM
> >  =

> >  /* The hcalls above are standardized in PAPR and implemented by pHyp
> >   * as well.
> > @@ -864,6 +866,9 @@ int spapr_caps_post_migration(SpaprMachineState *sp=
apr);
> >  =

> >  void spapr_check_pagesize(SpaprMachineState *spapr, hwaddr pagesize,
> >                            Error **errp);
> > +
> > +void spapr_hcall_tpm_reset(void);
> > +
> >  /*
> >   * XIVE definitions
> >   */
> =

> -- =

> David Gibson                    | I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au  | minimalist, thank you.  NOT _the_ _othe=
r_
>                                 | _way_ _around_!
> http://www.ozlabs.org/~dgibson

