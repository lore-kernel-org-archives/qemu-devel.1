Received: from eggs.gnu.org ([2001:4830:134:3::10]:60591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coPA4-0003gv-8W
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coPA0-0005er-7U
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:45:24 -0400
Received: from [59.151.112.132] (port=34236 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1coP9y-0005br-Tq
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 02:45:20 -0400
References: <1489568779098-473250.post@n7.nabble.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <81e6cb47-e97d-754d-6b0f-e6d4a651ccae@cn.fujitsu.com>
Date: Thu, 16 Mar 2017 14:44:33 +0800
MIME-Version: 1.0
In-Reply-To: <1489568779098-473250.post@n7.nabble.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] COLO failover hang
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wangguang <wang.guang55@zte.com.cn>, qemu-devel@nongnu.org
Cc: zhangchen.fnst@cn.fujitsu.com, zhanghailiang <zhang.zhanghailiang@huawei.com>



On 03/15/2017 05:06 PM, wangguang wrote:
>   am testing QEMU COLO feature described here [QEMU
> Wiki](http://wiki.qemu-project.org/Features/COLO).
>
> When the Primary Node panic,the Secondary Node qemu hang.
> hang at recvmsg in qio_channel_socket_readv.
> And  I run  { 'execute': 'nbd-server-stop' } and { "execute":
> "x-colo-lost-heartbeat" } in Secondary VM's
> monitor,the  Secondary Node qemu still hang at recvmsg .
>
> I found that the colo in qemu is not complete yet.
> Do the colo have any plan for development?

Yes, We are developing. You can see some of patch we pushing.

> Has anyone ever run it successfully? Any help is appreciated!

In our internal version can run it successfully,
The failover detail you can ask Zhanghailiang for help.
Next time if you have some question about COLO,
please cc me and zhanghailiang <zhang.zhanghailiang@huawei.com>.


Thanks
Zhang Chen


>
>
>
> centos7.2+qemu2.7.50
> (gdb) bt
> #0  0x00007f3e00cc86ad in recvmsg () from /lib64/libpthread.so.0
> #1  0x00007f3e0332b738 in qio_channel_socket_readv (ioc=<optimized out>,
> iov=<optimized out>, niov=<optimized out>, fds=0x0, nfds=0x0, errp=0x0) at
> io/channel-socket.c:497
> #2  0x00007f3e03329472 in qio_channel_read (ioc=ioc@entry=0x7f3e05110e40,
> buf=buf@entry=0x7f3e05910f38 "", buflen=buflen@entry=32768,
> errp=errp@entry=0x0) at io/channel.c:97
> #3  0x00007f3e032750e0 in channel_get_buffer (opaque=<optimized out>,
> buf=0x7f3e05910f38 "", pos=<optimized out>, size=32768) at
> migration/qemu-file-channel.c:78
> #4  0x00007f3e0327412c in qemu_fill_buffer (f=0x7f3e05910f00) at
> migration/qemu-file.c:257
> #5  0x00007f3e03274a41 in qemu_peek_byte (f=f@entry=0x7f3e05910f00,
> offset=offset@entry=0) at migration/qemu-file.c:510
> #6  0x00007f3e03274aab in qemu_get_byte (f=f@entry=0x7f3e05910f00) at
> migration/qemu-file.c:523
> #7  0x00007f3e03274cb2 in qemu_get_be32 (f=f@entry=0x7f3e05910f00) at
> migration/qemu-file.c:603
> #8  0x00007f3e03271735 in colo_receive_message (f=0x7f3e05910f00,
> errp=errp@entry=0x7f3d62bfaa50) at migration/colo.c:215
> #9  0x00007f3e0327250d in colo_wait_handle_message (errp=0x7f3d62bfaa48,
> checkpoint_request=<synthetic pointer>, f=<optimized out>) at
> migration/colo.c:546
> #10 colo_process_incoming_thread (opaque=0x7f3e067245e0) at
> migration/colo.c:649
> #11 0x00007f3e00cc1df3 in start_thread () from /lib64/libpthread.so.0
> #12 0x00007f3dfc9c03ed in clone () from /lib64/libc.so.6
>
>
>
>
>
> --
> View this message in context: http://qemu.11.n7.nabble.com/COLO-failover-hang-tp473250.html
> Sent from the Developer mailing list archive at Nabble.com.
>
>
>
>

-- 
Thanks
Zhang Chen
