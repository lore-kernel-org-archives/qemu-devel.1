Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B910EC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42DA0206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 16:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42DA0206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBLSG-0000UN-SN
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 12:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iBLAv-00027D-Uz
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:50:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iBLAq-0004up-P7
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:50:25 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:33841)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iBLAq-0004u5-J4
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 11:50:20 -0400
Received: from player735.ha.ovh.net (unknown [10.109.160.232])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id EF653201AE9
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 17:50:17 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id C969FA10B912;
 Fri, 20 Sep 2019 15:50:05 +0000 (UTC)
Subject: Re: [PATCH 02/15] ipmi: Fix the get watchdog command
To: minyard@acm.org, Peter Maydell <peter.maydell@linaro.org>
References: <20190919213924.31852-1-minyard@acm.org>
 <20190919213924.31852-3-minyard@acm.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <998c62cf-4a36-3f9a-1c50-953108967a79@kaod.org>
Date: Fri, 20 Sep 2019 17:50:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919213924.31852-3-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 17670154615394569144
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddvgdelfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.179.66
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
> It wasn't returning the set timeout like it should have been.

Looking at=20

  27.7 Get Watchdog Timer Command

This looks correct.


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>  hw/ipmi/ipmi_bmc_sim.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> index 8f63bb7181..afb99e33d7 100644
> --- a/hw/ipmi/ipmi_bmc_sim.c
> +++ b/hw/ipmi/ipmi_bmc_sim.c
> @@ -1228,6 +1228,8 @@ static void get_watchdog_timer(IPMIBmcSim *ibs,
>      rsp_buffer_push(rsp, ibs->watchdog_action);
>      rsp_buffer_push(rsp, ibs->watchdog_pretimeout);
>      rsp_buffer_push(rsp, ibs->watchdog_expired);
> +    rsp_buffer_push(rsp, ibs->watchdog_timeout & 0xff);
> +    rsp_buffer_push(rsp, (ibs->watchdog_timeout >> 8) & 0xff);
>      if (ibs->watchdog_running) {
>          long timeout;
>          timeout =3D ((ibs->watchdog_expiry - ipmi_getmonotime() + 5000=
0000)
>=20


