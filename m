Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF0C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA1D0206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 10:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA1D0206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE92N-0008LG-VJ
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 06:33:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kE91q-0007u3-1J; Fri, 04 Sep 2020 06:33:10 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:37765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kE91o-0004zC-1z; Fri, 04 Sep 2020 06:33:09 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.97])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 069F55DEA29B;
 Fri,  4 Sep 2020 12:33:04 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 4 Sep 2020
 12:33:03 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006e90edbe1-7133-47c2-982a-b686193c2d21,
 FCBA5915E3939154AC1297F78B1F164F9CE82A40) smtp.auth=groug@kaod.org
Date: Fri, 4 Sep 2020 12:33:02 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 3/3] spapr_numa: use spapr_numa_get_vcpu_assoc() in
 home_node hcall
Message-ID: <20200904123302.21bd6ed3@bahia.lan>
In-Reply-To: <20200904010439.581957-4-danielhb413@gmail.com>
References: <20200904010439.581957-1-danielhb413@gmail.com>
 <20200904010439.581957-4-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 338e78d4-3506-4425-9c89-32808ef30cde
X-Ovh-Tracer-Id: 1720093583724616160
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudegfedgvdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepuggrvhhiugesghhisghsohhnrdgurhhophgsvggrrhdrihgurdgruh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 06:02:44
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu,  3 Sep 2020 22:04:39 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> The current implementation of h_home_node_associativity hard codes
> the values of associativity domains of the vcpus. Let's make
> it consider the values already initialized in spapr->numa_assoc_array,
> via the spapr_numa_get_vcpu_assoc() helper.
> 
> We want to set it and forget it, and for that we also need to
> assert that we don't overflow the registers of the hypercall.
> From R4 to R9 we can squeeze in 12 associativity domains, so
> let's assert that MAX_DISTANCE_REF_POINTS isn't greater
> than that.
> 
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_numa.c | 33 +++++++++++++++++++++++++--------
>  1 file changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/ppc/spapr_numa.c b/hw/ppc/spapr_numa.c
> index 980a6488bf..0a7e07fe60 100644
> --- a/hw/ppc/spapr_numa.c
> +++ b/hw/ppc/spapr_numa.c
> @@ -181,10 +181,12 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
>                                                target_ulong opcode,
>                                                target_ulong *args)
>  {
> +    g_autofree uint32_t *vcpu_assoc = NULL;
>      target_ulong flags = args[0];
>      target_ulong procno = args[1];
>      PowerPCCPU *tcpu;
> -    int idx;
> +    uint vcpu_assoc_size;
> +    int idx, assoc_idx;
>  
>      /* only support procno from H_REGISTER_VPA */
>      if (flags != 0x1) {
> @@ -196,16 +198,31 @@ static target_ulong h_home_node_associativity(PowerPCCPU *cpu,
>          return H_P2;
>      }
>  
> -    /* sequence is the same as in the "ibm,associativity" property */
> +    /*
> +     * Given that we want to be flexible with the sizes and indexes,
> +     * we must consider that there is a hard limit of how many
> +     * associativities domain we can fit in R4 up to R9, which
> +     * would be 12. Assert and bail if that's not the case.
> +     */
> +    G_STATIC_ASSERT(MAX_DISTANCE_REF_POINTS <= 12);
> +
> +    vcpu_assoc = spapr_numa_get_vcpu_assoc(spapr, tcpu, &vcpu_assoc_size);
> +    vcpu_assoc_size /= sizeof(uint32_t);

Using vcpu_assoc_size both as a size-in-bytes and a number of elements in
the array is gross... Anyway since this should go away if you introduce
a macro as suggested in the previous patch.

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
> +        a = assoc_idx < vcpu_assoc_size ?
> +            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
> +        b = assoc_idx < vcpu_assoc_size ?
> +            be32_to_cpu(vcpu_assoc[assoc_idx++]) : -1;
> +
> +        args[idx] = ASSOCIATIVITY(a, b);
>      }

Ouch this change is really giving me a headache... I understand that
tcpu->node_id and procno are now being read from vcpu_assoc[] but
it's hard to check what vcpu_assoc[assoc_idx++] points to, especially
with the ternary operator... Honestly, I'd rather keep that loop
unrolled with comments telling what's being read.

>  #undef ASSOCIATIVITY
>  


