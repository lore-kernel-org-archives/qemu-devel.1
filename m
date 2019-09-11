Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC97C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56652084D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 14:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56652084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i83Pf-0005cx-3P
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 10:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i83OY-0004ch-DW
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i83OX-0005qD-5B
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:14:54 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:58652)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i83OW-0005pU-VU
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 10:14:53 -0400
Received: from player760.ha.ovh.net (unknown [10.108.54.230])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id DCA32789FD
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 16:14:50 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player760.ha.ovh.net (Postfix) with ESMTPSA id 63EFD9B6E04D;
 Wed, 11 Sep 2019 14:14:44 +0000 (UTC)
Date: Wed, 11 Sep 2019 16:14:25 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190911161425.1b08de6b@bahia.lan>
In-Reply-To: <20190911133937.2716-3-clg@kaod.org>
References: <20190911133937.2716-1-clg@kaod.org>
 <20190911133937.2716-3-clg@kaod.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 97390343945951627
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtdefgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.76.150
Subject: Re: [Qemu-devel] [PATCH v2 2/2] spapr/irq: Only claim VALID
 interrupts at the KVM level
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
Cc: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 15:39:37 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> A typical pseries VM with 16 vCPUs, one disk, one network adapater
> uses less than 100 interrupts but the whole IRQ number space of the
> QEMU machine is allocated at reset time and it is 8K wide. This is
> wasting a considerable amount of interrupt numbers in the global IRQ
> space which has 1M interrupts per socket on a POWER9.
>=20
> To optimise the HW resources, only request at the KVM level interrupts
> which have been claimed by the guest. This will help to increase the
> maximum number of VMs per system and also help supporting nested guests
> using the XIVE interrupt mode.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/spapr_xive_kvm.c | 29 ++++++++++++++++++++++++++---
>  hw/intc/xics_kvm.c       |  8 ++++++++
>  2 files changed, 34 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 17af4d19f54e..71b88d7797bc 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -255,11 +255,16 @@ void kvmppc_xive_source_reset_one(XiveSource *xsrc,=
 int srcno, Error **errp)
> =20
>  static void kvmppc_xive_source_reset(XiveSource *xsrc, Error **errp)
>  {
> +    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
>      int i;
> =20
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
>          Error *local_err =3D NULL;
> =20
> +        if (!xive_eas_is_valid(&xive->eat[i])) {
> +            continue;
> +        }
> +
>          kvmppc_xive_source_reset_one(xsrc, i, &local_err);
>          if (local_err) {
>              error_propagate(errp, local_err);
> @@ -328,11 +333,18 @@ uint64_t kvmppc_xive_esb_rw(XiveSource *xsrc, int s=
rcno, uint32_t offset,
> =20
>  static void kvmppc_xive_source_get_state(XiveSource *xsrc)
>  {
> +    SpaprXive *xive =3D SPAPR_XIVE(xsrc->xive);
>      int i;
> =20
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> +        uint8_t pq;
> +
> +        if (!xive_eas_is_valid(&xive->eat[i])) {
> +            continue;
> +        }
> +
>          /* Perform a load without side effect to retrieve the PQ bits */
> -        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> +        pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> =20
>          /* and save PQ locally */
>          xive_source_esb_set(xsrc, i, pq);
> @@ -521,9 +533,14 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
>       */
>      if (running) {
>          for (i =3D 0; i < xsrc->nr_irqs; i++) {
> -            uint8_t pq =3D xive_source_esb_get(xsrc, i);
> +            uint8_t pq;
>              uint8_t old_pq;
> =20
> +            if (!xive_eas_is_valid(&xive->eat[i])) {
> +                continue;
> +            }
> +
> +            pq =3D xive_source_esb_get(xsrc, i);
>              old_pq =3D xive_esb_read(xsrc, i, XIVE_ESB_SET_PQ_00 + (pq <=
< 8));
> =20
>              /*
> @@ -545,7 +562,13 @@ static void kvmppc_xive_change_state_handler(void *o=
paque, int running,
>       * migration is in progress.
>       */
>      for (i =3D 0; i < xsrc->nr_irqs; i++) {
> -        uint8_t pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> +        uint8_t pq;
> +
> +        if (!xive_eas_is_valid(&xive->eat[i])) {
> +            continue;
> +        }
> +
> +        pq =3D xive_esb_read(xsrc, i, XIVE_ESB_GET);
> =20
>          /*
>           * PQ is set to PENDING to possibly catch a triggered
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index a4d2e876cc5f..ba90d6dc966c 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -190,6 +190,10 @@ void ics_get_kvm_state(ICSState *ics)
>      for (i =3D 0; i < ics->nr_irqs; i++) {
>          ICSIRQState *irq =3D &ics->irqs[i];
> =20
> +        if (ics_irq_free(ics, i)) {
> +            continue;
> +        }
> +
>          kvm_device_access(kernel_xics_fd, KVM_DEV_XICS_GRP_SOURCES,
>                            i + ics->offset, &state, false, &error_fatal);
> =20
> @@ -301,6 +305,10 @@ int ics_set_kvm_state(ICSState *ics, Error **errp)
>          Error *local_err =3D NULL;
>          int ret;
> =20
> +        if (ics_irq_free(ics, i)) {
> +            continue;
> +        }
> +
>          ret =3D ics_set_kvm_state_one(ics, i, &local_err);
>          if (ret < 0) {
>              error_propagate(errp, local_err);


