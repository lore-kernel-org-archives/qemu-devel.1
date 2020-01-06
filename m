Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B37C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B9C20731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 17:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B9C20731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioWDO-0004MQ-EY
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 12:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ioWCD-0003Ou-4q
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ioWCB-0007z5-VZ
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:29:41 -0500
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:46473)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ioWCB-0007se-PX
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 12:29:39 -0500
Received: from player737.ha.ovh.net (unknown [10.108.16.196])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id C8E2712AF58
 for <qemu-devel@nongnu.org>; Mon,  6 Jan 2020 18:29:37 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 59506474C74E;
 Mon,  6 Jan 2020 17:29:33 +0000 (UTC)
Date: Mon, 6 Jan 2020 18:29:31 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] spapr/xive: remove redundant check in spapr_match_nvt()
Message-ID: <20200106182931.54f12057@bahia.lan>
In-Reply-To: <20200106163207.4608-1-clg@kaod.org>
References: <20200106163207.4608-1-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 7962645619541711243
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdehtddguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.111.180
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

On Mon,  6 Jan 2020 17:32:07 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> spapr_match_nvt() is a XIVE operation and it used by the machine to

... and it "is" used by the machine...

> look for a matching target when an event notification is being
> delivered. An assert checks that spapr_match_nvt() is called only when
> the machine has selected the XIVE interrupt mode but it is redundant
> with the XIVE_PRESENTER() dynamic cast.
>=20
> Apply the cast to spapr->active_intc and remove the assert.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e62c89b3dd40..5008b7563173 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4198,19 +4198,19 @@ static void spapr_pic_print_info(InterruptStatsPr=
ovider *obj,
>                     kvm_irqchip_in_kernel() ? "in-kernel" : "emulated");
>  }
> =20
> +/*
> + * This is a XIVE only operation
> + */
>  static int spapr_match_nvt(XiveFabric *xfb, uint8_t format,
>                             uint8_t nvt_blk, uint32_t nvt_idx,
>                             bool cam_ignore, uint8_t priority,
>                             uint32_t logic_serv, XiveTCTXMatch *match)
>  {
>      SpaprMachineState *spapr =3D SPAPR_MACHINE(xfb);
> -    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->xive);
> +    XivePresenter *xptr =3D XIVE_PRESENTER(spapr->active_intc);
>      XivePresenterClass *xpc =3D XIVE_PRESENTER_GET_CLASS(xptr);
>      int count;
> =20
> -    /* This is a XIVE only operation */
> -    assert(spapr->active_intc =3D=3D SPAPR_INTC(spapr->xive));
> -
>      count =3D xpc->match_nvt(xptr, format, nvt_blk, nvt_idx, cam_ignore,
>                             priority, logic_serv, match);
>      if (count < 0) {


