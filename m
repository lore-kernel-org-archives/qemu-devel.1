Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD59BC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7432122DA7
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7432122DA7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MeN-0001vG-Hq
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34347)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0McT-0007s7-6a
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0McP-0002te-EF
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:09:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36676)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0McP-0002tL-2l
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 05:09:25 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD52687638
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 09:09:23 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id j10so926987wrb.16
 for <qemu-devel@nongnu.org>; Wed, 21 Aug 2019 02:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jE/X1RF7jbp4FHFXGHAykxsOTRnbaVjDvaBEU63ADK0=;
 b=eI3Ni0i+U0TKryEVeyyGbfgpGuMS8ZvCba268FkLiCsEn5oyH8iDFeV8NPc6ljOGis
 Lqhk675lAcSUleAMbG2atIkmC0qPjUK9ngTb89GiETucWO7MFV7zhQhSVWPT/PM+Zrue
 LeRRNRERa1irQK9PgfNHPO2NQsUxmgBZBXyyds7IikkqPoKJODmMNaBPt2QgKTvPWWOA
 cv5D29DI5FfNYVb3TtekjeLAtdLz0dXJcEye39P4FvUQI7bKfJbm3VBhqU88KdYKFP4s
 gluPUhDG9nTL7Xs+xegp+8gDRa7fRb9C1h/yKrIEbzM3C0TtXefQ03k+njmdKWEdaAZX
 ting==
X-Gm-Message-State: APjAAAWIOgHmUEghLVOnBIzgJeFV/rVNM7f9X9fgtaKszKPKIwPleL7M
 oNHf0dB9deRfCcsomzTaEdNnmHNftN0una0ZM4pocctbvXBVF5mhrgDseIGfy9t/90PHFnDObym
 D0PrmYsuvbPMuSBI=
X-Received: by 2002:a05:600c:54c:: with SMTP id
 k12mr4787067wmc.117.1566378562119; 
 Wed, 21 Aug 2019 02:09:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzeEIhKznD9NdW1dt/9nL0cwY3r8eGGHJb0UdVV/H4rXiISogzMM32VdxiL/Oc1lBy12IWMdg==
X-Received: by 2002:a05:600c:54c:: with SMTP id
 k12mr4787026wmc.117.1566378561662; 
 Wed, 21 Aug 2019 02:09:21 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id t14sm14053479wrs.58.2019.08.21.02.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Aug 2019 02:09:21 -0700 (PDT)
To: minyard@acm.org, QEMU Developers <qemu-devel@nongnu.org>
References: <20190819201705.31633-1-minyard@acm.org>
 <20190819201705.31633-9-minyard@acm.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a9ebdb44-f469-3bb6-82bc-b0ddfa4f7000@redhat.com>
