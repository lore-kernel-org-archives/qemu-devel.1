Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C15C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92BF206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92BF206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECov-0001SL-VM
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kECo2-0000fK-Rk; Fri, 04 Sep 2020 10:35:10 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:32853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kECo0-0004QX-Nn; Fri, 04 Sep 2020 10:35:10 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.44])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 0498D5E02638;
 Fri,  4 Sep 2020 16:35:04 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 4 Sep 2020
 16:35:04 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006dc63137e-de63-4e37-a6c6-14145b739520,
 FCBA5915E3939154AC1297F78B1F164F9CE82A40) smtp.auth=groug@kaod.org
Date: Fri, 4 Sep 2020 16:35:03 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v5 2/3] spapr_numa: create a vcpu associativity helper
Message-ID: <20200904163503.269ebe77@bahia.lan>
In-Reply-To: <20200904135631.605094-3-danielhb413@gmail.com>
References: <20200904135631.605094-1-danielhb413@gmail.com>
 <20200904135631.605094-3-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG1EX1.mxp5.local (172.16.2.1) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: bf77b317-7612-4331-9634-e2ab3c23497a
X-Ovh-Tracer-Id: 5807391721351191008
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudegfedgjeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:35:05
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri,  4 Sep 2020 10:56:30 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> The work to be done in h_home_node_associativity() intersects
> with what is already done in spapr_numa_fixup_cpu_dt(). This
> patch creates a new helper, spapr_numa_get_vcpu_assoc(), to
> be used for both spapr_numa_fixup_cpu_dt() and
> h_home_node_associativity().
> 
> While we're at it, use memcpy() instead of loop assignment
> to created the returned array.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_numa.c    | 33 ++++++++++++++++++++-------------
>  include/hw/ppc/spapr.h |  7 ++++++-
>  2 files changed, 26 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 368c1a494d..674d2ee86d 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -71,31 +71,38 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
>                        sizeof(spapr->numa_assoc_array[nodeid]))));
>  }
>  
> -int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
> -                            int offset, PowerPCCPU *cpu)
> +static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
> +                                           PowerPCCPU *cpu)
>  {
> -    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
> -    uint32_t vcpu_assoc[vcpu_assoc_size];
> +    uint32_t *vcpu_assoc = g_malloc(VCPU_ASSOC_SIZE * sizeof(uint32_t));

CODING_STYLE recommends g_new(uint32_t, VCPU_ASSOC_SIZE)

>      int index = spapr_get_vcpu_id(cpu);
> -    int i;
> +
> +    g_assert(vcpu_assoc != NULL);
>  

g_malloc() and friends only return NULL when passed a zero size,
which is obviously not the case here.

>      /*
>       * VCPUs have an extra 'cpu_id' value in ibm,associativity
>       * compared to other resources. Increment the size at index
> -     * 0, copy all associativity domains already set, then put
> -     * cpu_id last.
> +     * 0, put cpu_id last, then copy the remaining associativity
> +     * domains.
>       */
>      vcpu_assoc[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
> +    vcpu_assoc[VCPU_ASSOC_SIZE - 1] = cpu_to_be32(index);
> +    memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id] + 1,
> +           (VCPU_ASSOC_SIZE - 2) * sizeof(uint32_t));
>  
> -    for (i = 1; i <= MAX_DISTANCE_REF_POINTS; i++) {
> -        vcpu_assoc[i] = spapr->numa_assoc_array[cpu->node_id][i];
> -    }
> +    return vcpu_assoc;
> +}
> +
> +int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
> +                            int offset, PowerPCCPU *cpu)
> +{
> +    g_autofree uint32_t *vcpu_assoc = NULL;
>  
> -    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
> +    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, cpu);
>  
>      /* Advertise NUMA via ibm,associativity */
> -    return fdt_setprop(fdt, offset, "ibm,associativity",
> -                       vcpu_assoc, sizeof(vcpu_assoc));
> +    return fdt_setprop(fdt, offset, "ibm,associativity", vcpu_assoc,
> +                       VCPU_ASSOC_SIZE * sizeof(uint32_t));
>  }
>  
>  
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 9a63380801..e50a2672e3 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -107,13 +107,18 @@ typedef enum {
>  
>  /*
>   * NUMA related macros. MAX_DISTANCE_REF_POINTS was taken
> - * from Taken from Linux kernel arch/powerpc/mm/numa.h.

Heh a good opportunity to fix the "from Taken from" typo I guess ;)

> + * from Linux kernel arch/powerpc/mm/numa.h. It represents the
> + * amount of associativity domains for non-CPU resources.
>   *
>   * NUMA_ASSOC_SIZE is the base array size of an ibm,associativity
>   * array for any non-CPU resource.
> + *
> + * VCPU_ASSOC_SIZE represents the size of ibm,associativity array
> + * for CPUs, which has an extra element (vcpu_id) in the end.
>   */
>  #define MAX_DISTANCE_REF_POINTS    4
>  #define NUMA_ASSOC_SIZE            (MAX_DISTANCE_REF_POINTS + 1)
> +#define VCPU_ASSOC_SIZE            (NUMA_ASSOC_SIZE + 1)
>  
>  typedef struct SpaprCapabilities SpaprCapabilities;
>  struct SpaprCapabilities {

With the comments on g_malloc() addressed, feel free to add:

Reviewed-by: Greg Kurz <groug@kaod.org>

