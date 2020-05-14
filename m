Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D34BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:35:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A30205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A30205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7Sa-0001D4-Hk
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jZ7PF-0004V4-3t
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:31:46 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:46572)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jZ7PB-0001PG-Ti
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:31:44 -0400
Received: from player789.ha.ovh.net (unknown [10.108.35.122])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 3CDA49E43C
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 08:31:40 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player789.ha.ovh.net (Postfix) with ESMTPSA id AE785125F3869;
 Thu, 14 May 2020 06:31:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0018b60205b-a213-420b-95b5-1b7ce67a7f57,92317E36A8DCBCCD86D4D3FC09BF80838F08FB4C)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 3/6] target/ppc: Don't initialize some local variables
 in ppc_radix64_xlate()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
 <158941062048.240484.9693581559252337111.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2f65c119-8e92-b2b2-a66c-0d0d6e9210c8@kaod.org>
Date: Thu, 14 May 2020 08:31:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158941062048.240484.9693581559252337111.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16558609933549931347
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleehgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.76.150; envelope-from=clg@kaod.org;
 helo=10.mo178.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 02:31:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/20 12:57 AM, Greg Kurz wrote:
> It is the job of the ppc_radix64_get_fully_qualified_addr() function
> which is called at the beginning of ppc_radix64_xlate() to set both
> lpid *and* pid. It doesn't buy us anything to initialize them first.
> 
> Worse, a bug in ppc_radix64_get_fully_qualified_addr(), eg. failing to
> set either lpid or pid, would be undetectable by static analysis tools
> like coverity.
> 
> Some recent versions of gcc (eg. gcc-9.3.1-2.fc30) may still think
> that lpid or pid is used uninitialized though, so this also adds
> default cases in the switch statements to make it clear this cannot
> happen.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  target/ppc/mmu-radix64.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index c76879f65b78..07f956c9864f 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -50,6 +50,8 @@ static bool ppc_radix64_get_fully_qualified_addr(const CPUPPCState *env,
>              *lpid = 0;
>              *pid = 0;
>              break;
> +        default:
> +            g_assert_not_reached();
>          }
>      } else {  /* !MSR[HV] -> Guest */
>          switch (eaddr & R_EADDR_QUADRANT) {
> @@ -64,6 +66,8 @@ static bool ppc_radix64_get_fully_qualified_addr(const CPUPPCState *env,
>              *lpid = env->spr[SPR_LPIDR];
>              *pid = 0; /* pid set to 0 -> addresses guest operating system */
>              break;
> +        default:
> +            g_assert_not_reached();
>          }
>      }
>  
> @@ -433,7 +437,7 @@ static int ppc_radix64_xlate(PowerPCCPU *cpu, vaddr eaddr, int rwx,
>                               bool cause_excp)
>  {
>      CPUPPCState *env = &cpu->env;
> -    uint64_t lpid = 0, pid = 0;
> +    uint64_t lpid, pid;
>      ppc_v3_pate_t pate;
>      int psize, prot;
>      hwaddr g_raddr;
> 


