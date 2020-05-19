Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2323AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:19:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFBA1206D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 09:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFBA1206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jayP0-000854-84
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 05:19:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jayON-0007YW-BV
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:18:31 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:43470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jayOM-0003HM-Bo
 for qemu-devel@nongnu.org; Tue, 19 May 2020 05:18:31 -0400
Received: from player738.ha.ovh.net (unknown [10.110.208.220])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id 2AAB98D102
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:18:20 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id D58E1129DB05E;
 Tue, 19 May 2020 09:18:16 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002b4001553-1dd6-4e3f-80e3-f3e556ea751f,70C5C5024F1CAF4ABF6ABE2DC9B39611306C745C)
 smtp.auth=groug@kaod.org
Date: Tue, 19 May 2020 11:18:15 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/9] ppc/xive: Export xive_presenter_notify()
Message-ID: <20200519111815.67b3a5b7@bahia.lan>
In-Reply-To: <20200513151109.453530-3-clg@kaod.org>
References: <20200513151109.453530-1-clg@kaod.org>
 <20200513151109.453530-3-clg@kaod.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 11843341123563919755
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddtjedgudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepueekjeekiefffedtveeukedvteejgeeivefhgfejgfdtleduvdfgfeelkeeuveeunecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.73.241; envelope-from=groug@kaod.org;
 helo=10.mo69.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/19 05:18:21
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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

On Wed, 13 May 2020 17:11:02 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> It's generic enough to be used from the XIVE2 router and avoid more
> duplication.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  include/hw/ppc/xive.h | 4 ++++
>  hw/intc/xive.c        | 8 ++++----
>  2 files changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 112fb6fb6dbe..88b0a2a3811f 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -406,6 +406,10 @@ int xive_presenter_tctx_match(XivePresenter *xptr, X=
iveTCTX *tctx,
>                                uint8_t format,
>                                uint8_t nvt_blk, uint32_t nvt_idx,
>                                bool cam_ignore, uint32_t logic_serv);
> +bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
> +                           uint8_t nvt_blk, uint32_t nvt_idx,
> +                           bool cam_ignore, uint8_t priority,
> +                           uint32_t logic_serv);
> =20
>  /*
>   * XIVE Fabric (Interface between Interrupt Controller and Machine)
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index b8825577f719..f08fcec1c039 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -1481,10 +1481,10 @@ int xive_presenter_tctx_match(XivePresenter *xptr=
, XiveTCTX *tctx,
>   *
>   * The parameters represent what is sent on the PowerBus
>   */
> -static bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
> -                                  uint8_t nvt_blk, uint32_t nvt_idx,
> -                                  bool cam_ignore, uint8_t priority,
> -                                  uint32_t logic_serv)
> +bool xive_presenter_notify(XiveFabric *xfb, uint8_t format,
> +                           uint8_t nvt_blk, uint32_t nvt_idx,
> +                           bool cam_ignore, uint8_t priority,
> +                           uint32_t logic_serv)
>  {
>      XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
>      XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };


