Return-Path: <SRS0=3J8r=XY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FD2C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 02:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A08D52082F
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Sep 2019 02:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08D52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iEOom-0002hi-LH
	for qemu-devel@archiver.kernel.org; Sat, 28 Sep 2019 22:20:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58008)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iEOnx-0002Ex-Dt
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 22:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iEOnu-0007Bd-RE
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 22:19:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52938)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iEOnu-0007BR-Iy
 for qemu-devel@nongnu.org; Sat, 28 Sep 2019 22:19:18 -0400
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A54928763B
 for <qemu-devel@nongnu.org>; Sun, 29 Sep 2019 02:19:17 +0000 (UTC)
Received: by mail-pg1-f200.google.com with SMTP id f10so5517801pgj.0
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2019 19:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=9TwgxL2tTxJWjrfcOfBUHXU+g8w+MicGlBJLbshdi2E=;
 b=SCV1KEFu1Pvc4bH9iy8ZFnW5ekjzhCnsX7RxbMxk44VuZ4kbTRsndBT0jtDSKa07y0
 DFCh6ic5lzdsWNoJj7iImKqJLFw1Hzma7CM/aT6HhBK5n6yfQpQf7qGkaWAOGJHDrwUX
 Kyv/iN03xTvY+OCrEjsEwC0g8ZjM/A56DR4lwOiPkoTuxyd2jeUIpky+xkGL8z0cG+yP
 mo/RHdBS9fuOjPdiniBhGDbT2w1cbNgz0RzZvosbszIFJeaDNdjFSAoMTfkbXXVRF0Lb
 v+KjdnmCPA9sFsKxuXF934rzGWfeSU63AYMw7jOOEQeAfXDahU6/1R8yvlSYO6cTq/L3
 4fxQ==
X-Gm-Message-State: APjAAAWCY4gEAADLzR+wZP7hsMlBiulENQkgTD969mGeolExB2BdxpaR
 CGt3QZhhHOIUjnXuYlJ091iEOmN++wZvwIQRNmdmHOevjM7kw0bFftUY9WKTUt8OE5JYFIBRzTs
 fc535sWOrHHU3kGU=
X-Received: by 2002:a63:1912:: with SMTP id z18mr7648390pgl.390.1569723557011; 
 Sat, 28 Sep 2019 19:19:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzc8a4/KwQAKYezof5kSijmYpBuHXe+3reXLI9i3wiRNu6OnjfwT4OQdx23VxICJWfH4BZDLA==
X-Received: by 2002:a63:1912:: with SMTP id z18mr7648368pgl.390.1569723556619; 
 Sat, 28 Sep 2019 19:19:16 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id o9sm8557053pfp.67.2019.09.28.19.19.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Sep 2019 19:19:15 -0700 (PDT)
Date: Sun, 29 Sep 2019 10:19:06 +0800
From: Peter Xu <peterx@redhat.com>
To: "Zhang, Qi1" <qi1.zhang@intel.com>
Subject: Re: [PATCH V2] intel_iommu: TM field should not be in reserved bits
Message-ID: <20190929021905.GB8286@xz-x1>
References: <20190927045838.2968-1-qi1.zhang@intel.com>
 <20190927061011.GB9412@xz-x1>
 <215440059103624D9AD9D1DCACBF45DD3E84E270@shsmsx102.ccr.corp.intel.com>
 <20190927093223.GC9412@xz-x1>
 <215440059103624D9AD9D1DCACBF45DD3E853A42@shsmsx102.ccr.corp.intel.com>
 <20190929020220.GA8286@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190929020220.GA8286@xz-x1>
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Qi,
 Yadong" <yadong.qi@intel.com>, "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 29, 2019 at 10:02:20AM +0800, Peter Xu wrote:
