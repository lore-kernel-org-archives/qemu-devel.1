Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F730C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:38:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F27E820833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:38:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F27E820833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48056 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsmC-00070D-82
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42133)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hcsTR-0002J1-Cf
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:19:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hcsTN-0006v2-1M
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:19:03 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:51344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hcsTM-0006qx-RW
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:19:00 -0400
Received: from player759.ha.ovh.net (unknown [10.109.143.24])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id D09385C274
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 16:18:58 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player759.ha.ovh.net (Postfix) with ESMTPSA id 3A8166F57BCC;
 Mon, 17 Jun 2019 14:18:54 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077920657.433243.13541093940589972734.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <974ab588-09b6-7952-f31e-34c534509f45@kaod.org>
Date: Mon, 17 Jun 2019 16:18:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156077920657.433243.13541093940589972734.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11624353590673640256
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeijedgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.173
Subject: Re: [Qemu-devel] [PATCH 3/6] xics/kvm: Skip rollback when KVM XICS
 is absent
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
> There is no need to rollback anything at this point, so just return an
> error.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/xics_kvm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 534515143ea8..377ff88701c2 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -348,7 +348,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Erro=
r **errp)
>      if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_=
XICS)) {
>          error_setg(errp,
>                     "KVM and IRQ_XICS capability must be present for in=
-kernel XICS");
> -        goto fail;
> +        return -1;
>      }
> =20
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_SET_XIVE, "ibm,set=
-xive");
>=20


