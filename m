Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11751C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:43:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC69C206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 09:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="OXVqy0/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC69C206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juuzr-0004jl-3h
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 05:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33926)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1juuwA-0007o3-Nu
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:39:50 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:33862 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1juuw8-0007zd-Lo
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 05:39:50 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 57FEE4C895;
 Mon, 13 Jul 2020 09:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1594633184;
 x=1596447585; bh=A0NE5T2IKT7eWNWzpzPEIe66YY1+D8nFbfC/FpbocNk=; b=
 OXVqy0/fDsgT1MRATcp67HNl3anPNIT1AE4DYWe7VjFXOduXnBcnlkejo+gqS1xS
 npMs5KIAa+ZUrFrfeV/WCzJK2HEHcFzYDeCyincZKN93yoTWCxt6CFluuUH7LfA/
 cDVni/9yIerxDNIsHV3qsv3Py3aLAHlAW9/owddfKKY=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pjC0m-UsepAf; Mon, 13 Jul 2020 12:39:44 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 144424C894;
 Mon, 13 Jul 2020 12:39:44 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 13
 Jul 2020 12:39:43 +0300
Date: Mon, 13 Jul 2020 12:39:43 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] i386: hvf: Implement CPU kick
Message-ID: <20200713093943.GA90799@SPB-NB-133.local>
References: <20200702105721.75333-1-r.bolshakov@yadro.com>
 <fa29e532-a891-cf61-a8a2-af5e36e7834f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fa29e532-a891-cf61-a8a2-af5e36e7834f@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 05:39:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Claudio Fontana <cfontana@suse.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 02, 2020 at 02:42:45PM +0200, Paolo Bonzini wrote:
> On 02/07/20 12:57, Roman Bolshakov wrote:
> > There's still a small chance of kick loss, on user-to-kernel border
> > between atomic_mb_set's just before the entry to hv_vcpu_run and just
> > after it.
> 
> Good point, but we can fix it.
> 
> > -static void dummy_signal(int sig)
> > +static void hvf_handle_ipi(int sig)
> >  {
> > +    CPUState *cpu = pthread_getspecific(hvf_cpu);
> 
> You can use current_cpu here.  If it's NULL, just return (it's a
> per-thread variable).
> 
> > +    X86CPU *x86_cpu = X86_CPU(cpu);
> > +    CPUX86State *env = &x86_cpu->env;
> > +
> > +    if (!atomic_xchg(&env->hvf_in_guest, false)) {
> 
> Here, thinking more about it, we need not write hvf_in_guest, so:
> 
> 	/* Write cpu->exit_request before reading env->hvf_in_guest.  */
> 	smp_mb();
> 	if (!atomic_read(&env->hvf_in_guest)) {
> 		...
> 	}
> 
> > +        wvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS,
> > +              rvmcs(cpu->hvf_fd, VMCS_PIN_BASED_CTLS)
> > +                | VMCS_PIN_BASED_CTLS_VMX_PREEMPT_TIMER);
> > +    }
> >  }
> >  
> >  int hvf_init_vcpu(CPUState *cpu)
> > @@ -631,7 +650,9 @@ int hvf_vcpu_exec(CPUState *cpu)
> >              return EXCP_HLT;
> >          }
> >  
> > +        atomic_mb_set(&env->hvf_in_guest, true);
> >          hv_return_t r  = hv_vcpu_run(cpu->hvf_fd);
> > +        atomic_mb_set(&env->hvf_in_guest, false);
> 
> 
> And here you can do instead:
> 
> 	atomic_set(&env->hvf_in_guest, true);
> 	/* Read cpu->exit_request after writing env->hvf_in_guest.  */
> 	smp_mb();
> 	if (atomic_read(&cpu->exit_request)) {
> 	    qemu_mutex_lock_iothread();
> 	    atomic_set(&env->hvf_in_guest, false);
> 	    return EXCP_INTERRUPT;
> 	}
> 	hv_return_t r  = hv_vcpu_run(cpu->hvf_fd);
> 	atomic_store_release(&env->hvf_in_guest, false);
> 
> This matching "write A/smp_mb()/read B" and "write B/smp_mb()/read A" is
> a very common idiom for lock-free signaling between threads.
> 

Hi Paolo,

Thanks for the feedback and the guidelines. I think I've got the idea:

exit_request is the way to record the fact of kick request even if it
was sent outside of hv_vcpu_run().

Best regards,
Roman

