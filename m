Received: from eggs.gnu.org ([2001:4830:134:3::10]:49088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqEey-0003FP-QH
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:56:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqEev-0007Zu-Lk
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:56:52 -0400
Received: from [59.151.112.132] (port=46714 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cqEeu-0007Wy-Od
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:56:49 -0400
References: <201703211527487634282@zte.com.cn>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <41554edc-09a8-1c12-84d3-1aa2b090a4d2@cn.fujitsu.com>
Date: Tue, 21 Mar 2017 15:55:58 +0800
MIME-Version: 1.0
In-Reply-To: <201703211527487634282@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBSZTogIFtCVUddQ09MTyBmYWlsb3Zl?=
 =?utf-8?q?r_hang?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.guang55@zte.com.cn, zhang.zhanghailiang@huawei.com
Cc: zhangchen.fnst@cn.fujitsu.com, qemu-devel@nongnu.org

Hi,Wang.

You can test this branch:

https://github.com/coloft/qemu/tree/colo-v5.1-developing-COLO-frame-v21-with-shared-disk

and please follow wiki ensure your own configuration correctly.

http://wiki.qemu-project.org/Features/COLO


Thanks

Zhang Chen


On 03/21/2017 03:27 PM, wang.guang55@zte.com.cn wrote:
>
> hi.
>
> I test the git qemu master have the same problem.
>
> (gdb) bt
>
> #0  qio_channel_socket_readv (ioc=0x7f65911b4e50, iov=0x7f64ef3fd880, 
> niov=1, fds=0x0, nfds=0x0, errp=0x0) at io/channel-socket.c:461
>
> #1  0x00007f658e4aa0c2 in qio_channel_read 
> (ioc=ioc@entry=0x7f65911b4e50, buf=buf@entry=0x7f65907cb838 "", 
> buflen=buflen@entry=32768, errp=errp@entry=0x0) at io/channel.c:114
>
> #2  0x00007f658e3ea990 in channel_get_buffer (opaque=＜optimized out＞, 
> buf=0x7f65907cb838 "", pos=＜optimized out＞, size=32768) at 
> migration/qemu-file-channel.c:78
>
> #3  0x00007f658e3e97fc in qemu_fill_buffer (f=0x7f65907cb800) at 
> migration/qemu-file.c:295
>
> #4  0x00007f658e3ea2e1 in qemu_peek_byte (f=f@entry=0x7f65907cb800, 
> offset=offset@entry=0) at migration/qemu-file.c:555
>
> #5  0x00007f658e3ea34b in qemu_get_byte (f=f@entry=0x7f65907cb800) at 
> migration/qemu-file.c:568
>
> #6  0x00007f658e3ea552 in qemu_get_be32 (f=f@entry=0x7f65907cb800) at 
> migration/qemu-file.c:648
>
> #7  0x00007f658e3e66e5 in colo_receive_message (f=0x7f65907cb800, 
> errp=errp@entry=0x7f64ef3fd9b0) at migration/colo.c:244
>
> #8  0x00007f658e3e681e in colo_receive_check_message (f=＜optimized 
> out＞, expect_msg=expect_msg@entry=COLO_MESSAGE_VMSTATE_SEND, 
> errp=errp@entry=0x7f64ef3fda08)
>
>     at migration/colo.c:264
>
> #9  0x00007f658e3e740e in colo_process_incoming_thread 
> (opaque=0x7f658eb30360 ＜mis_current.31286＞) at migration/colo.c:577
>
> #10 0x00007f658be09df3 in start_thread () from /lib64/libpthread.so.0
>
> #11 0x00007f65881983ed in clone () from /lib64/libc.so.6
>
> (gdb) p ioc-＞name
>
> $2 = 0x7f658ff7d5c0 "migration-socket-incoming"
>
> (gdb) p ioc-＞features        Do not support QIO_CHANNEL_FEATURE_SHUTDOWN
>
> $3 = 0
>
>
> (gdb) bt
>
> #0  socket_accept_incoming_migration (ioc=0x7fdcceeafa90, 
> condition=G_IO_IN, opaque=0x7fdcceeafa90) at migration/socket.c:137
>
> #1  0x00007fdcc6966350 in g_main_dispatch (context=＜optimized out＞) at 
> gmain.c:3054
>
> #2  g_main_context_dispatch (context=＜optimized out＞, 
> context@entry=0x7fdccce9f590) at gmain.c:3630
>
> #3  0x00007fdccb8a6dcc in glib_pollfds_poll () at util/main-loop.c:213
>
> #4  os_host_main_loop_wait (timeout=＜optimized out＞) at 
> util/main-loop.c:258
>
> #5  main_loop_wait (nonblocking=nonblocking@entry=0) at 
> util/main-loop.c:506
>
> #6  0x00007fdccb526187 in main_loop () at vl.c:1898
>
> #7  main (argc=＜optimized out＞, argv=＜optimized out＞, envp=＜optimized 
> out＞) at vl.c:4709
>
> (gdb) p ioc-＞features
>
> $1 = 6
>
> (gdb) p ioc-＞name
>
> $2 = 0x7fdcce1b1ab0 "migration-socket-listener"
>
>
> May be socket_accept_incoming_migration should 
> call qio_channel_set_feature(ioc, QIO_CHANNEL_FEATURE_SHUTDOWN)??
>
>
> thank you.
>
>
>
>
>
> 原始邮件
> *发件人：*＜zhangchen.fnst@cn.fujitsu.com＞;
> *收件人：*王广10165992;＜qemu-devel@nongnu.org＞;
> *抄送人：*＜zhangchen.fnst@cn.fujitsu.com＞;＜zhang.zhanghailiang@huawei.com＞;
> *日 期 ：*2017年03月16日 14:46
> *主 题 ：**Re: [Qemu-devel] COLO failover hang*
>
>
>
>
> On 03/15/2017 05:06 PM, wangguang wrote:
> ＞   am testing QEMU COLO feature described here [QEMU
> ＞ Wiki](http://wiki.qemu-project.org/Features/COLO).
> ＞
> ＞ When the Primary Node panic,the Secondary Node qemu hang.
> ＞ hang at recvmsg in qio_channel_socket_readv.
> ＞ And  I run  { 'execute': 'nbd-server-stop' } and { "execute":
> ＞ "x-colo-lost-heartbeat" } in Secondary VM's
> ＞ monitor,the  Secondary Node qemu still hang at recvmsg .
> ＞
> ＞ I found that the colo in qemu is not complete yet.
> ＞ Do the colo have any plan for development?
>
> Yes, We are developing. You can see some of patch we pushing.
>
> ＞ Has anyone ever run it successfully? Any help is appreciated!
>
> In our internal version can run it successfully,
> The failover detail you can ask Zhanghailiang for help.
> Next time if you have some question about COLO,
> please cc me and zhanghailiang ＜zhang.zhanghailiang@huawei.com＞.
>
>
> Thanks
> Zhang Chen
>
>
> ＞
> ＞
> ＞
> ＞ centos7.2+qemu2.7.50
> ＞ (gdb) bt
> ＞ #0  0x00007f3e00cc86ad in recvmsg () from /lib64/libpthread.so.0
> ＞ #1  0x00007f3e0332b738 in qio_channel_socket_readv (ioc=＜optimized out＞,
> ＞ iov=＜optimized out＞, niov=＜optimized out＞, fds=0x0, nfds=0x0, errp=0x0) at
> ＞ io/channel-socket.c:497
> ＞ #2  0x00007f3e03329472 in qio_channel_read (ioc=ioc@entry=0x7f3e05110e40,
> ＞ buf=buf@entry=0x7f3e05910f38 "", buflen=buflen@entry=32768,
> ＞ errp=errp@entry=0x0) at io/channel.c:97
> ＞ #3  0x00007f3e032750e0 in channel_get_buffer (opaque=＜optimized out＞,
> ＞ buf=0x7f3e05910f38 "", pos=＜optimized out＞, size=32768) at
> ＞ migration/qemu-file-channel.c:78
> ＞ #4  0x00007f3e0327412c in qemu_fill_buffer (f=0x7f3e05910f00) at
> ＞ migration/qemu-file.c:257
> ＞ #5  0x00007f3e03274a41 in qemu_peek_byte (f=f@entry=0x7f3e05910f00,
> ＞ offset=offset@entry=0) at migration/qemu-file.c:510
> ＞ #6  0x00007f3e03274aab in qemu_get_byte (f=f@entry=0x7f3e05910f00) at
> ＞ migration/qemu-file.c:523
> ＞ #7  0x00007f3e03274cb2 in qemu_get_be32 (f=f@entry=0x7f3e05910f00) at
> ＞ migration/qemu-file.c:603
> ＞ #8  0x00007f3e03271735 in colo_receive_message (f=0x7f3e05910f00,
> ＞ errp=errp@entry=0x7f3d62bfaa50) at migration/colo.c:215
> ＞ #9  0x00007f3e0327250d in colo_wait_handle_message (errp=0x7f3d62bfaa48,
> ＞ checkpoint_request=＜synthetic pointer＞, f=＜optimized out＞) at
> ＞ migration/colo.c:546
> ＞ #10 colo_process_incoming_thread (opaque=0x7f3e067245e0) at
> ＞ migration/colo.c:649
> ＞ #11 0x00007f3e00cc1df3 in start_thread () from /lib64/libpthread.so.0
> ＞ #12 0x00007f3dfc9c03ed in clone () from /lib64/libc.so.6
> ＞
> ＞
> ＞
> ＞
> ＞
> ＞ --
> ＞ View this message in context: http://qemu.11.n7.nabble.com/COLO-failover-hang-tp473250.html
> ＞ Sent from the Developer mailing list archive at Nabble.com.
> ＞
> ＞
> ＞
> ＞
>
> -- 
> Thanks
> Zhang Chen
>
>
>
>
>

-- 
Thanks
Zhang Chen
