Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07D1C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 12:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CEEF20663
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 12:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAMwni+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CEEF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg5tK-0004Hf-Oi
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 08:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jg5sV-0003lC-GI
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 08:18:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34693
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <slp@redhat.com>) id 1jg5sT-0005RK-NR
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 08:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591100324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d/bFIuGdI1QEvC3VTGV+5oSMP7luq7L/W/i2dKwRoHg=;
 b=cAMwni+wx/soe7FfxArZ0LFsN55WRXhntxknk+KRBLVewlMmVh/C6H+/lWXvVyNQTTZrPs
 iFHAjBc/ABJAG2tG/KhY4+CckGpa7w6J8C8j/TnVJYh46Xf4rD4xLrIJtUPJ+fhf2mgkRY
 dOTGpdGsBfyj0CXUZgBtHDuyeUMhDlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-qOeW0imsP92_7412750jVg-1; Tue, 02 Jun 2020 08:18:41 -0400
X-MC-Unique: qOeW0imsP92_7412750jVg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8FF5100CCC0;
 Tue,  2 Jun 2020 12:18:40 +0000 (UTC)
Received: from localhost (ovpn-113-52.rdu2.redhat.com [10.10.113.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E4D1678EF5;
 Tue,  2 Jun 2020 12:18:36 +0000 (UTC)
Date: Tue, 2 Jun 2020 14:18:35 +0200
From: Sergio Lopez <slp@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] virtio-blk: Disable request queuing while switching
 contexts
Message-ID: <20200602121835.kfld5taju25p6njn@dritchie>
References: <20200602081112.32426-1-slp@redhat.com>
 <20200602112314.GF5940@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200602112314.GF5940@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cefo3vhii3xawgg2"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=slp@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 06:26:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--cefo3vhii3xawgg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2020 at 01:23:14PM +0200, Kevin Wolf wrote:
> Am 02.06.2020 um 10:11 hat Sergio Lopez geschrieben:
> > Disable request queuing while switching contexts on
> > virtio_blk_data_plane_[start|stop](), preventing requests from getting
> > queued on the wrong context.
> >
> > Placing requests on the wrong context may lead to them being wrongly
> > accessed in parallel from different threads, potentially leading to
> > multiple issues.
> >
> > For example, stopping and resuming a VM multiple times while the guest
> > is generating I/O on a virtio_blk device can trigger a crash with a
> > stack tracing looking like this one:
> >
> > <------>
> >  Thread 2 (Thread 0x7ff736765700 (LWP 1062503)):
> >  #0  0x00005567a13b99d6 in iov_memset
> >      (iov=0x6563617073206f4e, iov_cnt=1717922848, offset=516096, fillc=0, bytes=7018105756081554803)
> >      at util/iov.c:69
> >  #1  0x00005567a13bab73 in qemu_iovec_memset
> >      (qiov=0x7ff73ec99748, offset=516096, fillc=0, bytes=7018105756081554803) at util/iov.c:530
> >  #2  0x00005567a12f411c in qemu_laio_process_completion (laiocb=0x7ff6512ee6c0) at block/linux-aio.c:86
> >  #3  0x00005567a12f42ff in qemu_laio_process_completions (s=0x7ff7182e8420) at block/linux-aio.c:217
> >  #4  0x00005567a12f480d in ioq_submit (s=0x7ff7182e8420) at block/linux-aio.c:323
> >  #5  0x00005567a12f43d9 in qemu_laio_process_completions_and_submit (s=0x7ff7182e8420)
> >      at block/linux-aio.c:236
> >  #6  0x00005567a12f44c2 in qemu_laio_poll_cb (opaque=0x7ff7182e8430) at block/linux-aio.c:267
> >  #7  0x00005567a13aed83 in run_poll_handlers_once (ctx=0x5567a2b58c70, timeout=0x7ff7367645f8)
> >      at util/aio-posix.c:520
> >  #8  0x00005567a13aee9f in run_poll_handlers (ctx=0x5567a2b58c70, max_ns=16000, timeout=0x7ff7367645f8)
> >      at util/aio-posix.c:562
> >  #9  0x00005567a13aefde in try_poll_mode (ctx=0x5567a2b58c70, timeout=0x7ff7367645f8)
> >      at util/aio-posix.c:597
> >  #10 0x00005567a13af115 in aio_poll (ctx=0x5567a2b58c70, blocking=true) at util/aio-posix.c:639
> >  #11 0x00005567a109acca in iothread_run (opaque=0x5567a2b29760) at iothread.c:75
> >  #12 0x00005567a13b2790 in qemu_thread_start (args=0x5567a2b694c0) at util/qemu-thread-posix.c:519
> >  #13 0x00007ff73eedf2de in start_thread () at /lib64/libpthread.so.0
> >  #14 0x00007ff73ec10e83 in clone () at /lib64/libc.so.6
> >
> >  Thread 1 (Thread 0x7ff743986f00 (LWP 1062500)):
> >  #0  0x00005567a13b99d6 in iov_memset
> >      (iov=0x6563617073206f4e, iov_cnt=1717922848, offset=516096, fillc=0, bytes=7018105756081554803)
> >      at util/iov.c:69
> >  #1  0x00005567a13bab73 in qemu_iovec_memset
> >      (qiov=0x7ff73ec99748, offset=516096, fillc=0, bytes=7018105756081554803) at util/iov.c:530
> >  #2  0x00005567a12f411c in qemu_laio_process_completion (laiocb=0x7ff6512ee6c0) at block/linux-aio.c:86
> >  #3  0x00005567a12f42ff in qemu_laio_process_completions (s=0x7ff7182e8420) at block/linux-aio.c:217
> >  #4  0x00005567a12f480d in ioq_submit (s=0x7ff7182e8420) at block/linux-aio.c:323
> >  #5  0x00005567a12f4a2f in laio_do_submit (fd=19, laiocb=0x7ff5f4ff9ae0, offset=472363008, type=2)
> >      at block/linux-aio.c:375
> >  #6  0x00005567a12f4af2 in laio_co_submit
> >      (bs=0x5567a2b8c460, s=0x7ff7182e8420, fd=19, offset=472363008, qiov=0x7ff5f4ff9ca0, type=2)
> >      at block/linux-aio.c:394
> >  #7  0x00005567a12f1803 in raw_co_prw
> >      (bs=0x5567a2b8c460, offset=472363008, bytes=20480, qiov=0x7ff5f4ff9ca0, type=2)
> >      at block/file-posix.c:1892
> >  #8  0x00005567a12f1941 in raw_co_pwritev
> >      (bs=0x5567a2b8c460, offset=472363008, bytes=20480, qiov=0x7ff5f4ff9ca0, flags=0)
> >      at block/file-posix.c:1925
> >  #9  0x00005567a12fe3e1 in bdrv_driver_pwritev
> >      (bs=0x5567a2b8c460, offset=472363008, bytes=20480, qiov=0x7ff5f4ff9ca0, qiov_offset=0, flags=0)
> >      at block/io.c:1183
> >  #10 0x00005567a1300340 in bdrv_aligned_pwritev
> >      (child=0x5567a2b5b070, req=0x7ff5f4ff9db0, offset=472363008, bytes=20480, align=512, qiov=0x7ff72c0425b8, qiov_offset=0, flags=0) at block/io.c:1980
> >  #11 0x00005567a1300b29 in bdrv_co_pwritev_part
> >      (child=0x5567a2b5b070, offset=472363008, bytes=20480, qiov=0x7ff72c0425b8, qiov_offset=0, flags=0)
> >      at block/io.c:2137
> >  #12 0x00005567a12baba1 in qcow2_co_pwritev_task
> >      (bs=0x5567a2b92740, file_cluster_offset=472317952, offset=487305216, bytes=20480, qiov=0x7ff72c0425b8, qiov_offset=0, l2meta=0x0) at block/qcow2.c:2444
> >  #13 0x00005567a12bacdb in qcow2_co_pwritev_task_entry (task=0x5567a2b48540) at block/qcow2.c:2475
> >  #14 0x00005567a13167d8 in aio_task_co (opaque=0x5567a2b48540) at block/aio_task.c:45
> >  #15 0x00005567a13cf00c in coroutine_trampoline (i0=738245600, i1=32759) at util/coroutine-ucontext.c:115
> >  #16 0x00007ff73eb622e0 in __start_context () at /lib64/libc.so.6
> >  #17 0x00007ff6626f1350 in  ()
> >  #18 0x0000000000000000 in  ()
> > <------>
> >
> > This is also known to cause crashes with this message (assertion
> > failed):
> >
> >  aio_co_schedule: Co-routine was already scheduled in 'aio_co_schedule'
> >
> > RHBZ: https://bugzilla.redhat.com/show_bug.cgi?id=1812765
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> > ---
> >  hw/block/dataplane/virtio-blk.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
> > index 1b52e8159c..f1c7ba69c0 100644
> > --- a/hw/block/dataplane/virtio-blk.c
> > +++ b/hw/block/dataplane/virtio-blk.c
> > @@ -214,12 +214,17 @@ int virtio_blk_data_plane_start(VirtIODevice *vdev)
> >      vblk->dataplane_started = true;
> >      trace_virtio_blk_data_plane_start(s);
> >
> > +    /* Prevent requests from getting queued on the old context */
> > +    blk_set_disable_request_queuing(s->conf->conf.blk, true);
> > +
> >      r = blk_set_aio_context(s->conf->conf.blk, s->ctx, &local_err);
> >      if (r < 0) {
> >          error_report_err(local_err);
> >          goto fail_guest_notifiers;
> >      }
> >
> > +    blk_set_disable_request_queuing(s->conf->conf.blk, false);
> > +
>
> Why are we even getting new requests that could possibly be queued? This
> is in virtio_blk_data_plane_start/stop(), so clearly the device should
> be idle and the virtio queues shouldn't be processed at all at the same
> time?

Requests are processed and queued by virtio_blk_dma_restart_bh(),
which is a BH registered by virtio_blk_dma_restart_cb(), which in turn
is a callback for VM state change events registered with
qemu_add_vm_change_state_handler(virtio_blk_dma_restart_cb, s).

This is the back trace of a request being queued this way:

(gdb) bt
#0  0x000055cd35ce7490 in virtio_blk_submit_multireq (blk=0x55cd38cd24d0, mrb=0x7ffd25b365c0)
    at /root/src/qemu/hw/block/virtio-blk.c:448
#1  0x000055cd35ce7d5f in virtio_blk_handle_request (req=0x7f5a4c022c80, mrb=0x7ffd25b365c0)
    at /root/src/qemu/hw/block/virtio-blk.c:686
#2  0x000055cd35ce8602 in virtio_blk_dma_restart_bh (opaque=0x55cd38ccf4c0)
    at /root/src/qemu/hw/block/virtio-blk.c:836
#3  0x000055cd360dc4f5 in aio_bh_call (bh=0x55cd3880b300) at /root/src/qemu/util/async.c:164
#4  0x000055cd360dc4f5 in aio_bh_poll (ctx=ctx@entry=0x55cd3780bff0) at /root/src/qemu/util/async.c:164
#5  0x000055cd360dfd29 in aio_poll (ctx=ctx@entry=0x55cd3780bff0, blocking=blocking@entry=true)
    at /root/src/qemu/util/aio-posix.c:650
#6  0x000055cd3603a645 in bdrv_do_drained_begin
    (poll=true, ignore_bds_parents=false, parent=0x0, recursive=false, bs=0x55cd3788d550)
    at /root/src/qemu/block/io.c:429
#7  0x000055cd3603a645 in bdrv_do_drained_begin
    (bs=0x55cd3788d550, recursive=<optimized out>, parent=0x0, ignore_bds_parents=<optimized out>, poll=<optimized out>) at /root/src/qemu/block/io.c:395
#8  0x000055cd35fde969 in bdrv_set_aio_context_ignore
    (bs=bs@entry=0x55cd3788d550, new_context=new_context@entry=0x55cd37810e40, ignore=ignore@entry=0x7ffd25b36890) at /root/src/qemu/block.c:6309
#9  0x000055cd35fdef33 in bdrv_child_try_set_aio_context
    (bs=bs@entry=0x55cd3788d550, ctx=0x55cd37810e40, ignore_child=<optimized out>, errp=<optimized out>)
    at /root/src/qemu/block.c:6431
#10 0x000055cd3602919b in blk_do_set_aio_context
    (blk=0x55cd38cd24d0, new_context=0x55cd37810e40, update_root_node=<optimized out>, errp=<optimized out>) at /root/src/qemu/block/block-backend.c:2016
#11 0x000055cd35cef54f in virtio_blk_data_plane_start (vdev=<optimized out>)
    at /root/src/qemu/hw/block/dataplane/virtio-blk.c:220
#12 0x000055cd35f48cd2 in virtio_bus_start_ioeventfd (bus=0x55cd38ccf438)
    at /root/src/qemu/hw/virtio/virtio-bus.c:222
#13 0x000055cd35d6ea1f in vm_state_notify (running=running@entry=1, state=state@entry=RUN_STATE_RUNNING)
    at /root/src/qemu/softmmu/vl.c:1271
#14 0x000055cd35ca931d in vm_prepare_start () at /root/src/qemu/cpus.c:2156
#15 0x000055cd35ca9369 in vm_start () at /root/src/qemu/cpus.c:2162
#16 0x000055cd35f7a265 in qmp_cont (errp=errp@entry=0x7ffd25b36a60)
    at /root/src/qemu/monitor/qmp-cmds.c:160
#17 0x000055cd35f7d704 in hmp_cont (mon=<optimized out>, qdict=<optimized out>)
    at /root/src/qemu/monitor/hmp-cmds.c:1050
#18 0x000055cd35f79c54 in handle_hmp_command (mon=mon@entry=0x55cd37813160, cmdline=<optimized out>,
    cmdline@entry=0x55cd3790cfe0 "c") at /root/src/qemu/monitor/hmp.c:1082
