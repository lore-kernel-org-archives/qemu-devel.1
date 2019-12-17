Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C71C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 00:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 647FC24672
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 00:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="XVUsOFBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647FC24672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih0mB-0002lx-Dc
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 19:31:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ih0kd-0001LC-FW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 19:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ih0ka-0007PM-Jm
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 19:30:11 -0500
Received: from ozlabs.org ([203.11.71.1]:44237)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ih0kZ-0007NG-KM; Mon, 16 Dec 2019 19:30:08 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47cJtz1slzz9sPJ; Tue, 17 Dec 2019 11:30:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1576542603;
 bh=QjbgE2Ur9ac7FSEFi5d5bYfnHBEMl2mZNCQb6N8VbQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XVUsOFBDCXeL0489hQS+tBFUpJnfJP50nDmY74tFCPWVOwUgJLVJp/KHYavLEDjQB
 CFHuanDNIAFILcr3OIn9P20s7D2hCPsYO1wKLAtzcu09MOtEzw1bZF2ESTDbLrza7n
 HAdZRDXqMPI9a6LKygoLYGlL96Vfc9RdnKH4Ijpc=
Date: Tue, 17 Dec 2019 11:29:54 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v5 1/5] tpm_spapr: Support TPM for ppc64 using CRQ based
 interface
Message-ID: <20191217002954.GH6242@umbus.fritz.box>
References: <20191212202430.1079725-1-stefanb@linux.vnet.ibm.com>
 <20191212202430.1079725-2-stefanb@linux.vnet.ibm.com>
 <20191213053453.GD207300@umbus.fritz.box>
 <75fd3e95-d72f-069b-22ce-f354e1c34660@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="fd5uyaI9j6xoeUBo"
