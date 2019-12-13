Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAB5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 03:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA8952173E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 03:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NbXVTwns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA8952173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifbWe-0007KS-TU
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 22:21:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1ifbW2-0006t1-N0
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 22:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1ifbW1-00038a-Gg
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 22:21:18 -0500
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:45329)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1ifbW0-00036C-4U
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 22:21:17 -0500
Received: by mail-qt1-x843.google.com with SMTP id l12so112553qtq.12
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 19:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hu2APQv+IVI+5iybEWjt//7XPT9MTquVNsXr5eKGijw=;
 b=NbXVTwnsEakgsLDn5trxVEpIqvFPkyT91OGxu6GSmlghAmcQnQGqJZi3cOnahPfSrD
 2IJNLrAntLb2Vg5yzKRR4QuDDeoYyiy6na2abkFIXUui3mifNSzOyNyMo0Ep0GzowQ8k
 73kBaxv12ceugNuZDtRCisBAErHfxIMqH+xDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hu2APQv+IVI+5iybEWjt//7XPT9MTquVNsXr5eKGijw=;
 b=SBnsqCe+cy3LWpGjheog8EGtezKs0bHuBcr38Ovfm0FTKLsvQ5PTq74qd8wCuYFmC+
 uSKRqv0M72VQ8ZILpqfIVo1cFxAoB1nVeDi2L7+T15TbLRrbOH9lXma28xexuLttYAhN
 kGwOgAGajhzhVkYEGYL+9tmBLZJjhcrSU+DgiHw0CWi5YKlms42dBDz1TjB3WG6CzlNd
 41QVzfLQh9Z+1vNVQuuQE1JN1o68peuBPHXb38/weN9HXlJWLSu4WZhFFvht4RVmubDS
 lOblm2V2wLvAcJ0jb01xE2ew33cbW8Qfd6McK4tTjZ1sENKqA736Y0VIemi0X08MO/z9
 7IJQ==
X-Gm-Message-State: APjAAAUVJv526vwPI95R1hxJ5POFo803K1+RYVDkEgc4O0mPLzW4wSZ3
 pZ9Js2wh84xD/snLTSylAUMT6qGn9NW8zhgJvzQFYA==
X-Google-Smtp-Source: APXvYqxkanE7QbTS//jm2AxQAVONJGlepSsWXOV9cZX2KUxILe5+aXQHWvDwDfO80Q8vQlRxi2+uGt+89jAjHljpaI4=
X-Received: by 2002:ac8:27a3:: with SMTP id w32mr10895350qtw.234.1576207275087; 
 Thu, 12 Dec 2019 19:21:15 -0800 (PST)
MIME-Version: 1.0
References: <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com>
 <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
 <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
 <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
 <20191212094121.by7w7fywlzdfoktn@sirius.home.kraxel.org>
 <CAD=HUj6YYupjdxxz2mgMmE2DcKhXP-qdhRORvUNTmzcORRrLzg@mail.gmail.com>
 <20191212133048.4nbmuwhbq5z2ai6o@sirius.home.kraxel.org>
In-Reply-To: <20191212133048.4nbmuwhbq5z2ai6o@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 13 Dec 2019 12:21:03 +0900
Message-ID: <CAD=HUj623MyeZ7VmrYTfig9oiyNhipidpvhuuurs3VgGBgjZpQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: Geoffrey McRae <geoff@hostfission.com>, Hans Verkuil <hverkuil@xs4all.nl>,
 Zach Reizner <zachr@chromium.org>, Alexandre Courbot <acourbot@chromium.org>,
 virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>,
 Alex Lau <alexlau@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> > > Without buffer sharing support the driver importing a virtio-gpu dma-buf
> > > can send the buffer scatter list to the host.  So both virtio-gpu and
> > > the other device would actually access the same guest pages, but they
> > > are not aware that the buffer is shared between devices.
> >
> > With the uuid approach, how should this case be handled? Should it be
> > equivalent to exporting and importing the buffer which was created
> > first? Should the spec say it's undefined behavior that might work as
> > expected but might not, depending on the device implementation? Does
> > the spec even need to say anything about it?
>
> Using the uuid is an optional optimization.  I'd expect the workflow be
> roughly this:
>
>   (1) exporting driver exports a dma-buf as usual, additionally attaches
>       a uuid to it and notifies the host (using device-specific commands).
>   (2) importing driver will ask the host to use the buffer referenced by
>       the given uuid.
>   (3) if (2) fails for some reason use the dma-buf scatter list instead.
>
> Of course only virtio drivers would try step (2), other drivers (when
> sharing buffers between intel gvt device and virtio-gpu for example)
> would go straight to (3).

For virtio-gpu as it is today, it's not clear to me that they're
equivalent. As I read it, the virtio-gpu spec makes a distinction
between the guest memory and the host resource. If virtio-gpu is
communicating with non-virtio devices, then obviously you'd just be
working with guest memory. But if it's communicating with another
virtio device, then there are potentially distinct guest and host
buffers that could be used. The spec shouldn't leave any room for
ambiguity as to how this distinction is handled.

> > Not just buffers not backed by guest ram, but things like fences. I
> > would suggest the uuids represent 'exported resources' rather than
> > 'exported buffers'.
>
> Hmm, I can't see how this is useful.  Care to outline how you envision
> this to work in a typical use case?

Looking at the spec again, it seems like there's some more work that
would need to be done before this would be possible. But the use case
I was thinking of would be to export a fence from virtio-gpu and share
it with a virtio decoder, to set up a decode pipeline that doesn't
need to go back into the guest for synchronization. I'm fine dropping
this point for now, though, and revisiting it as a separate proposal.

-David

