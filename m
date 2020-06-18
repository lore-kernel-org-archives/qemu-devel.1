Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF36C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0BD207DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 19:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMnz94w2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0BD207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm0V1-0006F3-Ou
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 15:46:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jm0U2-0004ij-5X
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:45:58 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:43370)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jm0U0-0005VS-9c
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 15:45:57 -0400
Received: by mail-il1-x141.google.com with SMTP id g3so7032824ilq.10
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 12:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ygq1EXsDRun1DCehXPAAc7PVxey3+FrlmSRx6f8A/FA=;
 b=QMnz94w2PdL83J8IjFDm96ICCRJgPVPIiXD/GaQknqRa0xR+6uGLl2K6sjXgj3waYl
 JP33FmopzYSGxI5iOoEypVFdhHn4TNbLaI8iUxS8DrVLZ4l303A7qP2dGq1jXPutHGvl
 fN7kVKnIt2E5rqk273b3roOnxNjp26G35VxGuuViD8AhKya36ST0qX8maP1GOoP/W8lv
 8J/HLF6Dm834BcHsXIAEM3HUuA/McMhzcAD+InU+G8eAfn2+M9dLvkBHuGthXyg4Imno
 ZrzweIyeoarpzwnNjjWyOhk0ypTb/sixVdtSncM59c9EOOiXK2kUNRt0lxkRlHVA1MyY
 9jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ygq1EXsDRun1DCehXPAAc7PVxey3+FrlmSRx6f8A/FA=;
 b=ByE8wiOS/aOWSr2hTvwbLs2pYji8MKuhR3zSoKzhQThSgo8eyhekES7REGgOP1zQHj
 AWyKeFn2dMM24hJzJPtZNz+kW0ixID/+xOE/Q5MW9IujMVparfCvK2W3udcyYBv25/TF
 ywl+6O1DJsNGS+E/E9+l67vEHjp0xNnbT7+wZl9U7UMOOw28UgaoHj1UBo1VlFebdSr3
 fGDVmkUiZ1q3eHAxdjN03rigm8r9zuZvg/bTpTo+tyh4jlU0AaI55p0D+tgZFXpFtzb/
 7FBn+/f2Y8s7AQ9EVzdgKPFV8qhSzLGyKKdKdW3vSYe3GXBCt+n4sPejoWq8i9UDcPN8
 wb/A==
X-Gm-Message-State: AOAM5331pRPTsoROAGk7ivb1ZeBBf43lhhhFBzGJGwNh690Uca7RcQtN
 i9/aD1j+3xbCgcXY4oPpFacMoSDPPBLX35b7C90=
X-Google-Smtp-Source: ABdhPJxtQg16U3quRUET7mTY4E1tAkkLsJbCG3m9IhwKaaMKsAD4uc/MOS0BVkIuWGvry/2CdrwI/OzNNHOzvYcF+O0=
X-Received: by 2002:a92:c904:: with SMTP id t4mr87542ilp.95.1592509554988;
 Thu, 18 Jun 2020 12:45:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
 <20200618120121-mutt-send-email-mst@kernel.org>
 <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
In-Reply-To: <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 18 Jun 2020 12:45:43 -0700
Message-ID: <CAKgT0UfgyVyfLSg1dZejUR0g6znijY+dRyW_TAFJMZU+qXK+UQ@mail.gmail.com>
Subject: Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
To: David Hildenbrand <david@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alexander.duyck@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 18, 2020 at 10:10 AM David Hildenbrand <david@redhat.com> wrote:
>
> >>
> >> Ugh, ...
> >>
> >> @MST, you might have missed that in another discussion, what's your
> >> general opinion about removing free page hinting in QEMU (and Linux)? We
> >> keep finding issues in the QEMU implementation, including non-trivial
> >> ones, and have to speculate about the actual semantics. I can see that
> >> e.g., libvirt does not support it yet.
> >
> > Not maintaining two similar features sounds attractive.

Agreed. Just to make sure we are all on the same page I am adding Wei
Wang since he was the original author for page hinting.

