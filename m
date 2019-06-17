Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE83C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291AB2086A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291AB2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48022 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsiF-0002mo-DY
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42042)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hcsTA-0002Ex-Q1
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hcsT6-0006dO-Nv
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:18:46 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:48753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hcsT5-0006aA-1z
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:18:43 -0400
Received: from player718.ha.ovh.net (unknown [10.109.143.18])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 8EBD05DA0B
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 16:18:38 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player718.ha.ovh.net (Postfix) with ESMTPSA id 786D26DB718C;
 Mon, 17 Jun 2019 14:18:34 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077920102.433243.6605099291134598170.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8febd0ad-d283-5111-d0aa-651832322661@kaod.org>
Date: Mon, 17 Jun 2019 16:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156077920102.433243.6605099291134598170.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11618724092569029440
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeijedgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.42.102
Subject: Re: [Qemu-devel] [PATCH 2/6] xics/spapr: Rename xics_kvm_init()
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

On 17/06/2019 15:46, Greg Kurz wrote:
> Switch to using the connect/disconnect terminology like we already do f=
or
> XIVE.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>  hw/intc/xics_kvm.c          |    2 +-
>  hw/ppc/spapr_irq.c          |    2 +-
>  include/hw/ppc/xics_spapr.h |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index c7f8f5edd257..534515143ea8 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -331,7 +331,7 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int =
val)
>      }
>  }
> =20
> -int xics_kvm_init(SpaprMachineState *spapr, Error **errp)
> +int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
>  {
>      int rc;
>      CPUState *cs;
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 84b9b32fe40f..ff3df0bbd8cf 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -237,7 +237,7 @@ static const char *spapr_irq_get_nodename_xics(Spap=
rMachineState *spapr)
>  static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **=
errp)
>  {
>      if (kvm_enabled()) {
> -        xics_kvm_init(spapr, errp);
> +        xics_kvm_connect(spapr, errp);
>      }
>  }
> =20
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 330448126223..5dabc9a1388f 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -33,7 +33,7 @@
> =20
>  void spapr_dt_xics(SpaprMachineState *spapr, uint32_t nr_servers, void=
 *fdt,
>                     uint32_t phandle);
> -int xics_kvm_init(SpaprMachineState *spapr, Error **errp);
> +int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
>  void xics_spapr_init(SpaprMachineState *spapr);
>=20