> On Sun, Sep 29, 2019 at 01:11:12AM +0000, Zhang, Qi1 wrote:
> > 
> > 
> > > -----Original Message-----
> > > From: Peter Xu <peterx@redhat.com>
> > > Sent: Friday, September 27, 2019 5:32 PM
> > > To: Zhang, Qi1 <qi1.zhang@intel.com>
> > > Cc: qemu-devel@nongnu.org; ehabkost@redhat.com; mst@redhat.com;
> > > pbonzini@redhat.com; rth@twiddle.net; Qi, Yadong <yadong.qi@intel.com>
> > > Subject: Re: [PATCH V2] intel_iommu: TM field should not be in reserved bits
> > > 
> > > On Fri, Sep 27, 2019 at 08:03:21AM +0000, Zhang, Qi1 wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Peter Xu <peterx@redhat.com>
> > > > > Sent: Friday, September 27, 2019 2:10 PM
> > > > > To: Zhang, Qi1 <qi1.zhang@intel.com>
> > > > > Cc: qemu-devel@nongnu.org; ehabkost@redhat.com; mst@redhat.com;
> > > > > pbonzini@redhat.com; rth@twiddle.net
> > > > > Subject: Re: [PATCH V2] intel_iommu: TM field should not be in
> > > > > reserved bits
> > > > >
> > > > > On Fri, Sep 27, 2019 at 12:58:38PM +0800, qi1.zhang@intel.com wrote:
> > > > > > From: "Zhang, Qi" <qi1.zhang@intel.com>
> > > > > >
> > > > > > When dt is supported, TM field should not be Reserved(0).
> > > > > >
> > > > > > Refer to VT-d Spec 9.8
> > > > > >
> > > > > > Signed-off-by: Zhang, Qi <qi1.zhang@intel.com>
> > > > > > Signed-off-by: Qi, Yadong <yadong.qi@intel.com>
> > > > > > ---
> > > > > >  hw/i386/intel_iommu.c          | 12 ++++++------
> > > > > >  hw/i386/intel_iommu_internal.h | 25 +++++++++++++++++++------
> > > > > >  2 files changed, 25 insertions(+), 12 deletions(-)
> > > > > > ---
> > > VTD_SPTE_PAGE_L2_RSVD_MASK(s-
> > > > > >aw_bits);
> > > > > > -    vtd_paging_entry_rsvd_field[3] =
> > > > > >aw_bits);
> > > > > > +    vtd_paging_entry_rsvd_field[5] =
> > > > > VTD_SPTE_LPAGE_L1_RSVD_MASK(s->aw_bits, x86_iommu-
> > > > > >dt_supported);
> > > > > > +    vtd_paging_entry_rsvd_field[6] =
> > > > > VTD_SPTE_LPAGE_L2_RSVD_MASK(s->aw_bits, x86_iommu-
> > > > > >dt_supported);
> > > > > > +    vtd_paging_entry_rsvd_field[7] =
> > > > > > + VTD_SPTE_LPAGE_L3_RSVD_MASK(s->aw_bits, x86_iommu-
> > > > > >dt_supported);
> > > > > >      vtd_paging_entry_rsvd_field[8] =
> > > > > >VTD_SPTE_LPAGE_L4_RSVD_MASK(s->aw_bits);
> > > > >
> > > > > Should this TM bit only affects leaves?  Say, entry 1 (4K), 5 (2M), 6 (1G).
> 
> [1]
> 
> > > > > While this reminded me that I'm totally confused on why we have had
> > > > > entry 7, 8 after all...  Are they really used?
> > > > Yes. TM bit only affects. To this array, index 1, 5,6,7 may be leaf. Will update
> > > a new patchset for it.
> > > 
> > > Could I ask why index 7 may be leaf?
> > Index 7 is PDPE 1G GB leaf.
> 
> I thought 1G was index 6.  I've listed my understanding above [1].
> Would you please double confirm?  Thanks,

Oh wait, You are right...  Index 6 should be for 1G because index 5
seems to be unused as well.  However then again we should drop 5
instead of 7?

I think we can do this in two patches:

Patch 1 to clean these up by only let vtd_paging_rsvd (we can rename
it to shorter one like this if going to touch it) to keep reserved
bits for non-huge pages.  Then we define a new struct
(e.g. vtd_paging_rsvd_huge) to only keep the huge page entries.  The
thing is that I see no point in keeping huge && non-huge in a single
array (and I believe that's why it caused confusion so far...). That
new one should be a size of 2 array.  Meanwhile we need to fix
vtd_slpte_nonzero_rsvd() too using the new arrays.

Then in patch 2 we do the DT bit change.

Does that look ok?

Thanks,

-- 
Peter Xu

