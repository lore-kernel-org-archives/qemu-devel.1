Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00207C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC2142084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2142084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47986 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsds-0007k2-4q
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41968)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hcsSo-0002AH-Uj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:18:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hcsSn-0006Rx-Uf
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:18:26 -0400
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:49277)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hcsSn-0006Qy-Ln
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:18:25 -0400
Received: from player731.ha.ovh.net (unknown [10.108.54.67])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 93FC1FD645
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 16:18:23 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player731.ha.ovh.net (Postfix) with ESMTPSA id 0B10B6D1F691;
 Mon, 17 Jun 2019 14:18:18 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077919546.433243.8748677531446035746.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <725ad083-aa25-28f0-c019-8fddcddc7698@kaod.org>
Date: Mon, 17 Jun 2019 16:18:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156077919546.433243.8748677531446035746.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11614501964497718080
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeijedgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.37.72
Subject: Re: [Qemu-devel] [PATCH 1/6] xics/spapr: Drop unused function
 declaration
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

On 17/06/2019 15:46, Greg Kurz wrote:
> Commit 9fb6eb7ca50c added the declaration of xics_spapr_connect(), whic=
h
> has no implementation and no users.
>=20
> This is a leftover from a previous iteration of this patch. Drop it.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  include/hw/ppc/xics_spapr.h |    1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/xics_spapr.h b/include/hw/ppc/xics_spapr.h
> index d968f2499ca7..330448126223 100644
> --- a/include/hw/ppc/xics_spapr.h
> +++ b/include/hw/ppc/xics_spapr.h
> @@ -37,6 +37,5 @@ int xics_kvm_init(SpaprMachineState *spapr, Error **e=
rrp);
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp);
>  bool xics_kvm_has_broken_disconnect(SpaprMachineState *spapr);
>  void xics_spapr_init(SpaprMachineState *spapr);
> -void xics_spapr_connect(SpaprMachineState *spapr);
> =20
>  #endif /* XICS_SPAPR_H */
>=20


