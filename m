Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAC2C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B51E21D81
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B51E21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUYBF-0002kd-6E
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Dave.Martin@arm.com>)
 id 1kUY9Z-0001Z8-MB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:36:57 -0400
Received: from foss.arm.com ([217.140.110.172]:54246)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Dave.Martin@arm.com>) id 1kUY9W-0006Bv-Gw
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 12:36:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B6151FB;
 Mon, 19 Oct 2020 09:36:53 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 408C73F66B;
 Mon, 19 Oct 2020 09:36:52 -0700 (PDT)
Date: Mon, 19 Oct 2020 17:36:49 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Andrew Jones <drjones@redhat.com>
Subject: Re: Kernel patch cases qemu live migration failed.
Message-ID: <20201019163648.GR32292@arm.com>
References: <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
 <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
 <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
 <20201019113157.GN32292@arm.com>
 <CAFEAcA8oncKmGxKGEZBg9Pnm4hjSO8u9KSv4YxFWxX0+LJ5E2g@mail.gmail.com>
 <20201019134043.vqusmzhqp7owjt6x@kamzik.brq.redhat.com>
 <CAFEAcA8RB6MTnv0qavxWs28=pbT16i9dT1pd+0Dy9HxPVk+bZA@mail.gmail.com>
 <20201019145839.GO32292@arm.com>
 <20201019152311.csxcz52sawia4imi@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201019152311.csxcz52sawia4imi@kamzik.brq.redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Received-SPF: pass client-ip=217.140.110.172; envelope-from=Dave.Martin@arm.com;
 helo=foss.arm.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 10:28:18
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
Cc: Marc Zyngier <maz@kernel.org>, xu910121@sina.com,
 qemu-devel <qemu-devel@nongnu.org>, kvmarm <kvmarm@lists.cs.columbia.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 19, 2020 at 05:23:11PM +0200, Andrew Jones wrote:
> On Mon, Oct 19, 2020 at 03:58:40PM +0100, Dave Martin wrote:
> > On Mon, Oct 19, 2020 at 03:18:11PM +0100, Peter Maydell wrote:
> > > On Mon, 19 Oct 2020 at 14:40, Andrew Jones <drjones@redhat.com> wrote:
> > > >
> > > > On Mon, Oct 19, 2020 at 12:43:33PM +0100, Peter Maydell wrote:
> > > > > Well, ID regs are special in the architecture -- they always exist
> > > > > and must RAZ/WI, even if they're not actually given any fields yet.
> > > > > This is different from other "unused" parts of the system register
> > > > > encoding space, which UNDEF.
> > > >
> > > > Table D12-2 confirms the register should be RAZ, as it says the register
> > > > is "RO, but RAZ if SVE is not implemented". Does "RO" imply "WI", though?
> > > > For the guest we inject an exception on writes, and for userspace we
> > > > require the value to be preserved on write.
> > > 
> > > Sorry, I mis-spoke. They're RAZ, but not WI, just RO (which is to say
> > > they'll UNDEF if you try to write to them).
> > > 
> > > > I think we should follow the spec, even for userspace access, and be RAZ
> > > > for when the feature isn't implemented. As for writes, assuming the
> > > > exception injection is what we want for the guest (not WI), then that's
> > > > correct. For userspace, I think we should continue forcing preservation
> > > > (which will force preservation of zero when it's RAZ).
> > > 
> > > Yes, that sounds right.
> > 
> > [...]
> > 
> > > > > The problem is that you've actually removed registers from
> > > > > the list that were previously in it (because pre-SVE
> > > > > kernels put this ID register in the list as a RAZ/WI register,
> > > > > and now it's not in the list if SVE isn't supported).
> > 
> > Define "previously", though.  IIUC, the full enumeration was added in
> > v4.15 (with ID_AA64ZFR0_EL1 still not supported at all):
> > 
> > v4.15-rc1~110^2~27
> > 93390c0a1b20 ("arm64: KVM: Hide unsupported AArch64 CPU features from guests")
> > 
> > 
> > And then ID_AA64FZR0_EL1 was removed from the enumeration, also in
> > v4.15:
> > 
> > v4.15-rc1~110^2~5
> > 07d79fe7c223 ("arm64/sve: KVM: Hide SVE from CPU features exposed to guests")
> > 
> > 
> > So, are there really two upstram kernel tags that are mismatched on
> > this, or is this just a bisectability issue in v4.14..v4.15?
> > 
> > It's a while since I looked at this, and I may have misunderstood the
> > timeline.
> > 
> > 
> > > > > > So, I think that instead of changing the ID_AA64ZFR0_EL1 behaviour,
> > > > > > parhaps we should move all ID_UNALLOCATED() regs (and possibly
> > > > > > ID_HIDDEN(), not sure about that) to have REG_HIDDEN_USER visibility.
> > > > >
> > > > > What does this do as far as the user-facing list-of-registers
> > > > > is concerned? All these registers need to remain in the
> > > > > KVM_GET_REG_LIST list, or you break migration from an old
> > > > > kernel to a new one.
> > 
> > OK, I think I see where you are coming from, now.
> > 
> > It may make sense to get rid of the REG_HIDDEN_GUEST / REG_HIDDEN_USER
> > distinction, and provide the same visibility for userspace as for MSR/
> > MRS all the time.  This would restore ID_AA64ZFR0_EL1 into the userspace
> > view, and may also allow a bit of simplification in the code.
> > 
> > Won't this will still break migration from the resulting kernel to a
> > current kernel that hides ID_AA64ZFR0_EL1?  Or have I misunderstood
> > something.
> >
> 
> Yes, but, while neither direction old -> new nor new -> old is actually
> something that people should do when using host cpu passthrough (they
> should only ever migrate between identical hosts, both hardware and
> host kernel version), migrating from old -> new makes more sense, as
> that's the upgrade path, and it's more supportable - we can workaround
> things on the new side. So, long story short, new -> old will fail due
> to making this change, but it's still probably the right thing to do,
> as we'll be defining a better pattern for ID registers going forward,
> and we never claimed new -> old migrations would work anyway with host
> passthrough.
> 
> Thanks,
> drew

Ack, just wanted to make sure I understood the implications correctly.

I'm still not sure I fully understand why we hit this problem (i.e.,
ZFR0 enumeration mismatch between host and guest) in the first place,
unless I've misunderstood which patches make these changes, or unless
RHEL has cherry-picked odd patches that weren't intended to be applied
separately...

Cheers
---Dave

