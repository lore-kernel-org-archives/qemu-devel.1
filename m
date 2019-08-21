Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7127AC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:13:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C66422DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C66422DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Mg9-0004HF-AS
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34859)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0Mez-0003Ff-FW
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:12:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0Mew-0003zV-5o
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:12:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34928)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0Mev-0003zC-R1
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:12:02 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 95C2B2F366D
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 09:12:00 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id k8so926118wrx.19
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 02:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hi92ttMUJUtmlq9f+liGzAFqD6dLe//USsDAfKS9rJw=;
 b=TdFwY9tkIsFVwQjHr15N3KySR9R7t6G6qLPnz93xNghHrf6qVhwd1QaAQaZ4NF2umr
 lzVV4AHtXGmszyBVzZkBmkW1gmHa+wS7xChJPXTQ9eURX9rta+U4vOpMRQST4P6cLMW/
 g/OY5H9IyVIA0iQAIe6FIEeCSs25swk99GFzofyPkWrnnrr6oI+82G+TQmqo6m2r0eSV
 BpZ3EcqceUF9Lju70cmUxmyCED6T5XRUuFO6Ktf+O+VtWT9Dxvb6ZnvRnnbNWBmptI2t
 5+YqANcRYV1clZd8qkM8mm5Ys7O2W0pW+ocoDiM4fA9Tr1QCaI6BXDVaFTxB5LNaki7I
 3XpA==
X-Gm-Message-State: APjAAAV3zBzG3rgd96HQWoXbvKx1wV4loP2sr8Paj/aYPzJ7TQ7bN4u+
 6NIO8ChfZb4m4LS64yfSJM+wNoCsNIjrG1pxNWKPOXsBGe/b6B0oMi0coFA4acCePIS/4pdQO+E
 nbljWQWRVMn2Bbd8=
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr39155984wrx.100.1566378719225; 
 Wed, 21 Aug 2019 02:11:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwV02rY6voNZO+6r549wVE6GjBbiS73F/LQege6TExMflgzqJTEZFAEzWenIOkjhCgsUbhgQQ==
X-Received: by 2002:a05:6000:12c3:: with SMTP id
 l3mr39155945wrx.100.1566378718853; 
 Wed, 21 Aug 2019 02:11:58 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id d16sm17932538wrv.55.2019.08.21.02.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 02:11:58 -0700 (PDT)
To: minyard@acm.org, QEMU Developers <qemu-devel@nongnu.org>
References: <20190819201705.31633-1-minyard@acm.org>
 <20190819201705.31633-8-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f3d511e2-945f-2d7e-1c0b-43b56bc686c7@redhat.com>
