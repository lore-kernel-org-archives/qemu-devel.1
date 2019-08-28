Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D883C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6474C214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 09:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6474C214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ttP-00063F-Gk
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 05:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i2trD-0004Q5-7Z
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i2trC-0006tt-57
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:03:11 -0400
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:56986)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i2trB-0006hC-W4
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 05:03:10 -0400
Received: from player755.ha.ovh.net (unknown [10.108.42.174])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 8FE47108B22
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2019 11:02:59 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id 18E809477446;
 Wed, 28 Aug 2019 09:02:53 +0000 (UTC)
Date: Wed, 28 Aug 2019 11:02:51 +0200
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Message-ID: <20190828110251.44ded1f5@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190826090812.19080-1-lvivier@redhat.com>
References: <20190826090812.19080-1-lvivier@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4846717627017763110
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrudeitddgudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.39.154
Subject: Re: [Qemu-devel] [PATCH] pseries: Fix compat_pvr on reset
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Aug 2019 11:08:12 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> If we a migrate P8 machine to a P9 machine, the migration fails on
> destination with:
> 
>   error while loading state for instance 0x1 of device 'cpu'
>   load of migration failed: Operation not permitted
> 
> This is caused because the compat_pvr field is only present for the first
> CPU.
> Originally, spapr_machine_reset() calls ppc_set_compat() to set the value
> max_compat_pvr for the first cpu and this was propagated to all CPUs by
> spapr_cpu_reset().  Now, as spapr_cpu_reset() is called before that, the
> value is not propagated to all CPUs and the migration fails.
> 
> To fix that, propagate the new value to all CPUs in spapr_machine_reset().
> 

Yeah, the assumption that compat_pvr would be set for the boot CPU before
device reset was rather fragile. It makes a lot of sense to do this explicitly
from the core machine code.

Reviewed-by: Greg Kurz <groug@kaod.org>

And now, ppc_set_compat() ends up being called twice for every CPU at
machine reset. It isn't a great performance penalty but I think the
case of hotplugged CPUs could be better handled by calling ppc_set_compat()
from spapr_core_plug(). This would also be cleaner to have the compat_pvr
stuff to be handled in spapr.c only rather than in two separate files IMHO.

I'll send a patch.

> Fixes: 25c9780d38d4 ("spapr: Reset CAS & IRQ subsystem after devices")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  hw/ppc/spapr.c          | 8 +++++++-
>  hw/ppc/spapr_cpu_core.c | 2 ++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index baedadf20b8c..d063312a3b2a 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1752,7 +1752,13 @@ static void spapr_machine_reset(MachineState *machine)
>          spapr_ovec_cleanup(spapr->ov5_cas);
>          spapr->ov5_cas = spapr_ovec_new();
>  
> -        ppc_set_compat(first_ppc_cpu, spapr->max_compat_pvr, &error_fatal);
> +        /*
> +         * reset compat_pvr for all CPUs
> +         * as qemu_devices_reset() is called before this,
> +         * it can't be propagated by spapr_cpu_reset()
> +         * from the first CPU to all the others
> +         */
> +        ppc_set_compat_all(spapr->max_compat_pvr, &error_fatal);
>      }
>  
>      /*
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index bf47fbdf6f7f..45e2f2747ffc 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -43,6 +43,8 @@ static void spapr_cpu_reset(void *opaque)
>  
>      /* Set compatibility mode to match the boot CPU, which was either set
>       * by the machine reset code or by CAS. This should never fail.
> +     * At startup the value is already set for all the CPUs
> +     * but we need this when we hotplug a new CPU
>       */
>      ppc_set_compat(cpu, POWERPC_CPU(first_cpu)->compat_pvr, &error_abort);
>  


