Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B86C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 07:59:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2D521479
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 07:59:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2D521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38003 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTM9p-00039E-My
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 03:59:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hTM94-0002pA-To
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hTM93-0004yF-OO
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:58:42 -0400
Received: from 16.mo5.mail-out.ovh.net ([87.98.174.144]:35436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hTM93-0004uG-HW
	for qemu-devel@nongnu.org; Wed, 22 May 2019 03:58:41 -0400
Received: from player759.ha.ovh.net (unknown [10.108.57.38])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7834A2363A7
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 09:58:38 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player759.ha.ovh.net (Postfix) with ESMTPSA id D000B60F4B9D;
	Wed, 22 May 2019 07:58:30 +0000 (UTC)
Date: Wed, 22 May 2019 09:58:29 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190522095829.7b688f35@bahia.lan>
In-Reply-To: <20190522044600.16534-22-david@gibson.dropbear.id.au>
References: <20190522044600.16534-1-david@gibson.dropbear.id.au>
	<20190522044600.16534-22-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 84723971913783782
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudduuddguddviecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.174.144
Subject: Re: [Qemu-devel] [PULL 21/38] spapr: Add forgotten capability to
 migration stream
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org, qemu-ppc@nongnu.org,
	qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 22 May 2019 14:45:43 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr machine capabilities are supposed to be sent in the migration stream
> so that we can sanity check the source and destination have compatible
> configuration.  Unfortunately, when we added the hpt-max-page-size
> capability, we forgot to add it to the migration state.  This means that =
we
> can generate spurious warnings when both ends are configured for large
> pages, or potentially fail to warn if the source is configured for huge
> pages, but the destination is not.
>=20
> Fixes: 2309832afda "spapr: Maximum (HPT) pagesize property"
>=20
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Huh... we discussed that it was breaking backward migration:

https://lists.gnu.org/archive/html/qemu-ppc/2019-05/msg00330.html

So I'm a bit surprised to see this in the PR... is it intentional ?

>  hw/ppc/spapr.c         | 1 +
>  hw/ppc/spapr_caps.c    | 1 +
>  include/hw/ppc/spapr.h | 1 +
>  3 files changed, 3 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 8580a8dc67..bcae30ad26 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2125,6 +2125,7 @@ static const VMStateDescription vmstate_spapr =3D {
>          &vmstate_spapr_cap_cfpc,
>          &vmstate_spapr_cap_sbbc,
>          &vmstate_spapr_cap_ibs,
> +        &vmstate_spapr_cap_hpt_maxpagesize,
>          &vmstate_spapr_irq_map,
>          &vmstate_spapr_cap_nested_kvm_hv,
>          &vmstate_spapr_dtb,
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 9b1c10baa6..658eb15a14 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -703,6 +703,7 @@ SPAPR_CAP_MIG_STATE(dfp, SPAPR_CAP_DFP);
>  SPAPR_CAP_MIG_STATE(cfpc, SPAPR_CAP_CFPC);
>  SPAPR_CAP_MIG_STATE(sbbc, SPAPR_CAP_SBBC);
>  SPAPR_CAP_MIG_STATE(ibs, SPAPR_CAP_IBS);
> +SPAPR_CAP_MIG_STATE(hpt_maxpagesize, SPAPR_CAP_HPT_MAXPAGESIZE);
>  SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_KVM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 7e32f309c2..9fc91c8f5e 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -849,6 +849,7 @@ extern const VMStateDescription vmstate_spapr_cap_dfp;
>  extern const VMStateDescription vmstate_spapr_cap_cfpc;
>  extern const VMStateDescription vmstate_spapr_cap_sbbc;
>  extern const VMStateDescription vmstate_spapr_cap_ibs;
> +extern const VMStateDescription vmstate_spapr_cap_hpt_maxpagesize;
>  extern const VMStateDescription vmstate_spapr_cap_nested_kvm_hv;
>  extern const VMStateDescription vmstate_spapr_cap_large_decr;
>  extern const VMStateDescription vmstate_spapr_cap_ccf_assist;


