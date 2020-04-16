Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99614C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 18:22:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 659D12222D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 18:22:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F++hYXCi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 659D12222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP99O-00068X-Eo
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 14:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43324)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jP98Z-0005jc-MH
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:21:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jP98Y-0003Qn-7t
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:21:19 -0400
Received: from mail-il1-x144.google.com ([2607:f8b0:4864:20::144]:36152)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jP98Y-0003Pk-3L
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 14:21:18 -0400
Received: by mail-il1-x144.google.com with SMTP id t8so7889616ilj.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9/ilK9h74frLS2QPOveBdqWTPAs2onSHmT92Qpp4lkk=;
 b=F++hYXCiyp5LBmDzYWxPIWIGhWpnWl/TFQRvtEuBP3QN1qEkmP1HuZBphLF+ED6S7N
 5VuNOXEEPHQYV7miHnoy5CxjlQx7W1TLRG8/yOFaiY17XqeJFdsuLfdFH4AGW2WnZQ8B
 6NZXPK5jn23gKnVlFws9hM9PTldqgKwf7Rt63eCP6EsapwDjS8AYAwZZaVcF4S6AxpD5
 lDuDpFek5460PGyMGerMe0Y8vVUqxPKbYFqCR77M/ltLoiaVbu1l9i3jU5QspVeC3POl
 0i1jCq0HHbnzWxH1hi7cHms3kcKCo/BVIfju3n/T8qkht6GC5Y3IcQRWtIijkkCRliMB
 Q3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9/ilK9h74frLS2QPOveBdqWTPAs2onSHmT92Qpp4lkk=;
 b=FBCSelpstNW3wv/asjq4Pexm3eXM5cVGKZBU1/lGZOnsV7iATE+pydTJugAqYBZclV
 izbbaqD3x9UYAfWt+suCg6Es7SXWr4BxcZFA6WaHqiHbF46YldH7Mzi3N97IR5WlF8DD
 LKNME/WObFJuTrGQJ2gL6tj7LOl3Hd/v8qm3gnqamdKbiWrMuhxlUXJeoMXFyd+LyKAc
 PV4rnsAFlQyNTuVglYPvVOYWKKklf7yeHeYOQNMzBqOLjOXf9t76LE/AZrsVR0dEDcEm
 1mGQbmMYwGPnDb2KprjeikB3AJpcgrF4fyUUJ0e5aiRhcL4bJ8R4LtsquQ5h9DtLOd7+
 DyfQ==
X-Gm-Message-State: AGi0PuYqu5D5ylNESrWAIEedjA5Jvef7LQBZe246CfcqsmGCKp0F65Tz
 83ffPxEQXIxuLJDgp7HUbGsM0l67FV6aNOkFzfg=
X-Google-Smtp-Source: APiQypIif0lhgBiue6WSgcG6ImaB3Jw+JA6MSqoX3brHo3HINE0e+E5H34dF75h2kDpjKnf4bE/IVHz24c8zuKAsDLU=
X-Received: by 2002:a92:858b:: with SMTP id f133mr2103786ilh.97.1587061276362; 
 Thu, 16 Apr 2020 11:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgT0UcaBfyKdTPErOxxLJgShOaJNfo9Maqps0ufABMbAo0iuQ@mail.gmail.com>
 <EDD25A47-8A8D-4F9B-9875-B983A1BA72C2@redhat.com>
 <CAKgT0Uf9a8K50XAS9K39KxBGdNRd5+G7nmkg2PsCHOYHAZ7Xew@mail.gmail.com>
 <f685fa75-6898-4fbe-c2a1-ba35424cb4a2@redhat.com>
 <20200416102229-mutt-send-email-mst@kernel.org>
 <5df12fd8-da98-dd3c-04ef-740189bc48ea@redhat.com>
In-Reply-To: <5df12fd8-da98-dd3c-04ef-740189bc48ea@redhat.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 16 Apr 2020 11:21:05 -0700
Message-ID: <CAKgT0UeVi=xnNxaVE5vB44rDwR4-m305wE671VdaK6R2TM6KGw@mail.gmail.com>
Subject: Re: [PATCH v19 QEMU 1/4] virtio-balloon: Implement support for page
 poison tracking feature
To: David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::144
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
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, "Wang, Wei W" <wei.w.wang@intel.com>,
 David Hildenbrand <dhildenb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 16, 2020 at 7:55 AM David Hildenbrand <david@redhat.com> wrote:
