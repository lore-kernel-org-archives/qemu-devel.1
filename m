Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E55C2D0E2
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F63D23787
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:49:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F63D23787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLM01-0003Xs-BD
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kLLyq-0002cY-D5; Thu, 24 Sep 2020 03:47:52 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:44193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kLLyo-00025X-1X; Thu, 24 Sep 2020 03:47:52 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.1.237])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 509F964F0276;
 Thu, 24 Sep 2020 09:47:38 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Thu, 24 Sep
 2020 09:47:37 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001c2756683-ff4d-428b-860b-431edabd94c2,
 85AEC8A2294FDACAA0F214F2A1981C2CEEF9973D) smtp.auth=groug@kaod.org
Date: Thu, 24 Sep 2020 09:47:36 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 1/6] spapr: add spapr_machine_using_legacy_numa() helper
Message-ID: <20200924094736.1937083c@bahia.lan>
In-Reply-To: <20200923193458.203186-2-danielhb413@gmail.com>
References: <20200923193458.203186-1-danielhb413@gmail.com>
 <20200923193458.203186-2-danielhb413@gmail.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 7b51a125-1b28-414b-ac20-0efdf107ea87
X-Ovh-Tracer-Id: 5699868280138799584
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrudejgdduvddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefuddtieejjeevheekieeltefgleetkeetheettdeifeffvefhffelffdtfeeljeenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghu
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 03:47:39
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

On Wed, 23 Sep 2020 16:34:53 -0300
Daniel Henrique Barboza <danielhb413@gmail.com> wrote:

> The changes to come to NUMA support are all guest visible. In
> theory we could just create a new 5_1 class option flag to
> avoid the changes to cascade to 5.1 and under. The reality is that
> these changes are only relevant if the machine has more than one
> NUMA node. There is no need to change guest behavior that has
> been around for years needlesly.
> 
> This new helper will be used by the next patches to determine
> whether we should retain the (soon to be) legacy NUMA behavior
> in the pSeries machine. The new behavior will only be exposed
> if:
> 
> - machine is pseries-5.2 and newer;
> - more than one NUMA node is declared in NUMA state.
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c         | 12 ++++++++++++
>  include/hw/ppc/spapr.h |  2 ++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index e813c7cfb9..c5d8910a74 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -294,6 +294,15 @@ static hwaddr spapr_node0_size(MachineState *machine)
>      return machine->ram_size;
>  }
>  
> +bool spapr_machine_using_legacy_numa(SpaprMachineState *spapr)
> +{
> +    MachineState *machine = MACHINE(spapr);
> +    SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
> +
> +    return smc->pre_5_2_numa_associativity ||
> +           machine->numa_state->num_nodes <= 1;
> +}
> +
>  static void add_str(GString *s, const gchar *s1)
>  {
>      g_string_append_len(s, s1, strlen(s1) + 1);
> @@ -4522,8 +4531,11 @@ DEFINE_SPAPR_MACHINE(5_2, "5.2", true);
>   */
>  static void spapr_machine_5_1_class_options(MachineClass *mc)
>  {
> +    SpaprMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
> +
>      spapr_machine_5_2_class_options(mc);
>      compat_props_add(mc->compat_props, hw_compat_5_1, hw_compat_5_1_len);
> +    smc->pre_5_2_numa_associativity = true;
>  }
>  
>  DEFINE_SPAPR_MACHINE(5_1, "5.1", false);
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index 114e819969..d1aae03b97 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -143,6 +143,7 @@ struct SpaprMachineClass {
>      bool smp_threads_vsmt; /* set VSMT to smp_threads by default */
>      hwaddr rma_limit;          /* clamp the RMA to this size */
>      bool pre_5_1_assoc_refpoints;
> +    bool pre_5_2_numa_associativity;
>  
>      void (*phb_placement)(SpaprMachineState *spapr, uint32_t index,
>                            uint64_t *buid, hwaddr *pio, 
> @@ -860,6 +861,7 @@ int spapr_max_server_number(SpaprMachineState *spapr);
>  void spapr_store_hpte(PowerPCCPU *cpu, hwaddr ptex,
>                        uint64_t pte0, uint64_t pte1);
>  void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered);
> +bool spapr_machine_using_legacy_numa(SpaprMachineState *spapr);
>  
>  /* DRC callbacks. */
>  void spapr_core_release(DeviceState *dev);


