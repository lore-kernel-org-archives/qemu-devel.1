Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2819BC433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57DA206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57DA206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECw7-0007Lt-6G
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37870)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kECvQ-0006nV-Va; Fri, 04 Sep 2020 10:42:48 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:38199)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kECvO-0005dv-WA; Fri, 04 Sep 2020 10:42:48 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.156.13])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 56E495E03276;
 Fri,  4 Sep 2020 16:42:26 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 4 Sep 2020
 16:42:25 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006e37d097f-3ea3-4146-b31a-c78cde3a3e07,
 FCBA5915E3939154AC1297F78B1F164F9CE82A40) smtp.auth=groug@kaod.org
Date: Fri, 4 Sep 2020 16:42:24 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v5 1/3] spapr: move h_home_node_associativity to
 spapr_numa.c
Message-ID: <20200904164224.513d612a@bahia.lan>
In-Reply-To: <20200904135631.605094-2-danielhb413@gmail.com>
References: <20200904135631.605094-1-danielhb413@gmail.com>
 <20200904135631.605094-2-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: b859d418-b125-4e47-ad1d-792e2300aaf7
X-Ovh-Tracer-Id: 5931803662345869792
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudegfedgkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
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

On Fri,  4 Sep 2020 10:56:29 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> The implementation of this hypercall will be modified to use
> spapr->numa_assoc_arrays input. Moving it to spapr_numa.c makes
> make more sense.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---

Not sure if David already applied it to ppc-for-5.2. Anyway:

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_hcall.c | 40 ---------------------------------------
>  hw/ppc/spapr_numa.c  | 45 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 40 deletions(-)
> 
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index c1d01228c6..c2776b6a7d 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1873,42 +1873,6 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
>      return ret;
>  }
>  
> -static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> -                                              SpaprMachineState *spapr,
> -                                              target_ulong opcode,
> -                                              target_ulong *args)
> -{
> -    target_ulong flags = args[0];
> -    target_ulong procno = args[1];
> -    PowerPCCPU *tcpu;
> -    int idx;
> -
> -    /* only support procno from H_REGISTER_VPA */
> -    if (flags != 0x1) {
> -        return H_FUNCTION;
> -    }
> -
> -    tcpu = spapr_find_cpu(procno);
> -    if (tcpu == NULL) {
> -        return H_P2;
> -    }
> -
> -    /* sequence is the same as in the "ibm,associativity" property */
> -
> -    idx = 0;
> -#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
> -                             ((uint64_t)(b) & 0xffffffff))
> -    args[idx++] = ASSOCIATIVITY(0, 0);
> -    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
> -    args[idx++] = ASSOCIATIVITY(procno, -1);
> -    for ( ; idx < 6; idx++) {
> -        args[idx] = -1;
> -    }
> -#undef ASSOCIATIVITY
> -
> -    return H_SUCCESS;
> -}
> -
>  static target_ulong h_get_cpu_characteristics(PowerPCCPU *cpu,
>                                                SpaprMachineState *spapr,
>                                                target_ulong opcode,
> @@ -2139,10 +2103,6 @@ static void hypercall_register_types(void)
>      spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
>  
>      spapr_register_hypercall(KVMPPC_H_UPDATE_DT, h_update_dt);
> -
> -    /* Virtual Processor Home Node */
> -    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
> -                             h_home_node_associativity);
>  }
>  
>  type_init(hypercall_register_types)
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 93a000b729..368c1a494d 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -165,3 +165,48 @@ void spapr_numa_write_rtas_dt(SpaprMachineState *spapr, void *fdt, int rtas)
>      _FDT(fdt_setprop(fdt, rtas, "ibm,max-associativity-domains",
>                       maxdomains, sizeof(maxdomains)));
>  }
> +
> +static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
> +                                              SpaprMachineState *spapr,
> +                                              target_ulong opcode,
> +                                              target_ulong *args)
> +{
> +    target_ulong flags = args[0];
> +    target_ulong procno = args[1];
> +    PowerPCCPU *tcpu;
> +    int idx;
> +
> +    /* only support procno from H_REGISTER_VPA */
> +    if (flags != 0x1) {
> +        return H_FUNCTION;
> +    }
> +
> +    tcpu = spapr_find_cpu(procno);
> +    if (tcpu == NULL) {
> +        return H_P2;
> +    }
> +
> +    /* sequence is the same as in the "ibm,associativity" property */
> +
> +    idx = 0;
> +#define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
> +                             ((uint64_t)(b) & 0xffffffff))
> +    args[idx++] = ASSOCIATIVITY(0, 0);
> +    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
> +    args[idx++] = ASSOCIATIVITY(procno, -1);
> +    for ( ; idx < 6; idx++) {
> +        args[idx] = -1;
> +    }
> +#undef ASSOCIATIVITY
> +
> +    return H_SUCCESS;
> +}
> +
> +static void spapr_numa_register_types(void)
> +{
> +    /* Virtual Processor Home Node */
> +    spapr_register_hypercall(H_HOME_NODE_ASSOCIATIVITY,
> +                             h_home_node_associativity);
> +}
> +
> +type_init(spapr_numa_register_types)


