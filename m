Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D33C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2915B2068E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 16:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2915B2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZHXx-0007N6-4P
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 11:49:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liam.r.girdwood@linux.intel.com>) id 1iZHVz-0006Px-JN
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liam.r.girdwood@linux.intel.com>) id 1iZHVx-0002HK-ED
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:47:06 -0500
Received: from mga02.intel.com ([134.134.136.20]:42883)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liam.r.girdwood@linux.intel.com>)
 id 1iZHVv-00022e-EJ
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 11:47:04 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Nov 2019 08:46:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,242,1571727600"; d="scan'208";a="202419454"
Received: from mpawlows-mobl2.ger.corp.intel.com ([10.252.20.57])
 by orsmga008.jf.intel.com with ESMTP; 25 Nov 2019 08:46:48 -0800
Message-ID: <296b7d844a283996a16769ecf3daade5198ae307.camel@linux.intel.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 25 Nov 2019 16:46:49 +0000
In-Reply-To: <20191120095349.oobeosin3lujgcja@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
 <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
 <CAAfnVBkMWurTpseQFjcna5kk3__40n6M68=RTHLbQsu__2AFxg@mail.gmail.com>
 <4a5dd822e86757f004d04af62fb7dd35ba75392d.camel@linux.intel.com>
 <CAAfnVB=F+HeQrrn23c=rZeOa5BfHo=9ArcG--gLf87gqBXfZ9A@mail.gmail.com>
 <bee3aae13f6cf69ee909aa9884926853d6123b25.camel@linux.intel.com>
 <20191120095349.oobeosin3lujgcja@sirius.home.kraxel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 134.134.136.20
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
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Keiichi Watanabe <keiichiw@chromium.org>,
 David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>,
 Dmitry Morozov <dmitry.morozov@opensynergy.com>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-11-20 at 10:53 +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > > > DSP FW has no access to userspace so we would need some
> > > > additional
> > > > API
> > > > on top of DMA_BUF_SET_NAME etc to get physical hardware pages ?
> > > 
> > > The dma-buf api currently can share guest memory sg-lists.
> > 
> > Ok, IIUC buffers can either be shared using the GPU proposed APIs
> > (above) or using the dma-buf API to share via userspace ? My
> > preference
> > would be to use teh more direct GPU APIs sending physical page
> > addresses from Guest to device driver. I guess this is your use
> > case
> > too ?
> 
> I'm not convinced this is useful for audio ...
> 
> I basically see two modes of operation which are useful:
> 
>   (1) send audio data via virtqueue.
>   (2) map host audio buffers into the guest address space.
> 
> The audio driver api (i.e. alsa) typically allows to mmap() the audio
> data buffers, so it is the host audio driver which handles the
> allocation. 

Yes, in regular non VM mode, it's the host driver which allocs the
buffers.

My end goal is to be able to share physical SG pages from host to
guests and HW (including DSP firmwares). 

>  Let the audio hardware dma from/to userspace-allocated
> buffers is not possible[1], but we would need that to allow qemu (or
> other vmms) use guest-allocated buffers.

My misunderstanding here on how the various proposals being discussed
all pass buffers between guests & host. I'm reading that some are
passing buffers via userspace descriptors and this would not be
workable for audio.

> 
> cheers,
>   Gerd
> 
> [1] Disclaimer: It's been a while I looked at alsa more closely, so
>     there is a chance this might have changed without /me noticing.
> 

Your all good here from audio. Disclaimer: I'm new to virtio.

Liam 



