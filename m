Return-Path: <SRS0=LaQQ=XZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A4C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 05:54:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C522168B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2019 05:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C522168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEodW-0000zm-R0
	for qemu-devel@archiver.kernel.org; Mon, 30 Sep 2019 01:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32827)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iEoc8-0008Ph-0m
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iEoc6-0005jJ-F9
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:52:51 -0400
Received: from 18.mo1.mail-out.ovh.net ([46.105.35.72]:35261)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iEoc6-0005iz-9L
 for qemu-devel@nongnu.org; Mon, 30 Sep 2019 01:52:50 -0400
Received: from player711.ha.ovh.net (unknown [10.108.35.210])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id D8819191854
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2019 07:52:48 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id 75906A444799;
 Mon, 30 Sep 2019 05:52:38 +0000 (UTC)
Subject: Re: [PATCH v2 27/33] spapr, xics, xive: Match signatures for XICS and
 XIVE KVM connect routines
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20190927055028.11493-1-david@gibson.dropbear.id.au>
 <20190927055028.11493-28-david@gibson.dropbear.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3bcb8ec2-985e-44e6-d6fc-90a1499245ad@kaod.org>
Date: Mon, 30 Sep 2019 07:52:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190927055028.11493-28-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10966265094875024153
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgedugddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.35.72
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, groug@kaod.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/09/2019 07:50, David Gibson wrote:
> Both XICS and XIVE have routines to connect and disconnect KVM with sim=
ilar
> but not identical signatures.  This adjusts them to match exactly, whic=
h
> will be useful for further cleanups later.
>=20
> While we're at it, remove error reporting from the disconnect path.  In=
 the
> XICS case this wasn't used at all.  In the XIVE case the only error cas=
e
> was if the KVM device was set up, but KVM didn't have the capability to=
 do
