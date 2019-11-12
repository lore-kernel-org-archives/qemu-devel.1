Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F89C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 04:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E18E12084F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 04:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ejAHNRdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E18E12084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUOEx-0002q3-4x
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 23:57:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gurchetansingh@chromium.org>) id 1iUKS1-0002TM-4t
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 19:54:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gurchetansingh@chromium.org>) id 1iUKRz-00033A-T7
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 19:54:33 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:39559)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <gurchetansingh@chromium.org>)
 id 1iUKRz-00032m-Jw
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 19:54:31 -0500
Received: by mail-lj1-x242.google.com with SMTP id p18so15808622ljc.6
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 16:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GZou4lQN9AdmuzA4/W7pow7uT+4WHFOjtCVdWX0VDPo=;
 b=ejAHNRdXqEG280TqIhUoNOdKc94fDbil9FkD0sphy37JpdzdIoeeBuHU0jSE7oD8mb
 LpYjQ1/WLCEHEG/mcxT8mug01iZ6Gj6LkK7KhvWp/XrFL8URP5AdCSgMsQVeBjCU2kfu
 ut52kG9Zc8zYvcPqNEwrzSVVK6gkT1gf0UFrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GZou4lQN9AdmuzA4/W7pow7uT+4WHFOjtCVdWX0VDPo=;
 b=AL1rD4+lJhTkVJQYY0Dfqeg8NfZowAO2oLp/RZa00Bub73DxlZ1OCwQSJNO/IgczkB
 /C4RhblzL07IslCN5FkSQV2gILDHXvmRZIrrbAMfm1J2dJzu8biY5zR0CizkYpZc9EBt
 iR/vJUewsv3LmUDjRrUfxEH/8ara9rNDAQ4aVgOf1miyNOoyksYnfGPTzp1A7/bViiqC
 Pr/tw5hvI4n9trinGFguAJYQWZZ1jI0fSQAlw4ib9qjDg5XsGPpXx/UtHNMTrJ1i2gbg
 U30z94peJxW5MA7wRWrh+GOCE82B09JK7SaE8nl6DevXvTs9jAI7GP2Au784wtRzByAZ
 +Ycg==
X-Gm-Message-State: APjAAAWmFEBROgwk9aw7IPmmR/Y9Msr9HbX7aw7X1fYuRnVm297k76Vh
 aGrhuNH1IHed+0HR9xQbyRY/0Y8hGraTJA==
X-Google-Smtp-Source: APXvYqz7IbFv8UFH9L42yfUxIDHGaA69mCp9Fnxn+EQxqYNo63mYm+Pze191wH6/h99OKZDCKDTIrg==
X-Received: by 2002:a2e:7e0b:: with SMTP id z11mr17908606ljc.45.1573520068227; 
 Mon, 11 Nov 2019 16:54:28 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com.
 [209.85.208.174])
 by smtp.gmail.com with ESMTPSA id n12sm6881194lfh.36.2019.11.11.16.54.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2019 16:54:27 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id q2so15816295ljg.7
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 16:54:27 -0800 (PST)
X-Received: by 2002:a2e:b007:: with SMTP id y7mr17717532ljk.69.1573520066803; 
 Mon, 11 Nov 2019 16:54:26 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
 <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
In-Reply-To: <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Mon, 11 Nov 2019 16:54:14 -0800
X-Gmail-Original-Message-ID: <CAAfnVBkMWurTpseQFjcna5kk3__40n6M68=RTHLbQsu__2AFxg@mail.gmail.com>
Message-ID: <CAAfnVBkMWurTpseQFjcna5kk3__40n6M68=RTHLbQsu__2AFxg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
X-Mailman-Approved-At: Mon, 11 Nov 2019 23:56:41 -0500
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
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org,
 Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 Alexandre Courbot <acourbot@chromium.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 5, 2019 at 2:55 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> Each buffer also has some properties to carry metadata, some fixed (id, size, application), but
> also allow free form (name = value, framebuffers would have
> width/height/stride/format for example).

Sounds a lot like the recently added DMA_BUF_SET_NAME ioctls:

https://patchwork.freedesktop.org/patch/310349/

For virtio-wayland + virtio-vdec, the problem is sharing -- not allocation.

As the buffer reaches a kernel boundary, it's properties devolve into
[fd, size].  Userspace can typically handle sharing metadata.  The
issue is the guest dma-buf fd doesn't mean anything on the host.

One scenario could be:

1) Guest userspace (say, gralloc) allocates using virtio-gpu.  When
allocating, we call uuidgen() and then pass that via RESOURCE_CREATE
hypercall to the host.
2) When exporting the dma-buf, we call DMA_BUF_SET_NAME (the buffer
name will be "virtgpu-buffer-${UUID}").
3) When importing, virtio-{vdec, video} reads the dma-buf name in
userspace, and calls fd to handle.  The name is sent to the host via a
hypercall, giving host virtio-{vdec, video} enough information to
identify the buffer.

This solution is entirely userspace -- we can probably come up with
something in kernel space [generate_random_uuid()] if need be.  We
only need two universal IDs: {device ID, buffer ID}.

> On Wed, Nov 6, 2019 at 2:28 PM Geoffrey McRae <geoff@hostfission.com> wrote:
> The entire point of this for our purposes is due to the fact that we can
> not allocate the buffer, it's either provided by the GPU driver or
> DirectX. If virtio-gpu were to allocate the buffer we might as well
> forget
> all this and continue using the ivshmem device.

We have a similar problem with closed source drivers.  As @lfy
mentioned, it's possible to map memory directory into virtio-gpu's PCI
bar and it's actually a planned feature.  Would that work for your use
case?

