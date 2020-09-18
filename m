Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77881C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:08:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0472A20717
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 14:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=euphon.net header.i=fam@euphon.net header.b="Q5UbD5q3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0472A20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=euphon.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJH4J-0000OD-2O
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 10:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56500)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kJH2w-0007Y8-Hl; Fri, 18 Sep 2020 10:07:30 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fam@euphon.net>)
 id 1kJH2s-0007ae-6U; Fri, 18 Sep 2020 10:07:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600437997; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=KB7detUw2F/wYYWWBbySB74FB7qnpZ1I3temR7jnuFD8oBLb5tSrSMp9SJD+EktHaarQHIMKItNaBfXIWz8EjFKLi4DtdGUZWjAOZLq/2LBK4Uvkz+mchIU7vjP06FU4r3PD5c56+T7Odnc8gzRhOOTd/zj6M37yTLtqgAjhwyY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1600437997;
 h=Content-Type:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=4s5oFqu/r3/CJVTg3XyeKY5N+d9Tt9MvxCvpliE9k0s=; 
 b=kHCqKvJ/d0vWBEA9uRnpAFA+OLb5fbAR9Hpk6DjHeiClq/v5octBL1LRmo4wE54FLmOc3g3iBJs1NqFonlxpMJGsbgqRkX5hYVD9MK54lp8fOM/iMDaVDO/IkLRFLPf6/MAc8ayZ3r4XTK5GlY9K87tt7Q2ZOXaP/T4t8yAnBI0=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=euphon.net;
 spf=pass  smtp.mailfrom=fam@euphon.net;
 dmarc=pass header.from=<fam@euphon.net> header.from=<fam@euphon.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1600437997; 
 s=zoho; d=euphon.net; i=fam@euphon.net;
 h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
 bh=4s5oFqu/r3/CJVTg3XyeKY5N+d9Tt9MvxCvpliE9k0s=;
 b=Q5UbD5q3cHU5HgI/ZrQVtwFmH1a6t+CZREXpR9Z+WdhA7o9ECZSYESRPKtRdYECo
 C2ntR58U5P2n4Q/zX71Yy6GGDux4CiOiWTmlvyGZQzl/wf08SZng0gh4N5cd5sMjgDE
 VU1albFuFgn2cnx1YCVwkhGakrQH7yoKZA34hxrI=
Received: from localhost (ec2-52-56-101-76.eu-west-2.compute.amazonaws.com
 [52.56.101.76]) by mx.zoho.com.cn
 with SMTPS id 1600437994406149.55722397655666;
 Fri, 18 Sep 2020 22:06:34 +0800 (CST)
Date: Fri, 18 Sep 2020 14:06:28 +0000
From: Fam Zheng <fam@euphon.net>
To: Zhenyu Ye <yezhenyu2@huawei.com>
Subject: Re: [PATCH v1 0/2] Add timeout mechanism to qmp actions
Message-ID: <20200918140628.GA2509473@dev>
References: <20200810145246.1049-1-yezhenyu2@huawei.com>
 <20200810153811.GF14538@linux.fritz.box>
 <c6d75e49-3e36-6a76-fdc8-cdf09e7c3393@huawei.com>
 <20200914132738.GL579094@stefanha-x1.localdomain>
 <7ad220bd-7ee5-1f66-b2e5-7dc57d72eb2e@huawei.com>
 <20200917154415.GB839531@stefanha-x1.localdomain>
 <20200917160054.GA2453251@dev>
 <5a5822ec-f3bc-a247-2b5a-f764b941c820@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a5822ec-f3bc-a247-2b5a-f764b941c820@huawei.com>
X-ZohoCNMailClient: External
Received-SPF: pass client-ip=163.53.93.243; envelope-from=fam@euphon.net;
 helo=sender2-op-o12.zoho.com.cn
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 10:07:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com,
 xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-09-18 19:23, Zhenyu Ye wrote:
> 	Thread 5 (LWP 4802):
> 	#0  0x0000ffff83086b54 in syscall () at /lib64/libc.so.6
> 	#1  0x0000ffff834598b8 in io_submit () at /lib64/libaio.so.1
> 	#2  0x0000aaaae851e89c in ioq_submit (s=0xfffd3c001bb0) at ../block/linux-aio.c:299
> 	#3  0x0000aaaae851eb50 in laio_io_unplug (bs=0xaaaaef0f2340, s=0xfffd3c001bb0)
> 	    at ../block/linux-aio.c:344
> 	#4  0x0000aaaae8559f1c in raw_aio_unplug (bs=0xaaaaef0f2340) at ../block/file-posix.c:2063
> 	#5  0x0000aaaae8538344 in bdrv_io_unplug (bs=0xaaaaef0f2340) at ../block/io.c:3135
> 	#6  0x0000aaaae8538360 in bdrv_io_unplug (bs=0xaaaaef0eb020) at ../block/io.c:3140
> 	#7  0x0000aaaae8496104 in blk_io_unplug (blk=0xaaaaef0e8f20)
> 	    at ../block/block-backend.c:2147
> 	#8  0x0000aaaae830e1a4 in virtio_blk_handle_vq (s=0xaaaaf0374280, vq=0xffff700fc1d8)
> 	    at ../hw/block/virtio-blk.c:796
> 	#9  0x0000aaaae82e6b68 in virtio_blk_data_plane_handle_output
> 	    (vdev=0xaaaaf0374280, vq=0xffff700fc1d8) at ../hw/block/dataplane/virtio-blk.c:165
> 	#10 0x0000aaaae83878fc in virtio_queue_notify_aio_vq (vq=0xffff700fc1d8)
> 	    at ../hw/virtio/virtio.c:2325
> 	#11 0x0000aaaae838ab50 in virtio_queue_host_notifier_aio_poll (opaque=0xffff700fc250)
> 	    at ../hw/virtio/virtio.c:3545
> 	#12 0x0000aaaae85fab3c in run_poll_handlers_once
> 	    (ctx=0xaaaaef0a87b0, now=77604310618960, timeout=0xffff73ffdf78)
> 	    at ../util/aio-posix.c:398
> 	#13 0x0000aaaae85fae5c in run_poll_handlers
> 	    (ctx=0xaaaaef0a87b0, max_ns=4000, timeout=0xffff73ffdf78) at ../util/aio-posix.c:492
> 	#14 0x0000aaaae85fb078 in try_poll_mode (ctx=0xaaaaef0a87b0, timeout=0xffff73ffdf78)
> 	    at ../util/aio-posix.c:535
> 	#15 0x0000aaaae85fb180 in aio_poll (ctx=0xaaaaef0a87b0, blocking=true)
> 	    at ../util/aio-posix.c:571
> 	#16 0x0000aaaae8027004 in iothread_run (opaque=0xaaaaeee79a00) at ../iothread.c:73
> 	#17 0x0000aaaae85f269c in qemu_thread_start (args=0xaaaaef0a8d10)
> 	    at ../util/qemu-thread-posix.c:521
> 	#18 0x0000ffff831428bc in  () at /lib64/libpthread.so.0
> 	#19 0x0000ffff8308aa1c in  () at /lib64/libc.so.6

I can see how blocking in a slow io_submit can cause trouble for main
thread. I think one way to fix it (until it's made truly async in new
kernels) is moving the io_submit call to thread pool, and wrapped in a
coroutine, perhaps.

I'm not sure qmp timeout is a complete solution because we would still
suffer from a blocked state for a period, in this exact situation before
the timeout.

Fam

