Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D99C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03BC1206C0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 20:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKPzbTfm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03BC1206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joC9E-0004G4-7b
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 16:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joC8W-0003hn-LN
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:36:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1joC8U-0006aj-2H
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 16:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593031003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yx0iP9KtSM/SlUA16rbQneeLtC71voOmM44sPD5jXVs=;
 b=JKPzbTfmJwKrYS7NW5ljGdK9zE2qZQdt1y3wu+pyEvTvJ+CR7eJVcYLouEIyE3tay0nbyK
 aQAL3DrK8uWGn6S9706o6KDBMBjpAZVnLyLimWuBGmsZv9sxMSj84bUw9uKPaWYbPU1d75
 tPmyyaqW5wqTkn9Wwi1X0t8mMyDxZf4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-n46xhMlQNPGIm4V_ajlhAw-1; Wed, 24 Jun 2020 16:36:42 -0400
X-MC-Unique: n46xhMlQNPGIm4V_ajlhAw-1
Received: by mail-wr1-f69.google.com with SMTP id e11so4069774wrs.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 13:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Yx0iP9KtSM/SlUA16rbQneeLtC71voOmM44sPD5jXVs=;
 b=fQmO2Ifz8GpTqnf79rhSvx+eyuXhybtic8fwhjItySFs0TTSEVai66TGqx4+XyGdJk
 CpGyOsB8eVACorRroUrLSwgAnNlvXwaVXn+CoxRs5o8jJjjudSnq0LoOXBtRi3cwSWBu
 m/d09gFGdS3mGizouNgJw5GDVBflBWQujnYZOaWfv+pTO+hED57uGmcoHW4PvAhn2Mog
 j09kIxx2WwYCvanZsbmbqrM6SldnTQk9LrBn2te71rjpqnWT9goPbgCOIskQmZ/xL94Y
 lZ16iZRU6H79eHUvUlaxe6VrKMkTzeSXBz5F09TEHzdJRsOc6ToNzNPdnUlVF53zOWPa
 c7yA==
X-Gm-Message-State: AOAM532lJZVWYqTvgaBScMZ6uzFQAGVZ9kmdocMYxFh4+5iRK/Jg0GTQ
 LI6pZVNYCii+VTcactvboZ/le+DtHXkNC8QN+c+97+Q/ONa2Tuv2hyzVpoRZJQN/Q18bkcdVlEy
 DYkuL3T91n9Otvs4=
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr22264735wmm.183.1593031000813; 
 Wed, 24 Jun 2020 13:36:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz7wumRD91EO6vvygR3xtIbzTdpkj3FOT+sOd9wK0ozDXcsMcdAsmde0Wf5N0+b9lY5kTLz8g==
X-Received: by 2002:a05:600c:d7:: with SMTP id
 u23mr22264718wmm.183.1593031000560; 
 Wed, 24 Jun 2020 13:36:40 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 u23sm14858486wru.94.2020.06.24.13.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 13:36:39 -0700 (PDT)
Date: Wed, 24 Jun 2020 16:36:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Message-ID: <20200624163604-mutt-send-email-mst@kernel.org>
References: <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
 <20200618120121-mutt-send-email-mst@kernel.org>
 <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
 <20200624103559-mutt-send-email-mst@kernel.org>
 <a7daa26d-52a2-4834-9cf1-7bdc457e686f@redhat.com>
 <20200624113417-mutt-send-email-mst@kernel.org>
 <dd2431be-fd22-9307-51e4-b081026f6315@redhat.com>
MIME-Version: 1.0
In-Reply-To: <dd2431be-fd22-9307-51e4-b081026f6315@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 00:34:35
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

On Wed, Jun 24, 2020 at 06:01:02PM +0200, David Hildenbrand wrote:
> On 24.06.20 17:37, Michael S. Tsirkin wrote:
> > On Wed, Jun 24, 2020 at 05:28:59PM +0200, David Hildenbrand wrote:
> >>> So at the high level the idea was simple, we just clear the dirty bit
> >>> when page is hinted, unless we sent a new command since. Implementation
> >>> was reviewed by migration maintainers. If there's a consensus the code
> >>> is written so badly we can't maintain it, maybe we should remove it.
> >>> Which parts are unmaintainable in your eyes - migration or virtio ones?
> >>
> >> QEMU implementation without a propert virtio specification. I hope that
> >> we can *at least* finally document the expected behavior. Alex gave it a
> >> shot, and I was hoping that Wei could jump in to clarify, help move this
> >> forward ... after all he implemented (+designed?) the feature and the
> >> virtio interface.
> >>
> >>> Or maybe it's the general thing that interface was never specced
> >>> properly.
> >>
> >> Yes, a spec would be definitely a good starter ...
> >>
> >> [...]
> >>
> >>>>
> >>>> 1. If migration fails during RAM precopy, the guest will never receive a
> >>>> DONE notification. Probably easy to fix.
> >>>>
> >>>> 2. Unclear semantics. Alex tried to document what the actual semantics
> >>>> of hinted pages are.
> >>>
> >>> I'll reply to that now.
> >>>
> >>>> Assume the following in the guest to a previously
> >>>> hinted page
> >>>>
> >>>> /* page was hinted and is reused now */
> >>>> if (page[x] != Y)
> >>>> 	page[x] == Y;
> >>>> /* migration ends, we now run on the destination */
> >>>> BUG_ON(page[x] != Y);
> >>>> /* BUG, because the content chan
> >>>
> >>> The assumption hinting makes is that data in page is writtent to before it's used.
> >>>
> >>>
> >>>> A guest can observe that. And that could be a random driver that just
> >>>> allocated a page.
> >>>>
> >>>> (I *assume* in Linux we might catch that using kasan, but I am not 100%
> >>>> sure, also, the actual semantics to document are unclear - e.g., for
> >>>> other guests)
> >>>
> >>> I think it's basically simple: hinting means it's ok to
> >>> fill page with trash unless it has been modified since the command
> >>> ID supplied.
> >>
> >> Yeah, I quite dislike the semantics, especially, as they are different
> >> to well-know semantics as e.g., represent in MADV_FREE. Getting changed
> >> content when reading is really weird. But it seemed to be easier to
> >> implement (low hanging fruit) and nobody complained back then. Well, now
> >> we are stuck with it.
> >>
> >> [..]
> > 
> > The difference with MADV_FREE is
> > - asynchronous (using cmd id to synchronize)
> > - zero not guaranteed
> > 
> > right?
> 
> *looking into man page*, yes, when reading you either get the old
> content or zero.
> 
> (I remember that a re-read also makes the content stable, but looks like
> you really have to write to a page)
> 
> We should most probably do what Alex suggested and initialize pages (at
> least write a single byte) when leaking them from the shrinker in the
> guest while hinting is active, such that the content is stable for
> anybody to allocate and reuse a page.

Drivers ignore old content from slab though, so I don't really see
the point.

> -- 
> Thanks,
> 
> David / dhildenb


