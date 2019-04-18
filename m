Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B25C10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 07:27:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB08D2083D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 07:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB08D2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37274 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH1SA-00064y-8Y
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 03:27:26 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hH1R0-0005UG-06
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 03:26:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hH1Qy-0007UM-1q
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 03:26:13 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hH1Qx-0007SV-Fc
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 03:26:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so1641843wrm.4
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 00:26:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=ortHHZ5ceSe88WkaYIAygN1Xp+iTIABvfj08DJY3VwE=;
	b=SG+0/A08JNo85yojr/3jmP9gl9jNCMnoXlPr2tCNbD+oqskpqJe3+uOja9JGsO7gnU
	23D+/B2FM5/Oe89UjCYmMl426fpjsjz3waYqX8fy+5t4ll2eSW3gECySYEyel/rsoAAy
	EvE9u+NK+sQcP8PvTXD/80G54c/+Rq5k/7/5no9hoKmX/rDnCFeYdlTfUDMfrvb7RshO
	tHm+0XK6FSDNaLiFUzj/hIuy/3rXOKsqTVvbDj3S2tB5KZo/3kgd6tEvhOQ6wbC7c2DV
	RcX/InltlwCDlHj3k32mr8y8E3TBFyvzKeR4zZElp39S99eV+uSRJ7EzbV3Ee9jcIM2Q
	8c6g==
X-Gm-Message-State: APjAAAXOCqGS5ZfXVjyYks4SEXY1VmqiVrlOY671YcgbrpTp0TY2nNpu
	SbY/6HnDjB/i47o8h/Ol7/rZ1A==
X-Google-Smtp-Source: APXvYqwzekYC1vuT8FsERIZrtkpYqSc8y8ZUr91fNVQCP5qdCB7XVq3GCFADNkN2Hz0hLqfJXMvGzg==
X-Received: by 2002:adf:e648:: with SMTP id b8mr8469778wrn.132.1555572368578; 
	Thu, 18 Apr 2019 00:26:08 -0700 (PDT)
Received: from steredhat (host35-203-static.12-87-b.business.telecomitalia.it.
	[87.12.203.35]) by smtp.gmail.com with ESMTPSA id
	b11sm1203335wru.61.2019.04.18.00.26.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 18 Apr 2019 00:26:07 -0700 (PDT)
Date: Thu, 18 Apr 2019 09:26:05 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190418072605.toaoek774tu5btdd@steredhat>
References: <20190417154850.29110-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190417154850.29110-1-kwolf@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH] block: Fix AioContext switch for bs->drv
 == NULL
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418072605.AgvcufB0PdgxaiNwfJZPMWeNTyScOQ74h9xJ2aFGkn8@z>

On Wed, Apr 17, 2019 at 05:48:50PM +0200, Kevin Wolf wrote:
> Even for block nodes with bs->drv == NULL, we can't just ignore a
> bdrv_set_aio_context() call. Leaving the node in its old context can
> mean that it's still in an iothread context in bdrv_close_all() during
> shutdown, resulting in an attempted unlock of the AioContext lock which
> we don't hold.
> 
> This is an example stack trace of a related crash:
> 
>  #0  0x00007ffff59da57f in raise () at /lib64/libc.so.6
>  #1  0x00007ffff59c4895 in abort () at /lib64/libc.so.6
>  #2  0x0000555555b97b1e in error_exit (err=<optimized out>, msg=msg@entry=0x555555d386d0 <__func__.19059> "qemu_mutex_unlock_impl") at util/qemu-thread-posix.c:36
>  #3  0x0000555555b97f7f in qemu_mutex_unlock_impl (mutex=mutex@entry=0x5555568002f0, file=file@entry=0x555555d378df "util/async.c", line=line@entry=507) at util/qemu-thread-posix.c:97
>  #4  0x0000555555b92f55 in aio_context_release (ctx=ctx@entry=0x555556800290) at util/async.c:507
>  #5  0x0000555555b05cf8 in bdrv_prwv_co (child=child@entry=0x7fffc80012f0, offset=offset@entry=131072, qiov=qiov@entry=0x7fffffffd4f0, is_write=is_write@entry=true, flags=flags@entry=0)
>          at block/io.c:833
>  #6  0x0000555555b060a9 in bdrv_pwritev (qiov=0x7fffffffd4f0, offset=131072, child=0x7fffc80012f0) at block/io.c:990
>  #7  0x0000555555b060a9 in bdrv_pwrite (child=0x7fffc80012f0, offset=131072, buf=<optimized out>, bytes=<optimized out>) at block/io.c:990
>  #8  0x0000555555ae172b in qcow2_cache_entry_flush (bs=bs@entry=0x555556810680, c=c@entry=0x5555568cc740, i=i@entry=0) at block/qcow2-cache.c:51
>  #9  0x0000555555ae18dd in qcow2_cache_write (bs=bs@entry=0x555556810680, c=0x5555568cc740) at block/qcow2-cache.c:248
>  #10 0x0000555555ae15de in qcow2_cache_flush (bs=0x555556810680, c=<optimized out>) at block/qcow2-cache.c:259
>  #11 0x0000555555ae16b1 in qcow2_cache_flush_dependency (c=0x5555568a1700, c=0x5555568a1700, bs=0x555556810680) at block/qcow2-cache.c:194
>  #12 0x0000555555ae16b1 in qcow2_cache_entry_flush (bs=bs@entry=0x555556810680, c=c@entry=0x5555568a1700, i=i@entry=0) at block/qcow2-cache.c:194
>  #13 0x0000555555ae18dd in qcow2_cache_write (bs=bs@entry=0x555556810680, c=0x5555568a1700) at block/qcow2-cache.c:248
>  #14 0x0000555555ae15de in qcow2_cache_flush (bs=bs@entry=0x555556810680, c=<optimized out>) at block/qcow2-cache.c:259
>  #15 0x0000555555ad242c in qcow2_inactivate (bs=bs@entry=0x555556810680) at block/qcow2.c:2124
>  #16 0x0000555555ad2590 in qcow2_close (bs=0x555556810680) at block/qcow2.c:2153
>  #17 0x0000555555ab0c62 in bdrv_close (bs=0x555556810680) at block.c:3358
>  #18 0x0000555555ab0c62 in bdrv_delete (bs=0x555556810680) at block.c:3542
>  #19 0x0000555555ab0c62 in bdrv_unref (bs=0x555556810680) at block.c:4598
>  #20 0x0000555555af4d72 in blk_remove_bs (blk=blk@entry=0x5555568103d0) at block/block-backend.c:785
>  #21 0x0000555555af4dbb in blk_remove_all_bs () at block/block-backend.c:483
>  #22 0x0000555555aae02f in bdrv_close_all () at block.c:3412
>  #23 0x00005555557f9796 in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>) at vl.c:4776
> 
> The reproducer I used is a qcow2 image on gluster volume, where the
> virtual disk size (4 GB) is larger than the gluster volume size (64M),
> so we can easily trigger an ENOSPC. This backend is assigned to a
> virtio-blk device using an iothread, and then from the guest a
> 'dd if=/dev/zero of=/dev/vda bs=1G count=1' causes the VM to stop
> because of an I/O error. qemu_gluster_co_flush_to_disk() sets
> bs->drv = NULL on error, so when virtio-blk stops the dataplane, the
> block nodes stay in the iothread AioContext. A 'quit' monitor command
> issued from this paused state crashes the process.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1631227
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

