Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8189BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 00:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E29D2245F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 00:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aatNqWaL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E29D2245F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXE66-0006Qw-Ei
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 19:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gurchetansingh@chromium.org>) id 1iXE5L-0005xp-IG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:43:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gurchetansingh@chromium.org>) id 1iXE5K-0001Sx-0U
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:43:07 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:41417)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <gurchetansingh@chromium.org>)
 id 1iXE5J-0001RK-M0
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 19:43:05 -0500
Received: by mail-lf1-x142.google.com with SMTP id j14so18665322lfb.8
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 16:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=SuCiKSsIRDKTbEIrlKuHNFUxZMf3N0BWgvOBBoTFOxg=;
 b=aatNqWaL0QyzhfFvsyJVZNwE0B3j5uWP4gtCcj8hIO+DL3zX4s+xOfl1Pb2PHnepNb
 YAAhjnh9lsk5gVv4jY4LAKfHk5UEtn+Aqq76ly7inUWooSmlMUp4o+Ozp+DPyrFCXoad
 R2JSfxtSpuaY4HTG9QFIXSei5hjZJA573tT6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SuCiKSsIRDKTbEIrlKuHNFUxZMf3N0BWgvOBBoTFOxg=;
 b=GqIngBdf0mdDBiiQFwNmGpaPApdetsiq/JDHD6TApvDwJBFP0/zkdA3+KrdtqBpD8z
 okQ/60iSbOt15ImYmsGWhUHdqbRdf2BBXFRSd32uBKX2wnJzguGPxTlGm3QNOLLzsqau
 XnIjyK0cMVODKT2C+eRQyVr+kjkdj9nOsgBX2xxvki8Op+iGyUJh1ER6svJHI6QI+ENj
 /Lu9bMknldgGOI46/mDLTudz0MITyU9tzQSLdcVgHRvk/8mqNWZEBajbJI2vNTn6/qqU
 VmQjeqR7/IAiEaGYMHunwvS6UWn9ESq+/gQxYJM5Y7GcfpxVTqjiVIXcx93wHCZhd9N6
 qmqg==
X-Gm-Message-State: APjAAAU1yuNl5RH7TlDgVKmpxFFvK36Ysm2qRRwz4vLc7tm6NZWjqt9c
 uTCJZhgvW254gFaSoHLYq5tKFYdStPQ=
X-Google-Smtp-Source: APXvYqx2OnJbLsfHKMAW3bBDU+lmBfVEVdifisO/kL5dhxCDeePrabP+iMp4JJuTMCFzjlO6cJOb4w==
X-Received: by 2002:a19:84d:: with SMTP id 74mr326424lfi.122.1574210583600;
 Tue, 19 Nov 2019 16:43:03 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com.
 [209.85.208.181])
 by smtp.gmail.com with ESMTPSA id q24sm10470424ljm.76.2019.11.19.16.43.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Nov 2019 16:43:02 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id v8so25499078ljh.5
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 16:43:02 -0800 (PST)
X-Received: by 2002:a2e:2e03:: with SMTP id u3mr209839lju.115.1574210581666;
 Tue, 19 Nov 2019 16:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
 <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
 <CAAfnVBkMWurTpseQFjcna5kk3__40n6M68=RTHLbQsu__2AFxg@mail.gmail.com>
 <4a5dd822e86757f004d04af62fb7dd35ba75392d.camel@linux.intel.com>
 <CAAfnVB=F+HeQrrn23c=rZeOa5BfHo=9ArcG--gLf87gqBXfZ9A@mail.gmail.com>
 <bee3aae13f6cf69ee909aa9884926853d6123b25.camel@linux.intel.com>
In-Reply-To: <bee3aae13f6cf69ee909aa9884926853d6123b25.camel@linux.intel.com>
From: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 19 Nov 2019 16:42:49 -0800
X-Gmail-Original-Message-ID: <CAAfnVBmcBWWpvTAijg8AY-6RoKGJ84AS_qo2WqF6sgLHVsHJsw@mail.gmail.com>
Message-ID: <CAAfnVBmcBWWpvTAijg8AY-6RoKGJ84AS_qo2WqF6sgLHVsHJsw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
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

