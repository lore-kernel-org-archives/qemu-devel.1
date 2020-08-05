Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912C8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:02:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 687582073E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 02:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687582073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k38lD-0005rm-Ks
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 22:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k38kW-00058e-MD
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:01:48 -0400
Received: from relay64.bu.edu ([128.197.228.104]:58131)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1k38kT-00080U-JM
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 22:01:47 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 07520xvr032511
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 4 Aug 2020 22:01:00 -0400
Date: Tue, 4 Aug 2020 22:00:59 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Bug 1890360 <1890360@bugs.launchpad.net>
Subject: Re: [Bug 1890360] [NEW] Assertion failure in address_space_unmap
 through virtio-blk
Message-ID: <20200805020059.qm2jpzfeqmwwbige@mozz.bu.edu>
References: <159659017753.10948.1930355246009105000.malonedeb@chaenomeles.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159659017753.10948.1930355246009105000.malonedeb@chaenomeles.canonical.com>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 21:45:14
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stefan,
This looks an awful lot like the one you looked at here:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg705719.html
though this one is for virtio-pci, while that one was for virtio-mmio:

They are probably the same issue, but the original reproducer no longer
causes an asserion failure for me, so maybe there was already a fix..
-Alex

On 200805 0116, Alexander Bulekov wrote:
> Public bug reported:
> 
> Hello,
> Reproducer:
> cat << EOF | ./i386-softmmu/qemu-system-i386 \
> -drive id=mydrive,file=null-co://,size=2M,format=raw,if=none \
> -device virtio-blk,drive=mydrive \
> -nodefaults -nographic -qtest stdio
> outl 0xcf8 0x80001010
> outl 0xcfc 0xc001
> outl 0xcf8 0x80001014
> outl 0xcf8 0x80001004
> outw 0xcfc 0x7
> outl 0xc006 0x3aff9090
> outl 0xcf8 0x8000100e
> outl 0xcfc 0x41005e1e
> write 0x3b00002 0x1 0x5e
> write 0x3b00004 0x1 0x5e
> write 0x3aff5e6 0x1 0x11
> write 0x3aff5eb 0x1 0xc6
> write 0x3aff5ec 0x1 0xc6
> write 0x7 0x1 0xff
> write 0x8 0x1 0xfb
> write 0xc 0x1 0x11
> write 0xe 0x1 0x5e
> write 0x5e8 0x1 0x11
> write 0x5ec 0x1 0xc6
> outl 0x410e 0x10e
> EOF
> 
> 
> qemu-fuzz-i386: /exec.c:3623: void address_space_unmap(AddressSpace *, void *, hwaddr, _Bool, hwaddr): Assertion `mr != NULL' failed.
> ==789== ERROR: libFuzzer: deadly signal
>     #8  in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/assert.c:101:3
>     #9  in address_space_unmap /exec.c:3623:9
>     #10 in dma_memory_unmap /include/sysemu/dma.h:145:5
>     #11 in virtqueue_unmap_sg /hw/virtio/virtio.c:690:9
>     #12 in virtqueue_fill /hw/virtio/virtio.c:843:5
>     #13 in virtqueue_push /hw/virtio/virtio.c:917:5
>     #14 in virtio_blk_req_complete /hw/block/virtio-blk.c:83:5
>     #15 in virtio_blk_handle_request /hw/block/virtio-blk.c:671:13
>     #16 in virtio_blk_handle_vq /hw/block/virtio-blk.c:780:17
>     #17 in virtio_queue_notify_aio_vq /hw/virtio/virtio.c:2324:15
>     #18 in virtio_queue_host_notifier_aio_read /hw/virtio/virtio.c:3495:9
>     #19 in aio_dispatch_handler /util/aio-posix.c:328:9
>     #20 in aio_dispatch_handlers /util/aio-posix.c:371:20
>     #21 in aio_dispatch /util/aio-posix.c:381:5
>     #22 in aio_ctx_dispatch /util/async.c:306:5
>     #23 in g_main_context_dispatch
> 
> 
> With -trace virtio\*
> 
> ...
> [S +0.099667] OK
> [R +0.099681] write 0x5ec 0x1 0xc6
> OK
> [S +0.099690] OK
> [R +0.099700] outl 0x410e 0x10e
> 29575@1596590112.074339:virtio_queue_notify vdev 0x62d000030590 n 0 vq 0x7f9b93fc9800
> 29575@1596590112.074423:virtio_blk_data_plane_start dataplane 0x60600000f260
> OK
> [S +0.099833] OK
> 29575@1596590112.076459:virtio_queue_notify vdev 0x62d000030590 n 0 vq 0x7f9b93fc9800
> 29575@1596590112.076642:virtio_blk_handle_read vdev 0x62d000030590 req 0x611000043e80 sector 0 nsectors 0
> 29575@1596590112.076651:virtio_blk_req_complete vdev 0x62d000030590 req 0x611000043e80 status 1
> qemu-system-i386: /home/alxndr/Development/qemu/general-fuzz/exec.c:3623: void address_space_unmap(AddressSpace *, void *, hwaddr, _Bool, hwaddr): Assertion `mr != NULL' failed.
> 
> 
> -Alex
> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> 
> -- 
> You received this bug notification because you are a member of qemu-
> devel-ml, which is subscribed to QEMU.
> https://bugs.launchpad.net/bugs/1890360
> 
> Title:
>   Assertion failure in address_space_unmap through virtio-blk
> 
> Status in QEMU:
>   New
> 
> Bug description:
>   Hello,
>   Reproducer:
>   cat << EOF | ./i386-softmmu/qemu-system-i386 \
>   -drive id=mydrive,file=null-co://,size=2M,format=raw,if=none \
>   -device virtio-blk,drive=mydrive \
>   -nodefaults -nographic -qtest stdio
>   outl 0xcf8 0x80001010
>   outl 0xcfc 0xc001
>   outl 0xcf8 0x80001014
>   outl 0xcf8 0x80001004
>   outw 0xcfc 0x7
>   outl 0xc006 0x3aff9090
>   outl 0xcf8 0x8000100e
>   outl 0xcfc 0x41005e1e
>   write 0x3b00002 0x1 0x5e
>   write 0x3b00004 0x1 0x5e
>   write 0x3aff5e6 0x1 0x11
>   write 0x3aff5eb 0x1 0xc6
>   write 0x3aff5ec 0x1 0xc6
>   write 0x7 0x1 0xff
>   write 0x8 0x1 0xfb
>   write 0xc 0x1 0x11
>   write 0xe 0x1 0x5e
>   write 0x5e8 0x1 0x11
>   write 0x5ec 0x1 0xc6
>   outl 0x410e 0x10e
>   EOF
> 
>   
>   qemu-fuzz-i386: /exec.c:3623: void address_space_unmap(AddressSpace *, void *, hwaddr, _Bool, hwaddr): Assertion `mr != NULL' failed.
>   ==789== ERROR: libFuzzer: deadly signal
>       #8  in __assert_fail /build/glibc-GwnBeO/glibc-2.30/assert/assert.c:101:3
>       #9  in address_space_unmap /exec.c:3623:9
>       #10 in dma_memory_unmap /include/sysemu/dma.h:145:5
>       #11 in virtqueue_unmap_sg /hw/virtio/virtio.c:690:9
>       #12 in virtqueue_fill /hw/virtio/virtio.c:843:5
>       #13 in virtqueue_push /hw/virtio/virtio.c:917:5
>       #14 in virtio_blk_req_complete /hw/block/virtio-blk.c:83:5
>       #15 in virtio_blk_handle_request /hw/block/virtio-blk.c:671:13
>       #16 in virtio_blk_handle_vq /hw/block/virtio-blk.c:780:17
>       #17 in virtio_queue_notify_aio_vq /hw/virtio/virtio.c:2324:15
>       #18 in virtio_queue_host_notifier_aio_read /hw/virtio/virtio.c:3495:9
>       #19 in aio_dispatch_handler /util/aio-posix.c:328:9
>       #20 in aio_dispatch_handlers /util/aio-posix.c:371:20
>       #21 in aio_dispatch /util/aio-posix.c:381:5
>       #22 in aio_ctx_dispatch /util/async.c:306:5
>       #23 in g_main_context_dispatch
> 
>   
>   With -trace virtio\*
> 
>   ...
>   [S +0.099667] OK
>   [R +0.099681] write 0x5ec 0x1 0xc6
>   OK
>   [S +0.099690] OK
>   [R +0.099700] outl 0x410e 0x10e
>   29575@1596590112.074339:virtio_queue_notify vdev 0x62d000030590 n 0 vq 0x7f9b93fc9800
>   29575@1596590112.074423:virtio_blk_data_plane_start dataplane 0x60600000f260
>   OK
>   [S +0.099833] OK
>   29575@1596590112.076459:virtio_queue_notify vdev 0x62d000030590 n 0 vq 0x7f9b93fc9800
>   29575@1596590112.076642:virtio_blk_handle_read vdev 0x62d000030590 req 0x611000043e80 sector 0 nsectors 0
>   29575@1596590112.076651:virtio_blk_req_complete vdev 0x62d000030590 req 0x611000043e80 status 1
>   qemu-system-i386: /home/alxndr/Development/qemu/general-fuzz/exec.c:3623: void address_space_unmap(AddressSpace *, void *, hwaddr, _Bool, hwaddr): Assertion `mr != NULL' failed.
> 
>   
>   -Alex
> 
> To manage notifications about this bug go to:
> https://bugs.launchpad.net/qemu/+bug/1890360/+subscriptions
> 

