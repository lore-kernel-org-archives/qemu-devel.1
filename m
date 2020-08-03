Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E70C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AADA20678
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AADA20678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2Zr4-0007g1-7D
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 08:46:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k2ZqL-0007AZ-9Y
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:45:29 -0400
Received: from relay68.bu.edu ([128.197.228.73]:43579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k2ZqJ-0007Hk-Hw
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:45:28 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay68.bu.edu (8.14.3/8.14.3) with ESMTP id 073CikhD010794
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 3 Aug 2020 08:44:54 -0400
Date: Mon, 3 Aug 2020 08:44:46 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Bug 1888606] [NEW] Heap-use-after-free in
 virtio_gpu_ctrl_response
Message-ID: <20200803124445.me2rmqytukjev22r@mozz.bu.edu>
References: <159548011952.31456.8249433335836304327.malonedeb@chaenomeles.canonical.com>
 <20200723153726.m6eckrxwkoooreh3@mozz.bu.edu>
 <20200803065604.lvvplrxwc5yomwl7@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803065604.lvvplrxwc5yomwl7@sirius.home.kraxel.org>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.73; envelope-from=alxndr@bu.edu;
 helo=relay68.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 08:45:25
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Bug 1888606 <1888606@bugs.launchpad.net>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,
Strange... After applying your patch, I re-ran the reproducer, but
I still see the same crash.
-Alex

On 200803 0856, Gerd Hoffmann wrote:
>   Hi,
> 
> > > The ASAN trace:
> > > ==29798==ERROR: AddressSanitizer: heap-use-after-free on address 0x60d0000050e8 at pc 0x560629814761 bp 0x7ffe916eb1e0 sp 0x7ffe916eb1d8
> > > READ of size 8 at 0x60d0000050e8 thread T0
> > >     #0 0x560629814760 in virtio_gpu_ctrl_response /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:181:42
> > >     #4 0x56062a8f1c96 in aio_bh_poll /home/alxndr/Development/qemu/util/async.c:164:13
> 
> > >     #1 0x560629827730 in virtio_gpu_reset /home/alxndr/Development/qemu/hw/display/virtio-gpu.c:1160:9
> 
> So it looks like the bottom half accesses stuff released by reset.
> 
> Guess the reset should cancel any scheduled bh calls to avoid that ...
> 
> Does the patch below help?
> 
> thanks,
>   Gerd
> 
> diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
> index 5f0dd7c15002..18f0011b5a0a 100644
> --- a/hw/display/virtio-gpu.c
> +++ b/hw/display/virtio-gpu.c
> @@ -1144,6 +1144,9 @@ static void virtio_gpu_reset(VirtIODevice *vdev)
>      struct virtio_gpu_simple_resource *res, *tmp;
>      struct virtio_gpu_ctrl_command *cmd;
>  
> +    qemu_bh_cancel(g->ctrl_bh);
> +    qemu_bh_cancel(g->cursor_bh);
> +
>  #ifdef CONFIG_VIRGL
>      if (g->parent_obj.use_virgl_renderer) {
>          virtio_gpu_virgl_reset(g);
> 

