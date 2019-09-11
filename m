Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63C6ECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:03:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AAC820872
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 08:03:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AAC820872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47655 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7xag-0006kI-MK
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 04:03:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52544)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1i7xZL-00061t-Au
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:01:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1i7xZK-0005Ra-5v
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:01:39 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:46297)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1i7xZI-0005Pf-Cy
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 04:01:38 -0400
Received: from player688.ha.ovh.net (unknown [10.109.160.23])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 03DDF1E0595
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 10:01:29 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id ABE9D998A24A;
 Wed, 11 Sep 2019 08:01:20 +0000 (UTC)
Date: Wed, 11 Sep 2019 10:01:19 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190911100119.20c82c06@bahia.lan>
In-Reply-To: <20190911040452.8341-5-david@gibson.dropbear.id.au>
References: <20190911040452.8341-1-david@gibson.dropbear.id.au>
 <20190911040452.8341-5-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12238813463781022182
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrtddugdduvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.39.161
Subject: Re: [Qemu-devel] [PATCH 4/7] spapr: Skip leading zeroes from
 memory@ DT node names
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
Cc: lvivier@redhat.com, aik@ozlabs.ru, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, clg@kaod.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 11 Sep 2019 14:04:49 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> From: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> The device tree build by QEMU at the machine reset time is used by SLOF
> to build its internal device tree but the node names are not preserved
> exactly so when QEMU provides a device tree update in response to H_CAS,
> it might become tricky to match a node from the update blob to
> the actual node in SLOF.
> 
> This removed leading zeroes from "memory@" nodes and makes
> the DTC checker happy.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d93dacd483..d072c2aa3d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -386,7 +386,7 @@ static int spapr_populate_memory_node(void *fdt, int nodeid, hwaddr start,
>      mem_reg_property[0] = cpu_to_be64(start);
>      mem_reg_property[1] = cpu_to_be64(size);
>  
> -    sprintf(mem_name, "memory@" TARGET_FMT_lx, start);
> +    sprintf(mem_name, "memory@%" HWADDR_PRIx, start);
>      off = fdt_add_subnode(fdt, 0, mem_name);
>      _FDT(off);
>      _FDT((fdt_setprop_string(fdt, off, "device_type", "memory")));


