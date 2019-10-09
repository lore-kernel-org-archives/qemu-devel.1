Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18318C4360C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2E93206C2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 01:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2E93206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iI0QH-0000NH-0g
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 21:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iI0Nw-0006pO-I1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:03:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iI0Nu-000779-0B
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:03:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:14379)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iI0Nt-00076Y-Nf
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 21:03:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 08 Oct 2019 18:03:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,273,1566889200"; d="scan'208";a="206765238"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.196.191])
 ([10.239.196.191])
 by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2019 18:03:16 -0700
Subject: Re: [PATCH v5 0/2] x86: Enable user wait instructions
To: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>
References: <20190929015718.19562-1-tao3.xu@intel.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <032bc3fa-d950-a30a-cb95-8fb11b398fd2@intel.com>
Date: Wed, 9 Oct 2019 09:03:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190929015718.19562-1-tao3.xu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.31
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
Cc: "Liu, Jingqi" <jingqi.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for comments :)

On 9/29/2019 9:57 AM, Xu, Tao3 wrote:
> UMONITOR, UMWAIT and TPAUSE are a set of user wait instructions.
> 
> UMONITOR arms address monitoring hardware using an address. A store
> to an address within the specified address range triggers the
> monitoring hardware to wake up the processor waiting in umwait.
> 
> UMWAIT instructs the processor to enter an implementation-dependent
> optimized state while monitoring a range of addresses. The optimized
> state may be either a light-weight power/performance optimized state
> (c0.1 state) or an improved power/performance optimized state
> (c0.2 state).
> 
> TPAUSE instructs the processor to enter an implementation-dependent
> optimized state c0.1 or c0.2 state and wake up when time-stamp counter
> reaches specified timeout.
> 
> Availability of the user wait instructions is indicated by the presence
> of the CPUID feature flag WAITPKG CPUID.0x07.0x0:ECX[5].
> 
> The patches enable the umonitor, umwait and tpause features in KVM.
> Because umwait and tpause can put a (psysical) CPU into a power saving
> state, by default we dont't expose it in kvm and provide a capability to
> enable it. Use kvm capability to enable UMONITOR, UMWAIT and TPAUSE when
> QEMU use "-overcommit cpu-pm=on, a VM can use UMONITOR, UMWAIT and TPAUSE
> instructions. If the instruction causes a delay, the amount of time
> delayed is called here the physical delay. The physical delay is first
> computed by determining the virtual delay (the time to delay relative to
> the VM’s timestamp counter). Otherwise, UMONITOR, UMWAIT and TPAUSE cause
> an invalid-opcode exception(#UD).
> 
> The release document ref below link:
> https://software.intel.com/sites/default/files/\
> managed/39/c5/325462-sdm-vol-1-2abcd-3abcd.pdf
> 
> Changelog:
> v5:
> 	Remove CPUID_7_0_ECX_WAITPKG if enable_cpu_pm is not set. (Paolo)
> v4:
> 	Set IA32_UMWAIT_CONTROL 32bits
> v3:
> 	Simplify the patches, expose user wait instructions when the guest
> 	has CPUID (Paolo)
> v2:
> 	Separated from the series
> 	https://www.mail-archive.com/qemu-devel@nongnu.org/msg549526.html
> 	Use kvm capability to enable UMONITOR, UMWAIT and TPAUSE when
> 	QEMU use "-overcommit cpu-pm=on"	
> v1:
> 	Sent out with MOVDIRI/MOVDIR64B instructions patches
> 
> Tao Xu (2):
>    x86/cpu: Add support for UMONITOR/UMWAIT/TPAUSE
>    target/i386: Add support for save/load IA32_UMWAIT_CONTROL MSR
> 
>   target/i386/cpu.c     |  3 ++-
>   target/i386/cpu.h     |  3 +++
>   target/i386/kvm.c     | 19 +++++++++++++++++++
>   target/i386/machine.c | 20 ++++++++++++++++++++
>   4 files changed, 44 insertions(+), 1 deletion(-)
> 


