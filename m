Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49415C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6730206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 16:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CzO/HUXZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6730206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONrH-0001sx-2F
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 12:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kONqB-0000f9-61
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55492)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1kONq9-0002co-8E
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 12:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601655804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aye1Pb2hwY0JlLJorHYQNOa61uWEXTTAnRL28wGoWj4=;
 b=CzO/HUXZ3ubZL0rPxAI7ISdhsbM7f1iqgWkWD0WtLPXdCp+Fy/y/duSb+olyC/gWWO4SW6
 xWcD9GjrVtO5slVcX/Y7HpzqeP7KLsk6VTzH/aCCTRjCpI9DtsdCkte/etXxPqyFua46VD
 r9M9egUUN9PcVPeeYbbFbuKRIb9aSFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-I0rZ_L8FPfijpuy-niMAjw-1; Fri, 02 Oct 2020 12:23:20 -0400
X-MC-Unique: I0rZ_L8FPfijpuy-niMAjw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16E2380364B;
 Fri,  2 Oct 2020 16:23:18 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.194.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAF145D9D3;
 Fri,  2 Oct 2020 16:23:13 +0000 (UTC)
Date: Fri, 2 Oct 2020 18:23:10 +0200
From: Andrew Jones <drjones@redhat.com>
To: Steven Price <steven.price@arm.com>
Subject: Re: [PATCH v3 0/2] MTE support for KVM guest
Message-ID: <20201002162310.zadgljfjl2uezys6@kamzik.brq.redhat.com>
References: <20200925093607.3051-1-steven.price@arm.com>
 <20201002143640.uzsz3nhr45payhlb@kamzik.brq.redhat.com>
 <b653bbc8-1ebc-7c1a-9653-5441ca1be4b2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b653bbc8-1ebc-7c1a-9653-5441ca1be4b2@arm.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=63.128.21.124; envelope-from=drjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 23:37:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>, linux-kernel@vger.kernel.org,
 Haibo Xu <Haibo.Xu@arm.com>, Juan Quintela <quintela@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org,
 Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
 Julien Thierry <julien.thierry.kdev@gmail.com>,
 Dave Martin <Dave.Martin@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 02, 2020 at 04:38:11PM +0100, Steven Price wrote:
> On 02/10/2020 15:36, Andrew Jones wrote:
> > On Fri, Sep 25, 2020 at 10:36:05AM +0100, Steven Price wrote:
> > > Version 3 of adding MTE support for KVM guests. See the previous (v2)
> > > posting for background:
> > > 
> > >   https://lore.kernel.org/r/20200904160018.29481-1-steven.price%40arm.com
> > > 
> > > These patches add support to KVM to enable MTE within a guest. They are
> > > based on Catalin's v9 MTE user-space support series[1] (currently in
> > > next).
> > > 
> > > Changes since v2:
> > > 
> > >   * MTE is no longer a VCPU feature, instead it is a VM cap.
> > > 
> > >   * Being a VM cap means easier probing (check for KVM_CAP_ARM_MTE).
> > > 
> > >   * The cap must be set before any VCPUs are created, preventing any
> > >     shenanigans where MTE is enabled for the guest after memory accesses
> > >     have been performed.
> > > 
> > > [1] https://lore.kernel.org/r/20200904103029.32083-1-catalin.marinas@arm.com
> > > 
> > > Steven Price (2):
> > >    arm64: kvm: Save/restore MTE registers
> > >    arm64: kvm: Introduce MTE VCPU feature
> > > 
> > >   arch/arm64/include/asm/kvm_emulate.h       |  3 +++
> > >   arch/arm64/include/asm/kvm_host.h          |  7 +++++++
> > >   arch/arm64/include/asm/sysreg.h            |  3 ++-
> > >   arch/arm64/kvm/arm.c                       |  9 +++++++++
> > >   arch/arm64/kvm/hyp/include/hyp/sysreg-sr.h | 14 ++++++++++++++
> > >   arch/arm64/kvm/mmu.c                       | 15 +++++++++++++++
> > >   arch/arm64/kvm/sys_regs.c                  | 20 +++++++++++++++-----
> > >   include/uapi/linux/kvm.h                   |  1 +
> > >   8 files changed, 66 insertions(+), 6 deletions(-)
> > > 
> > > -- 
> > > 2.20.1
> > > 
> > > 
> > 
> > Hi Steven,
> > 
> > These patches look fine to me, but I'd prefer we have a working
> > implementation in QEMU before we get too excited about the KVM
> > bits. kvmtool isn't sufficient since it doesn't support migration
> > (at least afaik). In the past we've implemented features in KVM
> > that look fine, but then issues have been discovered when trying
> > to enable them from QEMU, where we also support migration. This
> > feature looks like there's risk of issues with the userspace side.
> > Although these two patches would probably stay the same, even if
> > userspace requires more support.
> 
> I agree kvmtool isn't a great test because it doesn't support migration. The
> support in this series is just the basic support for MTE in a guest and we'd
> need to wait for the QEMU implementation before deciding whether we need any
> extra support (e.g. kernel interfaces for reading/writing tags as discussed
> before).
> 
> However, I don't think there's much danger of the support in this series
> changing - so extra support can be added when/if it's needed, but I don't
> think we need to block these series on that - QEMU can just probe for
> whatever additional support it needs before enabling MTE in a guest. I plan
> to rebase/repost after -rc1 when the user space support has been merged.
> 

Fair enough, but it feels like we'll be merging half a feature, leaving
the other half for somebody else to pick up later.

Thanks,
drew


