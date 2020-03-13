Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D6C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A432620724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 11:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A432620724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCigY-00063z-N5
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 07:41:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jCifl-0005Aw-FM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:40:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1jCifk-0001NT-DK
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:40:13 -0400
Received: from 7.mo68.mail-out.ovh.net ([46.105.63.230]:43235)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1jCifk-0001J7-7w
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 07:40:12 -0400
Received: from player746.ha.ovh.net (unknown [10.108.35.223])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 6072815F83D
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2020 12:40:10 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id 929E110774105;
 Fri, 13 Mar 2020 11:40:05 +0000 (UTC)
Date: Fri, 13 Mar 2020 12:40:03 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/4] spapr: Move creation of ibm,architecture-vec-5
 property
Message-ID: <20200313124003.63b87232@bahia.home>
In-Reply-To: <20200313040539.819138-3-david@gibson.dropbear.id.au>
References: <20200313040539.819138-1-david@gibson.dropbear.id.au>
 <20200313040539.819138-3-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8149545001532561894
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedruddvjedgfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejgeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.63.230
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
Cc: qemu-ppc@nongnu.org, philmd@redhat.com, clg@kaod.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 13 Mar 2020 15:05:37 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> This is currently called from spapr_dt_cas_updates() which is a hang over
> from when we created this only as a diff to the DT at CAS time.  Now that
> we fully rebuild the DT at CAS time, just create it alon with the rest

s/alon/along

> of the properties in /chosen.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 66289ffef5..fc28d9df25 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -889,22 +889,6 @@ static int spapr_rng_populate_dt(void *fdt)
>      return ret ? -1 : 0;
>  }
>  
> -static int spapr_dt_cas_updates(SpaprMachineState *spapr, void *fdt,
> -                                SpaprOptionVector *ov5_updates)

Heh I should have looked at patch 2 before commenting on patch 1 :)

Reviewed-by: Greg Kurz <groug@kaod.org>

> -{
> -    int offset;
> -
> -    offset = fdt_path_offset(fdt, "/chosen");
> -    if (offset < 0) {
> -        offset = fdt_add_subnode(fdt, 0, "chosen");
> -        if (offset < 0) {
> -            return offset;
> -        }
> -    }
> -    return spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
> -                                  "ibm,architecture-vec-5");
> -}
> -
>  static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
>  {
>      MachineState *ms = MACHINE(spapr);
> @@ -1115,6 +1099,9 @@ static void spapr_dt_chosen(SpaprMachineState *spapr, void *fdt)
>  
>      spapr_dt_ov5_platform_support(spapr, fdt, chosen);
>  
> +    _FDT(spapr_ovec_populate_dt(fdt, offset, spapr->ov5_cas,
> +                                "ibm,architecture-vec-5"));
> +
>      g_free(stdout_path);
>      g_free(bootlist);
>  }
> @@ -1263,13 +1250,6 @@ void *spapr_build_fdt(SpaprMachineState *spapr, bool reset, size_t space)
>          }
>      }
>  
> -    /* ibm,client-architecture-support updates */
> -    ret = spapr_dt_cas_updates(spapr, fdt, spapr->ov5_cas);
> -    if (ret < 0) {
> -        error_report("couldn't setup CAS properties fdt");
> -        exit(1);
> -    }
> -
>      if (smc->dr_phb_enabled) {
>          ret = spapr_dt_drc(fdt, 0, NULL, SPAPR_DR_CONNECTOR_TYPE_PHB);
>          if (ret < 0) {