>
> >> We should document our result of page poisoning, free page hinting, and
> >> free page reporting there as well. I hope you'll have time for the latter.
> >>
> >> -------------------------------------------------------------------------
> >> Semantics of VIRTIO_BALLOON_F_PAGE_POISON
> >> -------------------------------------------------------------------------
> >>
> >> "The VIRTIO_BALLOON_F_PAGE_POISON feature bit is used to indicate if the
> >> guest is using page poisoning. Guest writes to the poison_val config
> >> field to tell host about the page poisoning value that is in use."
> >> -> Very little information, no signs about what has to be done.
> >
> > I think it's an informational field. Knowing that free pages
> > are full of a specific pattern can be handy for the hypervisor
> > for a variety of reasons. E.g. compression/deduplication?
>
> I was referring to the documentation of the feature and what we
> (hypervisor) are expected to do (in regards to inflation/deflation).
>
> Yes, it might be valuable to know that the guest is using poisoning. I
> assume compression/deduplication (IOW KSM) will figure out themselves
> that such pages are equal.

The other thing to keep in mind is that the poison value only really
comes into play with hinting/reporting. In the case of the standard
balloon the pages are considered allocated from the guest's
perspective until the balloon is deflated. Then any poison/init will
occur over again anyway so I don't think the standard balloon should
really care.

For hinting it somewhat depends. Currently the implementation is
inflating a balloon so having poisoning or init_on_free means it is
written to immediately after it is freed so it defeats the purpose of
the hinting. However that is a Linux implementation issue, not
necessarily an issue with the QEMU implementation. As such may be I
should fix that in the Linux driver since that has been ignored in
QEMU up until now anyway. The more interesting bit is what should the
behavior be from the hypervisor when a page is marked as being hinted.
I think right now the behavior is to just not migrate the page. I
wonder though if we shouldn't instead just consider the page a zero
page, and then maybe modify the zero page behavior for the case where
we know page poisoning is enabled.

For reporting it is a matter of tracking the contents. We don't want
to modify the contents in any way as we are attempting to essentially
do in-place tracking of the page. So if it is poisoned or initialized
it needs to stay in that state so we cannot invalidate the page if
doing so will cause it to lose state information.

> >> "Let the hypervisor know that we are expecting a specific value to be
> >> written back in balloon pages."
> >
> >
> >
> >> -> Okay, that talks about "balloon pages", which would include right now
> >> -- pages "inflated" and then "deflated" using free page hinting
> >> -- pages "inflated" and then "deflated" using oridnary inflate/deflate
> >>    queue
> >
> > ATM, in this case driver calls "free" and that fills page with the
> > poison value.
>
> Yes, that's what I mentioned somehwere, it's currently done by Linux and ...
>
> >
> > It might be a valid optimization to allow driver to skip
> > poisoning of freed pages in this case.
>
> ... we should prepare for that :)

Agreed.

> >
> >> And I would add
> >>
> >> "However, if the inflated page was not filled with "poison_val" when
> >> inflating, it's not predictable if the original page or a page filled
> >> with "poison_val" is returned."
> >>
> >> Which would cover the "we did not discard the page in the hypervisor, so
> >> the original page is still there".
> >>
> >>
> >> We should also document what is expected to happen if "poison_val" is
> >> suddenly changed by the guest at one point in time again. (e.g., not
> >> supported, unexpected things can happen, etc.)
> >
> > Right. I think we should require that this can only be changed
> > before features have been negotiated.
> > That is the only point where hypervisor can still fail
> > gracefully (i.e. fail FEATURES_OK).
>
> Agreed.

I believe that is the current behavior. Essentially if poisoning
enabled then the feature flag is left set. I think the one change I
will make in the driver is that if poisoning is enabled in the kernel,
but PAGE_POISON is not available as a feature, I am going to disable
both the reporting and hinting features in virtballoon_validate.

> I can totally understand if Alex would want to stop working on
> VIRTIO_BALLOON_F_PAGE_POISON at this point and only fix the guest to not
> enable free page reporting in case we don't have
> VIRTIO_BALLOON_F_PAGE_POISON (unless that's already done), lol. :)

I already have a patch for that.

The bigger issue is how to deal with the PAGE_POISON being enabled
with FREE_PAGE_HINTING. The legacy code at this point is just broken
and is plowing through with FREE_PAGE_HINTING while it is enabled.
That is safe for now because it is using a balloon, the side effect is
that it is going to defer migration. If it switches to a page
reporting type setup at some point in the future we would need to make
sure something is written to the other end to identify the poison/zero
pages.

