Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48193C2BA15
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 18:00:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CF620678
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 18:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="oPluTSvq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CF620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jL9Z4-0000Ea-1J
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 14:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <r.bolshakov@yadro.com>) id 1jL9Xp-0007qw-G5
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 13:58:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <r.bolshakov@yadro.com>) id 1jL9Xm-0001qE-EY
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 13:58:51 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:53176 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
 id 1jL9Xm-0001oE-1F
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 13:58:50 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id B4F48412CF;
 Sun,  5 Apr 2020 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1586109525;
 x=1587923926; bh=LXtDwI4BXOnKX2ALZFA3hImZOCQFLUov/Vqc+b1GZzU=; b=
 oPluTSvqvQXDaKOcEiHfgaJwXH0dG4RG8YdAGn6cW6UcLdPK7VcvZl8yLkST5c7N
 sWUA1jgBnPANwZoknvP0fygGPt26MslMhyhUO6bHa8/nI4ZE4Non4vvuW3TpVVfX
 93tKwqTb0e6/3oDa5uaQtJazAgQfeF430zq0C9E5ItU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lJ-I_BDae2Yl; Sun,  5 Apr 2020 20:58:45 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 1978441287;
 Sun,  5 Apr 2020 20:58:45 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Sun, 5 Apr
 2020 20:58:45 +0300
Date: Sun, 5 Apr 2020 20:58:45 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH v1 1/3] hvf: use standard CR0 and CR4 register definitions
Message-ID: <20200405175845.GC74346@SPB-NB-133.local>
References: <cover.1585607927.git.dirty@apple.com>
 <9ba0495405a1cd1e6c272a1e67d54dfda09494e1.1585607927.git.dirty@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <9ba0495405a1cd1e6c272a1e67d54dfda09494e1.1585607927.git.dirty@apple.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 89.207.88.252
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 30, 2020 at 05:16:04PM -0700, Cameron Esfahani wrote:
> Signed-off-by: Cameron Esfahani <dirty@apple.com>
> ---
>  target/i386/cpu.h          |  2 ++
>  target/i386/hvf/hvf.c      |  1 +
>  target/i386/hvf/vmx.h      | 15 ++++++++-------
>  target/i386/hvf/x86.c      |  6 +++---
>  target/i386/hvf/x86.h      | 34 ----------------------------------
>  target/i386/hvf/x86_mmu.c  |  2 +-
>  target/i386/hvf/x86_task.c |  3 ++-
>  7 files changed, 17 insertions(+), 46 deletions(-)
> 

Hi Cameron,

I'm sorry for delay.

This is fun, I had very similar changeset I forgot to send quite a while
ago:
https://github.com/roolebo/qemu/commits/hvf-common-cr-constants

> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index d72543dc31..fef1ee7d70 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -455,6 +455,7 @@ void hvf_reset_vcpu(CPUState *cpu) {
>          wvmcs(cpu->hvf_fd, VMCS_GUEST_PDPTE0 + i * 2, pdpte[i]);
>      }
>  
> +    macvm_set_cr0(cpu->hvf_fd, CR0_CD_MASK | CR0_NW_MASK | CR0_ET_MASK);
>      macvm_set_cr0(cpu->hvf_fd, 0x60000010);

The second macvm_set_cr0() is a duplicate of the first one and should be
dropped.

>  
>      wvmcs(cpu->hvf_fd, VMCS_CR4_MASK, CR4_VMXE_MASK);
> diff --git a/target/i386/hvf/vmx.h b/target/i386/hvf/vmx.h
> index 03d2c79b9c..8ec2e6414e 100644
> --- a/target/i386/hvf/vmx.h
> +++ b/target/i386/hvf/vmx.h
> @@ -138,17 +139,17 @@ static inline void macvm_set_cr0(hv_vcpuid_t vcpu, uint64_t cr0)
>      wvmcs(vcpu, VMCS_CR0_SHADOW, cr0);
>  
>      if (efer & MSR_EFER_LME) {
> -        if (!(old_cr0 & CR0_PG) && (cr0 & CR0_PG)) {
> +        if (!(old_cr0 & CR0_PG_MASK) && (cr0 & CR0_PG_MASK)) {
>              enter_long_mode(vcpu, cr0, efer);
>          }
> -        if (/*(old_cr0 & CR0_PG) &&*/ !(cr0 & CR0_PG)) {
> +        if (!(cr0 & CR0_PG_MASK)) {

IMO the patch should only change CR0_PG to CR0_PG_MASK without removal
of the commented condition.

In the next patch you're improving how long mode exit is done and
replacement of the comment with an implementation fits better there.

>              exit_long_mode(vcpu, cr0, efer);
>          }
>      }
>  
>      /* Filter new CR0 after we are finished examining it above. */
> -    cr0 = (cr0 & ~(mask & ~CR0_PG));
> -    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE | CR0_ET);
> +    cr0 = (cr0 & ~(mask & ~CR0_PG_MASK));
> +    wvmcs(vcpu, VMCS_GUEST_CR0, cr0 | CR0_NE_MASK | CR0_ET_MASK);
>  
>      hv_vcpu_invalidate_tlb(vcpu);
>      hv_vcpu_flush(vcpu);
> -- 
> 2.24.0
> 

Best regards,
Roman

