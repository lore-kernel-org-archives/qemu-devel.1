Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70A10C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A744206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 15:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A744206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heLG4-0002Ml-Dv
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 11:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1heL75-0003Ul-PK
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:06:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1heL73-000676-Jk
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:06:03 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:48713)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1heL71-0005yu-KM
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 11:06:00 -0400
Received: from player718.ha.ovh.net (unknown [10.108.35.13])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 25AC023FF08
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2019 17:05:50 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player718.ha.ovh.net (Postfix) with ESMTPSA id E253570AB7AD;
 Fri, 21 Jun 2019 15:05:45 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156112873945.115975.15513090884722011930.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dad9ca85-4849-bfb0-0e09-8082ed64ecbc@kaod.org>
Date: Fri, 21 Jun 2019 17:05:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156112873945.115975.15513090884722011930.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 17459892806492064595
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrtdeigdekkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.107.29
Subject: Re: [Qemu-devel] [PATCH] spapr/xive: H_INT_ESB is used for LSIs only
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

On 21/06/2019 16:52, Greg Kurz wrote:
> As indicated in the function header, this "hcall is only supported for
> LISNs that have the ESB hcall flag set to 1 when returned from hcall()
> H_INT_GET_SOURCE_INFO". We only set that flag for LSIs actually.
>=20
> Check that in h_int_esb().

Indeed. H_INT_ESB should work on any IRQ, but I think it's better=20
to check that the HCALL is only used with the IRQ requiring it.  =20

> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/spapr_xive.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 58c2e5d890bd..01dd47ad5b02 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -1408,6 +1408,12 @@ static target_ulong h_int_esb(PowerPCCPU *cpu,
>          return H_P2;
>      }
> =20
> +    if (!xive_source_irq_is_lsi(xsrc, lisn)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: LISN " TARGET_FMT_lx "is=
n't LSI\n",
> +                      lisn);
> +        return H_P2;
> +    }
> +
>      if (offset > (1ull << xsrc->esb_shift)) {
>          return H_P3;
>      }
>=20


