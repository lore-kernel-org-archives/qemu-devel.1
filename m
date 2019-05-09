Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9720BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA9A21479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA9A21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50822 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOek3-0005bx-NY
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:49:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hOej5-0005Bo-FU
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hOej4-0001gi-Hi
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:48:27 -0400
Received: from 10.mo5.mail-out.ovh.net ([46.105.52.148]:58535)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hOej4-0001fO-CV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:48:26 -0400
Received: from player760.ha.ovh.net (unknown [10.109.160.153])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id BF86E22EBF5
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 10:48:23 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player760.ha.ovh.net (Postfix) with ESMTPSA id 86A77592E9AF;
	Thu,  9 May 2019 08:48:18 +0000 (UTC)
Date: Thu, 9 May 2019 10:48:17 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190509104817.622677d7@bahia.lan>
In-Reply-To: <20190508171946.657-2-clg@kaod.org>
References: <20190508171946.657-1-clg@kaod.org>
	<20190508171946.657-2-clg@kaod.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 16813907735977105803
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkeehgddtkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.52.148
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/3] spapr/xive: EQ page should
 be naturally aligned
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed,  8 May 2019 19:19:44 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> When the OS configures the EQ page in which to receive event
> notifications from the XIVE interrupt controller, the page should be
> naturally aligned. Add this check.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/spapr_xive.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 097f88d4608d..666e24e9b447 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -993,6 +993,12 @@ static target_ulong h_int_set_queue_config(PowerPCCP=
U *cpu,
>      case 16:
>      case 21:
>      case 24:
> +        if (!QEMU_IS_ALIGNED(qpage, 1ul << qsize)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: EQ @0x%" HWADDR_PRIx
> +                          " is not naturally aligned with %" HWADDR_PRIx=
 "\n",
> +                          qpage, 1ul << qsize);
> +            return H_P4;
> +        }
>          end.w2 =3D cpu_to_be32((qpage >> 32) & 0x0fffffff);
>          end.w3 =3D cpu_to_be32(qpage & 0xffffffff);
>          end.w0 |=3D cpu_to_be32(END_W0_ENQUEUE);


