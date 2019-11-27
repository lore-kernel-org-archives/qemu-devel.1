Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D79BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:54:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5133F20665
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5133F20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZt5m-0007qu-Eo
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 03:54:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45376)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iZt2L-0003LM-KW
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iZt2K-0000ca-4p
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:51:01 -0500
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:36279)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iZt2J-0000bO-U2
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:51:00 -0500
Received: from player770.ha.ovh.net (unknown [10.108.42.88])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 9C78B14E5A9
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2019 09:50:57 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player770.ha.ovh.net (Postfix) with ESMTPSA id AE56EC998480;
 Wed, 27 Nov 2019 08:50:52 +0000 (UTC)
Date: Wed, 27 Nov 2019 09:50:50 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v6 16/20] ppc/xive: Introduce a xive_tctx_ipb_update()
 helper
Message-ID: <20191127095050.2e916a03@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191125065820.927-17-clg@kaod.org>
References: <20191125065820.927-1-clg@kaod.org>
 <20191125065820.927-17-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 4102779262143207819
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeigedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.62.179
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

On Mon, 25 Nov 2019 07:58:16 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> We will use it to resend missed interrupts when a vCPU context is
> pushed on a HW thread.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/xive.h |  1 +
>  hw/intc/xive.c        | 21 +++++++++++----------
>  2 files changed, 12 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 24315480e7c2..9c0bf2c301e2 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -469,6 +469,7 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, Monitor=
 *mon);
>  Object *xive_tctx_create(Object *cpu, XiveRouter *xrtr, Error **errp);
>  void xive_tctx_reset(XiveTCTX *tctx);
>  void xive_tctx_destroy(XiveTCTX *tctx);
> +void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
> =20
>  /*
>   * KVM XIVE device helpers
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 4bff3abdc3eb..7047e45daca1 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -47,12 +47,6 @@ static uint8_t ipb_to_pipr(uint8_t ibp)
>      return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
>  }
> =20
> -static void ipb_update(uint8_t *regs, uint8_t priority)
> -{
> -    regs[TM_IPB] |=3D priority_to_ipb(priority);
> -    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
> -}
> -
>  static uint8_t exception_mask(uint8_t ring)
>  {
>      switch (ring) {
> @@ -135,6 +129,15 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8=
_t ring, uint8_t cppr)
>      xive_tctx_notify(tctx, ring);
>  }
> =20
> +void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
> +{
> +    uint8_t *regs =3D &tctx->regs[ring];
> +
> +    regs[TM_IPB] |=3D ipb;
> +    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
> +    xive_tctx_notify(tctx, ring);
> +}
> +

Maybe rename the helper to xive_tctx_update_ipb_and_notify() to
make it clear this raises an irq in the end ?

This can be done as follow-up though and the rest looks good, so:

Reviewed-by: Greg Kurz <groug@kaod.org>

>  static inline uint32_t xive_tctx_word2(uint8_t *ring)
>  {
>      return *((uint32_t *) &ring[TM_WORD2]);
> @@ -336,8 +339,7 @@ static void xive_tm_set_os_cppr(XivePresenter *xptr, =
XiveTCTX *tctx,
>  static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
>                                     hwaddr offset, uint64_t value, unsign=
ed size)
>  {
> -    ipb_update(&tctx->regs[TM_QW1_OS], value & 0xff);
> -    xive_tctx_notify(tctx, TM_QW1_OS);
> +    xive_tctx_ipb_update(tctx, TM_QW1_OS, priority_to_ipb(value & 0xff));
>  }
> =20
>  static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
> @@ -1429,8 +1431,7 @@ static bool xive_presenter_notify(uint8_t format,
> =20
>      /* handle CPU exception delivery */
>      if (count) {
> -        ipb_update(&match.tctx->regs[match.ring], priority);
> -        xive_tctx_notify(match.tctx, match.ring);
> +        xive_tctx_ipb_update(match.tctx, match.ring, priority_to_ipb(pri=
ority));
>      }
> =20
>      return !!count;