#19 0x000055cd35f79d7c in monitor_command_cb
    (opaque=0x55cd37813160, cmdline=0x55cd3790cfe0 "c", readline_opaque=<optimized out>)
    at /root/src/qemu/monitor/hmp.c:47
#20 0x000055cd360f46b5 in readline_handle_byte (rs=0x55cd3790cfe0, ch=<optimized out>)
    at /root/src/qemu/util/readline.c:408
#21 0x000055cd35f79de3 in monitor_read (opaque=0x55cd37813160, buf=<optimized out>, size=<optimized out>)
    at /root/src/qemu/monitor/hmp.c:1312
#22 0x000055cd3607050d in fd_chr_read (chan=0x55cd378143a0, cond=<optimized out>, opaque=<optimized out>)
    at /root/src/qemu/chardev/char-fd.c:68
#23 0x00007f5a70d1667d in g_main_context_dispatch () at /lib64/libglib-2.0.so.0
#24 0x000055cd360dee58 in glib_pollfds_poll () at /root/src/qemu/util/main-loop.c:219
#25 0x000055cd360dee58 in os_host_main_loop_wait (timeout=<optimized out>)
    at /root/src/qemu/util/main-loop.c:242
#26 0x000055cd360dee58 in main_loop_wait (nonblocking=nonblocking@entry=0)
    at /root/src/qemu/util/main-loop.c:518