Date: Wed, 21 Aug 2019 11:11:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819201705.31633-8-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/15] ipmi: Split out KCS-specific code
 from ISA KCS code
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
Cc: Corey Minyard <cminyard@mvista.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/19/19 10:16 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Get ready for PCI and other KCS interfaces.
>=20
> No functional changes, just split the code into the generic KCS code
> and the ISA-specific code.
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  hw/ipmi/Makefile.objs      |   2 +-
>  hw/ipmi/ipmi_kcs.c         | 408 ++++++++++++++++++++++++++++++++++++
>  hw/ipmi/isa_ipmi_kcs.c     | 417 ++-----------------------------------
>  include/hw/ipmi/ipmi_kcs.h |  75 +++++++
>  4 files changed, 505 insertions(+), 397 deletions(-)
>  create mode 100644 hw/ipmi/ipmi_kcs.c
>  create mode 100644 include/hw/ipmi/ipmi_kcs.h
>=20
> diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
> index 1b422bbee0..6835d2f64a 100644
> --- a/hw/ipmi/Makefile.objs
> +++ b/hw/ipmi/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-$(CONFIG_IPMI) +=3D ipmi.o
> +common-obj-$(CONFIG_IPMI) +=3D ipmi.o ipmi_kcs.o
>  common-obj-$(CONFIG_IPMI_LOCAL) +=3D ipmi_bmc_sim.o
>  common-obj-$(CONFIG_IPMI_EXTERN) +=3D ipmi_bmc_extern.o
>  common-obj-$(CONFIG_ISA_IPMI_KCS) +=3D isa_ipmi_kcs.o
> diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
> new file mode 100644
> index 0000000000..dab1af8bc8
> --- /dev/null
> +++ b/hw/ipmi/ipmi_kcs.c
> @@ -0,0 +1,408 @@
> +/*
> + * QEMU IPMI KCS emulation
> + *
> + * Copyright (c) 2015,2017 Corey Minyard, MontaVista Software, LLC
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +#include "qemu/osdep.h"
> +#include "migration/vmstate.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "hw/ipmi/ipmi_kcs.h"
> +
> +#define IPMI_KCS_OBF_BIT        0
> +#define IPMI_KCS_IBF_BIT        1
> +#define IPMI_KCS_SMS_ATN_BIT    2
> +#define IPMI_KCS_CD_BIT         3
> +
> +#define IPMI_KCS_OBF_MASK          (1 << IPMI_KCS_OBF_BIT)
> +#define IPMI_KCS_GET_OBF(d)        (((d) >> IPMI_KCS_OBF_BIT) & 0x1)
> +#define IPMI_KCS_SET_OBF(d, v)     (d) =3D (((d) & ~IPMI_KCS_OBF_MASK)=
 | \
> +                                       (((v) & 1) << IPMI_KCS_OBF_BIT)=
)
> +#define IPMI_KCS_IBF_MASK          (1 << IPMI_KCS_IBF_BIT)
> +#define IPMI_KCS_GET_IBF(d)        (((d) >> IPMI_KCS_IBF_BIT) & 0x1)
> +#define IPMI_KCS_SET_IBF(d, v)     (d) =3D (((d) & ~IPMI_KCS_IBF_MASK)=
 | \
> +                                       (((v) & 1) << IPMI_KCS_IBF_BIT)=
)
> +#define IPMI_KCS_SMS_ATN_MASK      (1 << IPMI_KCS_SMS_ATN_BIT)
> +#define IPMI_KCS_GET_SMS_ATN(d)    (((d) >> IPMI_KCS_SMS_ATN_BIT) & 0x=
1)
> +#define IPMI_KCS_SET_SMS_ATN(d, v) (d) =3D (((d) & ~IPMI_KCS_SMS_ATN_M=
ASK) | \
> +                                       (((v) & 1) << IPMI_KCS_SMS_ATN_=
BIT))
> +#define IPMI_KCS_CD_MASK           (1 << IPMI_KCS_CD_BIT)
> +#define IPMI_KCS_GET_CD(d)         (((d) >> IPMI_KCS_CD_BIT) & 0x1)
> +#define IPMI_KCS_SET_CD(d, v)      (d) =3D (((d) & ~IPMI_KCS_CD_MASK) =
| \
> +                                       (((v) & 1) << IPMI_KCS_CD_BIT))
> +
> +#define IPMI_KCS_IDLE_STATE        0
> +#define IPMI_KCS_READ_STATE        1
> +#define IPMI_KCS_WRITE_STATE       2
> +#define IPMI_KCS_ERROR_STATE       3
> +
> +#define IPMI_KCS_GET_STATE(d)    (((d) >> 6) & 0x3)
> +#define IPMI_KCS_SET_STATE(d, v) ((d) =3D ((d) & ~0xc0) | (((v) & 0x3)=
 << 6))
> +
> +#define IPMI_KCS_ABORT_STATUS_CMD       0x60
> +#define IPMI_KCS_WRITE_START_CMD        0x61
> +#define IPMI_KCS_WRITE_END_CMD          0x62
> +#define IPMI_KCS_READ_CMD               0x68
> +
> +#define IPMI_KCS_STATUS_NO_ERR          0x00
> +#define IPMI_KCS_STATUS_ABORTED_ERR     0x01
> +#define IPMI_KCS_STATUS_BAD_CC_ERR      0x02
> +#define IPMI_KCS_STATUS_LENGTH_ERR      0x06
> +
> +static void ipmi_kcs_raise_irq(IPMIKCS *ik)
> +{
> +    if (ik->use_irq && ik->irqs_enabled && ik->raise_irq) {
> +        ik->raise_irq(ik);
> +    }
> +}
> +
> +static void ipmi_kcs_lower_irq(IPMIKCS *ik)
> +{
> +    if (ik->lower_irq) {
> +        ik->lower_irq(ik);
> +    }
> +}
> +
> +#define SET_OBF() \
> +    do {                                                              =
        \
> +        IPMI_KCS_SET_OBF(ik->status_reg, 1);                          =
        \
> +        if (!ik->obf_irq_set) {                                       =
        \
> +            ik->obf_irq_set =3D 1;                                    =
          \
> +            if (!ik->atn_irq_set) {                                   =
        \
> +                ipmi_kcs_raise_irq(ik);                               =
   \
> +            }                                                         =
        \
> +        }                                                             =
        \
> +    } while (0)
> +
> +static void ipmi_kcs_signal(IPMIKCS *ik, IPMIInterface *ii)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +
> +    ik->do_wake =3D 1;
> +    while (ik->do_wake) {
> +        ik->do_wake =3D 0;
> +        iic->handle_if_event(ii);
> +    }
> +}
> +
> +static void ipmi_kcs_handle_event(IPMIInterface *ii)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIKCS *ik =3D iic->get_backend_data(ii);
> +
> +    if (ik->cmd_reg =3D=3D IPMI_KCS_ABORT_STATUS_CMD) {
> +        if (IPMI_KCS_GET_STATE(ik->status_reg) !=3D IPMI_KCS_ERROR_STA=
TE) {
> +            ik->waiting_rsp++; /* Invalidate the message */
> +            ik->outmsg[0] =3D IPMI_KCS_STATUS_ABORTED_ERR;
> +            ik->outlen =3D 1;
> +            ik->outpos =3D 0;
> +            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
> +            SET_OBF();
> +        }
> +        goto out;
> +    }
> +
> +    switch (IPMI_KCS_GET_STATE(ik->status_reg)) {
> +    case IPMI_KCS_IDLE_STATE:
> +        if (ik->cmd_reg =3D=3D IPMI_KCS_WRITE_START_CMD) {
> +            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_WRITE_STATE);
> +            ik->cmd_reg =3D -1;
> +            ik->write_end =3D 0;
> +            ik->inlen =3D 0;
> +            SET_OBF();
> +        }
> +        break;
> +
> +    case IPMI_KCS_READ_STATE:
> +    handle_read:
> +        if (ik->outpos >=3D ik->outlen) {
> +            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_IDLE_STATE);
> +            SET_OBF();
> +        } else if (ik->data_in_reg =3D=3D IPMI_KCS_READ_CMD) {
> +            ik->data_out_reg =3D ik->outmsg[ik->outpos];
> +            ik->outpos++;
> +            SET_OBF();
> +        } else {
> +            ik->outmsg[0] =3D IPMI_KCS_STATUS_BAD_CC_ERR;
> +            ik->outlen =3D 1;
> +            ik->outpos =3D 0;
> +            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
> +            SET_OBF();
> +            goto out;
> +        }
> +        break;
> +
> +    case IPMI_KCS_WRITE_STATE:
> +        if (ik->data_in_reg !=3D -1) {
> +            /*
> +             * Don't worry about input overrun here, that will be
> +             * handled in the BMC.
> +             */
> +            if (ik->inlen < sizeof(ik->inmsg)) {
> +                ik->inmsg[ik->inlen] =3D ik->data_in_reg;
> +            }
> +            ik->inlen++;
> +        }
> +        if (ik->write_end) {
> +            IPMIBmcClass *bk =3D IPMI_BMC_GET_CLASS(ik->bmc);
> +            ik->outlen =3D 0;
> +            ik->write_end =3D 0;
> +            ik->outpos =3D 0;
> +            bk->handle_command(ik->bmc, ik->inmsg, ik->inlen, sizeof(i=
k->inmsg),
> +                               ik->waiting_rsp);
> +            goto out_noibf;
> +        } else if (ik->cmd_reg =3D=3D IPMI_KCS_WRITE_END_CMD) {
> +            ik->cmd_reg =3D -1;
> +            ik->write_end =3D 1;
> +        }
> +        SET_OBF();
> +        break;
> +
> +    case IPMI_KCS_ERROR_STATE:
> +        if (ik->data_in_reg !=3D -1) {
> +            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
> +            ik->data_in_reg =3D IPMI_KCS_READ_CMD;
> +            goto handle_read;
> +        }
> +        break;
> +    }
> +
> +    if (ik->cmd_reg !=3D -1) {
> +        /* Got an invalid command */
> +        ik->outmsg[0] =3D IPMI_KCS_STATUS_BAD_CC_ERR;
> +        ik->outlen =3D 1;
> +        ik->outpos =3D 0;
> +        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
> +    }
> +
> + out:
> +    ik->cmd_reg =3D -1;
> +    ik->data_in_reg =3D -1;
> +    IPMI_KCS_SET_IBF(ik->status_reg, 0);
> + out_noibf:
> +    return;
> +}
> +
> +static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
> +                                unsigned char *rsp, unsigned int rsp_l=
en)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIKCS *ik =3D iic->get_backend_data(ii);
> +
> +    if (ik->waiting_rsp =3D=3D msg_id) {
> +        ik->waiting_rsp++;
> +        if (rsp_len > sizeof(ik->outmsg)) {
> +            ik->outmsg[0] =3D rsp[0];
> +            ik->outmsg[1] =3D rsp[1];
> +            ik->outmsg[2] =3D IPMI_CC_CANNOT_RETURN_REQ_NUM_BYTES;
> +            ik->outlen =3D 3;
> +        } else {
> +            memcpy(ik->outmsg, rsp, rsp_len);
> +            ik->outlen =3D rsp_len;
> +        }
> +        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
> +        ik->data_in_reg =3D IPMI_KCS_READ_CMD;
> +        ipmi_kcs_signal(ik, ii);
> +    }
> +}
> +
> +
> +static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsign=
ed size)
> +{
> +    IPMIInterface *ii =3D opaque;
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIKCS *ik =3D iic->get_backend_data(ii);
> +    uint32_t ret;
> +
> +    switch (addr & 1) {
> +    case 0:
> +        ret =3D ik->data_out_reg;
> +        IPMI_KCS_SET_OBF(ik->status_reg, 0);
> +        if (ik->obf_irq_set) {
> +            ik->obf_irq_set =3D 0;
> +            if (!ik->atn_irq_set) {
> +                ipmi_kcs_lower_irq(ik);
> +            }
> +        }
> +        break;
> +    case 1:
> +        ret =3D ik->status_reg;
> +        if (ik->atn_irq_set) {
> +            ik->atn_irq_set =3D 0;
> +            if (!ik->obf_irq_set) {
> +                ipmi_kcs_lower_irq(ik);
> +            }
> +        }
> +        break;
> +    }
> +    return ret;
> +}
> +
> +static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t =
val,
> +                                  unsigned size)
> +{
> +    IPMIInterface *ii =3D opaque;
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIKCS *ik =3D iic->get_backend_data(ii);
> +
> +    if (IPMI_KCS_GET_IBF(ik->status_reg)) {
> +        return;
> +    }
> +
> +    switch (addr & 1) {
> +    case 0:
> +        ik->data_in_reg =3D val;
> +        break;
> +
> +    case 1:
> +        ik->cmd_reg =3D val;
> +        break;
> +    }
> +    IPMI_KCS_SET_IBF(ik->status_reg, 1);
> +    ipmi_kcs_signal(ik, ii);
> +}
> +
> +const MemoryRegionOps ipmi_kcs_io_ops =3D {
> +    .read =3D ipmi_kcs_ioport_read,
> +    .write =3D ipmi_kcs_ioport_write,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void ipmi_kcs_set_atn(IPMIInterface *ii, int val, int irq)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIKCS *ik =3D iic->get_backend_data(ii);
> +
> +    IPMI_KCS_SET_SMS_ATN(ik->status_reg, val);
> +    if (val) {
> +        if (irq && !ik->atn_irq_set) {
> +            ik->atn_irq_set =3D 1;
> +            if (!ik->obf_irq_set) {
> +                ipmi_kcs_raise_irq(ik);
> +            }
> +        }
> +    } else {
> +        if (ik->atn_irq_set) {
> +            ik->atn_irq_set =3D 0;
> +            if (!ik->obf_irq_set) {
> +                ipmi_kcs_lower_irq(ik);
> +            }
> +        }
> +    }
> +}
> +
> +static void ipmi_kcs_set_irq_enable(IPMIInterface *ii, int val)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIKCS *ik =3D iic->get_backend_data(ii);
> +
> +    ik->irqs_enabled =3D val;
> +}
> +
> +static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIKCS *ik =3D iic->get_backend_data(ii);
> +
> +    ik->io_length =3D 2;
> +    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-k=
cs", 2);
> +}
> +
> +int ipmi_kcs_vmstate_post_load(void *opaque, int version)
> +{
> +    IPMIKCS *ik =3D opaque;
> +
> +    /* Make sure all the values are sane. */
> +    if (ik->outpos >=3D MAX_IPMI_MSG_SIZE || ik->outlen >=3D MAX_IPMI_=
MSG_SIZE ||
> +        ik->outpos >=3D ik->outlen) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "ipmi:kcs: vmstate transfer received bad out val=
ues: %d %d\n",
> +                      ik->outpos, ik->outlen);
> +        ik->outpos =3D 0;
> +        ik->outlen =3D 0;
> +    }
> +
> +    if (ik->inlen >=3D MAX_IPMI_MSG_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "ipmi:kcs: vmstate transfer received bad in valu=
e: %d\n",
> +                      ik->inlen);
> +        ik->inlen =3D 0;
> +    }
> +
> +    return 0;
> +}
> +
> +static bool vmstate_kcs_before_version2(void *opaque, int version)
> +{
> +    return version <=3D 1;
> +}
> +
> +const VMStateDescription vmstate_IPMIKCS =3D {
> +    .name =3D TYPE_IPMI_INTERFACE_PREFIX "kcs",
> +    .version_id =3D 2,
> +    .minimum_version_id =3D 1,
> +    .post_load =3D ipmi_kcs_vmstate_post_load,
> +    .fields      =3D (VMStateField[]) {
> +        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
> +        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
> +        VMSTATE_UNUSED_TEST(vmstate_kcs_before_version2, 1), /* Was us=
e_irq */
> +        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
> +        VMSTATE_UINT32(outpos, IPMIKCS),
> +        VMSTATE_UINT32_V(outlen, IPMIKCS, 2),
> +        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_UINT32_V(inlen, IPMIKCS, 2),
> +        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_BOOL(write_end, IPMIKCS),
> +        VMSTATE_UINT8(status_reg, IPMIKCS),
> +        VMSTATE_UINT8(data_out_reg, IPMIKCS),
> +        VMSTATE_INT16(data_in_reg, IPMIKCS),
> +        VMSTATE_INT16(cmd_reg, IPMIKCS),
> +        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +void ipmi_kcs_get_fwinfo(IPMIKCS *ik, IPMIFwInfo *info)
> +{
> +    info->interface_name =3D "kcs";
> +    info->interface_type =3D IPMI_SMBIOS_KCS;
> +    info->ipmi_spec_major_revision =3D 2;
> +    info->ipmi_spec_minor_revision =3D 0;
> +    info->base_address =3D ik->io_base;
> +    info->i2c_slave_address =3D ik->bmc->slave_addr;
> +    info->register_length =3D ik->io_length;
> +    info->register_spacing =3D 1;
> +    info->memspace =3D IPMI_MEMSPACE_IO;
> +    info->irq_type =3D IPMI_LEVEL_IRQ;
> +}
> +
> +void ipmi_kcs_class_init(IPMIInterfaceClass *iic)
> +{
> +    iic->init =3D ipmi_kcs_init;
> +    iic->set_atn =3D ipmi_kcs_set_atn;
> +    iic->handle_rsp =3D ipmi_kcs_handle_rsp;
> +    iic->handle_if_event =3D ipmi_kcs_handle_event;
> +    iic->set_irq_enable =3D ipmi_kcs_set_irq_enable;
> +}
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index 374b2a0709..8e32774f85 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -1,7 +1,7 @@
>  /*
>   * QEMU ISA IPMI KCS emulation
>   *
> - * Copyright (c) 2015 Corey Minyard, MontaVista Software, LLC
> + * Copyright (c) 2015,2017 Corey Minyard, MontaVista Software, LLC
>   *
>   * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
>   * of this software and associated documentation files (the "Software"=
), to deal
> @@ -26,338 +26,12 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
> -#include "hw/ipmi/ipmi.h"
>  #include "hw/irq.h"
> +#include "hw/ipmi/ipmi_kcs.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
> =20
> -#define IPMI_KCS_OBF_BIT        0
> -#define IPMI_KCS_IBF_BIT        1
> -#define IPMI_KCS_SMS_ATN_BIT    2
> -#define IPMI_KCS_CD_BIT         3
> -
> -#define IPMI_KCS_OBF_MASK          (1 << IPMI_KCS_OBF_BIT)
> -#define IPMI_KCS_GET_OBF(d)        (((d) >> IPMI_KCS_OBF_BIT) & 0x1)
> -#define IPMI_KCS_SET_OBF(d, v)     (d) =3D (((d) & ~IPMI_KCS_OBF_MASK)=
 | \
> -                                       (((v) & 1) << IPMI_KCS_OBF_BIT)=
)
> -#define IPMI_KCS_IBF_MASK          (1 << IPMI_KCS_IBF_BIT)
> -#define IPMI_KCS_GET_IBF(d)        (((d) >> IPMI_KCS_IBF_BIT) & 0x1)
> -#define IPMI_KCS_SET_IBF(d, v)     (d) =3D (((d) & ~IPMI_KCS_IBF_MASK)=
 | \
> -                                       (((v) & 1) << IPMI_KCS_IBF_BIT)=
)
> -#define IPMI_KCS_SMS_ATN_MASK      (1 << IPMI_KCS_SMS_ATN_BIT)
> -#define IPMI_KCS_GET_SMS_ATN(d)    (((d) >> IPMI_KCS_SMS_ATN_BIT) & 0x=
1)
> -#define IPMI_KCS_SET_SMS_ATN(d, v) (d) =3D (((d) & ~IPMI_KCS_SMS_ATN_M=
ASK) | \
> -                                       (((v) & 1) << IPMI_KCS_SMS_ATN_=
BIT))
> -#define IPMI_KCS_CD_MASK           (1 << IPMI_KCS_CD_BIT)
> -#define IPMI_KCS_GET_CD(d)         (((d) >> IPMI_KCS_CD_BIT) & 0x1)
> -#define IPMI_KCS_SET_CD(d, v)      (d) =3D (((d) & ~IPMI_KCS_CD_MASK) =
| \
> -                                       (((v) & 1) << IPMI_KCS_CD_BIT))
> -
> -#define IPMI_KCS_IDLE_STATE        0
> -#define IPMI_KCS_READ_STATE        1
> -#define IPMI_KCS_WRITE_STATE       2
> -#define IPMI_KCS_ERROR_STATE       3
> -
> -#define IPMI_KCS_GET_STATE(d)    (((d) >> 6) & 0x3)
> -#define IPMI_KCS_SET_STATE(d, v) ((d) =3D ((d) & ~0xc0) | (((v) & 0x3)=
 << 6))
> -
> -#define IPMI_KCS_ABORT_STATUS_CMD       0x60
> -#define IPMI_KCS_WRITE_START_CMD        0x61
> -#define IPMI_KCS_WRITE_END_CMD          0x62
> -#define IPMI_KCS_READ_CMD               0x68
> -
> -#define IPMI_KCS_STATUS_NO_ERR          0x00
> -#define IPMI_KCS_STATUS_ABORTED_ERR     0x01
> -#define IPMI_KCS_STATUS_BAD_CC_ERR      0x02
> -#define IPMI_KCS_STATUS_LENGTH_ERR      0x06
> -
> -typedef struct IPMIKCS {
> -    IPMIBmc *bmc;
> -
> -    bool do_wake;
> -
> -    qemu_irq irq;
> -
> -    uint32_t io_base;
> -    unsigned long io_length;
> -    MemoryRegion io;
> -
> -    bool obf_irq_set;
> -    bool atn_irq_set;
> -    bool use_irq;
> -    bool irqs_enabled;
> -
> -    uint8_t outmsg[MAX_IPMI_MSG_SIZE];
> -    uint32_t outpos;
> -    uint32_t outlen;
> -
> -    uint8_t inmsg[MAX_IPMI_MSG_SIZE];
> -    uint32_t inlen;
> -    bool write_end;
> -
> -    uint8_t status_reg;
> -    uint8_t data_out_reg;
> -
> -    int16_t data_in_reg; /* -1 means not written */
> -    int16_t cmd_reg;
> -
> -    /*
> -     * This is a response number that we send with the command to make
> -     * sure that the response matches the command.
> -     */
> -    uint8_t waiting_rsp;
> -} IPMIKCS;
> -
> -#define SET_OBF() \
> -    do {                                                              =
        \
> -        IPMI_KCS_SET_OBF(ik->status_reg, 1);                          =
        \
> -        if (ik->use_irq && ik->irqs_enabled && !ik->obf_irq_set) {    =
        \
> -            ik->obf_irq_set =3D 1;                                    =
          \
> -            if (!ik->atn_irq_set) {                                   =
        \
> -                qemu_irq_raise(ik->irq);                              =
        \
> -            }                                                         =
        \
> -        }                                                             =
        \
> -    } while (0)
> -
> -static void ipmi_kcs_signal(IPMIKCS *ik, IPMIInterface *ii)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -
> -    ik->do_wake =3D 1;
> -    while (ik->do_wake) {
> -        ik->do_wake =3D 0;
> -        iic->handle_if_event(ii);
> -    }
> -}
> -
> -static void ipmi_kcs_handle_event(IPMIInterface *ii)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIKCS *ik =3D iic->get_backend_data(ii);
> -
> -    if (ik->cmd_reg =3D=3D IPMI_KCS_ABORT_STATUS_CMD) {
> -        if (IPMI_KCS_GET_STATE(ik->status_reg) !=3D IPMI_KCS_ERROR_STA=
TE) {
> -            ik->waiting_rsp++; /* Invalidate the message */
> -            ik->outmsg[0] =3D IPMI_KCS_STATUS_ABORTED_ERR;
> -            ik->outlen =3D 1;
> -            ik->outpos =3D 0;
> -            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
> -            SET_OBF();
> -        }
> -        goto out;
> -    }
> -
> -    switch (IPMI_KCS_GET_STATE(ik->status_reg)) {
> -    case IPMI_KCS_IDLE_STATE:
> -        if (ik->cmd_reg =3D=3D IPMI_KCS_WRITE_START_CMD) {
> -            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_WRITE_STATE);
> -            ik->cmd_reg =3D -1;
> -            ik->write_end =3D 0;
> -            ik->inlen =3D 0;
> -            SET_OBF();
> -        }
> -        break;
> -
> -    case IPMI_KCS_READ_STATE:
> -    handle_read:
> -        if (ik->outpos >=3D ik->outlen) {
> -            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_IDLE_STATE);
> -            SET_OBF();
> -        } else if (ik->data_in_reg =3D=3D IPMI_KCS_READ_CMD) {
> -            ik->data_out_reg =3D ik->outmsg[ik->outpos];
> -            ik->outpos++;
> -            SET_OBF();
> -        } else {
> -            ik->outmsg[0] =3D IPMI_KCS_STATUS_BAD_CC_ERR;
> -            ik->outlen =3D 1;
> -            ik->outpos =3D 0;
> -            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
> -            SET_OBF();
> -            goto out;
> -        }
> -        break;
> -
> -    case IPMI_KCS_WRITE_STATE:
> -        if (ik->data_in_reg !=3D -1) {
> -            /*
> -             * Don't worry about input overrun here, that will be
> -             * handled in the BMC.
> -             */
> -            if (ik->inlen < sizeof(ik->inmsg)) {
> -                ik->inmsg[ik->inlen] =3D ik->data_in_reg;
> -            }
> -            ik->inlen++;
> -        }
> -        if (ik->write_end) {
> -            IPMIBmcClass *bk =3D IPMI_BMC_GET_CLASS(ik->bmc);
> -            ik->outlen =3D 0;
> -            ik->write_end =3D 0;
> -            ik->outpos =3D 0;
> -            bk->handle_command(ik->bmc, ik->inmsg, ik->inlen, sizeof(i=
k->inmsg),
> -                               ik->waiting_rsp);
> -            goto out_noibf;
> -        } else if (ik->cmd_reg =3D=3D IPMI_KCS_WRITE_END_CMD) {
> -            ik->cmd_reg =3D -1;
> -            ik->write_end =3D 1;
> -        }
> -        SET_OBF();
> -        break;
> -
> -    case IPMI_KCS_ERROR_STATE:
> -        if (ik->data_in_reg !=3D -1) {
> -            IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
> -            ik->data_in_reg =3D IPMI_KCS_READ_CMD;
> -            goto handle_read;
> -        }
> -        break;
> -    }
> -
> -    if (ik->cmd_reg !=3D -1) {
> -        /* Got an invalid command */
> -        ik->outmsg[0] =3D IPMI_KCS_STATUS_BAD_CC_ERR;
> -        ik->outlen =3D 1;
> -        ik->outpos =3D 0;
> -        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_ERROR_STATE);
> -    }
> -
> - out:
> -    ik->cmd_reg =3D -1;
> -    ik->data_in_reg =3D -1;
> -    IPMI_KCS_SET_IBF(ik->status_reg, 0);
> - out_noibf:
> -    return;
> -}
> -
> -static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
> -                                unsigned char *rsp, unsigned int rsp_l=
en)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIKCS *ik =3D iic->get_backend_data(ii);
> -
> -    if (ik->waiting_rsp =3D=3D msg_id) {
> -        ik->waiting_rsp++;
> -        if (rsp_len > sizeof(ik->outmsg)) {
> -            ik->outmsg[0] =3D rsp[0];
> -            ik->outmsg[1] =3D rsp[1];
> -            ik->outmsg[2] =3D IPMI_CC_CANNOT_RETURN_REQ_NUM_BYTES;
> -            ik->outlen =3D 3;
> -        } else {
> -            memcpy(ik->outmsg, rsp, rsp_len);
> -            ik->outlen =3D rsp_len;
> -        }
> -        IPMI_KCS_SET_STATE(ik->status_reg, IPMI_KCS_READ_STATE);
> -        ik->data_in_reg =3D IPMI_KCS_READ_CMD;
> -        ipmi_kcs_signal(ik, ii);
> -    }
> -}
> -
> -
> -static uint64_t ipmi_kcs_ioport_read(void *opaque, hwaddr addr, unsign=
ed size)
> -{
> -    IPMIInterface *ii =3D opaque;
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIKCS *ik =3D iic->get_backend_data(ii);
> -    uint32_t ret;
> -
> -    switch (addr & 1) {
> -    case 0:
> -        ret =3D ik->data_out_reg;
> -        IPMI_KCS_SET_OBF(ik->status_reg, 0);
> -        if (ik->obf_irq_set) {
> -            ik->obf_irq_set =3D 0;
> -            if (!ik->atn_irq_set) {
> -                qemu_irq_lower(ik->irq);
> -            }
> -        }
> -        break;
> -    case 1:
> -        ret =3D ik->status_reg;
> -        if (ik->atn_irq_set) {
> -            ik->atn_irq_set =3D 0;
> -            if (!ik->obf_irq_set) {
> -                qemu_irq_lower(ik->irq);
> -            }
> -        }
> -        break;
> -    }
> -    return ret;
> -}
> -
> -static void ipmi_kcs_ioport_write(void *opaque, hwaddr addr, uint64_t =
val,
> -                                  unsigned size)
> -{
> -    IPMIInterface *ii =3D opaque;
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIKCS *ik =3D iic->get_backend_data(ii);
> -
> -    if (IPMI_KCS_GET_IBF(ik->status_reg)) {
> -        return;
> -    }
> -
> -    switch (addr & 1) {
> -    case 0:
> -        ik->data_in_reg =3D val;
> -        break;
> -
> -    case 1:
> -        ik->cmd_reg =3D val;
> -        break;
> -    }
> -    IPMI_KCS_SET_IBF(ik->status_reg, 1);
> -    ipmi_kcs_signal(ik, ii);
> -}
> -
> -const MemoryRegionOps ipmi_kcs_io_ops =3D {
> -    .read =3D ipmi_kcs_ioport_read,
> -    .write =3D ipmi_kcs_ioport_write,
> -    .impl =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 1,
> -    },
> -    .endianness =3D DEVICE_LITTLE_ENDIAN,
> -};
> -
> -static void ipmi_kcs_set_atn(IPMIInterface *ii, int val, int irq)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIKCS *ik =3D iic->get_backend_data(ii);
> -
> -    IPMI_KCS_SET_SMS_ATN(ik->status_reg, val);
> -    if (val) {
> -        if (irq && !ik->atn_irq_set && ik->use_irq && ik->irqs_enabled=
) {
> -            ik->atn_irq_set =3D 1;
> -            if (!ik->obf_irq_set) {
> -                qemu_irq_raise(ik->irq);
> -            }
> -        }
> -    } else {
> -        if (ik->atn_irq_set) {
> -            ik->atn_irq_set =3D 0;
> -            if (!ik->obf_irq_set) {
> -                qemu_irq_lower(ik->irq);
> -            }
> -        }
> -    }
> -}
> -
> -static void ipmi_kcs_set_irq_enable(IPMIInterface *ii, int val)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIKCS *ik =3D iic->get_backend_data(ii);
> -
> -    ik->irqs_enabled =3D val;
> -}
> -
> -static void ipmi_kcs_init(IPMIInterface *ii, Error **errp)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIKCS *ik =3D iic->get_backend_data(ii);
> -
> -    ik->io_length =3D 2;
> -    memory_region_init_io(&ik->io, NULL, &ipmi_kcs_io_ops, ii, "ipmi-k=
cs", 2);
> -}
> -
>  #define TYPE_ISA_IPMI_KCS "isa-ipmi-kcs"
>  #define ISA_IPMI_KCS(obj) OBJECT_CHECK(ISAIPMIKCSDevice, (obj), \
>                                         TYPE_ISA_IPMI_KCS)
> @@ -365,36 +39,32 @@ static void ipmi_kcs_init(IPMIInterface *ii, Error=
 **errp)
