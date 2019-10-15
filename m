Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42E0EC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 13:30:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CC2218DE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 13:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CC2218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKMuC-0005SH-TN
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 09:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iKMtM-0004zd-E3
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iKMtJ-0004PF-Et
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:29:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iKMtJ-0004Oo-5b
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 09:29:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8D31A7FDE5;
 Tue, 15 Oct 2019 13:29:31 +0000 (UTC)
Received: from localhost (ovpn-116-20.phx2.redhat.com [10.3.116.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B20B5C21F;
 Tue, 15 Oct 2019 13:29:30 +0000 (UTC)
Date: Tue, 15 Oct 2019 10:29:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: "Kang, Luwei" <luwei.kang@intel.com>
Subject: Re: [PATCH v4 2/2] i386: Add support to get/set/migrate Intel
 Processor Trace feature
Message-ID: <20191015132929.GY4084@habkost.net>
References: <1520182116-16485-1-git-send-email-luwei.kang@intel.com>
 <1520182116-16485-2-git-send-email-luwei.kang@intel.com>
 <20191012031407.GK4084@habkost.net>
 <82D7661F83C1A047AF7DC287873BF1E17382A209@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82D7661F83C1A047AF7DC287873BF1E17382A209@SHSMSX104.ccr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 15 Oct 2019 13:29:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Chao Peng <chao.p.peng@linux.intel.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 12:51:48PM +0000, Kang, Luwei wrote:
> qemu> > diff --git a/target/i386/kvm.c b/target/i386/kvm.c index
> > > f9f4cd1..097c953 100644
> > > --- a/target/i386/kvm.c
> > > +++ b/target/i386/kvm.c
> > > @@ -1811,6 +1811,25 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
> > >                  kvm_msr_entry_add(cpu, MSR_MTRRphysMask(i), mask);
> > >              }
> > >          }
> > > +        if (env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_INTEL_PT) {
> > > +            int addr_num = kvm_arch_get_supported_cpuid(kvm_state,
> > > +                                                    0x14, 1, R_EAX) &
> > > + 0x7;
> > > +
> > > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_CTL,
> > > +                            env->msr_rtit_ctrl);
> > > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_STATUS,
> > > +                            env->msr_rtit_status);
> > > +            kvm_msr_entry_add(cpu, MSR_IA32_RTIT_OUTPUT_BASE,
> > > +                            env->msr_rtit_output_base);
> > 
> > This causes the following crash on some hosts:
> > 
> >   qemu-system-x86_64: error: failed to set MSR 0x560 to 0x0
> >   qemu-system-x86_64: target/i386/kvm.c:2673: kvm_put_msrs: Assertion `ret == cpu->kvm_msr_buf->nmsrs' failed.
> > 
> > Checking for CPUID_7_0_EBX_INTEL_PT is not enough: KVM has additional conditions that might prevent writing to this MSR
> > (PT_CAP_topa_output && PT_CAP_single_range_output).  This causes QEMU to crash if some of the conditions aren't met.
> > 
> > Writing and reading this MSR (and the ones below) need to be conditional on KVM_GET_MSR_INDEX_LIST.
> > 
> 
> Hi Eduardo,
>     I found this issue can't be reproduced in upstream source code but can be reproduced on RHEL8.1. I haven't got the qemu source code of RHEL8.1. But after adding some trace in KVM, I found the KVM has reported the complete Intel PT CPUID information to qemu but the Intel PT CPUID (0x14) is lost when qemu setting the CPUID to KVM (cpuid level is 0xd). It looks like lost the below patch.
> 
> commit f24c3a79a415042f6dc195f029a2ba7247d14cac
> Author: Luwei Kang <luwei.kang@intel.com>
> Date:   Tue Jan 29 18:52:59 2019 -0500
>     i386: extended the cpuid_level when Intel PT is enabled
> 
>     Intel Processor Trace required CPUID[0x14] but the cpuid_level
>     have no change when create a kvm guest with
>     e.g. "-cpu qemu64,+intel-pt".

Thanks for the pointer.  This may avoid triggering the bug in the
default configuration, but we still need to make the MSR writing
conditional on KVM_GET_MSR_INDEX_LIST.  Older machine-types have
x-intel-pt-auto-level=off, and the user may set `level` manually.

-- 
Eduardo

