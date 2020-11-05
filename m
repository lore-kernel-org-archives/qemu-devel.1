Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A970C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C04E20739
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 16:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYB3MAZo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C04E20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaiFt-0003jP-9z
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 11:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kaiEm-0002Ye-DG
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:35:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52511)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kaiEi-0007Gy-Hz
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 11:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604594143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=riIzeKzbBvZLTplx3374YuEYSNo82MKeQbx6CVPcZl8=;
 b=hYB3MAZo7BIuP6FYitvOmAHO6vPebMvZ23t79ctU+d6Uju7kHKGmO7WpSQhVj9kyqsoidU
 9HU/ZdvFcEd9X2hD0ioPjCfylFRKlDfeqKmC97lb3aSN9cQCOnZbvvyqWr659vnDsuB3n6
 zSfOMzTtnXCX1K4YOXm4Th+BrqXigTc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-aB041QJVO5yHTLRQCAAQPQ-1; Thu, 05 Nov 2020 11:35:40 -0500
X-MC-Unique: aB041QJVO5yHTLRQCAAQPQ-1
Received: by mail-qk1-f197.google.com with SMTP id y8so1254359qki.12
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 08:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=riIzeKzbBvZLTplx3374YuEYSNo82MKeQbx6CVPcZl8=;
 b=jOjefXaSIKDqj5+p7DrTCXWRjyo7dLf9nrLbkHBZezhIiMbcN9LQOnv3yYdvmZn8EB
 vEDArBFHoBQqqidMuajX4iqQsTZ2OhdSsGb0tJcgFoMfcrOnHaEJPz5UPtjQqkVG9M86
 eHiojKhLt8dFM78esty2q56WZ9cWJ6whz3ZeSTLeTOs5al89omP5c+/7B9YiG2b8W0Uw
 Xq/QjktYQT7N/ZfhY0EIK5QcADVlVOe3/11CcKrLj0hzXxL+weEmcuDnS92PRpGoqGgG
 VXgglZ5UGCaGDQ4DVPB7CGk7TPmzKFKVbDaK4lXHHK5biARzu/53MMh5+B71DcKjojZg
 iqOQ==
X-Gm-Message-State: AOAM532QxDcF9ljqpEq57VFv+8x3KuEuebuPBf4a5UODfPDzGuu9KSZJ
 ETFyRC1GNYeBB2S7UEg+kpDjtl2Y8ltAG9bcun3JEL5xofsf2u29PFDYjy9uBfKbSkJeNXVhRL6
 T0jiYtxaX4EphmZQ=
X-Received: by 2002:a0c:fdcb:: with SMTP id g11mr2868797qvs.58.1604594139620; 
 Thu, 05 Nov 2020 08:35:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyHn/oHboyF9QHNL0QRMP5tGjxHqn5/YU49t8mEJVWLZw8j2KveGbcR6EBIzu+WNI5aRPzUbQ==
X-Received: by 2002:a0c:fdcb:: with SMTP id g11mr2868755qvs.58.1604594139159; 
 Thu, 05 Nov 2020 08:35:39 -0800 (PST)
Received: from xz-x1
 (bras-vprn-toroon474qw-lp130-20-174-93-89-196.dsl.bell.ca. [174.93.89.196])
 by smtp.gmail.com with ESMTPSA id d20sm1341994qkj.49.2020.11.05.08.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 08:35:38 -0800 (PST)
Date: Thu, 5 Nov 2020 11:35:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: Re: [PATCH RFC] memory: pause all vCPUs for the duration of memory
 transactions
Message-ID: <20201105163536.GB106309@xz-x1>
References: <20201026084916.3103221-1-vkuznets@redhat.com>
 <20201102195729.GA20600@xz-x1>
 <87v9emy4g2.fsf@vitty.brq.redhat.com>
 <20201103163718.GH20600@xz-x1>
 <f7cd01b0-086c-307e-f995-d4c3c4729bd6@redhat.com>
 <20201104192322.GA96645@xz-x1>
 <87r1p7yfwj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