Date: Wed, 21 Aug 2019 11:09:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190819201705.31633-9-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 08/15] ipmi: Split out BT-specific code
 from ISA BT code
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
> Get ready for PCI and other BT interfaces.
>=20
> No functional changes, just split the code into generic BT code
> and ISA-specific BT code.
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>  hw/ipmi/Makefile.objs     |   2 +-
>  hw/ipmi/ipmi_bt.c         | 426 ++++++++++++++++++++++++++++++++++++
>  hw/ipmi/isa_ipmi_bt.c     | 441 ++------------------------------------
>  include/hw/ipmi/ipmi_bt.h |  72 +++++++
>  4 files changed, 520 insertions(+), 421 deletions(-)
>  create mode 100644 hw/ipmi/ipmi_bt.c
>  create mode 100644 include/hw/ipmi/ipmi_bt.h
>=20
> diff --git a/hw/ipmi/Makefile.objs b/hw/ipmi/Makefile.objs
> index 6835d2f64a..4ffa45a66c 100644
> --- a/hw/ipmi/Makefile.objs
> +++ b/hw/ipmi/Makefile.objs
> @@ -1,4 +1,4 @@
> -common-obj-$(CONFIG_IPMI) +=3D ipmi.o ipmi_kcs.o
> +common-obj-$(CONFIG_IPMI) +=3D ipmi.o ipmi_kcs.o ipmi_bt.o
>  common-obj-$(CONFIG_IPMI_LOCAL) +=3D ipmi_bmc_sim.o
>  common-obj-$(CONFIG_IPMI_EXTERN) +=3D ipmi_bmc_extern.o
>  common-obj-$(CONFIG_ISA_IPMI_KCS) +=3D isa_ipmi_kcs.o
> diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
> new file mode 100644
> index 0000000000..e6765ca4f8
> --- /dev/null
> +++ b/hw/ipmi/ipmi_bt.c
> @@ -0,0 +1,426 @@
> +/*
> + * QEMU IPMI BT emulation
> + *
> + * Copyright (c) 2015 Corey Minyard, MontaVista Software, LLC
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
> +#include "hw/ipmi/ipmi_bt.h"
> +
> +/* Control register */
> +#define IPMI_BT_CLR_WR_BIT         0
> +#define IPMI_BT_CLR_RD_BIT         1
> +#define IPMI_BT_H2B_ATN_BIT        2
> +#define IPMI_BT_B2H_ATN_BIT        3
> +#define IPMI_BT_SMS_ATN_BIT        4
> +#define IPMI_BT_HBUSY_BIT          6
> +#define IPMI_BT_BBUSY_BIT          7
> +
> +#define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)
> +
> +#define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)
> +
> +#define IPMI_BT_GET_H2B_ATN(d)     (((d) >> IPMI_BT_H2B_ATN_BIT) & 0x1=
)
> +
> +#define IPMI_BT_B2H_ATN_MASK       (1 << IPMI_BT_B2H_ATN_BIT)
> +#define IPMI_BT_GET_B2H_ATN(d)     (((d) >> IPMI_BT_B2H_ATN_BIT) & 0x1=
)
> +#define IPMI_BT_SET_B2H_ATN(d, v)  ((d) =3D (((d) & ~IPMI_BT_B2H_ATN_M=
ASK) | \
> +                                        (!!(v) << IPMI_BT_B2H_ATN_BIT)=
))
> +
> +#define IPMI_BT_SMS_ATN_MASK       (1 << IPMI_BT_SMS_ATN_BIT)
> +#define IPMI_BT_GET_SMS_ATN(d)     (((d) >> IPMI_BT_SMS_ATN_BIT) & 0x1=
)
> +#define IPMI_BT_SET_SMS_ATN(d, v)  ((d) =3D (((d) & ~IPMI_BT_SMS_ATN_M=
ASK) | \
> +                                        (!!(v) << IPMI_BT_SMS_ATN_BIT)=
))
> +
> +#define IPMI_BT_HBUSY_MASK         (1 << IPMI_BT_HBUSY_BIT)
> +#define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
> +#define IPMI_BT_SET_HBUSY(d, v)    ((d) =3D (((d) & ~IPMI_BT_HBUSY_MAS=
K) | \
> +                                       (!!(v) << IPMI_BT_HBUSY_BIT)))
> +
> +#define IPMI_BT_BBUSY_MASK         (1 << IPMI_BT_BBUSY_BIT)
> +#define IPMI_BT_SET_BBUSY(d, v)    ((d) =3D (((d) & ~IPMI_BT_BBUSY_MAS=
K) | \
> +                                       (!!(v) << IPMI_BT_BBUSY_BIT)))
> +
> +
> +/* Mask register */
> +#define IPMI_BT_B2H_IRQ_EN_BIT     0
> +#define IPMI_BT_B2H_IRQ_BIT        1
> +
> +#define IPMI_BT_B2H_IRQ_EN_MASK      (1 << IPMI_BT_B2H_IRQ_EN_BIT)
> +#define IPMI_BT_GET_B2H_IRQ_EN(d)    (((d) >> IPMI_BT_B2H_IRQ_EN_BIT) =
& 0x1)
> +#define IPMI_BT_SET_B2H_IRQ_EN(d, v) ((d) =3D (((d) & ~IPMI_BT_B2H_IRQ=
_EN_MASK) |\
> +                                        (!!(v) << IPMI_BT_B2H_IRQ_EN_B=
IT)))
> +
> +#define IPMI_BT_B2H_IRQ_MASK         (1 << IPMI_BT_B2H_IRQ_BIT)
> +#define IPMI_BT_GET_B2H_IRQ(d)       (((d) >> IPMI_BT_B2H_IRQ_BIT) & 0=
x1)
> +#define IPMI_BT_SET_B2H_IRQ(d, v)    ((d) =3D (((d) & ~IPMI_BT_B2H_IRQ=
_MASK) | \
> +                                        (!!(v) << IPMI_BT_B2H_IRQ_BIT)=
))
> +
> +#define IPMI_CMD_GET_BT_INTF_CAP        0x36
> +
> +static void ipmi_bt_raise_irq(IPMIBT *ib)
> +{
> +    if (ib->use_irq && ib->irqs_enabled && ib->raise_irq) {
> +        ib->raise_irq(ib);
> +    }
> +}
> +
> +static void ipmi_bt_lower_irq(IPMIBT *ib)
> +{
> +    if (ib->lower_irq) {
> +        ib->lower_irq(ib);
> +    }
> +}
> +
> +static void ipmi_bt_handle_event(IPMIInterface *ii)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIBT *ib =3D iic->get_backend_data(ii);
> +
> +    if (ib->inlen < 4) {
> +        goto out;
> +    }
> +    /* Note that overruns are handled by handle_command */
> +    if (ib->inmsg[0] !=3D (ib->inlen - 1)) {
> +        /* Length mismatch, just ignore. */
> +        IPMI_BT_SET_BBUSY(ib->control_reg, 1);
> +        ib->inlen =3D 0;
> +        goto out;
> +    }
> +    if ((ib->inmsg[1] =3D=3D (IPMI_NETFN_APP << 2)) &&
> +                        (ib->inmsg[3] =3D=3D IPMI_CMD_GET_BT_INTF_CAP)=
) {
> +        /* We handle this one ourselves. */
> +        ib->outmsg[0] =3D 9;
> +        ib->outmsg[1] =3D ib->inmsg[1] | 0x04;
> +        ib->outmsg[2] =3D ib->inmsg[2];
> +        ib->outmsg[3] =3D ib->inmsg[3];
> +        ib->outmsg[4] =3D 0;
> +        ib->outmsg[5] =3D 1; /* Only support 1 outstanding request. */
> +        if (sizeof(ib->inmsg) > 0xff) { /* Input buffer size */
> +            ib->outmsg[6] =3D 0xff;
> +        } else {
> +            ib->outmsg[6] =3D (unsigned char) sizeof(ib->inmsg);
> +        }
> +        if (sizeof(ib->outmsg) > 0xff) { /* Output buffer size */
> +            ib->outmsg[7] =3D 0xff;
> +        } else {
> +            ib->outmsg[7] =3D (unsigned char) sizeof(ib->outmsg);
> +        }
> +        ib->outmsg[8] =3D 10; /* Max request to response time */
> +        ib->outmsg[9] =3D 0; /* Don't recommend retries */
> +        ib->outlen =3D 10;
> +        IPMI_BT_SET_BBUSY(ib->control_reg, 0);
> +        IPMI_BT_SET_B2H_ATN(ib->control_reg, 1);
> +        if (!IPMI_BT_GET_B2H_IRQ(ib->mask_reg) &&
> +                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
> +            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
> +            ipmi_bt_raise_irq(ib);
> +        }
> +        goto out;
> +    }
> +    ib->waiting_seq =3D ib->inmsg[2];
> +    ib->inmsg[2] =3D ib->inmsg[1];
> +    {
> +        IPMIBmcClass *bk =3D IPMI_BMC_GET_CLASS(ib->bmc);
> +        bk->handle_command(ib->bmc, ib->inmsg + 2, ib->inlen - 2,
> +                           sizeof(ib->inmsg), ib->waiting_rsp);
> +    }
> + out:
> +    return;
> +}
> +
> +static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
> +                                unsigned char *rsp, unsigned int rsp_l=
en)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIBT *ib =3D iic->get_backend_data(ii);
> +
> +    if (ib->waiting_rsp =3D=3D msg_id) {
> +        ib->waiting_rsp++;
> +        if (rsp_len > (sizeof(ib->outmsg) - 2)) {
> +            ib->outmsg[0] =3D 4;
> +            ib->outmsg[1] =3D rsp[0];
> +            ib->outmsg[2] =3D ib->waiting_seq;
> +            ib->outmsg[3] =3D rsp[1];
> +            ib->outmsg[4] =3D IPMI_CC_CANNOT_RETURN_REQ_NUM_BYTES;
> +            ib->outlen =3D 5;
> +        } else {
> +            ib->outmsg[0] =3D rsp_len + 1;
> +            ib->outmsg[1] =3D rsp[0];
> +            ib->outmsg[2] =3D ib->waiting_seq;
> +            memcpy(ib->outmsg + 3, rsp + 1, rsp_len - 1);
> +            ib->outlen =3D rsp_len + 2;
> +        }
> +        IPMI_BT_SET_BBUSY(ib->control_reg, 0);
> +        IPMI_BT_SET_B2H_ATN(ib->control_reg, 1);
> +        if (!IPMI_BT_GET_B2H_IRQ(ib->mask_reg) &&
> +                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
> +            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
> +            ipmi_bt_raise_irq(ib);
> +        }
> +    }
> +}
> +
> +
> +static uint64_t ipmi_bt_ioport_read(void *opaque, hwaddr addr, unsigne=
d size)
> +{
> +    IPMIInterface *ii =3D opaque;
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIBT *ib =3D iic->get_backend_data(ii);
> +    uint32_t ret =3D 0xff;
> +
> +    switch (addr & 3) {
> +    case 0:
> +        ret =3D ib->control_reg;
> +        break;
> +    case 1:
> +        if (ib->outpos < ib->outlen) {
> +            ret =3D ib->outmsg[ib->outpos];
> +            ib->outpos++;
> +            if (ib->outpos =3D=3D ib->outlen) {
> +                ib->outpos =3D 0;
> +                ib->outlen =3D 0;
> +            }
> +        } else {
> +            ret =3D 0xff;
> +        }
> +        break;
> +    case 2:
> +        ret =3D ib->mask_reg;
> +        break;
> +    }
> +    return ret;
> +}
> +
> +static void ipmi_bt_signal(IPMIBT *ib, IPMIInterface *ii)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +
> +    ib->do_wake =3D 1;
> +    while (ib->do_wake) {
> +        ib->do_wake =3D 0;
> +        iic->handle_if_event(ii);
> +    }
> +}
> +
> +static void ipmi_bt_ioport_write(void *opaque, hwaddr addr, uint64_t v=
al,
> +                                 unsigned size)
> +{
> +    IPMIInterface *ii =3D opaque;
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIBT *ib =3D iic->get_backend_data(ii);
> +
> +    switch (addr & 3) {
> +    case 0:
> +        if (IPMI_BT_GET_CLR_WR(val)) {
> +            ib->inlen =3D 0;
> +        }
> +        if (IPMI_BT_GET_CLR_RD(val)) {
> +            ib->outpos =3D 0;
> +        }
> +        if (IPMI_BT_GET_B2H_ATN(val)) {
> +            IPMI_BT_SET_B2H_ATN(ib->control_reg, 0);
> +        }
> +        if (IPMI_BT_GET_SMS_ATN(val)) {
> +            IPMI_BT_SET_SMS_ATN(ib->control_reg, 0);
> +        }
> +        if (IPMI_BT_GET_HBUSY(val)) {
> +            /* Toggle */
> +            IPMI_BT_SET_HBUSY(ib->control_reg,
> +                              !IPMI_BT_GET_HBUSY(ib->control_reg));
> +        }
> +        if (IPMI_BT_GET_H2B_ATN(val)) {
> +            IPMI_BT_SET_BBUSY(ib->control_reg, 1);
> +            ipmi_bt_signal(ib, ii);
> +        }
> +        break;
> +
> +    case 1:
> +        if (ib->inlen < sizeof(ib->inmsg)) {
> +            ib->inmsg[ib->inlen] =3D val;
> +        }
> +        ib->inlen++;
> +        break;
> +
> +    case 2:
> +        if (IPMI_BT_GET_B2H_IRQ_EN(val) !=3D
> +                        IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
> +            if (IPMI_BT_GET_B2H_IRQ_EN(val)) {
> +                if (IPMI_BT_GET_B2H_ATN(ib->control_reg) ||
> +                        IPMI_BT_GET_SMS_ATN(ib->control_reg)) {
> +                    IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
> +                    ipmi_bt_raise_irq(ib);
> +                }
> +                IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 1);
> +            } else {
> +                if (IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
> +                    IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
> +                    ipmi_bt_lower_irq(ib);
> +                }
> +                IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 0);
> +            }
> +        }
> +        if (IPMI_BT_GET_B2H_IRQ(val) && IPMI_BT_GET_B2H_IRQ(ib->mask_r=
eg)) {
> +            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
> +            ipmi_bt_lower_irq(ib);
> +        }
> +        break;
> +    }
> +}
> +
> +static const MemoryRegionOps ipmi_bt_io_ops =3D {
> +    .read =3D ipmi_bt_ioport_read,
> +    .write =3D ipmi_bt_ioport_write,
> +    .impl =3D {
> +        .min_access_size =3D 1,
> +        .max_access_size =3D 1,
> +    },
> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
> +};
> +
> +static void ipmi_bt_set_atn(IPMIInterface *ii, int val, int irq)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIBT *ib =3D iic->get_backend_data(ii);
> +
> +    if (!!val =3D=3D IPMI_BT_GET_SMS_ATN(ib->control_reg)) {
> +        return;
> +    }
> +
> +    IPMI_BT_SET_SMS_ATN(ib->control_reg, val);
> +    if (val) {
> +        if (irq && !IPMI_BT_GET_B2H_ATN(ib->control_reg) &&
> +                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
> +            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
> +            ipmi_bt_raise_irq(ib);
> +        }
> +    } else {
> +        if (!IPMI_BT_GET_B2H_ATN(ib->control_reg) &&
> +                IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
> +            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
> +            ipmi_bt_lower_irq(ib);
> +        }
> +    }
> +}
> +
> +static void ipmi_bt_handle_reset(IPMIInterface *ii, bool is_cold)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIBT *ib =3D iic->get_backend_data(ii);
> +
> +    if (is_cold) {
> +        /* Disable the BT interrupt on reset */
> +        if (IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
> +            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
> +            ipmi_bt_lower_irq(ib);
> +        }
> +        IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 0);
> +    }
> +}
> +
> +static void ipmi_bt_set_irq_enable(IPMIInterface *ii, int val)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIBT *ib =3D iic->get_backend_data(ii);
> +
> +    ib->irqs_enabled =3D val;
> +}
> +
> +static void ipmi_bt_init(IPMIInterface *ii, Error **errp)
> +{
> +    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> +    IPMIBT *ib =3D iic->get_backend_data(ii);
> +
> +    ib->io_length =3D 3;
> +
> +    memory_region_init_io(&ib->io, NULL, &ipmi_bt_io_ops, ii, "ipmi-bt=
", 3);
> +}
> +
> +int ipmi_bt_vmstate_post_load(void *opaque, int version)
> +{
> +    IPMIBT *ib =3D opaque;
> +
> +    /* Make sure all the values are sane. */
> +    if (ib->outpos >=3D MAX_IPMI_MSG_SIZE || ib->outlen >=3D MAX_IPMI_=
MSG_SIZE ||
> +        ib->outpos >=3D ib->outlen) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "ipmi:bt: vmstate transfer received bad out valu=
es: %d %d\n",
> +                      ib->outpos, ib->outlen);
> +        ib->outpos =3D 0;
> +        ib->outlen =3D 0;
> +    }
> +
> +    if (ib->inlen >=3D MAX_IPMI_MSG_SIZE) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "ipmi:bt: vmstate transfer received bad in value=
: %d\n",
> +                      ib->inlen);
> +        ib->inlen =3D 0;
> +    }
> +
> +    return 0;
> +}
> +
> +const VMStateDescription vmstate_IPMIBT =3D {
> +    .name =3D TYPE_IPMI_INTERFACE_PREFIX "bt",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .post_load =3D ipmi_bt_vmstate_post_load,
> +    .fields      =3D (VMStateField[]) {
> +        VMSTATE_BOOL(obf_irq_set, IPMIBT),
> +        VMSTATE_BOOL(atn_irq_set, IPMIBT),
> +        VMSTATE_BOOL(irqs_enabled, IPMIBT),
> +        VMSTATE_UINT32(outpos, IPMIBT),
> +        VMSTATE_UINT32(outlen, IPMIBT),
> +        VMSTATE_UINT8_ARRAY(outmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_UINT32(inlen, IPMIBT),
> +        VMSTATE_UINT8_ARRAY(inmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
> +        VMSTATE_UINT8(control_reg, IPMIBT),
> +        VMSTATE_UINT8(mask_reg, IPMIBT),
> +        VMSTATE_UINT8(waiting_rsp, IPMIBT),
> +        VMSTATE_UINT8(waiting_seq, IPMIBT),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +void ipmi_bt_get_fwinfo(struct IPMIBT *ib, IPMIFwInfo *info)
> +{
> +    info->interface_name =3D "bt";
> +    info->interface_type =3D IPMI_SMBIOS_BT;
> +    info->ipmi_spec_major_revision =3D 2;
> +    info->ipmi_spec_minor_revision =3D 0;
> +    info->base_address =3D ib->io_base;
> +    info->register_length =3D ib->io_length;
> +    info->register_spacing =3D 1;
> +    info->memspace =3D IPMI_MEMSPACE_IO;
> +    info->irq_type =3D IPMI_LEVEL_IRQ;
> +}
> +
> +void ipmi_bt_class_init(IPMIInterfaceClass *iic)
> +{
> +    iic->init =3D ipmi_bt_init;
> +    iic->set_atn =3D ipmi_bt_set_atn;
> +    iic->handle_rsp =3D ipmi_bt_handle_rsp;
> +    iic->handle_if_event =3D ipmi_bt_handle_event;
> +    iic->set_irq_enable =3D ipmi_bt_set_irq_enable;
> +    iic->reset =3D ipmi_bt_handle_reset;
> +}
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index a696096cbb..c102778712 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -26,403 +26,46 @@
>  #include "qemu/log.h"
>  #include "qemu/module.h"
>  #include "qapi/error.h"
> -#include "hw/ipmi/ipmi.h"
>  #include "hw/irq.h"
> +#include "hw/ipmi/ipmi_bt.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
>  #include "migration/vmstate.h"
> =20
> -/* Control register */
> -#define IPMI_BT_CLR_WR_BIT         0
> -#define IPMI_BT_CLR_RD_BIT         1
> -#define IPMI_BT_H2B_ATN_BIT        2
> -#define IPMI_BT_B2H_ATN_BIT        3
> -#define IPMI_BT_SMS_ATN_BIT        4
> -#define IPMI_BT_HBUSY_BIT          6
> -#define IPMI_BT_BBUSY_BIT          7
> -
> -#define IPMI_BT_GET_CLR_WR(d)      (((d) >> IPMI_BT_CLR_WR_BIT) & 0x1)
> -
> -#define IPMI_BT_GET_CLR_RD(d)      (((d) >> IPMI_BT_CLR_RD_BIT) & 0x1)
> -
> -#define IPMI_BT_GET_H2B_ATN(d)     (((d) >> IPMI_BT_H2B_ATN_BIT) & 0x1=
)
> -
> -#define IPMI_BT_B2H_ATN_MASK       (1 << IPMI_BT_B2H_ATN_BIT)
> -#define IPMI_BT_GET_B2H_ATN(d)     (((d) >> IPMI_BT_B2H_ATN_BIT) & 0x1=
)
> -#define IPMI_BT_SET_B2H_ATN(d, v)  ((d) =3D (((d) & ~IPMI_BT_B2H_ATN_M=
ASK) | \
> -                                        (!!(v) << IPMI_BT_B2H_ATN_BIT)=
))
> -
> -#define IPMI_BT_SMS_ATN_MASK       (1 << IPMI_BT_SMS_ATN_BIT)
> -#define IPMI_BT_GET_SMS_ATN(d)     (((d) >> IPMI_BT_SMS_ATN_BIT) & 0x1=
)
> -#define IPMI_BT_SET_SMS_ATN(d, v)  ((d) =3D (((d) & ~IPMI_BT_SMS_ATN_M=
ASK) | \
> -                                        (!!(v) << IPMI_BT_SMS_ATN_BIT)=
))
> -
> -#define IPMI_BT_HBUSY_MASK         (1 << IPMI_BT_HBUSY_BIT)
> -#define IPMI_BT_GET_HBUSY(d)       (((d) >> IPMI_BT_HBUSY_BIT) & 0x1)
> -#define IPMI_BT_SET_HBUSY(d, v)    ((d) =3D (((d) & ~IPMI_BT_HBUSY_MAS=
K) | \
> -                                       (!!(v) << IPMI_BT_HBUSY_BIT)))
> -
> -#define IPMI_BT_BBUSY_MASK         (1 << IPMI_BT_BBUSY_BIT)
> -#define IPMI_BT_SET_BBUSY(d, v)    ((d) =3D (((d) & ~IPMI_BT_BBUSY_MAS=
K) | \
> -                                       (!!(v) << IPMI_BT_BBUSY_BIT)))
> -
> -
> -/* Mask register */
> -#define IPMI_BT_B2H_IRQ_EN_BIT     0
> -#define IPMI_BT_B2H_IRQ_BIT        1
> -
> -#define IPMI_BT_B2H_IRQ_EN_MASK      (1 << IPMI_BT_B2H_IRQ_EN_BIT)
> -#define IPMI_BT_GET_B2H_IRQ_EN(d)    (((d) >> IPMI_BT_B2H_IRQ_EN_BIT) =
& 0x1)
> -#define IPMI_BT_SET_B2H_IRQ_EN(d, v) ((d) =3D (((d) & ~IPMI_BT_B2H_IRQ=
_EN_MASK) |\
> -                                        (!!(v) << IPMI_BT_B2H_IRQ_EN_B=
IT)))
> -
> -#define IPMI_BT_B2H_IRQ_MASK         (1 << IPMI_BT_B2H_IRQ_BIT)
> -#define IPMI_BT_GET_B2H_IRQ(d)       (((d) >> IPMI_BT_B2H_IRQ_BIT) & 0=
x1)
> -#define IPMI_BT_SET_B2H_IRQ(d, v)    ((d) =3D (((d) & ~IPMI_BT_B2H_IRQ=
_MASK) | \
> -                                        (!!(v) << IPMI_BT_B2H_IRQ_BIT)=
))
> -
> -typedef struct IPMIBT {
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
> -
> -    uint8_t control_reg;
> -    uint8_t mask_reg;
> -
> -    /*
> -     * This is a response number that we send with the command to make
> -     * sure that the response matches the command.
> -     */
> -    uint8_t waiting_rsp;
> -    uint8_t waiting_seq;
> -} IPMIBT;
> -
> -#define IPMI_CMD_GET_BT_INTF_CAP        0x36
> -
> -static void ipmi_bt_handle_event(IPMIInterface *ii)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIBT *ib =3D iic->get_backend_data(ii);
> -
> -    if (ib->inlen < 4) {
> -        goto out;
> -    }
> -    /* Note that overruns are handled by handle_command */
> -    if (ib->inmsg[0] !=3D (ib->inlen - 1)) {
> -        /* Length mismatch, just ignore. */
> -        IPMI_BT_SET_BBUSY(ib->control_reg, 1);
> -        ib->inlen =3D 0;
> -        goto out;
> -    }
> -    if ((ib->inmsg[1] =3D=3D (IPMI_NETFN_APP << 2)) &&
> -                        (ib->inmsg[3] =3D=3D IPMI_CMD_GET_BT_INTF_CAP)=
) {
> -        /* We handle this one ourselves. */
> -        ib->outmsg[0] =3D 9;
> -        ib->outmsg[1] =3D ib->inmsg[1] | 0x04;
> -        ib->outmsg[2] =3D ib->inmsg[2];
> -        ib->outmsg[3] =3D ib->inmsg[3];
> -        ib->outmsg[4] =3D 0;
> -        ib->outmsg[5] =3D 1; /* Only support 1 outstanding request. */
> -        if (sizeof(ib->inmsg) > 0xff) { /* Input buffer size */
> -            ib->outmsg[6] =3D 0xff;
> -        } else {
> -            ib->outmsg[6] =3D (unsigned char) sizeof(ib->inmsg);
> -        }
> -        if (sizeof(ib->outmsg) > 0xff) { /* Output buffer size */
> -            ib->outmsg[7] =3D 0xff;
> -        } else {
> -            ib->outmsg[7] =3D (unsigned char) sizeof(ib->outmsg);
> -        }
> -        ib->outmsg[8] =3D 10; /* Max request to response time */
> -        ib->outmsg[9] =3D 0; /* Don't recommend retries */
> -        ib->outlen =3D 10;
> -        IPMI_BT_SET_BBUSY(ib->control_reg, 0);
> -        IPMI_BT_SET_B2H_ATN(ib->control_reg, 1);
> -        if (ib->use_irq && ib->irqs_enabled &&
> -                !IPMI_BT_GET_B2H_IRQ(ib->mask_reg) &&
> -                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
> -            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
> -            qemu_irq_raise(ib->irq);
> -        }
> -        goto out;
> -    }
> -    ib->waiting_seq =3D ib->inmsg[2];
> -    ib->inmsg[2] =3D ib->inmsg[1];
> -    {
> -        IPMIBmcClass *bk =3D IPMI_BMC_GET_CLASS(ib->bmc);
> -        bk->handle_command(ib->bmc, ib->inmsg + 2, ib->inlen - 2,
> -                           sizeof(ib->inmsg), ib->waiting_rsp);
> -    }
> - out:
> -    return;
> -}
> -
> -static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
> -                                unsigned char *rsp, unsigned int rsp_l=
en)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIBT *ib =3D iic->get_backend_data(ii);
> -
> -    if (ib->waiting_rsp =3D=3D msg_id) {
> -        ib->waiting_rsp++;
> -        if (rsp_len > (sizeof(ib->outmsg) - 2)) {
> -            ib->outmsg[0] =3D 4;
> -            ib->outmsg[1] =3D rsp[0];
> -            ib->outmsg[2] =3D ib->waiting_seq;
> -            ib->outmsg[3] =3D rsp[1];
> -            ib->outmsg[4] =3D IPMI_CC_CANNOT_RETURN_REQ_NUM_BYTES;
> -            ib->outlen =3D 5;
> -        } else {
> -            ib->outmsg[0] =3D rsp_len + 1;
> -            ib->outmsg[1] =3D rsp[0];
> -            ib->outmsg[2] =3D ib->waiting_seq;
> -            memcpy(ib->outmsg + 3, rsp + 1, rsp_len - 1);
> -            ib->outlen =3D rsp_len + 2;
> -        }
> -        IPMI_BT_SET_BBUSY(ib->control_reg, 0);
> -        IPMI_BT_SET_B2H_ATN(ib->control_reg, 1);
> -        if (ib->use_irq && ib->irqs_enabled &&
> -                !IPMI_BT_GET_B2H_IRQ(ib->mask_reg) &&
> -                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
> -            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
> -            qemu_irq_raise(ib->irq);
> -        }
> -    }
> -}
> -
> -
> -static uint64_t ipmi_bt_ioport_read(void *opaque, hwaddr addr, unsigne=
d size)
> -{
> -    IPMIInterface *ii =3D opaque;
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIBT *ib =3D iic->get_backend_data(ii);
> -    uint32_t ret =3D 0xff;
> -
> -    switch (addr & 3) {
> -    case 0:
> -        ret =3D ib->control_reg;
> -        break;
> -    case 1:
> -        if (ib->outpos < ib->outlen) {
> -            ret =3D ib->outmsg[ib->outpos];
> -            ib->outpos++;
> -            if (ib->outpos =3D=3D ib->outlen) {
> -                ib->outpos =3D 0;
> -                ib->outlen =3D 0;
> -            }
> -        } else {
> -            ret =3D 0xff;
> -        }
> -        break;
> -    case 2:
> -        ret =3D ib->mask_reg;
> -        break;
> -    }
> -    return ret;
> -}
> -
> -static void ipmi_bt_signal(IPMIBT *ib, IPMIInterface *ii)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -
> -    ib->do_wake =3D 1;
> -    while (ib->do_wake) {
> -        ib->do_wake =3D 0;
> -        iic->handle_if_event(ii);
> -    }
> -}
> -
> -static void ipmi_bt_ioport_write(void *opaque, hwaddr addr, uint64_t v=
al,
> -                                 unsigned size)
> -{
> -    IPMIInterface *ii =3D opaque;
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIBT *ib =3D iic->get_backend_data(ii);
> -
> -    switch (addr & 3) {
> -    case 0:
> -        if (IPMI_BT_GET_CLR_WR(val)) {
> -            ib->inlen =3D 0;
> -        }
> -        if (IPMI_BT_GET_CLR_RD(val)) {
> -            ib->outpos =3D 0;
> -        }
> -        if (IPMI_BT_GET_B2H_ATN(val)) {
> -            IPMI_BT_SET_B2H_ATN(ib->control_reg, 0);
> -        }
> -        if (IPMI_BT_GET_SMS_ATN(val)) {
> -            IPMI_BT_SET_SMS_ATN(ib->control_reg, 0);
> -        }
> -        if (IPMI_BT_GET_HBUSY(val)) {
> -            /* Toggle */
> -            IPMI_BT_SET_HBUSY(ib->control_reg,
> -                              !IPMI_BT_GET_HBUSY(ib->control_reg));
> -        }
> -        if (IPMI_BT_GET_H2B_ATN(val)) {
> -            IPMI_BT_SET_BBUSY(ib->control_reg, 1);
> -            ipmi_bt_signal(ib, ii);
> -        }
> -        break;
> -
> -    case 1:
> -        if (ib->inlen < sizeof(ib->inmsg)) {
> -            ib->inmsg[ib->inlen] =3D val;
> -        }
> -        ib->inlen++;
> -        break;
> -
> -    case 2:
> -        if (IPMI_BT_GET_B2H_IRQ_EN(val) !=3D
> -                        IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
> -            if (IPMI_BT_GET_B2H_IRQ_EN(val)) {
> -                if (IPMI_BT_GET_B2H_ATN(ib->control_reg) ||
> -                        IPMI_BT_GET_SMS_ATN(ib->control_reg)) {
> -                    IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
> -                    qemu_irq_raise(ib->irq);
> -                }
> -                IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 1);
> -            } else {
> -                if (IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
> -                    IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
> -                    qemu_irq_lower(ib->irq);
> -                }
> -                IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 0);
> -            }
> -        }
> -        if (IPMI_BT_GET_B2H_IRQ(val) && IPMI_BT_GET_B2H_IRQ(ib->mask_r=
eg)) {
> -            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
> -            qemu_irq_lower(ib->irq);
> -        }
> -        break;
> -    }
> -}
> -
> -static const MemoryRegionOps ipmi_bt_io_ops =3D {
> -    .read =3D ipmi_bt_ioport_read,
> -    .write =3D ipmi_bt_ioport_write,
> -    .impl =3D {
> -        .min_access_size =3D 1,
> -        .max_access_size =3D 1,
> -    },
> -    .endianness =3D DEVICE_LITTLE_ENDIAN,
> -};
> -
> -static void ipmi_bt_set_atn(IPMIInterface *ii, int val, int irq)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIBT *ib =3D iic->get_backend_data(ii);
> -
> -    if (!!val =3D=3D IPMI_BT_GET_SMS_ATN(ib->control_reg)) {
> -        return;
> -    }
> -
> -    IPMI_BT_SET_SMS_ATN(ib->control_reg, val);
> -    if (val) {
> -        if (irq && ib->use_irq && ib->irqs_enabled &&
> -                !IPMI_BT_GET_B2H_ATN(ib->control_reg) &&
> -                IPMI_BT_GET_B2H_IRQ_EN(ib->mask_reg)) {
> -            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
> -            qemu_irq_raise(ib->irq);
> -        }
> -    } else {
> -        if (!IPMI_BT_GET_B2H_ATN(ib->control_reg) &&
> -                IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
> -            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
> -            qemu_irq_lower(ib->irq);
> -        }
> -    }
> -}
> -
> -static void ipmi_bt_handle_reset(IPMIInterface *ii, bool is_cold)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIBT *ib =3D iic->get_backend_data(ii);
> -
> -    if (is_cold) {
> -        /* Disable the BT interrupt on reset */
> -        if (IPMI_BT_GET_B2H_IRQ(ib->mask_reg)) {
> -            IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 0);
> -            qemu_irq_lower(ib->irq);
> -        }
> -        IPMI_BT_SET_B2H_IRQ_EN(ib->mask_reg, 0);
> -    }
> -}
> -
> -static void ipmi_bt_set_irq_enable(IPMIInterface *ii, int val)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIBT *ib =3D iic->get_backend_data(ii);
> -
> -    ib->irqs_enabled =3D val;
> -}
> -
> -static void ipmi_bt_init(IPMIInterface *ii, Error **errp)
> -{
> -    IPMIInterfaceClass *iic =3D IPMI_INTERFACE_GET_CLASS(ii);
> -    IPMIBT *ib =3D iic->get_backend_data(ii);
> -
> -    ib->io_length =3D 3;
> -
> -    memory_region_init_io(&ib->io, NULL, &ipmi_bt_io_ops, ii, "ipmi-bt=
", 3);
> -}
> -
> -
>  #define TYPE_ISA_IPMI_BT "isa-ipmi-bt"
>  #define ISA_IPMI_BT(obj) OBJECT_CHECK(ISAIPMIBTDevice, (obj), \
> -                                       TYPE_ISA_IPMI_BT)
> +                                      TYPE_ISA_IPMI_BT)
> =20
>  typedef struct ISAIPMIBTDevice {
>      ISADevice dev;
>      int32_t isairq;
> +    qemu_irq irq;
>      IPMIBT bt;
>      uint32_t uuid;
>  } ISAIPMIBTDevice;
> =20
> -static void ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInfo *i=
nfo)
> +static void isa_ipmi_bt_get_fwinfo(struct IPMIInterface *ii, IPMIFwInf=
o *info)
>  {
>      ISAIPMIBTDevice *iib =3D ISA_IPMI_BT(ii);
> =20
> -    info->interface_name =3D "bt";
> -    info->interface_type =3D IPMI_SMBIOS_BT;
> -    info->ipmi_spec_major_revision =3D 2;
> -    info->ipmi_spec_minor_revision =3D 0;
> -    info->base_address =3D iib->bt.io_base;
> -    info->register_length =3D iib->bt.io_length;
> -    info->register_spacing =3D 1;
> -    info->memspace =3D IPMI_MEMSPACE_IO;
> -    info->irq_type =3D IPMI_LEVEL_IRQ;
> +    ipmi_bt_get_fwinfo(&iib->bt, info);
>      info->interrupt_number =3D iib->isairq;
>      info->i2c_slave_address =3D iib->bt.bmc->slave_addr;
>      info->uuid =3D iib->uuid;
>  }
> =20
> -static void ipmi_bt_class_init(IPMIInterfaceClass *iic)
> +static void isa_ipmi_bt_raise_irq(IPMIBT *ib)
>  {
> -    iic->init =3D ipmi_bt_init;
> -    iic->set_atn =3D ipmi_bt_set_atn;
> -    iic->handle_rsp =3D ipmi_bt_handle_rsp;
> -    iic->handle_if_event =3D ipmi_bt_handle_event;
> -    iic->set_irq_enable =3D ipmi_bt_set_irq_enable;
> -    iic->reset =3D ipmi_bt_handle_reset;
> -    iic->get_fwinfo =3D ipmi_bt_get_fwinfo;
> +    ISAIPMIBTDevice *iib =3D ib->opaque;
> +
> +    qemu_irq_raise(iib->irq);
> +}
> +
> +static void isa_ipmi_bt_lower_irq(IPMIBT *ib)
> +{
> +    ISAIPMIBTDevice *iib =3D ib->opaque;
> +
> +    qemu_irq_lower(iib->irq);
>  }
> =20
>  static void isa_ipmi_bt_realize(DeviceState *dev, Error **errp)
> @@ -440,14 +83,17 @@ static void isa_ipmi_bt_realize(DeviceState *dev, =
Error **errp)
>      iib->uuid =3D ipmi_next_uuid();
> =20
>      iib->bt.bmc->intf =3D ii;
> +    iib->bt.opaque =3D iib;
> =20
>      iic->init(ii, errp);
>      if (*errp)
>          return;
> =20
>      if (iib->isairq > 0) {
> -        isa_init_irq(isadev, &iib->bt.irq, iib->isairq);
> +        isa_init_irq(isadev, &iib->irq, iib->isairq);
>          iib->bt.use_irq =3D 1;
> +        iib->bt.raise_irq =3D isa_ipmi_bt_raise_irq;
> +        iib->bt.lower_irq =3D isa_ipmi_bt_lower_irq;
>      }
> =20
>      qdev_set_legacy_instance_id(dev, iib->bt.io_base, iib->bt.io_lengt=
h);
> @@ -455,52 +101,6 @@ static void isa_ipmi_bt_realize(DeviceState *dev, =
Error **errp)
>      isa_register_ioport(isadev, &iib->bt.io, iib->bt.io_base);
>  }
> =20
> -static int ipmi_bt_vmstate_post_load(void *opaque, int version)
> -{
> -    IPMIBT *ib =3D opaque;
> -
> -    /* Make sure all the values are sane. */
> -    if (ib->outpos >=3D MAX_IPMI_MSG_SIZE || ib->outlen >=3D MAX_IPMI_=
MSG_SIZE ||
> -        ib->outpos >=3D ib->outlen) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "ipmi:bt: vmstate transfer received bad out valu=
es: %d %d\n",
> -                      ib->outpos, ib->outlen);
> -        ib->outpos =3D 0;
> -        ib->outlen =3D 0;
> -    }
> -
> -    if (ib->inlen >=3D MAX_IPMI_MSG_SIZE) {
> -        qemu_log_mask(LOG_GUEST_ERROR,
> -                      "ipmi:bt: vmstate transfer received bad in value=
: %d\n",
> -                      ib->inlen);
> -        ib->inlen =3D 0;
> -    }
> -
> -    return 0;
> -}
> -
> -const VMStateDescription vmstate_IPMIBT =3D {
> -    .name =3D TYPE_IPMI_INTERFACE_PREFIX "bt",
> -    .version_id =3D 1,
> -    .minimum_version_id =3D 1,
> -    .post_load =3D ipmi_bt_vmstate_post_load,
> -    .fields      =3D (VMStateField[]) {
> -        VMSTATE_BOOL(obf_irq_set, IPMIBT),
> -        VMSTATE_BOOL(atn_irq_set, IPMIBT),
> -        VMSTATE_BOOL(irqs_enabled, IPMIBT),
> -        VMSTATE_UINT32(outpos, IPMIBT),
> -        VMSTATE_UINT32(outlen, IPMIBT),
> -        VMSTATE_UINT8_ARRAY(outmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
> -        VMSTATE_UINT32(inlen, IPMIBT),
> -        VMSTATE_UINT8_ARRAY(inmsg, IPMIBT, MAX_IPMI_MSG_SIZE),
> -        VMSTATE_UINT8(control_reg, IPMIBT),
> -        VMSTATE_UINT8(mask_reg, IPMIBT),
> -        VMSTATE_UINT8(waiting_rsp, IPMIBT),
> -        VMSTATE_UINT8(waiting_seq, IPMIBT),
> -        VMSTATE_END_OF_LIST()
> -    }
> -};
> -
>  static const VMStateDescription vmstate_ISAIPMIBTDevice =3D {
>      .name =3D TYPE_IPMI_INTERFACE_PREFIX "isa-bt",
>      .version_id =3D 2,
> @@ -548,6 +148,7 @@ static void isa_ipmi_bt_class_init(ObjectClass *oc,=
 void *data)
> =20
>      iic->get_backend_data =3D isa_ipmi_bt_get_backend_data;
>      ipmi_bt_class_init(iic);
> +    iic->get_fwinfo =3D isa_ipmi_bt_get_fwinfo;
>  }
> =20
>  static const TypeInfo isa_ipmi_bt_info =3D {
> diff --git a/include/hw/ipmi/ipmi_bt.h b/include/hw/ipmi/ipmi_bt.h
> new file mode 100644
> index 0000000000..9667aaa88a
> --- /dev/null
> +++ b/include/hw/ipmi/ipmi_bt.h
> @@ -0,0 +1,72 @@
> +/*
> + * QEMU IPMI BT emulation
> + *
> + * Copyright (c) 2015 Corey Minyard, MontaVista Software, LLC
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
> +#ifndef HW_IPMI_BT_H
> +#define HW_IPMI_BT_H
> +
> +#include "hw/ipmi/ipmi.h"
> +
> +typedef struct IPMIBT {
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
> +
> +    uint8_t control_reg;
> +    uint8_t mask_reg;
> +
> +    /*
> +     * This is a response number that we send with the command to make
> +     * sure that the response matches the command.
> +     */
> +    uint8_t waiting_rsp;
> +    uint8_t waiting_seq;
> +
> +    uint32_t io_base;
> +    unsigned long io_length;
> +    MemoryRegion io;
> +
> +    void (*raise_irq)(struct IPMIBT *ib);
> +    void (*lower_irq)(struct IPMIBT *ib);
> +    void *opaque;
> +
> +    bool use_irq;
> +} IPMIBT;
> +
> +void ipmi_bt_get_fwinfo(IPMIBT *ik, IPMIFwInfo *info);
> +void ipmi_bt_class_init(IPMIInterfaceClass *iic);
> +extern const VMStateDescription vmstate_IPMIBT;
> +int ipmi_bt_vmstate_post_load(void *opaque, int version);
> +
> +#endif /* HW_IPMI_BT_H */
>=20