>  typedef struct ISAIPMIKCSDevice {
>      ISADevice dev;
>      int32_t isairq;
> +    qemu_irq irq;
>      IPMIKCS kcs;
>      uint32_t uuid;
>  } ISAIPMIKCSDevice;
> =20
> -static void ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *info)
> +static void isa_ipmi_kcs_get_fwinfo(IPMIInterface *ii, IPMIFwInfo *inf=
o)
>  {
>      ISAIPMIKCSDevice *iik =3D ISA_IPMI_KCS(ii);
> =20
> -    info->interface_name =3D "kcs";
> -    info->interface_type =3D IPMI_SMBIOS_KCS;
> -    info->ipmi_spec_major_revision =3D 2;
> -    info->ipmi_spec_minor_revision =3D 0;
> -    info->base_address =3D iik->kcs.io_base;
> -    info->i2c_slave_address =3D iik->kcs.bmc->slave_addr;
> -    info->register_length =3D iik->kcs.io_length;
> -    info->register_spacing =3D 1;
> -    info->memspace =3D IPMI_MEMSPACE_IO;
> -    info->irq_type =3D IPMI_LEVEL_IRQ;
> +    ipmi_kcs_get_fwinfo(&iik->kcs, info);
>      info->interrupt_number =3D iik->isairq;
>      info->uuid =3D iik->uuid;
>  }
> =20
> -static void ipmi_kcs_class_init(IPMIInterfaceClass *iic)
> +static void isa_ipmi_kcs_raise_irq(IPMIKCS *ik)
>  {
> -    iic->init =3D ipmi_kcs_init;
> -    iic->set_atn =3D ipmi_kcs_set_atn;
> -    iic->handle_rsp =3D ipmi_kcs_handle_rsp;
> -    iic->handle_if_event =3D ipmi_kcs_handle_event;
> -    iic->set_irq_enable =3D ipmi_kcs_set_irq_enable;
> -    iic->get_fwinfo =3D ipmi_kcs_get_fwinfo;
> +    ISAIPMIKCSDevice *iik =3D ik->opaque;
> +
> +    qemu_irq_raise(iik->irq);
> +}
> +
> +static void isa_ipmi_kcs_lower_irq(IPMIKCS *ik)
> +{
> +    ISAIPMIKCSDevice *iik =3D ik->opaque;
> +
> +    qemu_irq_lower(iik->irq);
>  }
> =20
>  static void ipmi_isa_realize(DeviceState *dev, Error **errp)
> @@ -412,14 +82,17 @@ static void ipmi_isa_realize(DeviceState *dev, Err=
or **errp)
>      iik->uuid =3D ipmi_next_uuid();
> =20
>      iik->kcs.bmc->intf =3D ii;
> +    iik->kcs.opaque =3D iik;
> =20
>      iic->init(ii, errp);
>      if (*errp)
>          return;
> =20
>      if (iik->isairq > 0) {
> -        isa_init_irq(isadev, &iik->kcs.irq, iik->isairq);
> +        isa_init_irq(isadev, &iik->irq, iik->isairq);
>          iik->kcs.use_irq =3D 1;
> +        iik->kcs.raise_irq =3D isa_ipmi_kcs_raise_irq;
> +        iik->kcs.lower_irq =3D isa_ipmi_kcs_lower_irq;
>      }
> =20
>      qdev_set_legacy_instance_id(dev, iik->kcs.io_base, iik->kcs.io_len=
gth);
> @@ -427,60 +100,11 @@ static void ipmi_isa_realize(DeviceState *dev, Er=
ror **errp)
>      isa_register_ioport(isadev, &iik->kcs.io, iik->kcs.io_base);
>  }
> =20
> -static int ipmi_kcs_vmstate_post_load(void *opaque, int version)
> -{
> -    IPMIKCS *ik =3D opaque;
> -
> -    /* Make sure all the values are sane. */
> -    if (ik->outpos >=3D MAX_IPMI_MSG_SIZE || ik->outlen >=3D MAX_IPMI_=
MSG_SIZE ||
> -        ik->outpos >=3D ik->outlen) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "ipmi:kcs: vmstate transfer received bad out val=
ues: %d %d\n",
> -                      ik->outpos, ik->outlen);
> -        ik->outpos =3D 0;
> -        ik->outlen =3D 0;
> -    }
> -
> -    if (ik->inlen >=3D MAX_IPMI_MSG_SIZE) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "ipmi:kcs: vmstate transfer received bad in valu=
e: %d\n",
> -                      ik->inlen);
> -        ik->inlen =3D 0;
> -    }
> -
> -    return 0;
> -}
> -
>  static bool vmstate_kcs_before_version2(void *opaque, int version)
>  {
>      return version <=3D 1;
>  }
> =20
> -static const VMStateDescription vmstate_IPMIKCS =3D {
> -    .name =3D TYPE_IPMI_INTERFACE_PREFIX "kcs",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 1,
> -    .post_load =3D ipmi_kcs_vmstate_post_load,
> -    .fields      =3D (VMStateField[]) {
> -        VMSTATE_BOOL(obf_irq_set, IPMIKCS),
> -        VMSTATE_BOOL(atn_irq_set, IPMIKCS),
> -        VMSTATE_UNUSED_TEST(vmstate_kcs_before_version2, 1), /* Was us=
e_irq */
> -        VMSTATE_BOOL(irqs_enabled, IPMIKCS),
> -        VMSTATE_UINT32(outpos, IPMIKCS),
> -        VMSTATE_UINT32_V(outlen, IPMIKCS, 2),
> -        VMSTATE_UINT8_ARRAY(outmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> -        VMSTATE_UINT32_V(inlen, IPMIKCS, 2),
> -        VMSTATE_UINT8_ARRAY(inmsg, IPMIKCS, MAX_IPMI_MSG_SIZE),
> -        VMSTATE_BOOL(write_end, IPMIKCS),
> -        VMSTATE_UINT8(status_reg, IPMIKCS),
> -        VMSTATE_UINT8(data_out_reg, IPMIKCS),
> -        VMSTATE_INT16(data_in_reg, IPMIKCS),
> -        VMSTATE_INT16(cmd_reg, IPMIKCS),
> -        VMSTATE_UINT8(waiting_rsp, IPMIKCS),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
>  static const VMStateDescription vmstate_ISAIPMIKCSDevice =3D {
>      .name =3D TYPE_IPMI_INTERFACE,
>      .version_id =3D 2,
> @@ -531,6 +155,7 @@ static void isa_ipmi_kcs_class_init(ObjectClass *oc=
, void *data)
> =20
>      iic->get_backend_data =3D isa_ipmi_kcs_get_backend_data;
>      ipmi_kcs_class_init(iic);
> +    iic->get_fwinfo =3D isa_ipmi_kcs_get_fwinfo;
>  }
> =20
>  static const TypeInfo isa_ipmi_kcs_info =3D {
> diff --git a/include/hw/ipmi/ipmi_kcs.h b/include/hw/ipmi/ipmi_kcs.h
> new file mode 100644
> index 0000000000..91d76d08f4
> --- /dev/null
> +++ b/include/hw/ipmi/ipmi_kcs.h
> @@ -0,0 +1,75 @@
> +/*
> + * QEMU IPMI KCS emulation
> + *
> + * Copyright (c) 2015,2017 Corey Minyard, MontaVista Software, LLC
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#ifndef HW_IPMI_KCS_H
> +#define HW_IPMI_KCS_H
> +
> +#include "hw/ipmi/ipmi.h"
> +
> +typedef struct IPMIKCS {
> +    IPMIBmc *bmc;
> +
> +    bool do_wake;
> +
> +    bool obf_irq_set;
> +    bool atn_irq_set;
> +    bool irqs_enabled;
> +
> +    uint8_t outmsg[MAX_IPMI_MSG_SIZE];
> +    uint32_t outpos;
> +    uint32_t outlen;
> +
> +    uint8_t inmsg[MAX_IPMI_MSG_SIZE];
> +    uint32_t inlen;
> +    bool write_end;
> +
> +    uint8_t status_reg;
> +    uint8_t data_out_reg;
> +
> +    int16_t data_in_reg; /* -1 means not written */
> +    int16_t cmd_reg;
> +
> +    /*
> +     * This is a response number that we send with the command to make
> +     * sure that the response matches the command.
> +     */
> +    uint8_t waiting_rsp;
> +
> +    uint32_t io_base;
> +    unsigned long io_length;
> +    MemoryRegion io;
> +
> +    void (*raise_irq)(struct IPMIKCS *ik);
> +    void (*lower_irq)(struct IPMIKCS *ik);
> +    void *opaque;
> +
> +    bool use_irq;
> +} IPMIKCS;
> +
> +void ipmi_kcs_get_fwinfo(IPMIKCS *ik, IPMIFwInfo *info);
> +void ipmi_kcs_class_init(IPMIInterfaceClass *iic);
> +extern const VMStateDescription vmstate_IPMIKCS;
> +int ipmi_kcs_vmstate_post_load(void *opaque, int version);
> +
> +#endif /* HW_IPMI_KCS_H */
>=20

