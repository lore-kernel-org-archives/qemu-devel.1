Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401DFCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8C4214B2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 11:29:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8C4214B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMsML-0002C0-SI
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 07:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iMsKH-0000SN-Qc
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:27:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iMsKG-0002iX-EW
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:27:45 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:49433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iMsKG-0002hw-5i
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 07:27:44 -0400
Received: from player698.ha.ovh.net (unknown [10.109.143.249])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 98ED311D504
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 13:27:41 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id B0250B3E64BE;
 Tue, 22 Oct 2019 11:27:33 +0000 (UTC)
Date: Tue, 22 Oct 2019 13:27:28 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v3 4/4] spapr/xive: Set the OS CAM line at reset
Message-ID: <20191022132728.17a86789@bahia.lan>
In-Reply-To: <20191022072246.9200-5-clg@kaod.org>
References: <20191022072246.9200-1-clg@kaod.org>
 <20191022072246.9200-5-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 16693999397685401995
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgdegtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.74.148
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

On Tue, 22 Oct 2019 09:22:46 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> When a Virtual Processor is scheduled to run on a HW thread, the
> hypervisor pushes its identifier in the OS CAM line. When running with
> kernel_irqchip=3Doff, QEMU needs to emulate the same behavior.
>=20
> Set the OS CAM line when the interrupt presenter of the sPAPR core is
> reseted. This will also cover the case of hot-plugged CPUs.
>=20
> This change also has the benefit to remove the use of CPU_FOREACH()
> which can be unsafe.
>=20

CPU_FOREACH() is indeed an unsafe way to loop on presenters. There
are some other users in XICS and XIVE that do cause QEMU to crash.
I shall send fixes as soon as this series reaches ppc-for-4.2.

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/spapr_xive.h |  1 -
>  hw/intc/spapr_xive.c        | 48 +++++++++++++------------------------
>  2 files changed, 17 insertions(+), 32 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index d84bd5c229f0..742b7e834f2a 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -57,7 +57,6 @@ typedef struct SpaprXive {
>  void spapr_xive_pic_print_info(SpaprXive *xive, Monitor *mon);
> =20
>  void spapr_xive_hcall_init(SpaprMachineState *spapr);
> -void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx);
>  void spapr_xive_mmio_set_enabled(SpaprXive *xive, bool enable);
>  void spapr_xive_map_mmio(SpaprXive *xive);
> =20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 20a8d8285f64..d8e1291905c3 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -205,23 +205,6 @@ void spapr_xive_mmio_set_enabled(SpaprXive *xive, bo=
ol enable)
>      memory_region_set_enabled(&xive->end_source.esb_mmio, false);
>  }
> =20
> -/*
> - * When a Virtual Processor is scheduled to run on a HW thread, the
> - * hypervisor pushes its identifier in the OS CAM line. Emulate the
> - * same behavior under QEMU.
> - */
> -void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
> -{
> -    uint8_t  nvt_blk;
> -    uint32_t nvt_idx;
> -    uint32_t nvt_cam;
> -
> -    spapr_xive_cpu_to_nvt(POWERPC_CPU(tctx->cs), &nvt_blk, &nvt_idx);
> -
> -    nvt_cam =3D cpu_to_be32(TM_QW1W2_VO | xive_nvt_cam_line(nvt_blk, nvt=
_idx));
> -    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &nvt_cam, 4);
> -}
> -
>  static void spapr_xive_end_reset(XiveEND *end)
>  {
>      memset(end, 0, sizeof(*end));
> @@ -544,21 +527,32 @@ static int spapr_xive_cpu_intc_create(SpaprInterrup=
tController *intc,
>      }
> =20
>      spapr_cpu->tctx =3D XIVE_TCTX(obj);
> -
> -    /*
> -     * (TCG) Early setting the OS CAM line for hotplugged CPUs as they
> -     * don't beneficiate from the reset of the XIVE IRQ backend
> -     */
> -    spapr_xive_set_tctx_os_cam(spapr_cpu->tctx);
>      return 0;
>  }
> =20
> +static void xive_tctx_set_os_cam(XiveTCTX *tctx, uint32_t os_cam)
> +{
> +    uint32_t qw1w2 =3D cpu_to_be32(TM_QW1W2_VO | os_cam);
> +    memcpy(&tctx->regs[TM_QW1_OS + TM_WORD2], &qw1w2, 4);
> +}
> +
>  static void spapr_xive_cpu_intc_reset(SpaprInterruptController *intc,
>                                       PowerPCCPU *cpu)
>  {
>      XiveTCTX *tctx =3D spapr_cpu_state(cpu)->tctx;
> +    uint8_t  nvt_blk;
> +    uint32_t nvt_idx;
> =20
>      xive_tctx_reset(tctx);
> +
> +    /*
> +     * When a Virtual Processor is scheduled to run on a HW thread,
> +     * the hypervisor pushes its identifier in the OS CAM line.
> +     * Emulate the same behavior under QEMU.
> +     */
> +    spapr_xive_cpu_to_nvt(cpu, &nvt_blk, &nvt_idx);
> +
> +    xive_tctx_set_os_cam(tctx, xive_nvt_cam_line(nvt_blk, nvt_idx));
>  }
> =20
>  static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, =
int val)
> @@ -651,14 +645,6 @@ static void spapr_xive_dt(SpaprInterruptController *=
intc, uint32_t nr_servers,
>  static int spapr_xive_activate(SpaprInterruptController *intc, Error **e=
rrp)
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(intc);
> -    CPUState *cs;
> -
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -
> -        /* (TCG) Set the OS CAM line of the thread interrupt context. */
> -        spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
> -    }
> =20
>      if (kvm_enabled()) {
>          int rc =3D spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp);


