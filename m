Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66B6CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:09:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B8520854
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 06:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B8520854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLhw1-0002SQ-Qv
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 02:09:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iLhvD-0001pD-NE
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:09:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iLhvB-0007tX-GJ
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:09:03 -0400
Received: from 3.mo179.mail-out.ovh.net ([178.33.251.175]:57674)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iLhvB-0007sD-8i
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 02:09:01 -0400
Received: from player792.ha.ovh.net (unknown [10.109.160.62])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id DA560145BEC
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 08:08:58 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player792.ha.ovh.net (Postfix) with ESMTPSA id 8146DB236DDC;
 Sat, 19 Oct 2019 06:08:53 +0000 (UTC)
Date: Sat, 19 Oct 2019 08:08:52 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 2/2] spapr/xive: Set the OS CAM line at reset
Message-ID: <20191019080852.330aab30@bahia.lan>
In-Reply-To: <20191018172219.10039-3-clg@kaod.org>
References: <20191018172219.10039-1-clg@kaod.org>
 <20191018172219.10039-3-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 12140015746927794571
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkedtgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.175
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

On Fri, 18 Oct 2019 19:22:19 +0200
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

Yeah, CPU_FOREACH() can bite hard... it's easy as 1-2-3 to crash QEMU with =
the
ones in xics_spapr_print_info() and spapr_xive_print_info(). I'll post fixes
soon.

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/spapr_xive.h |  1 -
>  hw/intc/spapr_xive.c        | 18 +++---------------
>  2 files changed, 3 insertions(+), 16 deletions(-)
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
> index 258b1c5fb5ff..4f584e582b6c 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -210,7 +210,7 @@ void spapr_xive_mmio_set_enabled(SpaprXive *xive, boo=
l enable)
>   * hypervisor pushes its identifier in the OS CAM line. Emulate the
>   * same behavior under QEMU.
>   */
> -void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
> +static void spapr_xive_set_tctx_os_cam(XiveTCTX *tctx)
>  {
>      uint8_t  nvt_blk;
>      uint32_t nvt_idx;
> @@ -544,12 +544,6 @@ static int spapr_xive_cpu_intc_create(SpaprInterrupt=
Controller *intc,
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
> @@ -557,6 +551,8 @@ static void spapr_xive_cpu_intc_reset(SpaprInterruptC=
ontroller *intc,
>                                       PowerPCCPU *cpu)
>  {
>      xive_tctx_reset(spapr_cpu_state(cpu)->tctx);
> +
> +    spapr_xive_set_tctx_os_cam(spapr_cpu_state(cpu)->tctx);
>  }
> =20
>  static void spapr_xive_set_irq(SpaprInterruptController *intc, int irq, =
int val)
> @@ -649,14 +645,6 @@ static void spapr_xive_dt(SpaprInterruptController *=
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


