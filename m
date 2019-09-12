Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172A4C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:34:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E16A12081B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16A12081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8QAi-00055b-6i
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1i8Q91-0003ai-BM
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:32:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1i8Q90-0004gW-C2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:32:23 -0400
Received: from 10.mo4.mail-out.ovh.net ([188.165.33.109]:32887)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1i8Q90-0004fX-6M
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 10:32:22 -0400
Received: from player716.ha.ovh.net (unknown [10.108.57.139])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 09E89206C47
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 16:32:19 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player716.ha.ovh.net (Postfix) with ESMTPSA id A51649AF85F7;
 Thu, 12 Sep 2019 14:32:14 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156829860985.2073005.5893493824873412773.stgit@bahia.tls.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <56e9a1ae-b35b-c5fa-b01a-418a5f47027c@kaod.org>
Date: Thu, 12 Sep 2019 16:32:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156829860985.2073005.5893493824873412773.stgit@bahia.tls.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6265351508185418560
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdehgdejiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.109
Subject: Re: [Qemu-devel] [PATCH] spapr: Report kvm_irqchip_in_kernel() in
 'info pic'
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/09/2019 16:30, Greg Kurz wrote:
> Unless the machine was started with kernel-irqchip=3Don, we cannot easi=
ly
> tell if we're actually using an in-kernel or an emulated irqchip. This
> information is important enough that it is worth printing it in 'info
> pic'.

Nice !=20
=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/spapr.c |    4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 761f8214c312..348c007ffbd3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -81,6 +81,8 @@
>  #include "hw/mem/memory-device.h"
>  #include "hw/ppc/spapr_tpm_proxy.h"
> =20
> +#include "monitor/monitor.h"
> +
>  #include <libfdt.h>
> =20
>  /* SLOF memory layout:
> @@ -4360,6 +4362,8 @@ static void spapr_pic_print_info(InterruptStatsPr=
ovider *obj,
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
> =20
>      spapr->irq->print_info(spapr, mon);
> +    monitor_printf(mon, "irqchip: %s\n",
> +                   kvm_irqchip_in_kernel() ? "in-kernel" : "emulated")=
;
>  }
> =20
>  int spapr_get_vcpu_id(PowerPCCPU *cpu)
>=20


