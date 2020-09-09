Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E94DC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:26:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1C6322272
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 15:26:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYkMbvbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C6322272
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37214 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG1zp-0003aJ-V3
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 11:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kG1yx-00038q-3L
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:25:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45134
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kG1yu-0005mK-Cc
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 11:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599665153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S0HGwn08RTZDvSiMKGm+kokg7Mfm7dvHTLJh8SzogJA=;
 b=JYkMbvbjTbFY/6all5du3qwzJl50c//GzGBJap5dPAm+u0y6JywBF0+/CC01MoHZ8syYVJ
 CWUgoxQGX4W5NeA8mbCCLDARzcxDTwJ35jShI8AZKD7g6QOluvcJstQWVMhPCo17j54+2U
 ucDBU8L+t4BjAkr4QvOpk7kNw5Jlzwc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-8uZ_4VOWNSiimj2WvWYA1w-1; Wed, 09 Sep 2020 11:25:50 -0400
X-MC-Unique: 8uZ_4VOWNSiimj2WvWYA1w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9E011017DC3;
 Wed,  9 Sep 2020 15:25:47 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 457655C1C2;
 Wed,  9 Sep 2020 15:25:44 +0000 (UTC)
Date: Wed, 9 Sep 2020 17:25:40 +0200
From: Andrew Jones <drjones@redhat.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
Message-ID: <20200909152540.ylnrljd6aelxoxrf@kamzik.brq.redhat.com>
References: <20200904160018.29481-1-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160018.29481-1-steven.price@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:13:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URI_DOTEDU=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <Peter.Maydell@arm.com>, Juan Quintela <quintela@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kvmarm@lists.cs.columbia.edu,
 linux-arm-kernel@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Dave Martin <Dave.Martin@arm.com>, linux-kernel@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 04, 2020 at 05:00:16PM +0100, Steven Price wrote:
> Arm's Memory Tagging Extension (MTE) adds 4 bits of tag data to every 16
> bytes of memory in the system. This along with stashing a tag within the
> high bit of virtual addresses allows runtime checking of memory
> accesses.
> 
> These patches add support to KVM to enable MTE within a guest. They are
> based on Catalin's v9 MTE user-space support series[1].
> 
> I'd welcome feedback on the proposed user-kernel ABI. Specifically this
> series currently:
>
   0. Feature probing

Probably a KVM cap, rather than requiring userspace to attempt VCPU
features one at a time with a scratch VCPU.
 
>  1. Requires the VMM to enable MTE per-VCPU.

I suppose. We're collecting many features that are enabling CPU features,
so they map nicely to VCPU features, yet they're effectively VM features
due to a shared resource such as an irq or memory.

>  2. Automatically promotes (normal host) memory given to the guest to be
>     tag enabled (sets PG_mte_tagged), if any VCPU has MTE enabled. The
>     tags are cleared if the memory wasn't previously MTE enabled.

Shouldn't this be up to the guest? Or, is this required in order for the
guest to use tagging at all. Something like making the guest IPAs memtag
capable, but if the guest doesn't enable tagging then there is no guest
impact? In any case, shouldn't userspace be the one that adds PROT_MTE
to the memory regions it wants the guest to be able to use tagging with,
rather than KVM adding the attribute page by page?

>  3. Doesn't provide any new methods for the VMM to access the tags on
>     memory.
> 
> (2) and (3) are particularly interesting from the aspect of VM migration.
> The guest is able to store/retrieve data in the tags (presumably for the
> purpose of tag checking, but architecturally it could be used as just
> storage). This means that when migrating a guest the data needs to be
> transferred (or saved/restored).
> 
> MTE tags are controlled by the same permission model as normal pages
> (i.e. a read-only page has read-only tags), so the normal methods of
> detecting guest changes to pages can be used. But this would also
> require the tags within a page to be migrated at the same time as the
> data (since the access control for tags is the same as the normal data
> within a page).
> 
> (3) may be problematic and I'd welcome input from those familiar with
> VMMs. User space cannot access tags unless the memory is mapped with the
> PROT_MTE flag. However enabling PROT_MTE will also enable tag checking
> for the user space process (assuming the VMM enables tag checking for
> the process) and since the tags in memory are controlled by the guest
> it's unlikely the VMM would have an appropriately tagged pointer for its
> access. This means the VMM would either need to maintain two mappings of
> memory (one to access tags, the other to access data) or disable tag
> checking during the accesses to data.

If userspace needs to write to guest memory then it should be due to
a device DMA or other specific hardware emulation. Those accesses can
be done with tag checking disabled.

> 
> If it's not practical to either disable tag checking in the VMM or
> maintain multiple mappings then the alternatives I'm aware of are:
> 
>  * Provide a KVM-specific method to extract the tags from guest memory.
>    This might also have benefits in terms of providing an easy way to
>    read bulk tag data from guest memory (since the LDGM instruction
>    isn't available at EL0).

Maybe we need a new version of KVM_GET_DIRTY_LOG that also provides
the tags for all addresses of each dirty page.

>  * Provide support for user space setting the TCMA0 or TCMA1 bits in
>    TCR_EL1. These would allow the VMM to generate pointers which are not
>    tag checked.

So this is necessary to allow the VMM to keep tag checking enabled for
itself, plus map guest memory as PROT_MTE, and write to that memory when
needed? 

Thanks,
drew

> 
> Feedback is welcome, and feel free to ask questions if anything in the
> above doesn't make sense.
> 
> Changes since the previous v1 posting[2]:
> 
>  * Rebasing clean-ups
>  * sysreg visibility is now controlled based on whether the VCPU has MTE
>    enabled or not
> 
> [1] https://lore.kernel.org/r/20200904103029.32083-1-catalin.marinas@arm.com
> [2] https://lore.kernel.org/r/20200713100102.53664-1-steven.price%40arm.com
> 
> Steven Price (2):
>   arm64: kvm: Save/restore MTE registers
>   arm64: kvm: Introduce MTE VCPU feature
> 
>  arch/arm64/include/asm/kvm_emulate.h       |  3 +++
>  arch/arm64/include/asm/kvm_host.h          |  9 ++++++++-
>  arch/arm64/include/asm/sysreg.h            |  3 ++-
>  arch/arm64/include/uapi/asm/kvm.h          |  1 +
>  arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
>  arch/arm64/kvm/mmu.c                       | 15 +++++++++++++++
>  arch/arm64/kvm/reset.c                     |  8 ++++++++
>  arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
>  8 files changed, 66 insertions(+), 7 deletions(-)
> 
> -- 
> 2.20.1
> 
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> 


