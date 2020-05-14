Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4E0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:31:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0814206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0814206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7Ob-0003oT-TN
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jZ7Nc-0002lX-1b
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:30:04 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:40812)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jZ7Na-0000zY-IM
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:30:03 -0400
Received: from player776.ha.ovh.net (unknown [10.108.35.211])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9BA2627D10A
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 08:29:59 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player776.ha.ovh.net (Postfix) with ESMTPSA id 597B31264F011;
 Thu, 14 May 2020 06:29:55 +0000 (UTC)
Subject: Re: [PATCH v2 1/6] target/ppc: Pass const pointer to
 ppc_radix64_get_prot_amr()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
 <158941060817.240484.14621015211317485106.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <030d3ccf-9706-9af5-bf14-b7e26ab01b6b@kaod.org>
Date: Thu, 14 May 2020 08:29:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158941060817.240484.14621015211317485106.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16530180961262340947
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleehgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.107.29; envelope-from=clg@kaod.org;
 helo=15.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 02:29:59
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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

On 5/14/20 12:56 AM, Greg Kurz wrote:
> This doesn't require write access to the CPU structure.
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  target/ppc/mmu-radix64.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/mmu-radix64.h b/target/ppc/mmu-radix64.h
> index 96228546aa85..f28c5794d071 100644
> --- a/target/ppc/mmu-radix64.h
> +++ b/target/ppc/mmu-radix64.h
> @@ -55,9 +55,9 @@ static inline int ppc_radix64_get_prot_eaa(uint64_t pte)
>             (pte & R_PTE_EAA_X ? PAGE_EXEC : 0);
>  }
>  
> -static inline int ppc_radix64_get_prot_amr(PowerPCCPU *cpu)
> +static inline int ppc_radix64_get_prot_amr(const PowerPCCPU *cpu)
>  {
> -    CPUPPCState *env = &cpu->env;
> +    const CPUPPCState *env = &cpu->env;
>      int amr = env->spr[SPR_AMR] >> 62; /* We only care about key0 AMR63:62 */
>      int iamr = env->spr[SPR_IAMR] >> 62; /* We only care about key0 IAMR63:62 */
>  
> 