> so which is pretty obviously impossible.
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/spapr_xive_kvm.c    | 22 ++++++++++------------
>  hw/intc/xics_kvm.c          |  9 +++++----
>  hw/ppc/spapr_irq.c          | 22 +++++-----------------
>  include/hw/ppc/spapr_xive.h |  4 ++--
>  include/hw/ppc/xics_spapr.h |  4 ++--
>  5 files changed, 24 insertions(+), 37 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 51b334b676..08012ac7cd 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -740,8 +740,9 @@ static void *kvmppc_xive_mmap(SpaprXive *xive, int =
pgoff, size_t len,
>   * All the XIVE memory regions are now backed by mappings from the KVM
>   * XIVE device.
>   */
> -void kvmppc_xive_connect(SpaprXive *xive, Error **errp)
> +int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp)
>  {
> +    SpaprXive *xive =3D SPAPR_XIVE(intc);
>      XiveSource *xsrc =3D &xive->source;
>      Error *local_err =3D NULL;
>      size_t esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> @@ -753,19 +754,19 @@ void kvmppc_xive_connect(SpaprXive *xive, Error *=
*errp)
>       * rebooting under the XIVE-only interrupt mode.
>       */
>      if (xive->fd !=3D -1) {
> -        return;
> +        return 0;
>      }
> =20
>      if (!kvmppc_has_cap_xive()) {
>          error_setg(errp, "IRQ_XIVE capability must be present for KVM"=
);
> -        return;
> +        return -1;
>      }
> =20
>      /* First, create the KVM XIVE device */
>      xive->fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XIVE, false=
);
>      if (xive->fd < 0) {
>          error_setg_errno(errp, -xive->fd, "XIVE: error creating KVM de=
vice");
> -        return;
> +        return -1;
>      }
> =20
>      /*
> @@ -821,15 +822,17 @@ void kvmppc_xive_connect(SpaprXive *xive, Error *=
*errp)
>      kvm_kernel_irqchip =3D true;
>      kvm_msi_via_irqfd_allowed =3D true;
>      kvm_gsi_direct_mapping =3D true;
> -    return;
> +    return 0;
> =20
>  fail:
>      error_propagate(errp, local_err);
> -    kvmppc_xive_disconnect(xive, NULL);
> +    kvmppc_xive_disconnect(intc);
> +    return -1;
>  }
> =20
> -void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp)
> +void kvmppc_xive_disconnect(SpaprInterruptController *intc)
>  {
> +    SpaprXive *xive =3D SPAPR_XIVE(intc);
>      XiveSource *xsrc;
>      size_t esb_len;
> =20
> @@ -838,11 +841,6 @@ void kvmppc_xive_disconnect(SpaprXive *xive, Error=
 **errp)
>          return;
>      }
> =20
> -    if (!kvmppc_has_cap_xive()) {
> -        error_setg(errp, "IRQ_XIVE capability must be present for KVM"=
);
> -        return;
> -    }
> -
>      /* Clear the KVM mapping */
>      xsrc =3D &xive->source;
>      esb_len =3D (1ull << xsrc->esb_shift) * xsrc->nr_irqs;
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index ba90d6dc96..954c424b36 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -342,8 +342,9 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int =
val)
>      }
>  }
> =20
> -int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
> +int xics_kvm_connect(SpaprInterruptController *intc, Error **errp)
>  {
> +    ICSState *ics =3D ICS_SPAPR(intc);
>      int rc;
>      CPUState *cs;
>      Error *local_err =3D NULL;
> @@ -413,7 +414,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Erro=
r **errp)
>      }
> =20
>      /* Update the KVM sources */
> -    ics_set_kvm_state(spapr->ics, &local_err);
> +    ics_set_kvm_state(ics, &local_err);
>      if (local_err) {
>          goto fail;
>      }
> @@ -431,11 +432,11 @@ int xics_kvm_connect(SpaprMachineState *spapr, Er=
ror **errp)
> =20
>  fail:
>      error_propagate(errp, local_err);
> -    xics_kvm_disconnect(spapr, NULL);
> +    xics_kvm_disconnect(intc);
>      return -1;
>  }
> =20
> -void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp)
> +void xics_kvm_disconnect(SpaprInterruptController *intc)
>  {
>      /*
>       * Only on P9 using the XICS-on XIVE KVM device:
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 79cbe8064e..561bdbc4de 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -124,7 +124,7 @@ static void spapr_irq_reset_xics(SpaprMachineState =
*spapr, Error **errp)
>  static void spapr_irq_init_kvm_xics(SpaprMachineState *spapr, Error **=
errp)
>  {
>      if (kvm_enabled()) {
> -        xics_kvm_connect(spapr, errp);
> +        xics_kvm_connect(SPAPR_INTC(spapr->ics), errp);
>      }
>  }
> =20
> @@ -173,7 +173,7 @@ static void spapr_irq_reset_xive(SpaprMachineState =
*spapr, Error **errp)
>  static void spapr_irq_init_kvm_xive(SpaprMachineState *spapr, Error **=
errp)
>  {
>      if (kvm_enabled()) {
> -        kvmppc_xive_connect(spapr->xive, errp);
> +        kvmppc_xive_connect(SPAPR_INTC(spapr->xive), errp);
>      }
>  }
> =20
> @@ -215,7 +215,7 @@ static int spapr_irq_post_load_dual(SpaprMachineSta=
te *spapr, int version_id)
>       */
>      if (spapr_ovec_test(spapr->ov5_cas, OV5_XIVE_EXPLOIT)) {
>          if (kvm_irqchip_in_kernel()) {
> -            xics_kvm_disconnect(spapr, &error_fatal);
> +            xics_kvm_disconnect(SPAPR_INTC(spapr->ics));
>          }
>          spapr_irq_xive.reset(spapr, &error_fatal);
>      }
> @@ -225,8 +225,6 @@ static int spapr_irq_post_load_dual(SpaprMachineSta=
te *spapr, int version_id)
> =20
>  static void spapr_irq_reset_dual(SpaprMachineState *spapr, Error **err=
p)
>  {
> -    Error *local_err =3D NULL;
> -
>      /*
>       * Deactivate the XIVE MMIOs. The XIVE backend will reenable them
>       * if selected.
> @@ -235,18 +233,8 @@ static void spapr_irq_reset_dual(SpaprMachineState=
 *spapr, Error **errp)
> =20
>      /* Destroy all KVM devices */
>      if (kvm_irqchip_in_kernel()) {
> -        xics_kvm_disconnect(spapr, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            error_prepend(errp, "KVM XICS disconnect failed: ");
> -            return;
> -        }
> -        kvmppc_xive_disconnect(spapr->xive, &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            error_prepend(errp, "KVM XIVE disconnect failed: ");
> -            return;
> -        }
> +        xics_kvm_disconnect(SPAPR_INTC(spapr->ics));
> +        kvmppc_xive_disconnect(SPAPR_INTC(spapr->xive));
>      }
> =20
>      spapr_irq_current(spapr)->reset(spapr, errp);
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index ebe156eb30..64972754f9 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -68,8 +68,8 @@ int spapr_xive_end_to_target(uint8_t end_blk, uint32_=
t end_idx,
>  /*
>   * KVM XIVE device helpers
>   */
> -void kvmppc_xive_connect(SpaprXive *xive, Error **errp);
> -void kvmppc_xive_disconnect(SpaprXive *xive, Error **errp);
> +int kvmppc_xive_connect(SpaprInterruptController *intc, Error **errp);
> +void kvmppc_xive_disconnect(SpaprInterruptController *intc);
>  void kvmppc_xive_reset(SpaprXive *xive, Error **errp);
>  void kvmppc_xive_set_source_config(SpaprXive *xive, uint32_t lisn, Xiv=
eEAS *eas,
>                                     Error **errp);
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index 9c9044db65..445beeffef 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -33,8 +33,8 @@
>  #define ICS_SPAPR(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SPAPR)
> =20
>  void ics_spapr_create(SpaprMachineState *spapr, int nr_xirqs, Error **=
errp);
> -int xics_kvm_connect(SpaprMachineState *spapr, Error **errp);
> -void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
> +int xics_kvm_connect(SpaprInterruptController *intc, Error **errp);
> +void xics_kvm_disconnect(SpaprInterruptController *intc);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
> =20
>  #endif /* XICS_SPAPR_H */
>=20


