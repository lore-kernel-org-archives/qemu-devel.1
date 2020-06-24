Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF10AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E2F820857
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 09:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E2F820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo1L7-00066U-Vz
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 05:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jo1KV-0005Zs-Hz
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:04:27 -0400
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:38607)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jo1KT-0007pr-FC
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 05:04:27 -0400
Received: from player695.ha.ovh.net (unknown [10.108.35.185])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 3B2501DFE90
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 11:04:23 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player695.ha.ovh.net (Postfix) with ESMTPSA id AA4BB139279DF;
 Wed, 24 Jun 2020 09:04:19 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0019dddba49-4392-428c-b69b-02e3b8eaa821,C444FAC41FF2550221413609A00B1E8A3B07177F)
 smtp.auth=groug@kaod.org
Date: Wed, 24 Jun 2020 11:04:17 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 07/25] spapr: Plug minor memory leak in
 spapr_machine_init()
Message-ID: <20200624110417.05910d50@bahia.lan>
In-Reply-To: <20200624083737.3086768-8-armbru@redhat.com>
References: <20200624083737.3086768-1-armbru@redhat.com>
 <20200624083737.3086768-8-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1663517114766432654
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekjedgtdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=188.165.53.149; envelope-from=groug@kaod.org;
 helo=2.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 05:04:23
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: David Gibson <dgibson@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 24 Jun 2020 10:37:19 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> spapr_machine_init() leaks an Error object when
> kvmppc_check_papr_resize_hpt() fails and spapr->resize_hpt is
> SPAPR_RESIZE_HPT_DISABLED, i.e. when the host doesn't support hash
> page table resizing, and the user didn't ask for it.  As harmless as
> memory leaks can possibly be.  Plug it.
> 
> Fixes: 30f4b05bd090564181554d0890605eb2c143e4ea
> Cc: David Gibson <dgibson@redhat.com>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Ditto.

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index bd9345cdac..9bd2183ead 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -2731,6 +2731,7 @@ static void spapr_machine_init(MachineState *machine)
>          error_report_err(resize_hpt_err);
>          exit(1);
>      }
> +    error_free(resize_hpt_err);
>  
>      spapr->rma_size = spapr_rma_size(spapr, &error_fatal);
>  


