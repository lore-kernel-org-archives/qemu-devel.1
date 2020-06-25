Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D39EC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:03:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 655E9207E8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="We/CYXSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 655E9207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joTPZ-0002AD-Mq
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joTOZ-0001GW-8D
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:02:31 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:42592 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1joTOX-0008Fy-9O
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:02:30 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id D70E14C8B7;
 Thu, 25 Jun 2020 15:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593097344;
 x=1594911745; bh=oThQCtlFTIagl9wbYElNC61m9nqZMW5iRBPlY3X6ybs=; b=
 We/CYXSD4+mGFTrKzHBOs0I8tV8Et+PZ0VKYgXENErczJXUN+5/L7EpXdiM4pqka
 IqChhuu1l8lsKvlyuw8jWziaar6BOo+nGwmZlvSTdr7uVXl7hxBnTB6yG7Of7Xo0
 Vi1zeeu9zsSdjQbSw4QXrElpi1p2zorHDVSPqsBBBGs=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 73Tg2a8X_EDr; Thu, 25 Jun 2020 18:02:24 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 9F4484C8AD;
 Thu, 25 Jun 2020 18:02:24 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 25
 Jun 2020 18:02:24 +0300
Date: Thu, 25 Jun 2020 18:02:23 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6/8] i386: hvf: Drop hvf_reset_vcpu()
Message-ID: <20200625150223.GH25104@SPB-NB-133.local>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 11:02:26
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
> > 
> > Yes, there's such a place. post-init and post-reset invoke
> > hvf_put_registers() and the latter one calls hvf_put_segments().
> > hvf_put_segments() sets CR4 and CR0 via macvm_set_cr0/macvm_set_cr4
> > using the CR0/CR4 from env. So, the reset is relying on generic QEMU
> > CPUX86State now. LMA in EFER is reset there as well.
> 
> Ok, do you want to send a follow-up or a v2 of this?
> 

I'm still trying to understand what I should do :)

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

macvm_set_cr0() sets/clears LMA in entry controls only in case of
transitions into/out of long mode in enter_long_mode() in
exit_long_mode(), respectively. But macvm_set_cr0() doesn't load
EFER.LMA from CPUX86State into VMCS entry controls during reset and
that's where hvf_put_registers() might not behave properly.

As far as I understand you propose to drop explicit LMA reset in
post-reset and rather impove synchronization between efer and entry
controls in macvm_set_cr0(), right? In that case I don't see a
regression in the series, and if possible I'd prefer a follow up patch
for the issue.

> PDPTEs are not a problem, because they are not used after reset (only if
> CR4.PAE=CR4.PG=1 and EFER.LME=0).
> 

Ok, good, then we're leaving PDPTE initialization as is in post-reset.

Thanks,
Roman


