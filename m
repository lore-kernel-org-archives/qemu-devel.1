Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063F6C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:05:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF151222D3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF151222D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX47v-0008Kx-04
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:05:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iX479-0007u4-HD
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:04:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iX478-0001zp-6b
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:04:19 -0500
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:42744)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iX478-0001zI-0c
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:04:18 -0500
Received: from player718.ha.ovh.net (unknown [10.109.159.73])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 78D4525AC27
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:04:15 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player718.ha.ovh.net (Postfix) with ESMTPSA id 6B219C35FDF5;
 Tue, 19 Nov 2019 14:04:10 +0000 (UTC)
Date: Tue, 19 Nov 2019 15:04:03 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 02/23] ppc/xive: Introduce helpers for the
 NVT id
Message-ID: <20191119150403.02a78ace@bahia.lan>
In-Reply-To: <20191115162436.30548-3-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-3-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 17752626784658561419
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjedukedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.32.116.78
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

On Fri, 15 Nov 2019 17:24:15 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Each vCPU in the system is identified with an NVT identifier which is
> pushed in the OS CAM line (QW1W2) of the HW thread interrupt context
> register when the vCPU is dispatched on a HW thread. This identifier
> is used by the presenter subengine to find a matching target to notify
> of an event. It is also used to fetch the associate NVT structure
> which may contain pending interrupts that need a resend.
>=20
> Add a couple of helpers for the NVT ids. The NVT space is 19 bits
> wide, giving a maximum of 512K per chip.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h      |  5 -----
>  include/hw/ppc/xive_regs.h | 21 +++++++++++++++++++++
>  2 files changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 8fd439ec9bba..fa7adf87feb2 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -418,11 +418,6 @@ Object *xive_tctx_create(Object *cpu, XiveRouter *xr=
tr, Error **errp);
>  void xive_tctx_reset(XiveTCTX *tctx);
>  void xive_tctx_destroy(XiveTCTX *tctx);
> =20
> -static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
> -{
> -    return (nvt_blk << 19) | nvt_idx;
> -}
> -
>  /*
>   * KVM XIVE device helpers
>   */
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 530f232b04f8..1a5622f8ded8 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -272,4 +272,25 @@ typedef struct XiveNVT {
> =20
>  #define xive_nvt_is_valid(nvt)    (be32_to_cpu((nvt)->w0) & NVT_W0_VALID)
> =20
> +/*
> + * The VP number space in a block is defined by the END_W6_NVT_INDEX
> + * field of the XIVE END
> + */
> +#define XIVE_NVT_SHIFT                19
> +
> +static inline uint32_t xive_nvt_cam_line(uint8_t nvt_blk, uint32_t nvt_i=
dx)
> +{
> +    return (nvt_blk << XIVE_NVT_SHIFT) | nvt_idx;

Shouldn't we ensure nvt_idx fits in the 19 bits ?

> +}
> +
> +static inline uint32_t xive_nvt_idx(uint32_t cam_line)
> +{
> +    return cam_line & ((1 << XIVE_NVT_SHIFT) - 1);
> +}
> +
> +static inline uint32_t xive_nvt_blk(uint32_t cam_line)
> +{
> +    return (cam_line >> XIVE_NVT_SHIFT) & 0xf;
> +}
> +
>  #endif /* PPC_XIVE_REGS_H */


