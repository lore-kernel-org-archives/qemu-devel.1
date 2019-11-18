Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B29C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68FDF20857
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68FDF20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWjEB-0007zW-Kn
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iWjCT-0006om-3U
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:44:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iWjCR-0004VC-PC
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:44:25 -0500
Received: from 5.mo2.mail-out.ovh.net ([87.98.181.248]:57590)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iWjCQ-0004Su-6c
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:44:23 -0500
Received: from player688.ha.ovh.net (unknown [10.109.160.253])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id B82B11B50A7
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 16:44:19 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 96E4DC2A18A3;
 Mon, 18 Nov 2019 15:44:14 +0000 (UTC)
Date: Mon, 18 Nov 2019 16:44:11 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 01/23] ppc/xive: Record the IPB in the
 associated NVT
Message-ID: <20191118164411.2045c2e2@bahia.lan>
In-Reply-To: <20191115162436.30548-2-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-2-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 13570190103889156491
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegiedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.181.248
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

On Fri, 15 Nov 2019 17:24:14 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> When an interrupt can not be presented to a vCPU, because it is not
> running on any of the HW treads, the XIVE presenter updates the
> Interrupt Pending Buffer register of the associated XIVE NVT
> structure. This is only done if backlog is activated in the END but
> this is generally the case.
>=20
> The current code assumes that the fields of the NVT structure is
> architected with the same layout of the thread interrupt context
> registers. Fix this assumption and define an offset for the IPB
> register backup value in the NVT.
>=20

Does this fix a visible bug in the powernv machine ? If so,
maybe worth describing the symptoms.

Anyway, this seems conforment to the XIVE spec I have, so FWIW:

Reviewed-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive_regs.h |  1 +
>  hw/intc/xive.c             | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 55307cd1533c..530f232b04f8 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -255,6 +255,7 @@ typedef struct XiveNVT {
>          uint32_t        w2;
>          uint32_t        w3;
>          uint32_t        w4;
> +#define NVT_W4_IPB               PPC_BITMASK32(16, 23)
>          uint32_t        w5;
>          uint32_t        w6;
>          uint32_t        w7;
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 3d472e29c858..177663d2b43e 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1607,14 +1607,21 @@ static void xive_router_end_notify(XiveRouter *xr=
tr, uint8_t end_blk,
>       * - logical server : forward request to IVPE (not supported)
>       */
>      if (xive_end_is_backlog(&end)) {
> +        uint8_t ipb;
> +
>          if (format =3D=3D 1) {
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "XIVE: END %x/%x invalid config: F1 & backlog\=
n",
>                            end_blk, end_idx);
>              return;
>          }
> -        /* Record the IPB in the associated NVT structure */
> -        ipb_update((uint8_t *) &nvt.w4, priority);
> +        /*
> +         * Record the IPB in the associated NVT structure for later
> +         * use. The presenter will resend the interrupt when the vCPU
> +         * is dispatched again on a HW thread.
> +         */
> +        ipb =3D xive_get_field32(NVT_W4_IPB, nvt.w4) | priority_to_ipb(p=
riority);
> +        nvt.w4 =3D xive_set_field32(NVT_W4_IPB, nvt.w4, ipb);
>          xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
> =20
>          /*


