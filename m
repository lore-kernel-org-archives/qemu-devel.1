Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB326C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:39:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CBA22257
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 11:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CBA22257
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUTW2-0006sO-Sf
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 07:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Dave.Martin@arm.com>)
 id 1kUTOe-0003Yk-ST
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:32:12 -0400
Received: from foss.arm.com ([217.140.110.172]:48246)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Dave.Martin@arm.com>) id 1kUTOb-0006lc-C2
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 07:32:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F08930E;
 Mon, 19 Oct 2020 04:32:04 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46E503F719;
 Mon, 19 Oct 2020 04:32:03 -0700 (PDT)
Date: Mon, 19 Oct 2020 12:32:00 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: Kernel patch cases qemu live migration failed.
Message-ID: <20201019113157.GN32292@arm.com>
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
 <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
 <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
 <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
 <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
 <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Received-SPF: pass client-ip=217.140.110.172; envelope-from=Dave.Martin@arm.com;
 helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 07:32:04
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, xu910121@sina.com,
 qemu-devel <qemu-devel@nongnu.org>, kvmarm <kvmarm@lists.cs.columbia.edu>,
 Marc Zyngier <maz@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 11:25:25AM +0200, Andrew Jones wrote:
> On Thu, Oct 15, 2020 at 03:57:02PM +0100, Peter Maydell wrote:
> > On Thu, 15 Oct 2020 at 15:41, Andrew Jones <drjones@redhat.com> wrote:
> > > The reporter states neither the source nor destination hardware supports
> > > SVE. My guess is that what's happening is the reserved ID register
> > > ID_UNALLOCATED(4,4) was showing up in the KVM_GET_REG_LIST count on
> > > the old kernel, but the new kernel filters it out. Maybe it is a
> > > bug to filter it out of the count, as it's a reserved ID register and
> > > I suppose the other reserved ID registers are still showing up?
> > 
> > Yeah, RES0 ID registers should show up in the list, because otherwise
> > userspace has to annoyingly special case them when the architecture
> > eventually defines behaviour for them.
> > 
> > Dave's comment in the kernel commit message
> > # ID_AA64ZFR0_EL1 is RO-RAZ for MRS/MSR when SVE is disabled for the
> > # guest, but for compatibility with non-SVE aware KVM implementations
> > # the register should not be enumerated at all for KVM_GET_REG_LIST
> > # in this case.
> > seems wrong to me -- for compatibility the register should remain
> > present and behave as RAZ/WI if SVE is disabled in the guest,
> > the same way it was before the kernel/KVM knew about SVE at all.
> 
> Yup, I agree with you and I'll try writing a patch for this.
> 
> Thanks,
> drew

I'm not quite sure about Peter's assessment here.

I agree with the inconsistency identified here: we always enumerate all
unallocated ID regs, but we enumerate ID_AA64ZFR0_EL1 conditionally.
This doesn't feel right: on a non-SVE guest, ID_AA64ZFR0_EL1 should
behave exactly as an unallocated ID register.

I'm not sure about the proposed fix.

For one thing, I'm not sure that old hosts will accept writing of 0 to
arbitrary ID regs.  This may require some digging, but commit
93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU features from guests")
may be the place to start.

My original idea was that at the source end we should be conservative:
enumerate and dump the minimum set of registers relevant to the
target -- for compatibility with old hosts that don't handle the
unallocated ID regs at all.  At the destination end, modern hosts
should be permissive, i.e., allow any ID reg to be set to 0, but don't
require the setting of any reg that older source hosts might not send.

So, I think that instead of changing the ID_AA64ZFR0_EL1 behaviour,
parhaps we should move all ID_UNALLOCATED() regs (and possibly
ID_HIDDEN(), not sure about that) to have REG_HIDDEN_USER visibility.

Thoughts?

---Dave

