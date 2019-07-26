Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50C8BC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29AA421901
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 15:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29AA421901
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1jN-0006AO-OX
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 11:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hr1j9-0005dV-Pf
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:01:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hr1j8-0005nI-Df
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:01:47 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:49483)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hr1j8-0005jR-3I
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 11:01:46 -0400
Received: from player157.ha.ovh.net (unknown [10.109.143.189])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 84A461A7C6E
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 17:01:43 +0200 (CEST)
Received: from kaod.org (bad36-1-78-202-132-1.fbx.proxad.net [78.202.132.1])
 (Authenticated sender: clg@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 7CCB084971DB;
 Fri, 26 Jul 2019 15:01:37 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156415227297.1064338.9181963275184520284.stgit@bahia.lan>
 <156415228966.1064338.190189424190233355.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <523c8643-13ba-7f1f-f2b5-86ce5812e564@kaod.org>
Date: Fri, 26 Jul 2019 17:01:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156415228966.1064338.190189424190233355.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 1573726597713922899
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkeeggdekgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.52.147
Subject: Re: [Qemu-devel] [PATCH 3/3] spapr/irq: Drop spapr_irq_msi_reset()
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

On 26/07/2019 16:44, Greg Kurz wrote:
> PHBs already take care of clearing the MSIs from the bitmap during rese=
t
> or unplug. No need to do this globally from the machine code. Rather ad=
d
> an assert to ensure that PHBs have acted as expected.

This works because spar_irq_reset() is called after qemu_devices_reset().=
=20
I guess this is fine.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/ppc/spapr.c             |    4 ----
>  hw/ppc/spapr_irq.c         |    7 ++-----
>  include/hw/ppc/spapr_irq.h |    1 -
>  3 files changed, 2 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 5894329f29a9..855e9fbd9805 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1739,10 +1739,6 @@ static void spapr_machine_reset(MachineState *ma=
chine)
>          ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fa=
tal);
>      }
> =20
> -    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
> -        spapr_irq_msi_reset(spapr);
> -    }
> -
>      /*
>       * NVLink2-connected GPU RAM needs to be placed on a separate NUMA=
 node.
>       * We assign a new numa ID per GPU in spapr_pci_collect_nvgpu() wh=
ich is
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index d07aed8ca9f9..c72d8433681d 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -57,11 +57,6 @@ void spapr_irq_msi_free(SpaprMachineState *spapr, in=
t irq, uint32_t num)
>      bitmap_clear(spapr->irq_map, irq - SPAPR_IRQ_MSI, num);
>  }
> =20
> -void spapr_irq_msi_reset(SpaprMachineState *spapr)
> -{
> -    bitmap_clear(spapr->irq_map, 0, spapr->irq_map_nr);
> -}
> -
>  static void spapr_irq_init_kvm(SpaprMachineState *spapr,
>                                    SpaprIrq *irq, Error **errp)
>  {
> @@ -729,6 +724,8 @@ int spapr_irq_post_load(SpaprMachineState *spapr, i=
nt version_id)
> =20
>  void spapr_irq_reset(SpaprMachineState *spapr, Error **errp)
>  {
> +    assert(bitmap_empty(spapr->irq_map, spapr->irq_map_nr));
> +
>      if (spapr->irq->reset) {
>          spapr->irq->reset(spapr, errp);
>      }
> diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
> index f965a58f8954..44fe4f9e0e2e 100644
> --- a/include/hw/ppc/spapr_irq.h
> +++ b/include/hw/ppc/spapr_irq.h
> @@ -28,7 +28,6 @@ void spapr_irq_msi_init(SpaprMachineState *spapr, uin=
t32_t nr_msis);
>  int spapr_irq_msi_alloc(SpaprMachineState *spapr, uint32_t num, bool a=
lign,
>                          Error **errp);
>  void spapr_irq_msi_free(SpaprMachineState *spapr, int irq, uint32_t nu=
m);
> -void spapr_irq_msi_reset(SpaprMachineState *spapr);
> =20
>  typedef struct SpaprIrq {
>      uint32_t    nr_irqs;
>=20