In-Reply-To: <87r1p7yfwj.fsf@vitty.brq.redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 22:46:30
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Vitaly,

On Thu, Nov 05, 2020 at 04:36:28PM +0100, Vitaly Kuznetsov wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, Nov 04, 2020 at 07:09:02PM +0100, Laszlo Ersek wrote:
> >> On 11/03/20 17:37, Peter Xu wrote:
> >> > On Tue, Nov 03, 2020 at 02:07:09PM +0100, Vitaly Kuznetsov wrote:
> >> >> In case it is a normal access from the guest, yes, but AFAIR here
> >> >> guest's CR3 is pointing to non existent memory and when KVM detects that
> >> >> it injects #PF by itself without a loop through userspace.
> >> > 
> >> > I see, thanks Vitaly.  I think this kind of answered my previous confusion on
> >> > why we can't just bounce all these to QEMU since I thought QEMU should try to
> >> > take the bql if it's mmio access - probably because there're quite a lot of
> >> > references to guest memslots in kernel that cannot be naturally treated as
> >> > guest MMIO access (especially for nested, maybe?) so that maybe it's very hard
> >> > to cover all of them.  Paolo has mentioned quite a few times that he'd prefer a
> >> > kernel solution for this; I feel like I understand better on the reason now..
> >> > 
> >> > Have any of us tried to collect the requirements on this new kernel interface
> >> > (if to be proposed)?  I'm kind of thinking how it would look like to solve all
> >> > the pains we have right now.
> >> > 
> >> > Firstly, I think we'd likely want to have the capability to handle "holes" in
> >> > memslots, either to punch a hole, which iiuc is the problem behind this patch.
> >> > Or the reversed operation, which is to fill up a whole that we've just punched.
> >> > The other major one could be virtio-mem who would like to extend or shrink an
> >> > existing memslot.  However IIUC that's also doable with the "hole" idea in that
> >> > we can create the memslot with the maximum supported size, then "punch a hole"
> >> > at the end of the memslot just like it shrinked.  When extend, we shrink the
> >> > hole instead rather than the memslot.
> >> > 
> >> > Then there's the other case where we want to keep the dirty bitmap when
> >> > punching a hole on existing ram.  If with the "hole" idea in the kernel, it
> >> > seems easy too - when we punch the hole, we drop dirty bitmaps only for the
> >> > range covered by the hole.  Then we won't lose the rest bitmaps that where the
> >> > RAM still makes sense, since the memslot will use the same bitmap before/after
> >> > punching a hole.
> >> > 
> >> > So now an simple idea comes to my mind (I think we can have even more better,
> >> > or more complicated ideas, e.g., to make kvm memslot a tree? But I'll start
> >> > with the simple): maybe we just need to teach each kvm memslot to take "holes"
> >> > within itself.  By default, there's no holes with KVM_SET_USER_MEMORY_REGION
> >> > configured kvm memslots, then we can configure holes for each memslot using a
> >> > new flag (assuming, KVM_MEM_SET_HOLE) of the same ioctl (after LOG_DIRTY_PAGES
> >> > and READ_ONLY).  Initially we may add a restriction on how many holes we need,
> >> > so the holes can also be an array.
> >> > 
> >> > Thoughts?
> >> 
> >> My only one (and completely unwashed / uneducated) thought is that this
> >> resembles the fact (?) that VMAs are represented as rbtrees. So maybe
> >> don't turn a single KVM memslot into a tree, but represent the full set
> >> of KVM memslots as an rbtree?
> >> 
> >> My understanding is that "interval tree" is one of the most efficient
> >> data structures for tracking a set of (discontiguous) memory regions,
> >> and that an rbtree can be generalized into an interval tree. I'm super
> >> rusty on the theory (after having contributed a genuine rbtree impl to
> >> edk2 in 2014, sic transit gloria mundi :/), but I think that's what the
> >> VMA stuff in the kernel does, effectively.
> >> 
> >> Perhaps it could apply to KVM memslots too.
> >> 
> >> Sorry if I'm making no sense, of course. (I'm going out on a limb with
> >> posting this email, but whatever...)
> >
> > Appreciate your input, Laszlo.
> >
> > I agree that in most cases tree is more efficient.  Though, I feel like
> > there're two issues, while the structure itself is the less important one.
> >
> > Firstly, about the "tree or array" question: I'm not sure whether it's urgently
> > needed for kvm.  Here imho slot lookup should be the major critical operation
> > for kvm memslots, while crrent array impl of kvm memslot has already achieved
> > something similar of a tree (O(logn)) by keeping the array ordered (can refer
> > to search_memslots()).  That's why I think it's still ok.
> >
> > The other issue is about the "atomic update" of memslots that we're trying to
> > look for a solution that can address all the issues we've seen.  IMHO it's a
> > different problem to solve.  For example, even if we start to use tree
> > structure, we'll still face the same issue when we want to punch a hole in an
> > existing memslot - we'll still need to remove the tree node before adding the
> > new one.  AFAICT, same failure could happen on CR3.
> >
> > So IMHO the more important question is how to make these operations atomic.
> >
> > To make things clearer, I'll also try to expand a bit more on the "hole" idea
> > proposed above.
> >
> > Firstly, I believe there's also other solutions for these problems.
> >
> > Assuming we would like to remove slot X (range 0-4G), and add back slots X1
> > (range 0-1G) and X2 (range 2G-4G), with range 1G-2G as new MMIO region.
> >
> > One example is, we can introduce another new ioctl to contain a few operations
> > of KVM_SET_USER_MEMORY_REGION, then we can put three items in:
> >
> >   - Remove memslot X
> >   - Add memslot X1
> >   - Add memslot X2
> >
> > So that the container update will be atomic.  I think it works too at least for
> > the issue that this patch wants to address.  However I think it's not ideal.
> > The thing is, the memslot ID could change before/after the new ioctl even if
> > it's backing mostly the same thing.  Meanwhile, we'll need to destroy a memslot
> > that is destined to be added back with just some range information changed.
> > E.g., if we have dirty bitmap, we need to drop it and reallocate again.  That's
> > a waste, imho.
> >
> > So I'm thinking, how about we teach kvm similar things as what QEMU has already
> > know with those memory regions?  That means kvm would start to know "ok this
> > memslot is always that one, it never changed, however we want to mask some of
> > it and bounce to QEMU for whatever reason".  The simplest way to implement this
> > is to introduce a "hole" idea to kvm.  And as I mentioned, I believe an array
> > would work too similar to memslots, but that's another story.
> >
> > One thing intersting about the "hole" idea is that, we don't need containers to
> > keep a bunch of KVM_SET_USER_MEMORY_REGION ioctls any more!  Because our
> > operation is naturally atomic when represented as "holes": when we add a new
> > MMIO region within a RAM range, we simply add a new hole element to the
> > existing holes of this kvm memslot (note! adding the hole does _not_ change
> > slot ID and everything of the slot itself; e.g. dirty bitmaps do not need to be
> > re-allocate when we operate on the holes).  As a summary, in the new world: A
> > memslot should present something more close to ramblock in QEMU.  It means
> > "this range will be used by the guest", but it does not mean that guest can
> > access all of it.  When the access reaches a hole, we bounce to QEMU as if the
> > memslot is missing.
> >
> > (Since this is really more kvm-specific, cc kvm list too)
> 
> Thank you for the write up Peter!
> 
> My first reaction to the 'hole' idea was that it's rather redundant and
> sticking to the current concept where 'everything missing is a hole' is
> sufficient. I, however, didn't think about dirty bitmap at all so maybe
> it is worth considering.

