Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C96FC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:59:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6A123D38
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 12:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="XUXXkmas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6A123D38
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jptO2-0003QK-H3
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 08:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jptNF-0002yO-SU
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:59:01 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:46696 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jptND-0002Dw-8l
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 08:59:01 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 1FE7C4C88B;
 Mon, 29 Jun 2020 12:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593435536;
 x=1595249937; bh=oMCgcaA8AV2jrYjuAk7T40Y6T4kMVAxXOP0TY5pP064=; b=
 XUXXkmasqlJqz9+jkleBsx/9oEho4ny7tBj/pDY4d/ssCP8DCbd+JGiAuvPAaPhr
 K7WE1z3hfESG4GQm+siVz/M07WfBRHP5tC+Qf87Rpkg+bNfx7BRPsSDN/T1O41o0
 CtCJaq+CEToLd+4ytYOLpJEMxMF+yeNh6/seOvnVm9c=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2WqOVtZMBETM; Mon, 29 Jun 2020 15:58:56 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 2122341282;
 Mon, 29 Jun 2020 15:58:55 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 29
 Jun 2020 15:58:55 +0300
Date: Mon, 29 Jun 2020 15:58:55 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/8] i386: hvf: Drop hvf_reset_vcpu()
Message-ID: <20200629125855.GM25104@SPB-NB-133.local>
References: <20200624225850.16982-1-r.bolshakov@yadro.com>
 <20200624225850.16982-7-r.bolshakov@yadro.com>
 <ac800efc-c51d-e44c-de5c-cdef81d24dec@redhat.com>
 <20200625123637.GG25104@SPB-NB-133.local>
 <34821aae-e8f5-adc6-eab5-0a6f6b2835e8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <34821aae-e8f5-adc6-eab5-0a6f6b2835e8@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 07:31:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>,
 qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 25, 2020 at 03:30:38PM +0200, Paolo Bonzini wrote:
> On 25/06/20 14:36, Roman Bolshakov wrote:
> > I don't know any alternative for PDPTE and VMCS Entry Controls in
> > CPUX86State, that's why I left explicit reset of the VMCS fields in
> > post-reset.
> 
> VMCS entry controls should be handled by macvm_set_cr0 as well, because
> QEMU does not use any except for the LMA bit.  They are initialized zero
> 
>     wvmcs(cpu->hvf_fd, VMCS_ENTRY_CTLS,
> 	  cap2ctrl(hvf_state->hvf_caps->vmx_cap_entry, 0));
> 
> but in practice the last argument ends up being zero all the time.
> 
> PDPTEs are not a problem, because they are not used after reset (only if
> CR4.PAE=CR4.PG=1 and EFER.LME=0).
> 

Paolo, I'm not sure if I properly understand it yet but I don't see any
specific requirements on PDPTE's reset. SDM says that it should be valid
only if PAE is used as documented in 26.3.1.6 Checks on Guest
Page-Directory-Pointer-Table Entries:
 "A VM entry to a guest that does not use PAE paging does not check the
 validity of any PDPTEs.

 A VM entry that checks the validity of the PDPTEs uses the same checks
 that are used when CR3 is loaded with MOV to CR3 when PAE paging is in
 use. If MOV to CR3 would cause a general-protection exception due to
 the PDPTEs that would be loaded (e.g., because a reserved bit is set),
 the VM entry fails."

That means we can drop PDPTE initialization in hv_vcpu_reset() as well.
Perhaps, I can try that and check if Windows XP with PAE support works
well alright across resets. macvm_set_cr0() takes care of setting PDPTEs
upon the entry into PAE mode.

Regards,
Roman

