Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FD8C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:17:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0871920679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:17:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0871920679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54308 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd8NB-0002LH-Ca
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 03:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50874)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hd8Lq-0001k0-RG
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:16:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hd8Lp-00066C-Br
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:16:18 -0400
Received: from 18.mo5.mail-out.ovh.net ([178.33.45.10]:41822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hd8Lp-00063t-3A
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:16:17 -0400
Received: from player716.ha.ovh.net (unknown [10.108.35.74])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 3361E23BD08
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:16:13 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player716.ha.ovh.net (Postfix) with ESMTPSA id 194006E33E7E;
 Tue, 18 Jun 2019 07:16:08 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077921763.433243.4614327010172954196.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <419fb6fb-01d3-498c-31be-22fa7092a7c1@kaod.org>
Date: Tue, 18 Jun 2019 09:16:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156077921763.433243.4614327010172954196.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10357153243359710016
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeikedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.45.10
Subject: Re: [Qemu-devel] [PATCH 5/6] xics/kvm: Add error propagation to
 ic*_set_kvm_state() functions
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
> This allows errors happening there to be propagated up to spapr_irq,
> just like XIVE already does.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/xics.c        |   39 ++++++++++++++++++++++++++++++++++-----
>  hw/intc/xics_kvm.c    |   37 ++++++++++++++++++++++---------------
>  include/hw/ppc/xics.h |    6 +++---
>  3 files changed, 59 insertions(+), 23 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 1dc3a0f12280..69152e3d9ff6 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -267,7 +267,14 @@ static int icp_post_load(void *opaque, int version=
_id)
>      ICPState *icp =3D opaque;
> =20
>      if (kvm_irqchip_in_kernel()) {
> -        return icp_set_kvm_state(icp);
> +        Error *local_err =3D NULL;
> +        int ret;
> +
> +        ret =3D icp_set_kvm_state(icp, &local_err);
> +        if (ret < 0) {
> +            error_report_err(local_err);
> +            return ret;
> +        }
>      }
> =20
>      return 0;
> @@ -300,7 +307,12 @@ static void icp_reset_handler(void *dev)
>      qemu_set_irq(icp->output, 0);
> =20
>      if (kvm_irqchip_in_kernel()) {
> -        icp_set_kvm_state(ICP(dev));
> +        Error *local_err =3D NULL;
> +
> +        icp_set_kvm_state(ICP(dev), &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
>      }
>  }
> =20
> @@ -555,7 +567,12 @@ static void ics_simple_reset(DeviceState *dev)
>      icsc->parent_reset(dev);
> =20
>      if (kvm_irqchip_in_kernel()) {
> -        ics_set_kvm_state(ICS_BASE(dev));
> +        Error *local_err =3D NULL;
> +
> +        ics_set_kvm_state(ICS_BASE(dev), &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
>      }
>  }
> =20
> @@ -671,7 +688,14 @@ static int ics_base_post_load(void *opaque, int ve=
rsion_id)
>      ICSState *ics =3D opaque;
> =20
>      if (kvm_irqchip_in_kernel()) {
> -        return ics_set_kvm_state(ics);
> +        Error *local_err =3D NULL;
> +        int ret;
> +
> +        ret =3D ics_set_kvm_state(ics, &local_err);
> +        if (ret < 0) {
> +            error_report_err(local_err);
> +            return ret;
> +        }
>      }
> =20
>      return 0;
> @@ -757,8 +781,13 @@ void ics_set_irq_type(ICSState *ics, int srcno, bo=
ol lsi)
>          lsi ? XICS_FLAGS_IRQ_LSI : XICS_FLAGS_IRQ_MSI;
> =20
>      if (kvm_irqchip_in_kernel()) {
> +        Error *local_err =3D NULL;
> +
>          ics_reset_irq(ics->irqs + srcno);
> -        ics_set_kvm_state_one(ics, srcno);
> +        ics_set_kvm_state_one(ics, srcno, &local_err);
> +        if (local_err) {
> +            error_report_err(local_err);
> +        }
>      }
>  }
> =20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index c9e25fb051bb..4bfbe1a84092 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -106,7 +106,7 @@ void icp_synchronize_state(ICPState *icp)
>      }
>  }
> =20
> -int icp_set_kvm_state(ICPState *icp)
> +int icp_set_kvm_state(ICPState *icp, Error **errp)
>  {
>      uint64_t state;
>      int ret;
> @@ -126,10 +126,11 @@ int icp_set_kvm_state(ICPState *icp)
>          | ((uint64_t)icp->pending_priority << KVM_REG_PPC_ICP_PPRI_SHI=
FT);
> =20
>      ret =3D kvm_set_one_reg(icp->cs, KVM_REG_PPC_ICP_STATE, &state);
> -    if (ret !=3D 0) {
> -        error_report("Unable to restore KVM interrupt controller state=
 (0x%"
> -                PRIx64 ") for CPU %ld: %s", state, kvm_arch_vcpu_id(ic=
p->cs),
> -                strerror(errno));
> +    if (ret < 0) {
> +        error_setg_errno(errp, -ret,
> +                         "Unable to restore KVM interrupt controller s=
tate (0x%"
> +                         PRIx64 ") for CPU %ld", state,
> +                         kvm_arch_vcpu_id(icp->cs));
>          return ret;
>      }
> =20
> @@ -240,10 +241,9 @@ void ics_synchronize_state(ICSState *ics)
>      ics_get_kvm_state(ics);
>  }
> =20
> -int ics_set_kvm_state_one(ICSState *ics, int srcno)
> +int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp)
>  {
>      uint64_t state;
> -    Error *local_err =3D NULL;
>      ICSIRQState *irq =3D &ics->irqs[srcno];
>      int ret;
> =20
> @@ -278,16 +278,15 @@ int ics_set_kvm_state_one(ICSState *ics, int srcn=
o)
>      }
> =20
>      ret =3D kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES=
,
> -                            srcno + ics->offset, &state, true, &local_=
err);
> -    if (local_err) {
> -        error_report_err(local_err);
> +                            srcno + ics->offset, &state, true, errp);
> +    if (ret < 0) {
>          return ret;
>      }
> =20
>      return 0;
>  }
> =20
> -int ics_set_kvm_state(ICSState *ics)
> +int ics_set_kvm_state(ICSState *ics, Error **errp)
>  {
>      int i;
> =20
> @@ -297,10 +296,12 @@ int ics_set_kvm_state(ICSState *ics)
>      }
> =20
>      for (i =3D 0; i < ics->nr_irqs; i++) {
> +        Error *local_err =3D NULL;
>          int ret;
> =20
> -        ret =3D ics_set_kvm_state_one(ics, i);
> -        if (ret) {
> +        ret =3D ics_set_kvm_state_one(ics, i, &local_err);
> +        if (ret < 0) {
> +            error_propagate(errp, local_err);
>              return ret;
>          }
>      }
> @@ -402,12 +403,18 @@ int xics_kvm_connect(SpaprMachineState *spapr, Er=
ror **errp)
>      }
> =20
>      /* Update the KVM sources */
> -    ics_set_kvm_state(spapr->ics);
> +    ics_set_kvm_state(spapr->ics, &local_err);
> +    if (local_err) {
> +        goto fail;
> +    }
> =20
>      /* Connect the presenters to the initial VCPUs of the machine */
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> -        icp_set_kvm_state(spapr_cpu_state(cpu)->icp);
> +        icp_set_kvm_state(spapr_cpu_state(cpu)->icp, &local_err);
> +        if (local_err) {
> +            goto fail;
> +        }
>      }
> =20
>      return 0;
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index eb65ad7e43b7..1eb7b5cd6847 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -190,13 +190,13 @@ Object *icp_create(Object *cpu, const char *type,=
 XICSFabric *xi,
> =20
>  /* KVM */
>  void icp_get_kvm_state(ICPState *icp);
> -int icp_set_kvm_state(ICPState *icp);
> +int icp_set_kvm_state(ICPState *icp, Error **errp);
>  void icp_synchronize_state(ICPState *icp);
>  void icp_kvm_realize(DeviceState *dev, Error **errp);
> =20
>  void ics_get_kvm_state(ICSState *ics);
> -int ics_set_kvm_state_one(ICSState *ics, int srcno);
> -int ics_set_kvm_state(ICSState *ics);
> +int ics_set_kvm_state_one(ICSState *ics, int srcno, Error **errp);
> +int ics_set_kvm_state(ICSState *ics, Error **errp);
>  void ics_synchronize_state(ICSState *ics);
>  void ics_kvm_set_irq(ICSState *ics, int srcno, int val);
> =20
>=20


