Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6F4C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C1820848
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 18:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C1820848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41998 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1x4j-0005ca-Qb
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 13:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1j1x44-000537-GX
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:48:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1j1x43-0006li-I0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:48:48 -0500
Received: from 7.mo69.mail-out.ovh.net ([46.105.50.32]:33132)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1j1x43-0006l5-Cw
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 13:48:47 -0500
Received: from player788.ha.ovh.net (unknown [10.110.115.67])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id D08BA80709
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 19:48:37 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id C396FF56E5A4;
 Wed, 12 Feb 2020 18:48:30 +0000 (UTC)
Date: Wed, 12 Feb 2020 19:48:25 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PULL 34/35] target/ppc: Use probe_write for DCBZ
Message-ID: <20200212194825.18da5290@bahia.lan>
In-Reply-To: <20200203061123.59150-35-david@gibson.dropbear.id.au>
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
 <20200203061123.59150-35-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5225582946007816678
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedugedrieehgdduvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.50.32
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
Cc: lvivier@redhat.com, peter.maydell@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon,  3 Feb 2020 17:11:22 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> From: Richard Henderson <richard.henderson@linaro.org>
> 
> Using probe_write instead of tlb_vaddr_to_host means that we
> process watchpoints and notdirty pages more efficiently.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20200129235040.24022-5-richard.henderson@linaro.org>
> Tested-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/ppc/mem_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index 0cb78777e7..98f589552b 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -298,7 +298,7 @@ static void dcbz_common(CPUPPCState *env, target_ulong addr,
>      }
>  
>      /* Try fast path translate */
> -    haddr = tlb_vaddr_to_host(env, addr, MMU_DATA_STORE, mmu_idx);
> +    haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);

Hi Richard,

This one is making coverity unhappy.


** CID 1419390:  Memory - corruptions  (OVERRUN)


______________________________________________________________________________________________________
*** CID 1419390:  Memory - corruptions  (OVERRUN)
/target/ppc/mem_helper.c: 301 in dcbz_common()
295         /* Check reservation */
296         if ((env->reserve_addr & mask) == addr)  {
297             env->reserve_addr = (target_ulong)-1ULL;
298         }
299     
300         /* Try fast path translate */
>>>     CID 1419390:  Memory - corruptions  (OVERRUN)
>>>     Overrunning callee's array of size 9 by passing argument "mmu_idx" (which evaluates to 9) in call to "probe_write".  
301         haddr = probe_write(env, addr, dcbz_size, mmu_idx, retaddr);
302         if (haddr) {
303             memset(haddr, 0, dcbz_size);
304         } else {
305             /* Slow path */
306             for (i = 0; i < dcbz_size; i += 8) {


Can you have a look ?

Cheers,

--
Greg

>      if (haddr) {
>          memset(haddr, 0, dcbz_size);
>      } else {


