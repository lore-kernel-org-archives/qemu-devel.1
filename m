Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076B3C388F4
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 01:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3EEE21655
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 01:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EEE21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iE1YQ-0001GP-Oh
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 21:29:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59819)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iE1X8-0000nJ-BQ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 21:28:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iE1X5-0006vu-Hq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 21:28:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iE1X5-0006vB-8m
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 21:28:23 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 020FAC06512C
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 01:28:22 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id d3so4658458pgv.9
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 18:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0YHo50JUwRc2YMmg8C+iErt2cCDEYkxZHSCRKCZZNbI=;
 b=M6Noj4owP+Iz2giEve01/ND24kAv8ZZH2pGagoRhSV9v4INulyrUg3NX7pMvPPBicE
 4VGajoWT/4a7u+Y3Hg0nB+3sIVB3sP+r6zB9na30zkBsNjPWKkD05kOn0gLI2Dp+0MEa
 i8TZPBjMPH1jdgFjnuDaO7Xqe3I5s8FgllwRBOsvSA5x0JyUig88I/nc7w5ByPw7p+oO
 EzkDx4y8Fs0wIzIfMNSpnR8fiUEIUMOqHIyo5qWtn/+5S+iZcwbBkkf2sXTjHh+CRgUX
 EDDOofbaooX0Po3H3PQgPbRmmkwBLEgAZqPm24OZLPpXIMzCz6tgeyICmN9H0tWOslzO
 fVWg==
X-Gm-Message-State: APjAAAV071ItS35jkxBYYoyDZZxOLeO6tM1B8zs6qp4lNBNlSRiakbKO
 tFmQnnL+2y9Wub0joiCTcZ6V5zpTnk/4pwHm69XsM5pE8QAXDP5OLvT3rLbT8IPQYUmyf2dikb3
 4y81tealwgCeCmNE=
X-Received: by 2002:a17:90a:7f89:: with SMTP id
 m9mr13567726pjl.30.1569634101271; 
 Fri, 27 Sep 2019 18:28:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwztHJ2mOoZoNCwBIzmZ6HS65cDEMODvo5JckXPaCLmkBqQRlqWMKPZcAwDymRAED6UW6lrSQ==
X-Received: by 2002:a17:90a:7f89:: with SMTP id
 m9mr13567701pjl.30.1569634100847; 
 Fri, 27 Sep 2019 18:28:20 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id f6sm3317971pfq.169.2019.09.27.18.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Sep 2019 18:28:19 -0700 (PDT)
Date: Sat, 28 Sep 2019 09:28:08 +0800
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v7 4/4] s390: do not call
 memory_region_allocate_system_memory() multiple times
Message-ID: <20190928012808.GA31218@xz-x1>
References: <20190924144751.24149-1-imammedo@redhat.com>
 <20190924144751.24149-5-imammedo@redhat.com>
 <20190925032700.GI28074@xz-x1> <20190925135105.6e5f249a@redhat.com>
 <20190925235235.GV28074@xz-x1> <20190927153320.2edc683c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190927153320.2edc683c@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: thuth@redhat.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 27, 2019 at 03:33:20PM +0200, Igor Mammedov wrote:
> On Thu, 26 Sep 2019 07:52:35 +0800
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Sep 25, 2019 at 01:51:05PM +0200, Igor Mammedov wrote:
> > > On Wed, 25 Sep 2019 11:27:00 +0800
> > > Peter Xu <peterx@redhat.com> wrote:
> > >   
> > > > On Tue, Sep 24, 2019 at 10:47:51AM -0400, Igor Mammedov wrote:  
> > > > > s390 was trying to solve limited KVM memslot size issue by abusing
> > > > > memory_region_allocate_system_memory(), which breaks API contract
> > > > > where the function might be called only once.
> > > > > 
> > > > > Beside an invalid use of API, the approach also introduced migration
> > > > > issue, since RAM chunks for each KVM_SLOT_MAX_BYTES are transferred in
> > > > > migration stream as separate RAMBlocks.
> > > > > 
> > > > > After discussion [1], it was agreed to break migration from older
> > > > > QEMU for guest with RAM >8Tb (as it was relatively new (since 2.12)
> > > > > and considered to be not actually used downstream).
> > > > > Migration should keep working for guests with less than 8TB and for
> > > > > more than 8TB with QEMU 4.2 and newer binary.
> > > > > In case user tries to migrate more than 8TB guest, between incompatible
> > > > > QEMU versions, migration should fail gracefully due to non-exiting
> > > > > RAMBlock ID or RAMBlock size mismatch.
> > > > > 
> > > > > Taking in account above and that now KVM code is able to split too
> > > > > big MemorySection into several memslots, partially revert commit
> > > > >  (bb223055b s390-ccw-virtio: allow for systems larger that 7.999TB)
> > > > > and use kvm_set_max_memslot_size() to set KVMSlot size to
> > > > > KVM_SLOT_MAX_BYTES.
> > > > > 
> > > > > 1) [PATCH RFC v2 4/4] s390: do not call  memory_region_allocate_system_memory() multiple times
> > > > > 
> > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>    
> > > > 
> > > > Acked-by: Peter Xu <peterx@redhat.com>
> > > > 
> > > > IMHO it would be good to at least mention bb223055b9 in the commit
> > > > message even if not with a "Fixed:" tag.  May be amended during commit
> > > > if anyone prefers.  
> > > 
> > > /me confused, bb223055b9 is mentioned in commit message  
> > 
> > I'm sorry, I overlooked that.
> > 
> > >    
> > > > Also, this only applies the split limitation to s390.  Would that be a
> > > > good thing to some other archs as well?  
> > > 
> > > Don't we have the similar bitmap size issue in KVM for other archs?  
> > 
> > Yes I thought we had.  So I feel like it would be good to also allow
> > other archs to support >8TB mem as well.  Thanks,
> Another question, Is there another archs with that much RAM that are
> available/used in real life (if not I'd wait for demand to arise first)?

I don't know, so it was a pure question besides the series.  Sorry if
that holds your series somehow, it was not my intention.

> 
> If we are to generalize it to other targets, then instead of using
> arbitrary memslot max size per target, we could just hardcode or get
> from KVM, max supported size of bitmap and use that to calculate
> kvm_max_slot_size depending on target page size.

Right, I think if so hard code would be fine for now, and probably can
with a smallest one across all archs (should depend on the smallest
page size, I guess).

> 
> Then there wouldn't be need for having machine specific code
> to care about it and pick/set arbitrary values.
> 
> Another aspect to think about if we are to enable it for
> other targets is memslot accounting. It doesn't affect s390
> but other targets that support memory hotplug now assume 1:1
> relation between memoryregion:memslot, which currently holds
> true but would need to amended in case split is enabled there.

I didn't know this.  So maybe it makes more sense to have s390 only
here.  Thanks,

-- 
Peter Xu

