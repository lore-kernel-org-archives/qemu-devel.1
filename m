Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6563C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:32:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84FB1206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84FB1206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7QE-0005lX-Jy
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jZ7OS-0003wC-HX
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:30:57 -0400
Received: from 9.mo177.mail-out.ovh.net ([46.105.72.238]:41318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jZ7OQ-0001G6-Fn
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:30:56 -0400
Received: from player688.ha.ovh.net (unknown [10.108.42.184])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 4C49413093D
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 08:30:52 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 4426A12418B2F;
 Thu, 14 May 2020 06:30:48 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] target/ppc: Add missing braces in
 ppc_radix64_partition_scoped_xlate()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
 <158941062665.240484.2663106458734800894.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <04aa2276-ff73-d695-e0d1-51076e515b4d@kaod.org>
Date: Thu, 14 May 2020 08:30:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158941062665.240484.2663106458734800894.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16545099133498329939
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleehgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheikeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.72.238; envelope-from=clg@kaod.org;
 helo=9.mo177.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 02:30:52
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

On 5/14/20 12:57 AM, Greg Kurz wrote:
> As per CODING_STYLE.
> 
> Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped translation"
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  target/ppc/mmu-radix64.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index 07f956c9864f..fb7dfe25ba6f 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -286,8 +286,9 @@ static int ppc_radix64_partition_scoped_xlate(PowerPCCPU *cpu, int rwx,
>                                pate.dw0 & PRTBE_R_RPDS, h_raddr, h_page_size,
>                                &pte, &fault_cause, &pte_addr) ||
>          ppc_radix64_check_prot(cpu, rwx, pte, &fault_cause, h_prot, true)) {
> -        if (pde_addr) /* address being translated was that of a guest pde */
> +        if (pde_addr) { /* address being translated was that of a guest pde */
>              fault_cause |= DSISR_PRTABLE_FAULT;
> +        }
>          if (cause_excp) {
>              ppc_radix64_raise_hsi(cpu, rwx, eaddr, g_raddr, fault_cause);
>          }
> 


