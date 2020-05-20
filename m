Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7853C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74699207D4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 14:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74699207D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbQ2e-00045g-MS
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 10:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jbPxn-0006xy-VY
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:44:55 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:35300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jbPxl-0002U9-MG
 for qemu-devel@nongnu.org; Wed, 20 May 2020 10:44:55 -0400
Received: from player726.ha.ovh.net (unknown [10.110.103.121])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id CEA5E13AA4A
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 16:44:50 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id 4985F127CEDEE;
 Wed, 20 May 2020 14:44:46 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G0065a90287b-f85a-4872-a28b-d452051a3724,D4AE9CB3A4750E3488E7135F1D4D455A9A9A4933)
 smtp.auth=groug@kaod.org
Date: Wed, 20 May 2020 16:44:45 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 7/9] ppc/pnv: Add POWER10 quads
Message-ID: <20200520164445.1c8a03a1@bahia.lan>
In-Reply-To: <20200513151109.453530-8-clg@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
 <20200513151109.453530-8-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 4783385756989364619
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtledgjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueekjeekiefffedtveeukedvteejgeeivefhgfejgfdtleduvdfgfeelkeeuveeunecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejvdeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.44.159; envelope-from=groug@kaod.org;
 helo=7.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 10:44:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On Wed, 13 May 2020 17:11:07 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Still needs some refinements on the XSCOM registers.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/pnv.h |  4 ++++
>  hw/ppc/pnv.c         | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>=20
> diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
> index 3ff610a9c7b5..86bfa2107a8c 100644
> --- a/include/hw/ppc/pnv.h
> +++ b/include/hw/ppc/pnv.h
> @@ -123,6 +123,10 @@ typedef struct Pnv10Chip {
>      Pnv9Psi      psi;
>      PnvLpcController lpc;
>      PnvOCC       occ;
> +
> +    uint32_t     nr_quads;
> +    PnvQuad      *quads;
> +
>  } Pnv10Chip;
> =20
>  #define PNV10_PIR2FUSEDCORE(pir) (((pir) >> 3) & 0xf)
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9f1698a74467..fc751dd575d4 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1621,6 +1621,33 @@ static void pnv_chip_power10_instance_init(Object =
*obj)
>                              TYPE_PNV10_OCC, &error_abort, NULL);
>  }
> =20
> +
> +static void pnv_chip_power10_quad_realize(Pnv10Chip *chip10, Error **err=
p)
> +{
> +    PnvChip *chip =3D PNV_CHIP(chip10);
> +    int i;
> +
> +    chip10->nr_quads =3D DIV_ROUND_UP(chip->nr_cores, 4);
> +    chip10->quads =3D g_new0(PnvQuad, chip10->nr_quads);
> +
> +    for (i =3D 0; i < chip10->nr_quads; i++) {
> +        char eq_name[32];
> +        PnvQuad *eq =3D &chip10->quads[i];
> +        PnvCore *pnv_core =3D chip->cores[i * 4];
> +        int core_id =3D CPU_CORE(pnv_core)->core_id;
> +
> +        snprintf(eq_name, sizeof(eq_name), "eq[%d]", core_id);
> +        object_initialize_child(OBJECT(chip), eq_name, eq, sizeof(*eq),
> +                                TYPE_PNV_QUAD, &error_fatal, NULL);
> +
> +        object_property_set_int(OBJECT(eq), core_id, "id", &error_fatal);
> +        object_property_set_bool(OBJECT(eq), true, "realized", &error_fa=
tal);
> +
> +        pnv_xscom_add_subregion(chip, PNV10_XSCOM_EQ_BASE(eq->id),
> +                                &eq->xscom_regs);
> +    }
> +}

So, this function is mostly identical to the P9 variant, except the xscom
offset. Unless the refinements envisioned in the changelog bring substantial
change, I'd suggest to move this to a common helper and call it from dedica=
ted
P9 and P10 realize functions.

> +
>  static void pnv_chip_power10_realize(DeviceState *dev, Error **errp)
>  {
>      PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
> @@ -1642,6 +1669,12 @@ static void pnv_chip_power10_realize(DeviceState *=
dev, Error **errp)
>          return;
>      }
> =20
> +    pnv_chip_power10_quad_realize(chip10, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      /* XIVE2 interrupt controller (POWER10) */
>      object_property_set_int(OBJECT(&chip10->xive), PNV10_XIVE2_IC_BASE(c=
hip),
>                              "ic-bar", &error_fatal);


