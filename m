Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2DDC432C3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DE9C22304
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 15:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DE9C22304
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX5V3-00065h-FK
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 10:33:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51916)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.r.girdwood@linux.intel.com>) id 1iX5Tj-00057h-PH
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:31:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.r.girdwood@linux.intel.com>) id 1iX5Ti-0001tO-BJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:31:43 -0500
Received: from mga14.intel.com ([192.55.52.115]:4774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.r.girdwood@linux.intel.com>)
 id 1iX5Ti-0001s0-3Q
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 10:31:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Nov 2019 07:31:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,324,1569308400"; d="scan'208";a="209227174"
Received: from sstrehla-mobl1.ger.corp.intel.com ([10.252.16.202])
 by orsmga003.jf.intel.com with ESMTP; 19 Nov 2019 07:31:28 -0800
Message-ID: <bee3aae13f6cf69ee909aa9884926853d6123b25.camel@linux.intel.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
To: Gurchetan Singh <gurchetansingh@chromium.org>
Date: Tue, 19 Nov 2019 15:31:27 +0000
In-Reply-To: <CAAfnVB=F+HeQrrn23c=rZeOa5BfHo=9ArcG--gLf87gqBXfZ9A@mail.gmail.com>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
 <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
 <CAAfnVBkMWurTpseQFjcna5kk3__40n6M68=RTHLbQsu__2AFxg@mail.gmail.com>
 <4a5dd822e86757f004d04af62fb7dd35ba75392d.camel@linux.intel.com>
 <CAAfnVB=F+HeQrrn23c=rZeOa5BfHo=9ArcG--gLf87gqBXfZ9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.115
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
 =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-11-12 at 14:55 -0800, Gurchetan Singh wrote:
> On Tue, Nov 12, 2019 at 5:56 AM Liam Girdwood
> <liam.r.girdwood@linux.intel.com> wrote:
> > 
> > On Mon, 2019-11-11 at 16:54 -0800, Gurchetan Singh wrote:
> > > On Tue, Nov 5, 2019 at 2:55 AM Gerd Hoffmann <kraxel@redhat.com>
> > > wrote:
> > > > Each buffer also has some properties to carry metadata, some
> > > > fixed
> > > > (id, size, application), but
> > > > also allow free form (name = value, framebuffers would have
> > > > width/height/stride/format for example).
> > > 
> > > Sounds a lot like the recently added DMA_BUF_SET_NAME ioctls:
> > > 
> > > https://patchwork.freedesktop.org/patch/310349/
> > > 
> > > For virtio-wayland + virtio-vdec, the problem is sharing -- not
> > > allocation.
> > > 
> > 
> > Audio also needs to share buffers with firmware running on DSPs.
> > 
> > > As the buffer reaches a kernel boundary, it's properties devolve
> > > into
> > > [fd, size].  Userspace can typically handle sharing
> > > metadata.  The
> > > issue is the guest dma-buf fd doesn't mean anything on the host.
> > > 
> > > One scenario could be:
> > > 
> > > 1) Guest userspace (say, gralloc) allocates using virtio-
> > > gpu.  When
> > > allocating, we call uuidgen() and then pass that via
> > > RESOURCE_CREATE
> > > hypercall to the host.
> > > 2) When exporting the dma-buf, we call DMA_BUF_SET_NAME (the
> > > buffer
> > > name will be "virtgpu-buffer-${UUID}").
> > > 3) When importing, virtio-{vdec, video} reads the dma-buf name in
> > > userspace, and calls fd to handle.  The name is sent to the host
> > > via
> > > a
> > > hypercall, giving host virtio-{vdec, video} enough information to
> > > identify the buffer.
> > > 
> > > This solution is entirely userspace -- we can probably come up
> > > with
> > > something in kernel space [generate_random_uuid()] if need
> > > be.  We
> > > only need two universal IDs: {device ID, buffer ID}.
> > > 
> > 
> > I need something where I can take a guest buffer and then convert
> > it to
> > physical scatter gather page list. I can then either pass the SG
> > page
> > list to the DSP firmware (for DMAC IP programming) or have the host
> > driver program the DMAC directly using the page list (who programs
> > DMAC
> > depends on DSP architecture).
> 
> So you need the HW address space from a guest allocation? 

Yes.

>  Would your
> allocation hypercalls use something like the virtio_gpu_mem_entry
> (virtio_gpu.h) and the draft virtio_video_mem_entry (draft)?

IIUC, this looks like generic SG buffer allocation ?

> 
> struct {
>         __le64 addr;
>         __le32 length;
>         __le32 padding;
> };
> 
> /* VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING */
> struct virtio_gpu_resource_attach_backing {
>         struct virtio_gpu_ctrl_hdr hdr;
>         __le32 resource_id;
>         __le32 nr_entries;
>       *struct struct virtio_gpu_mem_entry */
> };
> 
> struct virtio_video_mem_entry {
>     __le64 addr;
>     __le32 length;
>     __u8 padding[4];
> };
> 
> struct virtio_video_resource_attach_backing {
>     struct virtio_video_ctrl_hdr hdr;
>     __le32 resource_id;
>     __le32 nr_entries;
> };
> 
> > 
> > DSP FW has no access to userspace so we would need some additional
> > API
> > on top of DMA_BUF_SET_NAME etc to get physical hardware pages ?
> 
> The dma-buf api currently can share guest memory sg-lists.

Ok, IIUC buffers can either be shared using the GPU proposed APIs
(above) or using the dma-buf API to share via userspace ? My preference
would be to use teh more direct GPU APIs sending physical page
addresses from Guest to device driver. I guess this is your use case
too ?

Thanks

Liam

> 
> > 
> > Liam
> > 
> > 
> > 
> > -----------------------------------------------------------------
> > ----
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: 
> > virtio-dev-help@lists.oasis-open.org
> > 
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 


