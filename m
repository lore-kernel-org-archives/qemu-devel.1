Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C48C3A5A6
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27EB320835
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 05:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27EB320835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCH7c-0006Vw-1D
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 01:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iCH6q-00064l-AS
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:42:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iCH6j-0002oH-8U
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:42:04 -0400
Received: from 15.mo1.mail-out.ovh.net ([188.165.38.232]:56611)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iCH6i-0002iB-Tz
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 01:41:57 -0400
Received: from player758.ha.ovh.net (unknown [10.108.35.59])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id F1399190169
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 07:41:47 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player758.ha.ovh.net (Postfix) with ESMTPSA id 09E71A201B61;
 Mon, 23 Sep 2019 05:41:35 +0000 (UTC)
Subject: Re: [PATCH 03/15] ipmi: Generate an interrupt on watchdog pretimeout
 expiry
To: minyard@acm.org, Peter Maydell <peter.maydell@linaro.org>
References: <20190919213924.31852-1-minyard@acm.org>
 <20190919213924.31852-4-minyard@acm.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <7d28ad10-c925-ea06-05de-5691e50083ef@kaod.org>
Date: Mon, 23 Sep 2019 07:41:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190919213924.31852-4-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6564840882969283512
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdejgddutdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.38.232
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
Cc: Corey Minyard <cminyard@mvista.com>, Fam Zheng <famz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/09/2019 23:39, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Add the watchdog pretimeout to the bits that cause an interrupt on attn=
.
> Otherwise the user won't know.
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

C.

> ---
>  hw/ipmi/ipmi_bmc_sim.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index afb99e33d7..6e6cd1b47d 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -477,7 +477,9 @@ static int attn_set(IPMIBmcSim *ibs)
> =20
>  static int attn_irq_enabled(IPMIBmcSim *ibs)
>  {
> -    return (IPMI_BMC_MSG_INTS_ON(ibs) && IPMI_BMC_MSG_FLAG_RCV_MSG_QUE=
UE_SET(ibs))
> +    return (IPMI_BMC_MSG_INTS_ON(ibs) &&
> +            (IPMI_BMC_MSG_FLAG_RCV_MSG_QUEUE_SET(ibs) ||
> +             IPMI_BMC_MSG_FLAG_WATCHDOG_TIMEOUT_MASK_SET(ibs)))
>          || (IPMI_BMC_EVBUF_FULL_INT_ENABLED(ibs) &&
>              IPMI_BMC_MSG_FLAG_EVT_BUF_FULL_SET(ibs));
>  }
>=20


