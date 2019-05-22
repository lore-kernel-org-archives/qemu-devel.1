Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5992C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A340217D4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A340217D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOWL-0002Br-RR
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:30:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hTOV7-0001ZS-5j
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hTOV5-0004xI-Q8
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:29:37 -0400
Received: from 1.mo7.mail-out.ovh.net ([178.33.45.51]:58020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hTOV5-0004wK-Ka
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:29:35 -0400
Received: from player770.ha.ovh.net (unknown [10.109.160.226])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 192B7115ED1
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 12:29:32 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player770.ha.ovh.net (Postfix) with ESMTPSA id BE4EE60B784E;
	Wed, 22 May 2019 10:29:25 +0000 (UTC)
Date: Wed, 22 May 2019 12:29:24 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190522122924.1d254c81@bahia.lan>
In-Reply-To: <20190522074016.10521-3-clg@kaod.org>
References: <20190522074016.10521-1-clg@kaod.org>
	<20190522074016.10521-3-clg@kaod.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 2633479885324720523
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudduvddgvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.45.51
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/2] spapr: change default
 interrupt mode to 'dual'
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 09:40:16 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> Now that XIVE support is complete (QEMU emulated and KVM devices),
> change the pseries machine to advertise both interrupt modes: XICS
> (P7/P8) and XIVE (P9).
>=20
> The machine default interrupt modes depends on the version. Current
> settings are:
>=20
>     pseries   default interrupt mode
>=20
>     4.1       dual
>     4.0       xics
>     3.1       xics
>     3.0       legacy xics (different IRQ number space layout)
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

At last ! :)

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 39e698e9b013..4fd16b43f014 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4352,7 +4352,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc, &error_abort);
> -    smc->irq =3D &spapr_irq_xics;
> +    smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
>  }
> =20
> @@ -4430,6 +4430,7 @@ static void spapr_machine_4_0_class_options(Machine=
Class *mc)
>      spapr_machine_4_1_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_4_0, hw_compat_4_0_len);
>      smc->phb_placement =3D phb_placement_4_0;
> +    smc->irq =3D &spapr_irq_xics;
>  }
> =20
>  DEFINE_SPAPR_MACHINE(4_0, "4.0", false);