> I consider free page hinting (in QEMU) to be in an unmaintainable state
> (and it looks like Alex and I are fixing a feature we don't actually
> intend to use / not aware of users). In contrast to that, the free page
> reporting functionality/implementation is a walk in the park.
>
> >
> > I'm still trying to get my head around the list of issues.  So far they
> > all look kind of minor to me.  Would you like to summarize them
> > somewhere?
>
> Some things I still have in my mind
>
>
> 1. If migration fails during RAM precopy, the guest will never receive a
> DONE notification. Probably easy to fix.

Agreed. It is just a matter of finding the right point to add a hook
so that if we abort the migration we can report DONE.

> 2. Unclear semantics. Alex tried to document what the actual semantics
> of hinted pages are. Assume the following in the guest to a previously
> hinted page
>
> /* page was hinted and is reused now */
> if (page[x] != Y)
>         page[x] == Y;
> /* migration ends, we now run on the destination */
> BUG_ON(page[x] != Y);
> /* BUG, because the content chan
>
> A guest can observe that. And that could be a random driver that just
> allocated a page.
>
> (I *assume* in Linux we might catch that using kasan, but I am not 100%
> sure, also, the actual semantics to document are unclear - e.g., for
> other guests)
>
> As Alex mentioned, it is not even guaranteed in QEMU that we receive a
> zero page on the destination, it could also be something else (e.g.,
> previously migrated values).

So this is only an issue for pages that are pushed out of the balloon
as a part of the shrinker process though. So fixing it would be pretty
straightforward as we would just have to initialize or at least dirty
pages that are leaked as a part of the shrinker. That may have an
impact on performance though as it would result in us dirtying pages
that are freed as a result of the shrinker being triggered.

> 3. If I am not wrong, the iothread works in
> virtio_ballloon_get_free_page_hints() on the virtqueue only with holding
> the free_page_lock (no BQL).
>
> Assume we're migrating, the iothread is active, and the guest triggers a
> device reset.
>
> virtio_balloon_device_reset() will trigger a
> virtio_balloon_free_page_stop(s). That won't actually wait for the
> iothread to stop, it will only temporarily lock free_page_lock and
> update s->free_page_report_status.
>
> I think there can be a race between the device reset and the iothread.
> Once virtio_balloon_free_page_stop() returned,
> virtio_ballloon_get_free_page_hints() can still call
> - virtio_queue_set_notification(vq, 0);
> - virtio_queue_set_notification(vq, 1);
> - virtio_notify(vdev, vq);
> - virtqueue_pop()
>
> I doubt this is very nice.

And our conversation had me start looking though reference to
virtio_balloon_free_page_stop. It looks like we call it for when we
unrealize the device or reset the device. It might make more sense for
us to look at pushing the status to DONE and forcing the iothread to
be flushed out.

> There are other concerns I had regarding the iothread (e.g., while
> reporting is active, virtio_ballloon_get_free_page_hints() is
> essentially a busy loop, in contrast to documented -
> continue_to_get_hints will always be true).
>
> > The appeal of hinting is that it's 0 overhead outside migration,
> > and pains were taken to avoid keeping pages locked while
> > hypervisor is busy.
> >
> > If we are to drop hinting completely we need to show that reporting
> > can be comparable, and we'll probably want to add a mode for
> > reporting that behaves somewhat similarly.
>
> Depends on the actual users. If we're dropping a feature that nobody is
> actively using, I don't think we have to show anything.
>
> This feature obviously saw no proper review.

I'm pretty sure it had some, as it went through several iterations as
I recall. However I don't think the review of the virtio interface was
very detailed as I think most of the attention was on the kernel
interface.

As far as trying to do this with page reporting it would be doable,
but I would need to use something like the command interface so that I
would have a way to tell the driver when to drop the reported bit from
the pages and when to stop/resume hinting. However it still wouldn't
resolve the issue of copy on write style pages where the page is only
read and never updated. I honestly wonder if it wouldn't be better to
just apply the same logic that I have been doing with page reporting
and migrate a zero page for a hinted page and MADVISE the page away so
that it should be zero on the origin. Then you get the benefit of the
guest shrinking as you perform the migration and would only be
transmitting zero pages to the other side which should be
significantly smaller if I am not mistaken.

