Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79795C433E2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:41:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46473206F2
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 14:41:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46473206F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kECuY-0005gq-GY
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 10:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kECtr-0004J1-Bo; Fri, 04 Sep 2020 10:41:11 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:35589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kECtp-0005Mh-2m; Fri, 04 Sep 2020 10:41:11 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.209])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 3AC255782E3F;
 Fri,  4 Sep 2020 16:41:05 +0200 (CEST)
Received: from kaod.org (37.59.142.106) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 4 Sep 2020
 16:41:04 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006c5ad9def-dabe-40f1-a2aa-6969e589d69e,
 FCBA5915E3939154AC1297F78B1F164F9CE82A40) smtp.auth=groug@kaod.org
Date: Fri, 4 Sep 2020 16:41:03 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v5 3/3] spapr_numa: use spapr_numa_get_vcpu_assoc() in
 home_node hcall
Message-ID: <20200904164103.5f2f3c88@bahia.lan>
In-Reply-To: <20200904135631.605094-4-danielhb413@gmail.com>
References: <20200904135631.605094-1-danielhb413@gmail.com>
 <20200904135631.605094-4-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 4d2ab73e-2eb2-41dd-b3fb-3da39dbf7dbc
X-Ovh-Tracer-Id: 5909004186220272096
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudegfedgkedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 10:41:06
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

On Fri,  4 Sep 2020 10:56:31 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> The current implementation of h_home_node_associativity hard codes
> the values of associativity domains of the vcpus. Let's make
> it consider the values already initialized in spapr->numa_assoc_array,
> via the spapr_numa_get_vcpu_assoc() helper.
> 
> We want to set it and forget it, and for that we also need to
> assert that we don't overflow the registers of the hypercall.
> From R4 to R9 we can squeeze in 12 associativity domains for
> vcpus, so let's assert that VCPU_ASSOC_SIZE -1 isn't greater
> than that.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_numa.c | 41 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 674d2ee86d..07eb921737 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -178,10 +178,11 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
>                                                target_ulong opcode,
>                                                target_ulong *args)
>  {
> +    g_autofree uint32_t *vcpu_assoc = NULL;
>      target_ulong flags = args[0];
>      target_ulong procno = args[1];
>      PowerPCCPU *tcpu;
> -    int idx;
> +    int idx, assoc_idx;
>  
>      /* only support procno from H_REGISTER_VPA */
>      if (flags != 0x1) {
> @@ -193,16 +194,40 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
>          return H_P2;
>      }
>  
> -    /* sequence is the same as in the "ibm,associativity" property */
> +    /*
> +     * Given that we want to be flexible with the sizes and indexes,
> +     * we must consider that there is a hard limit of how many
> +     * associativities domain we can fit in R4 up to R9, which would be
> +     * 12 associativity domains for vcpus. Assert and bail if that's
> +     * not the case.
> +     */
> +    G_STATIC_ASSERT((VCPU_ASSOC_SIZE - 1) <= 12);
> +
> +    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, tcpu);
> +    /* assoc_idx starts at 1 to skip associativity size */
> +    assoc_idx = 1;
>  
> -    idx = 0;
>  #define ASSOCIATIVITY(a, b) (((uint64_t)(a) << 32) | \
>                               ((uint64_t)(b) & 0xffffffff))
> -    args[idx++] = ASSOCIATIVITY(0, 0);
> -    args[idx++] = ASSOCIATIVITY(0, tcpu->node_id);
> -    args[idx++] = ASSOCIATIVITY(procno, -1);
> -    for ( ; idx < 6; idx++) {
> -        args[idx] = -1;
> +
> +    for (idx = 0; idx < 6; idx++) {
> +        int32_t a, b;
> +
> +        /*
> +         * vcpu_assoc[] will contain the associativity domains for tcpu,
> +         * including tcpu->node_id and procno, meaning that we don't
> +         * need to use these variables here.
> +         *
> +         * We'll read 2 values at a time to fill up the ASSOCIATIVITY()
> +         * macro. The ternary will fill the remaining registers with -1
> +         * after we went through vcpu_assoc[].
> +         */
> +        a = assoc_idx < VCPU_ASSOC_SIZE ?
> +            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
> +        b = assoc_idx < VCPU_ASSOC_SIZE ?
> +            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
> +
> +        args[idx] = ASSOCIATIVITY(a, b);
>      }
>  #undef ASSOCIATIVITY
>  

Much clearer with the comment.

Reviewed-by: Greg Kurz <groug@kaod.org>

