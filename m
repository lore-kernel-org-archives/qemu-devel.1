Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98636C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 611CF20791
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:03:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611CF20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE8Z2-0004AF-Ht
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 06:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kE8YT-0003ZN-ER; Fri, 04 Sep 2020 06:02:49 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:37667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kE8YR-0001T0-Fq; Fri, 04 Sep 2020 06:02:49 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.68])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 3217B5DE6DB1;
 Fri,  4 Sep 2020 12:02:02 +0200 (CEST)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 4 Sep 2020
 12:02:01 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003e85d8c53-b4c1-4bae-9d5c-9d2ac2f9e4da,
 FCBA5915E3939154AC1297F78B1F164F9CE82A40) smtp.auth=groug@kaod.org
Date: Fri, 4 Sep 2020 12:02:00 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 2/3] spapr_numa: create a vcpu associativity helper
Message-ID: <20200904120200.21cc9052@bahia.lan>
In-Reply-To: <20200904010439.581957-3-danielhb413@gmail.com>
References: <20200904010439.581957-1-danielhb413@gmail.com>
 <20200904010439.581957-3-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG9EX1.mxp5.local (172.16.2.81) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 9fcf9fc2-f41e-462a-8504-04183c38f30d
X-Ovh-Tracer-Id: 1196268653666671072
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudegfedgvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddttdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:02:44
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

On Thu,  3 Sep 2020 22:04:38 -0300
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

Hi Daniel,

A few comments below.

>  hw/ppc/spapr_numa.c | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 368c1a494d..980a6488bf 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -71,13 +71,15 @@ void spapr_numa_write_associativity_dt(SpaprMachineState *spapr, void *fdt,
>                        sizeof(spapr->numa_assoc_array[nodeid]))));
>  }
>  
> -int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
> -                            int offset, PowerPCCPU *cpu)
> +static uint32_t *spapr_numa_get_vcpu_assoc(SpaprMachineState *spapr,
> +                                          PowerPCCPU *cpu,
> +                                          uint *vcpu_assoc_size)
>  {
> -    uint vcpu_assoc_size = NUMA_ASSOC_SIZE + 1;
> -    uint32_t vcpu_assoc[vcpu_assoc_size];
> +    uint32_t *vcpu_assoc = NULL;

You don't need to initialize this pointer since it is assigned a value
unconditionally just below.

>      int index = spapr_get_vcpu_id(cpu);
> -    int i;
> +
> +    *vcpu_assoc_size = (NUMA_ASSOC_SIZE + 1) * sizeof(uint32_t);

It's a bit weird to return something that is definitely a compile
time constant by reference... What about introducing a macro ?

#define VCPU_NUMA_ASSOC_SIZE (NUMA_ASSOC_SIZE + 1)

> +    vcpu_assoc = g_malloc(*vcpu_assoc_size);
>  

    vcpu_assoc = g_new(uint32_t, VCPU_NUMA_ASSOC_SIZE);

>      /*
>       * VCPUs have an extra 'cpu_id' value in ibm,associativity
> @@ -86,16 +88,24 @@ int spapr_numa_fixup_cpu_dt(SpaprMachineState *spapr, void *fdt,
>       * cpu_id last.
>       */
>      vcpu_assoc[0] = cpu_to_be32(MAX_DISTANCE_REF_POINTS + 1);
> +    memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id],
> +           MAX_DISTANCE_REF_POINTS);
> +    vcpu_assoc[MAX_DISTANCE_REF_POINTS + 1] = cpu_to_be32(index);
>  

    memcpy(vcpu_assoc + 1, spapr->numa_assoc_array[cpu->node_id],
           (VPCU_ASSOC_SIZE - 2) * sizeof(uint32_t));
    vcpu_assoc[VCPU_ASSOC_SIZE - 1] = cpu_to_be32(index);

I personally find more clear than using MAX_DISTANCE_REF_POINTS in an array
that was just allocated with NUMA_ASSOC_SIZE... one has to check spapr.h
to see that NUMA_ASSOC_SIZE == MAX_DISTANCE_REF_POINTS + 1

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
> +    uint vcpu_assoc_size;
>  
> -    vcpu_assoc[vcpu_assoc_size - 1] = cpu_to_be32(index);
> +    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, cpu, &vcpu_assoc_size);
>  
>      /* Advertise NUMA via ibm,associativity */
>      return fdt_setprop(fdt, offset, "ibm,associativity",
> -                       vcpu_assoc, sizeof(vcpu_assoc));
> +                       vcpu_assoc, vcpu_assoc_size);

    return fdt_setprop(fdt, offset, "ibm,associativity",
                       vcpu_assoc, VCPU_NUMA_ASSOC_SIZE * sizeof(uint32_t));

>  }
>  
>  


