Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76F6C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B103721473
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 18:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B103721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrLK-0003lL-0A
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 14:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37470)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hbqDT-0007gW-IH
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:42:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hbqDQ-0006AA-IB
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:42:17 -0400
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:37913)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hbqDL-0005ri-F3
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:42:15 -0400
Received: from player789.ha.ovh.net (unknown [10.108.42.239])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 5CC0F6CFD8
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 19:41:59 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id 126446D12435;
 Fri, 14 Jun 2019 17:41:55 +0000 (UTC)
Date: Fri, 14 Jun 2019 19:41:54 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190614194154.3aaace21@bahia.lan>
In-Reply-To: <20190614165920.12670-3-clg@kaod.org>
References: <20190614165920.12670-1-clg@kaod.org>
 <20190614165920.12670-3-clg@kaod.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 15881662612689820043
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeiuddguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.74.227
Subject: Re: [Qemu-devel] [PATCH 2/2] spapr/xive: simplify
 spapr_irq_init_device() to remove the emulated init
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 14 Jun 2019 18:59:20 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> The init_emu() handles are now empty. Remove them and rename
> spapr_irq_init_device() to spapr_irq_init_kvm().
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/spapr_irq.h |  1 -
>  hw/ppc/spapr_irq.c         | 20 +++-----------------
>  2 files changed, 3 insertions(+), 18 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index 14cab73c9c07..f965a58f8954 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -48,7 +48,6 @@ typedef struct SpaprIrq {
>      void (*reset)(SpaprMachineState *spapr, Error **errp);
>      void (*set_irq)(void *opaque, int srcno, int val);
>      const char *(*get_nodename)(SpaprMachineState *spapr);
> -    void (*init_emu)(SpaprMachineState *spapr, Error **errp);
>      void (*init_kvm)(SpaprMachineState *spapr, Error **errp);
>  } SpaprIrq;
> =20
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 73e6f10da165..84b9b32fe40f 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -62,7 +62,7 @@ void spapr_irq_msi_reset(SpaprMachineState *spapr)
>      bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
>  }
> =20
> -static void spapr_irq_init_device(SpaprMachineState *spapr,
> +static void spapr_irq_init_kvm(SpaprMachineState *spapr,
>                                    SpaprIrq *irq, Error **errp)
>  {
>      MachineState *machine =3D MACHINE(spapr);
> @@ -88,8 +88,6 @@ static void spapr_irq_init_device(SpaprMachineState *sp=
apr,
>          error_prepend(&local_err, "kernel_irqchip allowed but unavailabl=
e: ");
>          warn_report_err(local_err);
>      }
> -
> -    irq->init_emu(spapr, errp);
>  }
> =20
>  /*
> @@ -224,7 +222,7 @@ static void spapr_irq_reset_xics(SpaprMachineState *s=
papr, Error **errp)
>  {
>      Error *local_err =3D NULL;
> =20
> -    spapr_irq_init_device(spapr, &spapr_irq_xics, &local_err);
> +    spapr_irq_init_kvm(spapr, &spapr_irq_xics, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -236,10 +234,6 @@ static const char *spapr_irq_get_nodename_xics(Spapr=
MachineState *spapr)
>      return XICS_NODENAME;
>  }
> =20
> -static void spapr_irq_init_emu_xics(SpaprMachineState *spapr, Error **er=
rp)
> -{
> -}
> -
>  static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **er=
rp)
>  {
>      if (kvm_enabled()) {
> @@ -267,7 +261,6 @@ SpaprIrq spapr_irq_xics =3D {
>      .reset       =3D spapr_irq_reset_xics,
>      .set_irq     =3D spapr_irq_set_irq_xics,
>      .get_nodename =3D spapr_irq_get_nodename_xics,
> -    .init_emu    =3D spapr_irq_init_emu_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>  };
> =20
> @@ -385,7 +378,7 @@ static void spapr_irq_reset_xive(SpaprMachineState *s=
papr, Error **errp)
>          spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
>      }
> =20
> -    spapr_irq_init_device(spapr, &spapr_irq_xive, &local_err);
> +    spapr_irq_init_kvm(spapr, &spapr_irq_xive, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> @@ -411,10 +404,6 @@ static const char *spapr_irq_get_nodename_xive(Spapr=
MachineState *spapr)
>      return spapr->xive->nodename;
>  }
> =20
> -static void spapr_irq_init_emu_xive(SpaprMachineState *spapr, Error **er=
rp)
> -{
> -}
> -
>  static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **er=
rp)
>  {
>      if (kvm_enabled()) {
> @@ -446,7 +435,6 @@ SpaprIrq spapr_irq_xive =3D {
>      .reset       =3D spapr_irq_reset_xive,
>      .set_irq     =3D spapr_irq_set_irq_xive,
>      .get_nodename =3D spapr_irq_get_nodename_xive,
> -    .init_emu    =3D spapr_irq_init_emu_xive,
>      .init_kvm    =3D spapr_irq_init_kvm_xive,
>  };
> =20
> @@ -624,7 +612,6 @@ SpaprIrq spapr_irq_dual =3D {
>      .reset       =3D spapr_irq_reset_dual,
>      .set_irq     =3D spapr_irq_set_irq_dual,
>      .get_nodename =3D spapr_irq_get_nodename_dual,
> -    .init_emu    =3D NULL, /* should not be used */
>      .init_kvm    =3D NULL, /* should not be used */
>  };
> =20
> @@ -840,6 +827,5 @@ SpaprIrq spapr_irq_xics_legacy =3D {
>      .reset       =3D spapr_irq_reset_xics,
>      .set_irq     =3D spapr_irq_set_irq_xics,
>      .get_nodename =3D spapr_irq_get_nodename_xics,
> -    .init_emu    =3D spapr_irq_init_emu_xics,
>      .init_kvm    =3D spapr_irq_init_kvm_xics,
>  };


