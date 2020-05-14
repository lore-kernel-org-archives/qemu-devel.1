Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8185FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC68206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 06:32:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC68206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ7QN-00069w-FX
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 02:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jZ7Oj-0004IV-4e
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:31:13 -0400
Received: from 10.mo7.mail-out.ovh.net ([178.33.250.56]:40550)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jZ7Og-0001JP-QZ
 for qemu-devel@nongnu.org; Thu, 14 May 2020 02:31:12 -0400
Received: from player798.ha.ovh.net (unknown [10.110.171.171])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id ADEB5163DC1
 for <qemu-devel@nongnu.org>; Thu, 14 May 2020 08:31:08 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player798.ha.ovh.net (Postfix) with ESMTPSA id A7CCC1271C7CA;
 Thu, 14 May 2020 06:31:02 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R0015f37fe8f-c5e0-4290-94d7-da9f5d3ef856,92317E36A8DCBCCD86D4D3FC09BF80838F08FB4C)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v2 5/6] target/ppc: Fix arguments to
 ppc_radix64_partition_scoped_xlate()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <158941060199.240484.5620994992064687533.stgit@bahia.lan>
 <158941063281.240484.9114539141307005992.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <595fce14-b04a-48f5-63c6-9532b9d8af26@kaod.org>
Date: Thu, 14 May 2020 08:31:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158941063281.240484.9114539141307005992.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 16549602731442080595
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrleehgddutdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.250.56; envelope-from=clg@kaod.org;
 helo=10.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 02:31:08
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
> The last two arguments have the bool type. Also, we shouldn't raise an
> exception when using gdbstub.
> 
> This was found while reading the code. Since it only affects the powernv
> machine, I didn't dig further to find an actual bug.
> 
> Fixes: d04ea940c597 "target/ppc: Add support for Radix partition-scoped translation"
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>  target/ppc/mmu-radix64.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index fb7dfe25ba6f..7ce37cb778db 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -339,7 +339,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>           */
>          ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, prtbe_addr,
>                                                   pate, &h_raddr, &h_prot,
> -                                                 &h_page_size, 1, 1);
> +                                                 &h_page_size, true,
> +                                                 cause_excp);
>          if (ret) {
>              return ret;
>          }
> @@ -378,7 +379,8 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu, int rwx,
>          do {
>              ret = ppc_radix64_partition_scoped_xlate(cpu, 0, eaddr, pte_addr,
>                                                       pate, &h_raddr, &h_prot,
> -                                                     &h_page_size, 1, 1);
> +                                                     &h_page_size, true,
> +                                                     cause_excp);
>              if (ret) {
>                  return ret;
>              }
> 