On Tue, Nov 19, 2019 at 7:31 AM Liam Girdwood
<liam.r.girdwood@linux.intel.com> wrote:
>
> On Tue, 2019-11-12 at 14:55 -0800, Gurchetan Singh wrote:
> > On Tue, Nov 12, 2019 at 5:56 AM Liam Girdwood
> > <liam.r.girdwood@linux.intel.com> wrote:
> > >
> > > On Mon, 2019-11-11 at 16:54 -0800, Gurchetan Singh wrote:
> > > > On Tue, Nov 5, 2019 at 2:55 AM Gerd Hoffmann <kraxel@redhat.com>
> > > > wrote:
> > > > > Each buffer also has some properties to carry metadata, some
> > > > > fixed
> > > > > (id, size, application), but
> > > > > also allow free form (name = value, framebuffers would have
> > > > > width/height/stride/format for example).
> > > >
> > > > Sounds a lot like the recently added DMA_BUF_SET_NAME ioctls:
> > > >
> > > > https://patchwork.freedesktop.org/patch/310349/
> > > >
> > > > For virtio-wayland + virtio-vdec, the problem is sharing -- not
> > > > allocation.
> > > >
> > >
> > > Audio also needs to share buffers with firmware running on DSPs.
> > >
> > > > As the buffer reaches a kernel boundary, it's properties devolve
> > > > into
> > > > [fd, size].  Userspace can typically handle sharing
> > > > metadata.  The
> > > > issue is the guest dma-buf fd doesn't mean anything on the host.
> > > >
> > > > One scenario could be:
> > > >
> > > > 1) Guest userspace (say, gralloc) allocates using virtio-
> > > > gpu.  When
> > > > allocating, we call uuidgen() and then pass that via
> > > > RESOURCE_CREATE
> > > > hypercall to the host.
> > > > 2) When exporting the dma-buf, we call DMA_BUF_SET_NAME (the
> > > > buffer
> > > > name will be "virtgpu-buffer-${UUID}").
> > > > 3) When importing, virtio-{vdec, video} reads the dma-buf name in
> > > > userspace, and calls fd to handle.  The name is sent to the host
> > > > via
> > > > a
> > > > hypercall, giving host virtio-{vdec, video} enough information to
> > > > identify the buffer.
> > > >
> > > > This solution is entirely userspace -- we can probably come up
> > > > with
> > > > something in kernel space [generate_random_uuid()] if need
> > > > be.  We
> > > > only need two universal IDs: {device ID, buffer ID}.
> > > >
> > >
> > > I need something where I can take a guest buffer and then convert
> > > it to
> > > physical scatter gather page list. I can then either pass the SG
> > > page
> > > list to the DSP firmware (for DMAC IP programming) or have the host
> > > driver program the DMAC directly using the page list (who programs
> > > DMAC
> > > depends on DSP architecture).
> >
> > So you need the HW address space from a guest allocation?
>
> Yes.
>
> >  Would your
> > allocation hypercalls use something like the virtio_gpu_mem_entry
> > (virtio_gpu.h) and the draft virtio_video_mem_entry (draft)?
>
> IIUC, this looks like generic SG buffer allocation ?
>
> >
> > struct {
> >         __le64 addr;
> >         __le32 length;
> >         __le32 padding;
> > };
> >
> > /* VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING */
> > struct virtio_gpu_resource_attach_backing {
> >         struct virtio_gpu_ctrl_hdr hdr;
> >         __le32 resource_id;
> >         __le32 nr_entries;
> >       *struct struct virtio_gpu_mem_entry */
> > };
> >
> > struct virtio_video_mem_entry {
> >     __le64 addr;
> >     __le32 length;
> >     __u8 padding[4];
> > };
> >
> > struct virtio_video_resource_attach_backing {
> >     struct virtio_video_ctrl_hdr hdr;
> >     __le32 resource_id;
> >     __le32 nr_entries;
> > };
> >
> > >
> > > DSP FW has no access to userspace so we would need some additional
> > > API
> > > on top of DMA_BUF_SET_NAME etc to get physical hardware pages ?
> >
> > The dma-buf api currently can share guest memory sg-lists.
>
> Ok, IIUC buffers can either be shared using the GPU proposed APIs
> (above) or using the dma-buf API to share via userspace ?

If we restrict ourselves to guest-sg lists only, then the current
dma-buf API is sufficient to share buffers.  From example, virtio-gpu
can allocate with the following hypercall (as it does now):

struct virtio_gpu_resource_attach_backing {
         struct virtio_gpu_ctrl_hdr hdr;
         __le32 resource_id;
         __le32 nr_entries;
       *struct struct virtio_gpu_mem_entry */
};

Then in the guest kernel, virtio-{video, snd} can get the sg-list via
dma_buf_map_attachment, and then have a hypercall of it's own:

struct virtio_video_resource_import {
         struct virtio_video_ctrl_hdr hdr;
         __le32 video_resource_id;
         __le32 nr_entries;
       *struct struct virtio_gpu_mem_entry */
};

Then it can create dmabuf on the host or get the HW address from the SG list.

The complications come in from sharing host allocated buffers ... for
that we may need a method to translate from guest fds to universal
"virtualized" resource IDs.  I've heard talk about the need to
translate from guest fence fds to host fence fds as well.

> My preference
> would be to use teh more direct GPU APIs sending physical page
> addresses from Guest to device driver. I guess this is your use case
> too ?

For my use case, guest memory is sufficient, especially given the
direction towards modifiers + system memory.  For closed source
drivers, we may need to directly map host buffers.  However, that use
case is restricted to virtio-gpu and won't work with other virtio
devices.


>
> Thanks
>
> Liam
>
> >
> > >
> > > Liam
> > >
> > >
> > >
> > > -----------------------------------------------------------------
> > > ----
> > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > For additional commands, e-mail:
> > > virtio-dev-help@lists.oasis-open.org
> > >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> >
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