You're definitely right here that at least it seems redundant at the first
glance that it kind of duplicated the idea of existing memslot, but just in a
reversed way.  However I'd like to emphasize just in case:

  - The "hole" idea I tried to introduce is not in the same level of current
    memslot, instead it's a property of one existing memslot.

  - The "hole" idea can help us achieve atomicity, and imho that's the most
    important thing that I think this idea brings.  We would like atomicity of
    every single memslot update, however current kvm memslot layout cannot
    solve atomicity of cases like "punching MMIO holes within an existing
    memslot".

By introducing this extra layer of "hole" idea within memslot, we can make
everything atomic now, by either atomically operating on memslot or on a hole
of it.  When punching the MMIO hole, we insert a hole (or expand an existing
hole!  We're still free to define the "hole" scemantics) into the existing
memslot.  That replaces all the previous 3 activities and it's naturally
atomic.

Dirty bitmap is another extra benefit out of the atomicity that we can get.
IMHO kvm memslot would be really more efficient when it represents the qemu
ramblocks.  It also does not really make sense to change slot ids if what we
did is simply punch a 1-byte hole onto a 4G range - the backing ram never
changed, so should the dirty bitmap and the slot id..  KVM memslot tried to
emulate these complexity of QEMU using a single layer of kvm memslot, hence
we'll face these atomicity problems.  So I'm thinking whether we should provide
extra abstraction (the "hole" idea is the 2nd layer, that's under kvm memslots;
we can also think about some other ways to represent this, anyway I really feel
like that should a new layer of abstraction) to kvm memslots to know better
about guest rams.

> 
> As an in-KVM solution to the problem I could suggest an enhanced version
> of KVM_SET_USER_MEMORY_REGION taking multiple regions (or even the whole
> memmap for the guest) and we would process it in one shot. We can either
> do it in an incremental form (add this, remove that) or require to
> supply the full set so KVM will start with dropping everything. We can
> also exploit Paolo's idea and make the call return dirty bitmaps of the
> removed slots, however, this complicates things from both API (like if I
> want to remove two slots and add three -- where would the dirty bitmap
> go?) and QEMU PoV (as we don't necessarily want to consume dirty bitmap
> when we do the update). So I'd stick with the 'incremental' idea.

I'm not very sure about what's the "incremental idea" that you mentioned here.
However I agree with you on above and I think that's also why I think we may
consider to go the other way to add that extra layer to kvm memslot so that we
don't need to have these issues you mentioned.  It seems to bring unnecessary
complexity on the interface and it seems not as clean as the "hole" idea to me.

> 
> Honestly, I'm not fully convinced we need an in-KVM idea. We'll still
> have to kick all vCPUs out to do the update (for shorter period compared
> to in-QEMU solution but still) so in case we are concerned about e.g. RT
> workloads we should be as I don't see a way out: latency spikes are
> inevitable.

Yes it would be perfect if there's an userspace solution. I'd be fine to stop
all the vcpus as long as we haven't released the BQL during that period -
that'll be quite simple and efficient if doable.  I actually proposed similar
things during working on the qemu dirty ring series when I wanted to flush vcpu
dirty bitmaps, but I encountered the same issue of incorrect BQL releasing and
I got nasty coredumps.  I also questioned about "why we need to release BQL"
during pausing all vcpus but I didn't dig deeper yet (on the icount and
record/replay stuff, I think, Paolo or Alex may know better).  I'm just afraid
there's no one good solution there to solve all the similar problems.

In all cases, this is still my very unmature understanding.  I really hope
Paolo could chim in to share his thoughts on this too, or especially on why we
need to release bql during vcpu pausing and its necessity.

Regarding RT - I never worried about RT on this. :)

IMHO, "real-time host" does not mean that this RT host must guarantee
determinism across the whole lifecycle of the system.  There're plenty of stuff
that we can't do to guarantee that determinsm afaict, e.g., cpu hotplug.  I
don't think "changing guest mem layout" is a good thing to do during the guest
running RT workload.  It should be easier just to avoid it (e.g., make sure it
only happens before the RT workload starts; and forbidden during RT app
running) rather than trying to make that opeartion determinstic as well.

Thanks,

-- 
Peter Xu