Content-Disposition: inline
In-Reply-To: <75fd3e95-d72f-069b-22ce-f354e1c34660@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--fd5uyaI9j6xoeUBo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 13, 2019 at 08:03:36AM -0500, Stefan Berger wrote:
> On 12/13/19 12:34 AM, David Gibson wrote:
> > On Thu, Dec 12, 2019 at 03:24:26PM -0500, Stefan Berger wrote:
> > > Implement support for TPM on ppc64 by implementing the vTPM CRQ inter=
face
> > > as a frontend. It can use the tpm_emulator driver backend with the ex=
ternal
> > > swtpm.
> > >=20
> > > The Linux vTPM driver for ppc64 works with this emulation.
> > >=20
> > > This TPM emulator also handles the TPM 2 case.
> > >=20
> > > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> > > Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> > >=20
> > > diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
> > > index 4c8ee87d67..66a570aac1 100644
> > > --- a/hw/tpm/Kconfig
> > > +++ b/hw/tpm/Kconfig
> > > @@ -22,3 +22,9 @@ config TPM_EMULATOR
> > >       bool
> > >       default y
> > >       depends on TPMDEV
> > > +
> > > +config TPM_SPAPR
> > > +    bool
> > > +    default n
> > > +    select TPMDEV
> > > +    depends on PSERIES
> > > diff --git a/hw/tpm/Makefile.objs b/hw/tpm/Makefile.objs
> > > index de0b85d02a..85eb99ae05 100644
> > > --- a/hw/tpm/Makefile.objs
> > > +++ b/hw/tpm/Makefile.objs
> > > @@ -4,3 +4,4 @@ common-obj-$(CONFIG_TPM_TIS) +=3D tpm_tis.o
> > >   common-obj-$(CONFIG_TPM_CRB) +=3D tpm_crb.o
> > >   common-obj-$(CONFIG_TPM_PASSTHROUGH) +=3D tpm_passthrough.o
> > >   common-obj-$(CONFIG_TPM_EMULATOR) +=3D tpm_emulator.o
> > > +obj-$(CONFIG_TPM_SPAPR) +=3D tpm_spapr.o
> > > diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
> > > new file mode 100644
> > > index 0000000000..c4a67e2403
> > > --- /dev/null
> > > +++ b/hw/tpm/tpm_spapr.c
> > > @@ -0,0 +1,405 @@
> > > +/*
> > > + * QEMU PowerPC pSeries Logical Partition (aka sPAPR) hardware Syste=
m Emulator
> > > + *
> > > + * PAPR Virtual TPM
> > > + *
> > > + * Copyright (c) 2015, 2017 IBM Corporation.
> > > + *
> > > + * Authors:
> > > + *    Stefan Berger <stefanb@linux.vnet.ibm.com>
> > > + *
> > > + * This code is licensed under the GPL version 2 or later. See the
> > > + * COPYING file in the top-level directory.
> > > + *
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/error-report.h"
> > > +#include "qapi/error.h"
> > > +#include "hw/qdev-properties.h"
> > > +#include "migration/vmstate.h"
> > > +
> > > +#include "sysemu/tpm_backend.h"
> > > +#include "tpm_int.h"
> > > +#include "tpm_util.h"
> > > +
> > > +#include "hw/ppc/spapr.h"
> > > +#include "hw/ppc/spapr_vio.h"
> > > +#include "trace.h"
> > > +
> > > +#define DEBUG_SPAPR 0
> > > +
> > > +#define VIO_SPAPR_VTPM(obj) \
> > > +     OBJECT_CHECK(SPAPRvTPMState, (obj), TYPE_TPM_SPAPR)
> > > +
> > > +typedef struct VioCRQ {
> > How does this structure relate to the existing SpaprVioCrq?
>=20
> The existing one looks like this:
>=20
> typedef struct SpaprVioCrq {
> =A0=A0=A0 uint64_t qladdr;
> =A0=A0=A0 uint32_t qsize;
> =A0=A0=A0 uint32_t qnext;
> =A0=A0=A0 int(*SendFunc)(struct SpaprVioDevice *vdev, uint8_t *crq);
> } SpaprVioCrq;
>=20
> I don't seem to find the fields there that we need for vTPM support.

Yeah, I can see the difference in the structures.  What I'm after is
what is the difference in purpose which means they have different
content.

Having read through the whole series now, I *think* the answer is that
the tpm specific structure is one entry in the request queue for the
vtpm, whereas the VioCrq structure is a handle on an entire queue.

I think the tpm one needs a rename to reflect that a) it's vtpm
specific and b) it's not actually a queue, just part of it.

> > Also we're now avoiding exceptions to StudlyCaps, because it causes
> > more confusion even if it is to match other capitalization
> > conventions.  So, I'd suggest 'VioCrq', 'TpmSpaprCrq' etc.
>=20
>=20
> Will adjust.
>=20
>=20
> >=20
> > > +    uint8_t valid;  /* 0x80: cmd; 0xc0: init crq */
> > > +                    /* 0x81-0x83: CRQ message response */
> > > +    uint8_t msg;    /* see below */
> > > +    uint16_t len;   /* len of TPM request; len of TPM response */
> > > +    uint32_t data;  /* rtce_dma_handle when sending TPM request */
> > > +    uint64_t reserved;
> > > +} VioCRQ;
> > > +
> > > +typedef union TPMSpaprCRQ {
> > > +    VioCRQ s;
> > > +    uint8_t raw[sizeof(VioCRQ)];
> > > +} TPMSpaprCRQ;
> > A union just to get raw bytes seems a really weird thing to do (as
> > opposed to just casting to (char *))
>=20
>=20
> Ok, I will change it.
>=20
>=20
>=20
> >=20
> > > +
> > > +#define SPAPR_VTPM_VALID_INIT_CRQ_COMMAND  0xC0
> > > +#define SPAPR_VTPM_VALID_COMMAND           0x80
> > > +#define SPAPR_VTPM_MSG_RESULT              0x80
> > > +
> > > +/* msg types for valid =3D SPAPR_VTPM_VALID_INIT_CRQ */
> > > +#define SPAPR_VTPM_INIT_CRQ_RESULT           0x1
> > > +#define SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT  0x2
> > > +
> > > +/* msg types for valid =3D SPAPR_VTPM_VALID_CMD */
> > > +#define SPAPR_VTPM_GET_VERSION               0x1
> > > +#define SPAPR_VTPM_TPM_COMMAND               0x2
> > > +#define SPAPR_VTPM_GET_RTCE_BUFFER_SIZE      0x3
> > > +#define SPAPR_VTPM_PREPARE_TO_SUSPEND        0x4
> > > +
> > > +/* response error messages */
> > > +#define SPAPR_VTPM_VTPM_ERROR                0xff
> > > +
> > > +/* error codes */
> > > +#define SPAPR_VTPM_ERR_COPY_IN_FAILED        0x3
> > > +#define SPAPR_VTPM_ERR_COPY_OUT_FAILED       0x4
> > > +
> > > +#define MAX_BUFFER_SIZE TARGET_PAGE_SIZE
> > > +
> > > +typedef struct {
> > > +    SpaprVioDevice vdev;
> > > +
> > > +    TPMSpaprCRQ crq; /* track single TPM command */
> > > +
> > > +    uint8_t state;
> > > +#define SPAPR_VTPM_STATE_NONE         0
> > > +#define SPAPR_VTPM_STATE_EXECUTION    1
> > > +#define SPAPR_VTPM_STATE_COMPLETION   2
> > I see this field written, but never read.  What's up with that?
>=20
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (s->state =3D=3D SPAPR_VTPM_STATE_EX=
ECUTION) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return H_BUSY;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>=20
> Is this what you mean?

Oh, I must have missed that, sorry.

>=20
>=20
> >=20
> > > +
> > > +    unsigned char buffer[MAX_BUFFER_SIZE];
> > > +
> > > +    TPMBackendCmd cmd;
> > > +
> > > +    TPMBackend *be_driver;
> > > +    TPMVersion be_tpm_version;
> > > +
> > > +    size_t be_buffer_size;
> > > +} SPAPRvTPMState;
> > SpaprVtpmState
> >=20
> > Or just SpaprTpmState, since we use just "tpm spapr" rather than
> > "vtpm" in plenty of other places.
>=20
>=20
> Will adjust.
>=20
>=20
> >=20
> > > +
> > > +static void tpm_spapr_show_buffer(const unsigned char *buffer,
> > > +                                  size_t buffer_size, const char *st=
ring)
> > > +{
> > > +    size_t len, i;
> > > +    char *line_buffer, *p;
> > > +
> > > +    len =3D MIN(tpm_cmd_get_size(buffer), buffer_size);
> > > +
> > > +    /*
> > > +     * allocate enough room for 3 chars per buffer entry plus a
> > > +     * newline after every 16 chars and a final null terminator.
> > > +     */
> > > +    line_buffer =3D g_malloc(len * 3 + (len / 16) + 1);
> > You can use g_strdup_printf() / g_string_append_printf() to avoid
> > fiddly messing around with allocations like this.
>=20
> This is a 1:1 copy from the existing TIS driver.

Hm, right.  Probably not a bad idea to move that out as a helper
function then.

> > > +
> > > +    for (i =3D 0, p =3D line_buffer; i < len; i++) {
> > > +        if (i && !(i % 16)) {
> > > +            p +=3D sprintf(p, "\n");
> > > +        }
> > > +        p +=3D sprintf(p, "%.2X ", buffer[i]);
> > > +    }
> > > +    trace_tpm_spapr_show_buffer(string, len, line_buffer);
> > > +
> > > +    g_free(line_buffer);
> > > +}
> > > +
> > > +/*
> > > + * Send a request to the TPM.
> > > + */
> > > +static void tpm_spapr_tpm_send(SPAPRvTPMState *s)
> > > +{
> > > +    if (trace_event_get_state_backends(TRACE_TPM_SPAPR_SHOW_BUFFER))=
 {
> > > +        tpm_spapr_show_buffer(s->buffer, sizeof(s->buffer), "To TPM"=
);
> > > +    }
> > > +
> > > +    s->state =3D SPAPR_VTPM_STATE_EXECUTION;
> > > +    s->cmd =3D (TPMBackendCmd) {
> > > +        .locty =3D 0,
> > > +        .in =3D s->buffer,
> > > +        .in_len =3D MIN(tpm_cmd_get_size(s->buffer), sizeof(s->buffe=
r)),
> > > +        .out =3D s->buffer,
> > > +        .out_len =3D sizeof(s->buffer),
> > > +    };
> > > +
> > > +    tpm_backend_deliver_request(s->be_driver, &s->cmd);
> > > +}
> > > +
> > > +static int tpm_spapr_process_cmd(SPAPRvTPMState *s, uint64_t dataptr)
> > > +{
> > > +    long rc;
> > > +
> > > +    /* a max. of be_buffer_size bytes can be transported */
> > > +    rc =3D spapr_vio_dma_read(&s->vdev, dataptr,
> > > +                            s->buffer, s->be_buffer_size);
> > > +    if (rc) {
> > > +        error_report("tpm_spapr_got_payload: DMA read failure");
> > > +    }
> > > +    /* let vTPM handle any malformed request */
> > > +    tpm_spapr_tpm_send(s);
> > > +
> > > +    return rc;
> > > +}
> > > +
> > > +static int tpm_spapr_do_crq(struct SpaprVioDevice *dev, uint8_t *crq=
_data)
> > > +{
> > > +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> > > +    TPMSpaprCRQ local_crq;
> > > +    TPMSpaprCRQ *crq =3D &s->crq; /* requests only */
> > > +    int rc;
> > > +
> > > +    memcpy(&local_crq.raw, crq_data, sizeof(local_crq.raw));
> > Again, no real need for a union here, you can just memcpy onto a
> > structure variable.
> >=20
> > > +    trace_tpm_spapr_do_crq(local_crq.raw[0], local_crq.raw[1]);
> > > +
> > > +    switch (local_crq.s.valid) {
> > > +    case SPAPR_VTPM_VALID_INIT_CRQ_COMMAND: /* Init command/response=
 */
> > > +
> > > +        /* Respond to initialization request */
> > > +        switch (local_crq.s.msg) {
> > > +        case SPAPR_VTPM_INIT_CRQ_RESULT:
> > > +            trace_tpm_spapr_do_crq_crq_result();
> > > +            memset(local_crq.raw, 0, sizeof(local_crq.raw));
> > > +            local_crq.s.valid =3D SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
> > > +            local_crq.s.msg =3D SPAPR_VTPM_INIT_CRQ_RESULT;
> > > +            spapr_vio_send_crq(dev, local_crq.raw);
> > > +            break;
> > > +
> > > +        case SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT:
> > > +            trace_tpm_spapr_do_crq_crq_complete_result();
> > > +            memset(local_crq.raw, 0, sizeof(local_crq.raw));
> > > +            local_crq.s.valid =3D SPAPR_VTPM_VALID_INIT_CRQ_COMMAND;
> > > +            local_crq.s.msg =3D SPAPR_VTPM_INIT_CRQ_COMPLETE_RESULT;
> > > +            spapr_vio_send_crq(dev, local_crq.raw);
> > > +            break;
> > > +        }
> > > +
> > > +        break;
> > > +    case SPAPR_VTPM_VALID_COMMAND: /* Payloads */
> > > +        switch (local_crq.s.msg) {
> > > +        case SPAPR_VTPM_TPM_COMMAND:
> > > +            trace_tpm_spapr_do_crq_tpm_command();
> > > +            if (s->state =3D=3D SPAPR_VTPM_STATE_EXECUTION) {
> > > +                return H_BUSY;
> > > +            }
> > > +            /* this crq is tracked */
> > > +            memcpy(crq->raw, crq_data, sizeof(crq->raw));
> > > +
> > > +            rc =3D tpm_spapr_process_cmd(s, be32_to_cpu(crq->s.data)=
);
> > > +
> > > +            if (rc =3D=3D H_SUCCESS) {
> > > +                crq->s.valid =3D be16_to_cpu(0);
> > > +            } else {
> > > +                local_crq.s.valid =3D SPAPR_VTPM_MSG_RESULT;
> > > +                local_crq.s.msg =3D SPAPR_VTPM_VTPM_ERROR;
> > > +                local_crq.s.data =3D cpu_to_be32(SPAPR_VTPM_ERR_COPY=
_IN_FAILED);
> > > +                spapr_vio_send_crq(dev, local_crq.raw);
> > > +            }
> > > +            break;
> > > +
> > > +        case SPAPR_VTPM_GET_RTCE_BUFFER_SIZE:
> > > +            trace_tpm_spapr_do_crq_tpm_get_rtce_buffer_size(s->be_bu=
ffer_size);
> > > +            local_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
> > > +            local_crq.s.len =3D cpu_to_be16(s->be_buffer_size);
> > > +            spapr_vio_send_crq(dev, local_crq.raw);
> > > +            break;
> > > +
> > > +        case SPAPR_VTPM_GET_VERSION:
> > > +            local_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
> > > +            local_crq.s.len =3D cpu_to_be16(0);
> > > +            switch (s->be_tpm_version) {
> > > +            case TPM_VERSION_UNSPEC:
> > > +                local_crq.s.data =3D cpu_to_be32(0);
> > > +                break;
> > > +            case TPM_VERSION_1_2:
> > > +                local_crq.s.data =3D cpu_to_be32(1);
> > > +                break;
> > > +            case TPM_VERSION_2_0:
> > > +                local_crq.s.data =3D cpu_to_be32(2);
> > > +                break;
> > To make the breakage obvious when/if the backend adds a new version we
> > should probably have a default: case with g_assert_not_reached() or
> > the like.
> I will add this.
> >=20
> > > +            }
> > > +            trace_tpm_spapr_do_crq_get_version(be32_to_cpu(local_crq=
=2Es.data));
> > > +            spapr_vio_send_crq(dev, local_crq.raw);
> > > +            break;
> > > +
> > > +        case SPAPR_VTPM_PREPARE_TO_SUSPEND:
> > > +            trace_tpm_spapr_do_crq_prepare_to_suspend();
> > > +            local_crq.s.msg |=3D SPAPR_VTPM_MSG_RESULT;
> > > +            spapr_vio_send_crq(dev, local_crq.raw);
> > > +            break;
> > > +
> > > +        default:
> > > +            trace_tpm_spapr_do_crq_unknown_msg_type(crq->s.msg);
> > > +        }
> > > +        break;
> > > +    default:
> > > +        trace_tpm_spapr_do_crq_unknown_crq(local_crq.raw[0], local_c=
rq.raw[1]);
> > > +    };
> > > +
> > > +    return H_SUCCESS;
> > > +}
> > > +
> > > +static void tpm_spapr_request_completed(TPMIf *ti, int ret)
> > > +{
> > > +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(ti);
> > > +    TPMSpaprCRQ *crq =3D &s->crq;
> > > +    uint32_t len;
> > > +    int rc;
> > > +
> > > +    s->state =3D SPAPR_VTPM_STATE_COMPLETION;
> > > +
> > > +    /* a max. of be_buffer_size bytes can be transported */
> > > +    len =3D MIN(tpm_cmd_get_size(s->buffer), s->be_buffer_size);
> > > +    rc =3D spapr_vio_dma_write(&s->vdev, be32_to_cpu(crq->s.data),
> > > +                             s->buffer, len);
> > > +
> > > +    if (trace_event_get_state_backends(TRACE_TPM_SPAPR_SHOW_BUFFER))=
 {
> > > +        tpm_spapr_show_buffer(s->buffer, len, "From TPM");
> > > +    }
> > > +
> > > +    crq->s.valid =3D SPAPR_VTPM_MSG_RESULT;
> > > +    if (rc =3D=3D H_SUCCESS) {
> > > +        crq->s.msg =3D SPAPR_VTPM_TPM_COMMAND | SPAPR_VTPM_MSG_RESUL=
T;
> > > +        crq->s.len =3D cpu_to_be16(len);
> > > +    } else {
> > > +        error_report("%s: DMA write failure", __func__);
> > > +        crq->s.msg =3D SPAPR_VTPM_VTPM_ERROR;
> > > +        crq->s.len =3D cpu_to_be16(0);
> > > +        crq->s.data =3D cpu_to_be32(SPAPR_VTPM_ERR_COPY_OUT_FAILED);
> > > +    }
> > > +
> > > +    rc =3D spapr_vio_send_crq(&s->vdev, crq->raw);
> > > +    if (rc) {
> > > +        error_report("%s: Error sending response", __func__);
> > > +    }
> > > +}
> > > +
> > > +static int tpm_spapr_do_startup_tpm(SPAPRvTPMState *s, size_t buffer=
size)
> > > +{
> > > +    return tpm_backend_startup_tpm(s->be_driver, buffersize);
> > > +}
> > > +
> > > +static void tpm_spapr_update_deviceclass(SpaprVioDevice *dev)
> > > +{
> > > +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> > > +    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_GET_CLASS(dev);
> > > +
> > > +    switch (s->be_tpm_version) {
> > > +    case TPM_VERSION_UNSPEC:
> > > +        assert(false);
> > > +        break;
> > > +    case TPM_VERSION_1_2:
> > > +        k->dt_name =3D "vtpm";
> > > +        k->dt_type =3D "IBM,vtpm";
> > > +        k->dt_compatible =3D "IBM,vtpm";
> > > +        break;
> > > +    case TPM_VERSION_2_0:
> > > +        k->dt_name =3D "vtpm";
> > > +        k->dt_type =3D "IBM,vtpm";
> > > +        k->dt_compatible =3D "IBM,vtpm20";
> > > +        break;
> > Erk.  Updating DeviceClass structures on the fly is hideously ugly.
> > We might need to take a different approach for this.
>=20
> Make a suggestion... Obviously, we can hard-initialize dt_name and dt_type
> but dt_compatible can only be set after we have determined the version of
> TPM.

As you say name and type can just be put into the class statically.
Since you need to change compatible based on an internal variable,
we'd need to replace the static dt_compatible in the class with a
callback.

> > > +    }
> > > +}
> > > +
> > > +static void tpm_spapr_reset(SpaprVioDevice *dev)
> > > +{
> > > +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> > > +
> > > +    s->state =3D SPAPR_VTPM_STATE_NONE;
> > > +
> > > +    s->be_tpm_version =3D tpm_backend_get_tpm_version(s->be_driver);
> > > +    tpm_spapr_update_deviceclass(dev);
> > > +
> > > +    s->be_buffer_size =3D MAX(ROUND_UP(tpm_backend_get_buffer_size(s=
->be_driver),
> > > +                                     TARGET_PAGE_SIZE),
> > > +                            sizeof(s->buffer));
> > I'm very confused as to what be_buffer_size is supposed to represent.
> > it's not the backend size, because you're rounding that up and taking
> > MAX with another thing.  But it's not the max safe size for this
> > locally, because it can be bigger than s->buffer.
>=20
>=20
> Will adjust.
>=20
> >=20
> > > +    tpm_backend_reset(s->be_driver);
> > > +    tpm_spapr_do_startup_tpm(s, s->be_buffer_size);
> > > +}
> > > +
> > > +static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
> > > +{
> > > +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(ti);
> > > +
> > > +    if (tpm_backend_had_startup_error(s->be_driver)) {
> > > +        return TPM_VERSION_UNSPEC;
> > > +    }
> > > +
> > > +    return tpm_backend_get_tpm_version(s->be_driver);
> > > +}
> > > +
> > > +static const VMStateDescription vmstate_spapr_vtpm =3D {
> > > +    .name =3D "tpm-spapr",
> > > +    .unmigratable =3D 1,
> > > +};
> > > +
> > > +static Property tpm_spapr_properties[] =3D {
> > > +    DEFINE_SPAPR_PROPERTIES(SPAPRvTPMState, vdev),
> > > +    DEFINE_PROP_TPMBE("tpmdev", SPAPRvTPMState, be_driver),
> > > +    DEFINE_PROP_END_OF_LIST(),
> > > +};
> > > +
> > > +static void tpm_spapr_realizefn(SpaprVioDevice *dev, Error **errp)
> > > +{
> > > +    SPAPRvTPMState *s =3D VIO_SPAPR_VTPM(dev);
> > > +
> > > +    if (!tpm_find()) {
> > This seems wrong, even though I also see it in existing TPM code.
> > AFAICT tpm_find() returns a TPMIf pointer for the existing TPM if it
> > exists, meaning !tpm_find() will be true if there is *not* an existing
> > TPM.
> /* returns NULL unless there is exactly one TPM device */
> static inline TPMIf *tpm_find(void)
> {
> =A0=A0=A0 Object *obj =3D object_resolve_path_type("", TYPE_TPM_IF, NULL);
>=20
> =A0=A0=A0 return TPM_IF(obj);
> }
>=20
>=20
> I would rather leave it like this.

Oh, I see.  Seems confusing to me, but I guess that's the idiom, so
let it be.

> > > +        error_setg(errp, "at most one TPM device is permitted");
> > > +        return;
> > > +    }
> > > +
> > > +    dev->crq.SendFunc =3D tpm_spapr_do_crq;
> > > +
> > > +    if (!s->be_driver) {
> > > +        error_setg(errp, "'tpmdev' property is required");
> > > +        return;
> > > +    }
> > > +}
> > > +
> > > +static void tpm_spapr_class_init(ObjectClass *klass, void *data)
> > > +{
> > > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > > +    SpaprVioDeviceClass *k =3D VIO_SPAPR_DEVICE_CLASS(klass);
> > > +    TPMIfClass *tc =3D TPM_IF_CLASS(klass);
> > > +
> > > +    k->realize =3D tpm_spapr_realizefn;
> > > +    k->reset =3D tpm_spapr_reset;
> > > +    k->signal_mask =3D 0x00000001;
> > > +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> > > +    dc->props =3D tpm_spapr_properties;
> > > +    k->rtce_window_size =3D 0x10000000;
> > > +    dc->vmsd =3D &vmstate_spapr_vtpm;
> > > +
> > > +    tc->model =3D TPM_MODEL_TPM_SPAPR;
> > > +    tc->get_version =3D tpm_spapr_get_version;
> > > +    tc->request_completed =3D tpm_spapr_request_completed;
> > > +}
> > > +
> > > +static const TypeInfo tpm_spapr_info =3D {
> > > +    .name          =3D TYPE_TPM_SPAPR,
> > > +    .parent        =3D TYPE_VIO_SPAPR_DEVICE,
> > > +    .instance_size =3D sizeof(SPAPRvTPMState),
> > > +    .class_init    =3D tpm_spapr_class_init,
> > > +    .interfaces =3D (InterfaceInfo[]) {
> > > +        { TYPE_TPM_IF },
> > > +        { }
> > > +    }
> > > +};
> > > +
> > > +static void tpm_spapr_register_types(void)
> > > +{
> > > +    type_register_static(&tpm_spapr_info);
> > > +}
> > > +
> > > +type_init(tpm_spapr_register_types)
> > > diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
> > > index 89804bcd64..6278a39618 100644
> > > --- a/hw/tpm/trace-events
> > > +++ b/hw/tpm/trace-events
> > > @@ -55,3 +55,15 @@ tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset=
) "locty: %d, rw_offset =3D %u"
> > >   # tpm_ppi.c
> > >   tpm_ppi_memset(uint8_t *ptr, size_t size) "memset: %p %zu"
> > > +
> > > +# hw/tpm/tpm_spapr.c
> > > +tpm_spapr_show_buffer(const char *direction, size_t len, const char =
*buf) "direction: %s len: %zu\n%s"
> > > +tpm_spapr_do_crq(uint8_t raw1, uint8_t raw2) "1st 2 bytes in CRQ: 0x=
%02x 0x%02x"
> > > +tpm_spapr_do_crq_crq_result(void) "SPAPR_VTPM_INIT_CRQ_RESULT"
> > > +tpm_spapr_do_crq_crq_complete_result(void) "SPAPR_VTPM_INIT_CRQ_COMP=
_RESULT"
> > > +tpm_spapr_do_crq_tpm_command(void) "got TPM command payload"
> > > +tpm_spapr_do_crq_tpm_get_rtce_buffer_size(size_t buffersize) "respon=
se: buffer size is %zu"
> > > +tpm_spapr_do_crq_get_version(uint32_t version) "response: version %u"
> > > +tpm_spapr_do_crq_prepare_to_suspend(void) "response: preparing to su=
spend"
> > > +tpm_spapr_do_crq_unknown_msg_type(uint8_t type) "Unknown message typ=
e 0x%02x"
> > > +tpm_spapr_do_crq_unknown_crq(uint8_t raw1, uint8_t raw2) "unknown CR=
Q 0x%02x 0x%02x ..."
> > > diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
> > > index 5b541a71c8..15979a3647 100644
> > > --- a/include/sysemu/tpm.h
> > > +++ b/include/sysemu/tpm.h
> > > @@ -45,11 +45,14 @@ typedef struct TPMIfClass {
> > >   #define TYPE_TPM_TIS                "tpm-tis"
> > >   #define TYPE_TPM_CRB                "tpm-crb"
> > > +#define TYPE_TPM_SPAPR              "tpm-spapr"
> > >   #define TPM_IS_TIS(chr)                             \
> > >       object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
> > >   #define TPM_IS_CRB(chr)                             \
> > >       object_dynamic_cast(OBJECT(chr), TYPE_TPM_CRB)
> > > +#define TPM_IS_SPAPR(chr)                           \
> > > +    object_dynamic_cast(OBJECT(chr), TYPE_TPM_SPAPR)
> > >   /* returns NULL unless there is exactly one TPM device */
> > >   static inline TPMIf *tpm_find(void)
> > > diff --git a/qapi/tpm.json b/qapi/tpm.json
> > > index b30323bb6b..63878aa0f4 100644
> > > --- a/qapi/tpm.json
> > > +++ b/qapi/tpm.json
> > > @@ -12,11 +12,11 @@
> > >   #
> > >   # @tpm-tis: TPM TIS model
> > >   # @tpm-crb: TPM CRB model (since 2.12)
> > > +# @tpm-spapr: TPM SPAPR model (since 5.0)
> > >   #
> > >   # Since: 1.5
> > >   ##
> > > -{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb' ] }
> > > -
> > > +{ 'enum': 'TpmModel', 'data': [ 'tpm-tis', 'tpm-crb', 'tpm-spapr' ] }
> > >   ##
> > >   # @query-tpm-models:
> > >   #
> > > @@ -29,7 +29,7 @@
> > >   # Example:
> > >   #
> > >   # -> { "execute": "query-tpm-models" }
> > > -# <- { "return": [ "tpm-tis", "tpm-crb" ] }
> > > +# <- { "return": [ "tpm-tis", "tpm-crb", "tpm-spapr" ] }
> > >   #
> > >   ##
> > >   { 'command': 'query-tpm-models', 'returns': ['TpmModel'] }
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--fd5uyaI9j6xoeUBo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl34IYIACgkQbDjKyiDZ
s5IDWhAAq6Wh0o+bRrngBKYEbT7ck5kBFgN8nN0+Ihp3rvVAXVsa9atrKegRMts5
AtjEnolI3roAQUM4YlkL0nYQO5tTeUj8ZXoWyTF9RjxoCe4rMz+Uz4grZrpt1AoG
6rOjT9MKdkh9xZFEsMtm8x/9UXUKIUyRNJ5hypBJ3qWVbSqi8G3rYR1dXaH+C5iQ
+jYMhPlaHevv/nCrfYXkePDuq3TDOZgClE1iQHs9PNQ2zJezON3dAkzx1Dijn8bm
/CBgcJmbhaCv0e1b7bHFQbjxcgzWKmKkRM+VUPD2lZ1g6Qeg5vtqUuvhBxYPhK97
wOYM2FfHe/SB1KPQPS5h+IzMyWeIJHhDEbzgNVgTNERq8Ivp93aIgHppwlBdqanw
exkSVMYpN7bRNWI+mANizB5Jvpen8gHaxVTI1tdf8MdRgG9JGv6KgWQfuLfn9f5H
sKm+OD1DmGJ5Xy6tLa/HDN1HGai0R4XAoODfZ7w9YQ8YlKQzj0REL0W2D8Xytsbs
HTMSO7qYsCTrS5RSCfuHH0+S/1vF0HuysK7sHDKFq16lRmmP/ue0cPaQeGET4diX
dzFaIREgtYYLUo77VbT+gSSIMxrBaz8C1SvDyq5WMNIvAIKZYrqpIGEH9nvFDuNG
yTuKQkzgj0FGfuZlVD9B5hpeDVCbuJAa/OqS/8X4kiMLgbNxJSc=
=6gik
-----END PGP SIGNATURE-----

--fd5uyaI9j6xoeUBo--

