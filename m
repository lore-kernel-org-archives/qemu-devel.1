Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00A8C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ED9820895
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 17:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ED9820895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXTkz-0000F7-L2
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 12:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iXTkG-0008B0-Ns
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:26:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iXTkF-0006zM-FS
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:26:24 -0500
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:52975)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iXTkF-0006xZ-8o
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 12:26:23 -0500
Received: from player731.ha.ovh.net (unknown [10.109.146.50])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id ED9381146D1
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 18:26:20 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id C6F46C28C6E3;
 Wed, 20 Nov 2019 17:26:15 +0000 (UTC)
Date: Wed, 20 Nov 2019 18:26:12 +0100
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH for-5.0 v5 11/23] ppc/pnv: Introduce a
 pnv_xive_is_cpu_enabled() helper
Message-ID: <20191120182612.3069e279@bahia.lan>
In-Reply-To: <20191115162436.30548-12-clg@kaod.org>
References: <20191115162436.30548-1-clg@kaod.org>
 <20191115162436.30548-12-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 8591742190112184715
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudehtddguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjqdffgfeufgfipdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfedurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.109.80
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

On Fri, 15 Nov 2019 17:24:24 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> and use this helper to exclude CPUs which are not enabled in the XIVE
> controller.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/pnv_xive.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 71ca4961b6b1..4c8c6e51c20f 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -372,6 +372,20 @@ static int pnv_xive_get_eas(XiveRouter *xrtr, uint8_=
t blk, uint32_t idx,
>      return pnv_xive_vst_read(xive, VST_TSEL_IVT, blk, idx, eas);
>  }
> =20
> +static int cpu_pir(PowerPCCPU *cpu)
> +{
> +    CPUPPCState *env =3D &cpu->env;
> +    return env->spr_cb[SPR_PIR].default_value;
> +}
> +
> +static bool pnv_xive_is_cpu_enabled(PnvXive *xive, PowerPCCPU *cpu)
> +{
> +    int pir =3D cpu_pir(cpu);
> +    int thrd_id =3D pir & 0x7f;
> +
> +    return xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(thrd_id);

A similar check is open-coded in pnv_xive_get_indirect_tctx() :

    /* Check that HW thread is XIVE enabled */
    if (!(xive->regs[PC_THREAD_EN_REG0 >> 3] & PPC_BIT(pir & 0x3f))) {
        xive_error(xive, "IC: CPU %x is not enabled", pir);
    }

The thread id is only the 6 lower bits of the PIR there, and so seems to
indicate the skiboot sources:

        /* Get bit in register */
        bit =3D c->pir & 0x3f;

Why make it pir & 0x7f here ? If it should actually be 0x3f, maybe also use
the helper in pnv_xive_get_indirect_tctx().

> +}
> +
>  static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>                                uint8_t nvt_blk, uint32_t nvt_idx,
>                                bool cam_ignore, uint8_t priority,
> @@ -393,6 +407,10 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, u=
int8_t format,
>              XiveTCTX *tctx;
>              int ring;
> =20
> +            if (!pnv_xive_is_cpu_enabled(xive, cpu)) {
> +                continue;
> +            }
> +
>              tctx =3D XIVE_TCTX(pnv_cpu_state(cpu)->intc);
> =20
>              /*