#27 0x000055cd35d6f1b9 in qemu_main_loop () at /root/src/qemu/softmmu/vl.c:1664
#28 0x000055cd35c6205e in main (argc=<optimized out>, argv=<optimized out>, envp=<optimized out>)
    at /root/src/qemu/softmmu/main.c:49

I'm not familiar with the code, but I guess we need this BH to ensure
we process the virtqueue after resuming. We could perhaps schedule the
BH in a different way, or add a flag to VirtIOBlock so
virtio_blk_data_plane_[start|stop] would instruct
virtio_blk_dma_restart_bh() to avoid processing the virtqueue,
rescheduling itself instead. How does this would look to you?

Thanks,
Sergio.

> blk_set_disable_request_queuing() feels more like a hack that hides the
> bug instead of fixing it.
>
> Kevin
>

--cefo3vhii3xawgg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl7WQ5oACgkQ9GknjS8M
AjX8qhAAiGyE3Loqr04yhZbh4qulqFJQElAN+2Je7uCkbd3lXkjfmlC1YOw12KQQ
VrQJQW3EH2YvNZ61W/XAdYfYelcgmw3ZuF4rFGGTKdY+28cQymFbK0ek9hU1SStJ
04pd/NXEiAdWTXbylQJWiEgs8LWiXxLLYeyu99VY7SI0iO4q20qiYU9fdhK0FwtP
8tIBhCE+QitnjMaQ+Q1Llji+fP2oCqOT31yCOeqBZB+1fOdj5f5b8rtvmnSY3upS
h2cv6ZiK2x5exAfi3WxtiGkS7gG17hLP6lJr17sl5gVXos/Rb70JWMuCSW1V5zOa
PJnpxMJkBtwCDCO9Rk/uY5VDpulKKpjn/5Z+C/Wur4rBwxqF8n6tJXqd7mTT3Sds
//Hm0e+3LU5HBmQiJc+OJlUnFpLyifvz2UP9YsrGE7Nqe30lHc5WPiZA+TD/PRmH
Sq6+3pGbUVzhPkh3J1LnZG9hpxiV+dPI5z4FE3BSmRf/917Qcpn+yFDNoeKKu2bd
FCcQz2HiC6iPhwe3QP3yP3r4DiMk4hfAbBpm/viY961mVVJksFsAkvSJ22f4L1t9
+ubt0foWlHQxESOZj0ryupEFYjrLP+i3oyo1JyS0rtb52bKut4rNH71Qk642l0Kd
ttoQSrSVv3j4ER5cI1QN5D9d1b9zwRugT14dAVU8UjDJVm4YIVU=
=I9KV
-----END PGP SIGNATURE-----

--cefo3vhii3xawgg2--


