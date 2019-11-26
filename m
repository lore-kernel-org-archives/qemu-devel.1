Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E8F6C432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 17:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CFEA20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 17:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CFEA20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZeKq-0006pK-8k
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 12:09:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42084)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iZeDw-0001NO-Ci
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iZeDu-00013R-AH
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:01:59 -0500
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:41473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iZeDu-0000vh-3o
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:01:58 -0500
Received: from player687.ha.ovh.net (unknown [10.108.1.232])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 04BDD14D927
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 18:01:48 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id 7C15CC8A62A2;
 Tue, 26 Nov 2019 17:01:44 +0000 (UTC)
Subject: Re: [for-5.0 PATCH v2 2/4] spapr: Pass the maximum number of vCPUs to
 the KVM interrupt controller
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
 <157478678301.67101.2717368060417156338.stgit@bahia.tlslab.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2fb5cb0b-a24b-6438-cf53-f61eb4705022@kaod.org>
Date: Tue, 26 Nov 2019 18:01:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157478678301.67101.2717368060417156338.stgit@bahia.tlslab.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6520086361912871744
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeifedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.78.111
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

On 26/11/2019 17:46, Greg Kurz wrote:
> The XIVE and XICS-on-XIVE KVM devices on POWER9 hosts can greatly reduc=
e
> their consumption of some scarce HW resources, namely Virtual Presenter
> identifiers, if they know the maximum number of vCPUs that may run in t=
he
> VM.
>=20
> Prepare ground for this by passing the value down to xics_kvm_connect()
> and kvmppc_xive_connect(). This is purely mechanical, no functional
> change.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/spapr_xive.c        |    6 ++++--
>  hw/intc/spapr_xive_kvm.c    |    3 ++-
>  hw/intc/xics_kvm.c          |    3 ++-
>  hw/intc/xics_spapr.c        |    5 +++--
>  hw/ppc/spapr_irq.c          |    8 +++++---
>  include/hw/ppc/spapr_irq.h  |   10 ++++++++--
>  include/hw/ppc/spapr_xive.h |    3 ++-
>  include/hw/ppc/xics_spapr.h |    3 ++-
>  8 files changed, 28 insertions(+), 13 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 729246e906c9..8364f61c786c 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -651,12 +651,14 @@ static void spapr_xive_dt(SpaprInterruptControlle=
r *intc, uint32_t nr_servers,
>                       plat_res_int_priorities, sizeof(plat_res_int_prio=
rities)));
>  }
> =20
> -static int spapr_xive_activate(SpaprInterruptController *intc, Error *=
*errp)
> +static int spapr_xive_activate(SpaprInterruptController *intc,
> +                               uint32_t nr_servers, Error **errp)
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(intc);
> =20
>      if (kvm_enabled()) {
> -        int rc =3D spapr_irq_init_kvm(kvmppc_xive_connect, intc, errp)=
;
> +        int rc =3D spapr_irq_init_kvm(kvmppc_xive_connect, intc, nr_se=
rvers,
> +                                    errp);
>          if (rc < 0) {
>              return rc;
>          }
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 69e73552f1ef..46c7609bd8d0 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -728,7 +728,8 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int =
pgoff, size_t len,
>   * All the XIVE memory regions are now backed by mappings from the KVM
>   * XIVE device.
>   */
> -int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp)
> +int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_se=
rvers,
> +                        Error **errp)
>  {
>      SpaprXive *xive =3D SPAPR_XIVE(intc);
>      XiveSource *xsrc =3D &xive->source;
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 954c424b3652..a1f1b7b0d37c 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -342,7 +342,8 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int =
val)
>      }
>  }
> =20
> -int xics_kvm_connect(SpaprInterruptController *intc, Error **errp)
> +int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_serve=
rs,
> +                     Error **errp)
>  {
>      ICSState *ics =3D ICS_SPAPR(intc);
>      int rc;
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index b3705dab0e8a..8ae4f41459c3 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -422,10 +422,11 @@ static int xics_spapr_post_load(SpaprInterruptCon=
troller *intc, int version_id)
>      return 0;
>  }
> =20
> -static int xics_spapr_activate(SpaprInterruptController *intc, Error *=
*errp)
> +static int xics_spapr_activate(SpaprInterruptController *intc,
> +                               uint32_t nr_servers, Error **errp)
>  {
>      if (kvm_enabled()) {
> -        return spapr_irq_init_kvm(xics_kvm_connect, intc, errp);
> +        return spapr_irq_init_kvm(xics_kvm_connect, intc, nr_servers, =
errp);
>      }
>      return 0;
>  }
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index d4a54afc8662..07e08d6544a0 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -70,15 +70,16 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, i=
nt irq, uint32_t num)
>      bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
>  }
> =20
> -int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **)=
,
> +int spapr_irq_init_kvm(SpaprInterruptControllerInitKvm fn,
>                         SpaprInterruptController *intc,
> +                       uint32_t nr_servers,
>                         Error **errp)
>  {
>      MachineState *machine =3D MACHINE(qdev_get_machine());
>      Error *local_err =3D NULL;
> =20
>      if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> -        if (fn(intc, &local_err) < 0) {
> +        if (fn(intc, nr_servers, &local_err) < 0) {
>              if (machine_kernel_irqchip_required(machine)) {
>                  error_prepend(&local_err,
>                                "kernel_irqchip requested but unavailabl=
e: ");
> @@ -481,6 +482,7 @@ static void set_active_intc(SpaprMachineState *spap=
r,
>                              SpaprInterruptController *new_intc)
>  {
>      SpaprInterruptControllerClass *sicc;
> +    uint32_t nr_servers =3D spapr_max_server_number(spapr);
> =20
>      assert(new_intc);
> =20
> @@ -498,7 +500,7 @@ static void set_active_intc(SpaprMachineState *spap=
r,
> =20
>      sicc =3D SPAPR_INTC_GET_CLASS(new_intc);
>      if (sicc->activate) {
> -        sicc->activate(new_intc, &error_fatal);
> +        sicc->activate(new_intc, nr_servers, &error_fatal);
>      }
> =20
>      spapr->active_intc =3D new_intc;
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index ff814d13de37..ca8cb4421374 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -43,7 +43,8 @@ typedef struct SpaprInterruptController SpaprInterrup=
tController;
>  typedef struct SpaprInterruptControllerClass {
>      InterfaceClass parent;
> =20
> -    int (*activate)(SpaprInterruptController *intc, Error **errp);
> +    int (*activate)(SpaprInterruptController *intc, uint32_t nr_server=
s,
> +                    Error **errp);
>      void (*deactivate)(SpaprInterruptController *intc);
> =20
>      /*
> @@ -98,8 +99,13 @@ qemu_irq spapr_qirq(SpaprMachineState *spapr, int ir=
q);
>  int spapr_irq_post_load(SpaprMachineState *spapr, int version_id);
>  void spapr_irq_reset(SpaprMachineState *spapr, Error **errp);
>  int spapr_irq_get_phandle(SpaprMachineState *spapr, void *fdt, Error *=
*errp);
> -int spapr_irq_init_kvm(int (*fn)(SpaprInterruptController *, Error **)=
,
> +
> +typedef int (*SpaprInterruptControllerInitKvm)(SpaprInterruptControlle=
r *,
> +                                               uint32_t, Error **);
> +
> +int spapr_irq_init_kvm(SpaprInterruptControllerInitKvm fn,
>                         SpaprInterruptController *intc,
> +                       uint32_t nr_servers,
>                         Error **errp);
> =20
>  /*
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 742b7e834f2a..3a103c224d44 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -66,7 +66,8 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_=
t end_idx,
>  /*
>   * KVM XIVE device helpers
>   */
> -int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp);
> +int kvmppc_xive_connect(SpaprInterruptController *intc, uint32_t nr_se=
rvers,
> +                        Error **errp);
>  void kvmppc_xive_disconnect(SpaprInterruptController *intc);
>  void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
>  void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, Xiv=
eEAS *eas,
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 28b87038c89a..1c65c96e3c7a 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -32,7 +32,8 @@
>  #define TYPE_ICS_SPAPR "ics-spapr"
>  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> =20
> -int xics_kvm_connect(SpaprInterruptController *intc, Error **errp);
> +int xics_kvm_connect(SpaprInterruptController *intc, uint32_t nr_serve=
rs,
> +                     Error **errp);
>  void xics_kvm_disconnect(SpaprInterruptController *intc);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
> =20
>=20


