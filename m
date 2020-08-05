Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845EEC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:30:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A7522CB3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:30:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A7522CB3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3MJP-0008PU-LA
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3MIl-0007rh-8J; Wed, 05 Aug 2020 12:30:03 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:52571)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1k3MIi-0002Bg-KF; Wed, 05 Aug 2020 12:30:02 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.118])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 021EF540F59F;
 Wed,  5 Aug 2020 18:29:25 +0200 (CEST)
Received: from kaod.org (37.59.142.99) by DAG4EX1.mxp5.local (172.16.2.31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 5 Aug 2020
 18:29:25 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G003e6c019d9-52f3-4ea5-9ef9-2f20075a0ac1,
 060DA44790D82B6AC40A57F5A63261D4F9508838) smtp.auth=clg@kaod.org
Subject: Re: [PATCH] spapr: Clarify error and documentation for broken KVM XICS
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <159664243614.622889.18307368735989783528.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8db4a56e-1676-f190-0d10-0707c797bc32@kaod.org>
Date: Wed, 5 Aug 2020 18:29:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <159664243614.622889.18307368735989783528.stgit@bahia.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.99]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG4EX1.mxp5.local
 (172.16.2.31)
X-Ovh-Tracer-GUID: 9fae7413-3c55-411f-8edf-a1f6a7a05ca9
X-Ovh-Tracer-Id: 16025214851568536483
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrjeekgddutdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfhisehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheevtdejledtleeutefgfeeiveefjeeggeeihfdvhffgkedthfdthfduhfevjeelnecuffhomhgrihhnpehlrghunhgthhhprggurdhnvghtnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepghhrohhugheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=clg@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 12:29:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Satheesh Rajendran <sathnaga@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/5/20 5:47 PM, Greg Kurz wrote:
> When starting an L2 KVM guest with `ic-mode=dual,kernel-irqchip=on`,
> QEMU fails with:
> 
> KVM is too old to support ic-mode=dual,kernel-irqchip=on
> 
> This error message was introduced to detect older KVM versions that
> didn't allow destruction and re-creation of the XICS KVM device that
> we do at reboot. But it is actually the same issue that we get with
> nested guests : when running under pseries, KVM currently provides
> a genuine XICS device (not the XICS-on-XIVE device that we get
> under powernv) which doesn't support destruction/re-creation.
> 
> This will eventually be fixed in KVM but in the meantime, update
> the error message and documentation to mention the nested case.
> While here, mention that in "No XIVE support in KVM" section that
> this can also happen with "guest OSes supporting XIVE" since
> we check this at init time before starting the guest.
> 
> Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1890290
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C. 


> ---
>  docs/specs/ppc-spapr-xive.rst |    5 ++++-
>  hw/ppc/spapr_irq.c            |   12 +++++++++---
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/specs/ppc-spapr-xive.rst b/docs/specs/ppc-spapr-xive.rst
> index 7199db730b82..7144347560f1 100644
> --- a/docs/specs/ppc-spapr-xive.rst
> +++ b/docs/specs/ppc-spapr-xive.rst
> @@ -126,6 +126,9 @@ xics            XICS KVM       XICS emul.     XICS KVM
>  
>  (1) QEMU warns with ``warning: kernel_irqchip requested but unavailable:
>      IRQ_XIVE capability must be present for KVM``
> +    In some cases (old host kernels or KVM nested guests), one may hit a
> +    QEMU/KVM incompatibility due to device destruction in reset. QEMU fails
> +    with ``KVM is incompatible with ic-mode=dual,kernel-irqchip=on``
>  (2) QEMU fails with ``kernel_irqchip requested but unavailable:
>      IRQ_XIVE capability must be present for KVM``
>  
> @@ -148,7 +151,7 @@ xics            XICS KVM       XICS emul.     XICS KVM
>      mode (XICS), either don't set the ic-mode machine property or try
>      ic-mode=xics or ic-mode=dual``
>  (4) QEMU/KVM incompatibility due to device destruction in reset. QEMU fails
> -    with ``KVM is too old to support ic-mode=dual,kernel-irqchip=on``
> +    with ``KVM is incompatible with ic-mode=dual,kernel-irqchip=on``
>  
>  
>  XIVE Device tree properties
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index 2f8f7d62f875..72bb938375ef 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -139,6 +139,7 @@ SpaprIrq spapr_irq_dual = {
>  
>  static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>  {
> +    ERRP_GUARD();
>      MachineState *machine = MACHINE(spapr);
>  
>      /*
> @@ -179,14 +180,19 @@ static int spapr_irq_check(SpaprMachineState *spapr, Error **errp)
>  
>      /*
>       * On a POWER9 host, some older KVM XICS devices cannot be destroyed and
> -     * re-created. Detect that early to avoid QEMU to exit later when the
> -     * guest reboots.
> +     * re-created. Same happens with KVM nested guests. Detect that early to
> +     * avoid QEMU to exit later when the guest reboots.
>       */
>      if (kvm_enabled() &&
>          spapr->irq == &spapr_irq_dual &&
>          kvm_kernel_irqchip_required() &&
>          xics_kvm_has_broken_disconnect(spapr)) {
> -        error_setg(errp, "KVM is too old to support ic-mode=dual,kernel-irqchip=on");
> +        error_setg(errp,
> +            "KVM is incompatible with ic-mode=dual,kernel-irqchip=on");
> +        error_append_hint(errp,
> +            "This can happen with an old KVM or in a KVM nested guest.\n");
> +        error_append_hint(errp,
> +            "Try without kernel-irqchip or with kernel-irqchip=off.\n");
>          return -1;
>      }
>  
> 
> 


