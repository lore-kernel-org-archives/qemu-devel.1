Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883BFC31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 614732080A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 13:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614732080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47640 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcs0n-0005hB-8a
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 09:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hcrxx-00046i-Ld
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hcrxw-0000NT-Gx
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:46:33 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:44930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hcrxw-0000GK-8S
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 09:46:32 -0400
Received: from player738.ha.ovh.net (unknown [10.108.35.158])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 7C35AFF3D5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:46:20 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id 8A73A70B9436;
 Mon, 17 Jun 2019 13:46:15 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156077793153.431407.3975189408068375970.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <97e49445-5d99-f37d-24a1-595123fa00f1@kaod.org>
Date: Mon, 17 Jun 2019 15:46:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156077793153.431407.3975189408068375970.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11072944111975762752
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeijedgieelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.36.172
Subject: Re: [Qemu-devel] [PATCH] xics: Don't call icp_kvm_realize() from
 icp_realize()
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

On 17/06/2019 15:25, Greg Kurz wrote:
> kvm_kernel_irqchip is set by xics_kvm_init() which is always called after
> icp_realize() since commit 3f777abc7107 "spapr/irq: add KVM support to the
> 'dual' machine".

I think we still need it for CPU hotplug.

C.


> This is thus dead code. Drop it.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/intc/xics.c |    8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index 29f7d397813e..1dc3a0f12280 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -351,14 +351,6 @@ static void icp_realize(DeviceState *dev, Error **errp)
>          return;
>      }
>  
> -    if (kvm_irqchip_in_kernel()) {
> -        icp_kvm_realize(dev, &err);
> -        if (err) {
> -            error_propagate(errp, err);
> -            return;
> -        }
> -    }
> -
>      qemu_register_reset(icp_reset_handler, dev);
>      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server, icp);
>  }
> 


