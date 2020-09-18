Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F4EC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 03:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2959A21973
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 03:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2959A21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJ7H2-00017y-0O
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 23:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46088)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kJ7GB-0000ba-Vo
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 23:40:31 -0400
Received: from mga11.intel.com ([192.55.52.93]:1108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sean.j.christopherson@intel.com>)
 id 1kJ7G8-000844-Tz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 23:40:31 -0400
IronPort-SDR: lDNohdsWlWVIgKLOHqinCd9lYyTCCbqwXbrp99CtwCf+IZB66w4MgAWckkaf/tRy2E1EYwuynG
 TzSrN5A/9Pcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9747"; a="157244561"
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; d="scan'208";a="157244561"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 20:40:21 -0700
IronPort-SDR: CbVNzFAOMR3PkY/2fc34QHgHGNTt+SunCQniElVPuifxlEm7+YvAweuzuX5pmbt79qQIA06lOR
 JVOyXFusBiQQ==
X-IronPort-AV: E=Sophos;i="5.77,273,1596524400"; d="scan'208";a="339662430"
Received: from sjchrist-ice.jf.intel.com (HELO sjchrist-ice) ([10.54.31.34])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2020 20:40:20 -0700
Date: Thu, 17 Sep 2020 20:40:19 -0700
From: Sean Christopherson <sean.j.christopherson@intel.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 0/5] Qemu SEV-ES guest support
Message-ID: <20200918034015.GD14678@sjchrist-ice>
References: <cover.1600205384.git.thomas.lendacky@amd.com>
 <20200917172802.GS2793@work-vm>
 <de0e9c27-8954-3a77-21db-cad84f334277@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0e9c27-8954-3a77-21db-cad84f334277@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=sean.j.christopherson@intel.com; helo=mga11.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 23:40:22
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Brijesh Singh <brijesh.singh@amd.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Connor Kuehl <ckuehl@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Slaby <jslaby@suse.cz>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 01:56:21PM -0500, Tom Lendacky wrote:
> On 9/17/20 12:28 PM, Dr. David Alan Gilbert wrote:
> > * Tom Lendacky (thomas.lendacky@amd.com) wrote:
> > > From: Tom Lendacky <thomas.lendacky@amd.com>
> > > 
> > > This patch series provides support for launching an SEV-ES guest.
> > > 
> > > Secure Encrypted Virtualization - Encrypted State (SEV-ES) expands on the
> > > SEV support to protect the guest register state from the hypervisor. See
> > > "AMD64 Architecture Programmer's Manual Volume 2: System Programming",
> > > section "15.35 Encrypted State (SEV-ES)" [1].
> > > 
> > > In order to allow a hypervisor to perform functions on behalf of a guest,
> > > there is architectural support for notifying a guest's operating system
> > > when certain types of VMEXITs are about to occur. This allows the guest to
> > > selectively share information with the hypervisor to satisfy the requested
> > > function. The notification is performed using a new exception, the VMM
> > > Communication exception (#VC). The information is shared through the
> > > Guest-Hypervisor Communication Block (GHCB) using the VMGEXIT instruction.
> > > The GHCB format and the protocol for using it is documented in "SEV-ES
> > > Guest-Hypervisor Communication Block Standardization" [2].
> > > 
> > > The main areas of the Qemu code that are updated to support SEV-ES are
> > > around the SEV guest launch process and AP booting in order to support
> > > booting multiple vCPUs.
> > > 
> > > There are no new command line switches required. Instead, the desire for
> > > SEV-ES is presented using the SEV policy object. Bit 2 of the SEV policy
> > > object indicates that SEV-ES is required.
> > > 
> > > The SEV launch process is updated in two ways. The first is that a the
> > > KVM_SEV_ES_INIT ioctl is used to initialize the guest instead of the
> > > standard KVM_SEV_INIT ioctl. The second is that before the SEV launch
> > > measurement is calculated, the LAUNCH_UPDATE_VMSA SEV API is invoked for
> > > each vCPU that Qemu has created. Once the LAUNCH_UPDATE_VMSA API has been
> > > invoked, no direct changes to the guest register state can be made.
> > > 
> > > AP booting poses some interesting challenges. The INIT-SIPI-SIPI sequence
> > > is typically used to boot the APs. However, the hypervisor is not allowed
> > > to update the guest registers. For the APs, the reset vector must be known
> > > in advance. An OVMF method to provide a known reset vector address exists
> > > by providing an SEV information block, identified by UUID, near the end of
> > > the firmware [3]. OVMF will program the jump to the actual reset vector in
> > > this area of memory. Since the memory location is known in advance, an AP
> > > can be created with the known reset vector address as its starting CS:IP.
> > > The GHCB document [2] talks about how SMP booting under SEV-ES is
> > > performed. SEV-ES also requires the use of the in-kernel irqchip support
> > > in order to minimize the changes required to Qemu to support AP booting.
> > 
> > Some random thoughts:
> >    a) Is there something that explicitly disallows SMM?
> 
> There isn't currently. Is there a way to know early on that SMM is enabled?
> Could I just call x86_machine_is_smm_enabled() to check that?

KVM_CAP_X86_SMM is currently checked as a KVM-wide capability.  One option
is to change that to use a per-VM ioctl() and then have KVM return 0 for
SEV-ES VMs.

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 416c82048a..4d7f84ed1b 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -145,7 +145,7 @@ int kvm_has_pit_state2(void)

 bool kvm_has_smm(void)
 {
-    return kvm_check_extension(kvm_state, KVM_CAP_X86_SMM);
+    return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);
 }

 bool kvm_has_adjust_clock_stable(void)

> >    b) I think all the interfaces you're using are already defined in
> > Linux header files - even if the code to implement them isn't actually
> > upstream in the kernel yet (the launch_update in particular) - we
> > normally wait for the kernel interface to be accepted before taking the
> > QEMU patches, but if the constants are in the headers already I'm not
> > sure what the rule is.
> 
> Correct, everything was already present from a Linux header perspective.
> 
> >    c) What happens if QEMU reads the register values from the state if
> > the guest is paused - does it just see junk?  I'm just wondering if you
> > need to add checks in places it might try to.
> 
> I thought about what to do about calls to read the registers once the guest
> state has become encrypted. I think it would take a lot of changes to make
> Qemu "protected state aware" for what I see as little gain. Qemu is likely
> to see a lot of zeroes or actual register values from the GHCB protocol for
> previous VMGEXITs that took place.

Yeah, we more or less came to the same conclusion for TDX.  It's easy enough
to throw an error if QEMU attempts to read protected state, but without
other invasive changes, it's too easy to unintentionally kill the VM.  MSRs
are a bit of a special case, but for REGS, SREGS, and whatever other state
is read out, simply letting KVM return zeros/garbage seems like the lesser
of all evils.

