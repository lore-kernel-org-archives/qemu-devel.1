Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88283C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B76216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B76216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50886 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOeov-0000EW-K3
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:54:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hOenW-0007x3-98
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hOenS-0006qI-Qh
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:53:00 -0400
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:35790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hOenS-0006ic-3j
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:52:58 -0400
Received: from player728.ha.ovh.net (unknown [10.108.57.49])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 5B8E55F2FF
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 10:52:51 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player728.ha.ovh.net (Postfix) with ESMTPSA id 444885797301;
	Thu,  9 May 2019 08:52:46 +0000 (UTC)
Date: Thu, 9 May 2019 10:52:45 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Message-ID: <20190509105245.294b60ef@bahia.lan>
In-Reply-To: <20190508171946.657-4-clg@kaod.org>
References: <20190508171946.657-1-clg@kaod.org>
	<20190508171946.657-4-clg@kaod.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 16889343030150928779
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkeehgddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.58.91
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 3/3] spapr/xive: print out the
 EQ page address in the monitor
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

On Wed,  8 May 2019 19:19:46 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> This proved to be a useful information when debugging issues with OS
> event queues allocated above 64GB.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/intc/spapr_xive.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 810435c30cc7..7faf03b1fb7c 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -120,6 +120,7 @@ static int spapr_xive_target_to_end(uint32_t target, =
uint8_t prio,
>  static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
>                                            Monitor *mon)
>  {
> +    uint64_t qaddr_base =3D xive_end_qaddr(end);
>      uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
>      uint32_t qgen =3D xive_get_field32(END_W1_GENERATION, end->w1);
>      uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
> @@ -127,9 +128,9 @@ static void spapr_xive_end_pic_print_info(SpaprXive *=
xive, XiveEND *end,
>      uint32_t nvt =3D xive_get_field32(END_W6_NVT_INDEX, end->w6);
>      uint8_t priority =3D xive_get_field32(END_W7_F0_PRIORITY, end->w7);
> =20
> -    monitor_printf(mon, "%3d/%d % 6d/%5d ^%d",
> +    monitor_printf(mon, "%3d/%d % 6d/%5d @%"PRIx64" ^%d",
>                     spapr_xive_nvt_to_target(0, nvt),
> -                   priority, qindex, qentries, qgen);
> +                   priority, qindex, qentries, qaddr_base, qgen);
> =20
>      xive_end_queue_pic_print_info(end, 6, mon);
>      monitor_printf(mon, "]");


