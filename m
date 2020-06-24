Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D0BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:39:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 209DE206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJkGS4qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 209DE206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo7Uh-00068K-DZ
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 11:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59660)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo7Sh-0003e7-4R
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:37:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29391
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jo7Se-0002hF-Qj
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593013035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tpj0NoM5Tq/pw550/Z474S9spxgpCHxnuQX1qNNsSss=;
 b=QJkGS4qav5+upRg8U2XEIVu3zZFvxqWDR6WiXcvRUjSdXM5lG0r3UVN8RDjZ5bcz3Kclwg
 49/FhCKh94Sc8CqvFm8GdEyyqcvF1mZD8C66VG0YWcz6L2rPN71MYPIbcgBY5lrlGiiWmY
 5kc8agA4ZxSGnuBMatpSw416vnSNbNA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-6kiYw4JqPUi8xJRCib_kow-1; Wed, 24 Jun 2020 11:37:13 -0400
X-MC-Unique: 6kiYw4JqPUi8xJRCib_kow-1
Received: by mail-wm1-f71.google.com with SMTP id a7so3001304wmf.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 08:37:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tpj0NoM5Tq/pw550/Z474S9spxgpCHxnuQX1qNNsSss=;
 b=rUn9XV7UF00QbMNWYtBxdaKEMhc/o4Bip9VWJyr06hQaFGTCPlc/26bwBtyrhV6YPE
 GoPx4BT+yeerEu6WWe0vVV/2gjCPKE29I7SzvfMEesuVcPRaQrdGOe8dVsMVaePt4oTl
 eKk48RNFxNbfnAZBgeJ3P6Yj/+RfoE0UUqsRpbm3kFE6qMEn58YxSO54y1lsdLfTzgGu
 inxouBo7bRMx1BvyUfhampCvQORIRvunWa1W7+6UCMX6OaUCUZqvgvBg9EVpqsTf39g4
 iYbHio8ojQOkVZ4ajKIJqJ2HGJz9hL6ICXnVG/cuzTJTcTSEh466OxZPRPBClbISGG7u
 PQ/Q==
X-Gm-Message-State: AOAM531QErrbqbaOuEwgXokx2+LZ45CzXSilEHsmcESA84coIxNGFjby
 MWZZGJyaTikTVFat4h0gmGdmnHf+/gNqeW+o7PWpvRzmaseOkZ2XjJTrrSE5g9hP6/ybj1zXGyF
 TXwKDvxj7CDsdXmU=
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr31045484wmj.67.1593013032561; 
 Wed, 24 Jun 2020 08:37:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/qR/G3tTK1LCrNcnGD14xUDykv7FFWHG1535IAiG5gdhErnShnJ8QC3xzbjrZthNWqOOvXQ==
X-Received: by 2002:a7b:cb18:: with SMTP id u24mr31045448wmj.67.1593013032266; 
 Wed, 24 Jun 2020 08:37:12 -0700 (PDT)
Received: from redhat.com ([82.166.20.53])
 by smtp.gmail.com with ESMTPSA id u65sm8939288wmg.5.2020.06.24.08.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 08:37:11 -0700 (PDT)
Date: Wed, 24 Jun 2020 11:37:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Message-ID: <20200624113417-mutt-send-email-mst@kernel.org>
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
 <20200618120121-mutt-send-email-mst@kernel.org>
 <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
 <20200624103559-mutt-send-email-mst@kernel.org>
 <a7daa26d-52a2-4834-9cf1-7bdc457e686f@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a7daa26d-52a2-4834-9cf1-7bdc457e686f@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
 Alexander Duyck <alexander.duyck@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 24, 2020 at 05:28:59PM +0200, David Hildenbrand wrote:
> > So at the high level the idea was simple, we just clear the dirty bit
> > when page is hinted, unless we sent a new command since. Implementation
> > was reviewed by migration maintainers. If there's a consensus the code
> > is written so badly we can't maintain it, maybe we should remove it.
> > Which parts are unmaintainable in your eyes - migration or virtio ones?
> 
> QEMU implementation without a propert virtio specification. I hope that
> we can *at least* finally document the expected behavior. Alex gave it a
> shot, and I was hoping that Wei could jump in to clarify, help move this
> forward ... after all he implemented (+designed?) the feature and the
> virtio interface.
> 
> > Or maybe it's the general thing that interface was never specced
> > properly.
> 
> Yes, a spec would be definitely a good starter ...
> 
> [...]
> 
> >>
> >> 1. If migration fails during RAM precopy, the guest will never receive a
> >> DONE notification. Probably easy to fix.
> >>
> >> 2. Unclear semantics. Alex tried to document what the actual semantics
> >> of hinted pages are.
> > 
> > I'll reply to that now.
> > 
> >> Assume the following in the guest to a previously
> >> hinted page
> >>
> >> /* page was hinted and is reused now */
> >> if (page[x] != Y)
> >> 	page[x] == Y;
> >> /* migration ends, we now run on the destination */
> >> BUG_ON(page[x] != Y);
> >> /* BUG, because the content chan
> > 
> > The assumption hinting makes is that data in page is writtent to before it's used.
> > 
> > 
> >> A guest can observe that. And that could be a random driver that just
> >> allocated a page.
> >>
> >> (I *assume* in Linux we might catch that using kasan, but I am not 100%
> >> sure, also, the actual semantics to document are unclear - e.g., for
> >> other guests)
> > 
> > I think it's basically simple: hinting means it's ok to
> > fill page with trash unless it has been modified since the command
> > ID supplied.
> 
> Yeah, I quite dislike the semantics, especially, as they are different
> to well-know semantics as e.g., represent in MADV_FREE. Getting changed
> content when reading is really weird. But it seemed to be easier to
> implement (low hanging fruit) and nobody complained back then. Well, now
> we are stuck with it.
> 
> [..]

The difference with MADV_FREE is
- asynchronous (using cmd id to synchronize)
- zero not guaranteed

right?

> > 
> >> There are other concerns I had regarding the iothread (e.g., while
> >> reporting is active, virtio_ballloon_get_free_page_hints() is
> >> essentially a busy loop, in contrast to documented -
> >> continue_to_get_hints will always be true).
> > 
> > So that would be a performance issue you are suggesting, right?
> 
> I misread the code, so that comment does no longer apply (see other
> message).
> 
> > 
> >>> The appeal of hinting is that it's 0 overhead outside migration,
> >>> and pains were taken to avoid keeping pages locked while
> >>> hypervisor is busy.
> >>>
> >>> If we are to drop hinting completely we need to show that reporting
> >>> can be comparable, and we'll probably want to add a mode for
> >>> reporting that behaves somewhat similarly.
> >>
> >> Depends on the actual users. If we're dropping a feature that nobody is
> >> actively using, I don't think we have to show anything.
> > 
> > 
> > I don't know how to find out. So far it doesn't look like we found
> > any common data corruptions that would indicate no one can use it safely.
> > Races around reset aren't all that uncommon but I don't think that
> > qualifies as a deal breaker.
> 
> As I said, there are no libvirt bindings, so at least anything using
> libvirt does not use it. I'd be curious about actual users.
> 
> > 
> > I find the idea of asynchronously sending hints to host without
> > waiting for them to be processed intriguing. Not something
> > I'd work on implementing if we had reporting originally,
> > but since it's there I'm not sure we should just discard it
> > at this point.
> > 
> >> This feature obviously saw no proper review.
> > 
> > I did my best but obviously missed some things.
> 
> Yeah, definitely not your fault. People cannot expect maintainers to
> review everything in detail.
> 
> -- 
> Thanks,
> 
> David / dhildenb


