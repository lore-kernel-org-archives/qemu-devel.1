Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D85C17440
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 22:56:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1749521783
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 22:56:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aL75rscQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1749521783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUf5e-0004xk-8J
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 17:56:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44305)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gurchetansingh@chromium.org>) id 1iUf4z-0004WX-GV
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gurchetansingh@chromium.org>) id 1iUf4y-0008TI-5Q
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:56:09 -0500
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33886)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <gurchetansingh@chromium.org>)
 id 1iUf4x-0008Ss-QI
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 17:56:08 -0500
Received: by mail-lj1-x241.google.com with SMTP id 139so323950ljf.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 14:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NRg/lnQIqsyAlkrMrDDQKffDJgYxXaKEgCFpr2Rfv3M=;
 b=aL75rscQiiD8cD6SexzGZExzdpBOv6yvnXOJXgPhpIuMsXo6Hiu19CCN9vFSeTLN7a
 XOywR7beF3VKHxHITOF/gIWFo5Ca7IkfyHk9VLRXsTD43xuyrcvZlYAjfp5trGMbOvOR
 P6T8Uow7jlnoLSoTfkr7WcD7MgT6ln+ssAb3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NRg/lnQIqsyAlkrMrDDQKffDJgYxXaKEgCFpr2Rfv3M=;
 b=DqdAc3dPXHnF/sDgTFAoj2o7OS/ghu7nAmYzB7destMH8AuaGXOHteYcF/ZKHgW8LW
 vel89Yt/0VDuz0V7bi/nwFguYsS8xJiedwk0khZaAj0wJFc3/cfHr+217L9ihIwtBd57
 qzWVrGIBNNTKW7KG6MSLzGk97FG6IFldf+ZknnnEVATbIh646isKcMYYVbXt+/55vp6C
 umSIDiRKEx6/LtFRKludWp83GVF9+bzTLaOuCa4x01v47ZNIqlp+6UhXLH2OLhbMUsTs
 zBqrWFb/viaIquk4tmK5OqKHRuUFdRAfcHnMqyTKfX8UT7oW7A8B681PaP07EJqA8gzO
 FKYw==
X-Gm-Message-State: APjAAAX87y/M3+YQworQJEH+e/jCPxxlngSLC0XUnjctgA91Kpt4hpwU
 kD8d/sUKAWT5FcFYuKRlb1j+hmv37tqURQ==
X-Google-Smtp-Source: APXvYqxvNmncR6Ya8rPioruzxDWQrDTBvEY23IwvFH8EedCwgckdhIxG8WvTKvqdiQO870GcnpLM4g==
X-Received: by 2002:a2e:8601:: with SMTP id a1mr131439lji.159.1573599363301;
 Tue, 12 Nov 2019 14:56:03 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com.
 [209.85.208.176])
 by smtp.gmail.com with ESMTPSA id z17sm53100ljm.16.2019.11.12.14.56.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Nov 2019 14:56:03 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id r7so321464ljg.2
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 14:56:02 -0800 (PST)
X-Received: by 2002:a05:651c:1136:: with SMTP id
 e22mr151566ljo.182.1573599361718; 
 Tue, 12 Nov 2019 14:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
 <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
 <CAAfnVBkMWurTpseQFjcna5kk3__40n6M68=RTHLbQsu__2AFxg@mail.gmail.com>
 <4a5dd822e86757f004d04af62fb7dd35ba75392d.camel@linux.intel.com>
In-Reply-To: <4a5dd822e86757f004d04af62fb7dd35ba75392d.camel@linux.intel.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 12 Nov 2019 14:55:49 -0800
X-Gmail-Original-Message-ID: <CAAfnVB=F+HeQrrn23c=rZeOa5BfHo=9ArcG--gLf87gqBXfZ9A@mail.gmail.com>
Message-ID: <CAAfnVB=F+HeQrrn23c=rZeOa5BfHo=9ArcG--gLf87gqBXfZ9A@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::241
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

On Tue, Nov 12, 2019 at 5:56 AM Liam Girdwood
<liam.r.girdwood@linux.intel.com> wrote:
>
> On Mon, 2019-11-11 at 16:54 -0800, Gurchetan Singh wrote:
> > On Tue, Nov 5, 2019 at 2:55 AM Gerd Hoffmann <kraxel@redhat.com>
> > wrote:
> > > Each buffer also has some properties to carry metadata, some fixed
> > > (id, size, application), but
> > > also allow free form (name = value, framebuffers would have
> > > width/height/stride/format for example).
> >
> > Sounds a lot like the recently added DMA_BUF_SET_NAME ioctls:
> >
> > https://patchwork.freedesktop.org/patch/310349/
> >
> > For virtio-wayland + virtio-vdec, the problem is sharing -- not
> > allocation.
> >
>
> Audio also needs to share buffers with firmware running on DSPs.
>
> > As the buffer reaches a kernel boundary, it's properties devolve into
> > [fd, size].  Userspace can typically handle sharing metadata.  The
> > issue is the guest dma-buf fd doesn't mean anything on the host.
> >
> > One scenario could be:
> >
> > 1) Guest userspace (say, gralloc) allocates using virtio-gpu.  When
> > allocating, we call uuidgen() and then pass that via RESOURCE_CREATE
> > hypercall to the host.
> > 2) When exporting the dma-buf, we call DMA_BUF_SET_NAME (the buffer
> > name will be "virtgpu-buffer-${UUID}").
> > 3) When importing, virtio-{vdec, video} reads the dma-buf name in
> > userspace, and calls fd to handle.  The name is sent to the host via
> > a
> > hypercall, giving host virtio-{vdec, video} enough information to
> > identify the buffer.
> >
> > This solution is entirely userspace -- we can probably come up with
> > something in kernel space [generate_random_uuid()] if need be.  We
> > only need two universal IDs: {device ID, buffer ID}.
> >
>
> I need something where I can take a guest buffer and then convert it to
> physical scatter gather page list. I can then either pass the SG page
> list to the DSP firmware (for DMAC IP programming) or have the host
> driver program the DMAC directly using the page list (who programs DMAC
> depends on DSP architecture).

So you need the HW address space from a guest allocation?  Would your
allocation hypercalls use something like the virtio_gpu_mem_entry
(virtio_gpu.h) and the draft virtio_video_mem_entry (draft)?

struct {
        __le64 addr;
        __le32 length;
        __le32 padding;
};

/* VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING */
struct virtio_gpu_resource_attach_backing {
        struct virtio_gpu_ctrl_hdr hdr;
        __le32 resource_id;
        __le32 nr_entries;
      *struct struct virtio_gpu_mem_entry */
};

struct virtio_video_mem_entry {
    __le64 addr;
    __le32 length;
    __u8 padding[4];
};

struct virtio_video_resource_attach_backing {
    struct virtio_video_ctrl_hdr hdr;
    __le32 resource_id;
    __le32 nr_entries;
};

>
> DSP FW has no access to userspace so we would need some additional API
> on top of DMA_BUF_SET_NAME etc to get physical hardware pages ?

The dma-buf api currently can share guest memory sg-lists.

>
> Liam
>
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

