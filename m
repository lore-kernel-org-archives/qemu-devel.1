Received: from eggs.gnu.org ([2001:4830:134:3::10]:36769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQ2X-0002qg-Rd
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsQ2S-0004Bd-3Q
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:07:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38914 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsQ2Q-00049Q-HB
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 06:06:54 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1533562177-16447-6-git-send-email-lidongchen@tencent.com>
	(Lidong Chen's message of "Mon, 6 Aug 2018 21:29:31 +0800")
References: <1533562177-16447-1-git-send-email-lidongchen@tencent.com>
	<1533562177-16447-6-git-send-email-lidongchen@tencent.com>
Reply-To: quintela@redhat.com
Date: Wed, 22 Aug 2018 12:06:45 +0200
Message-ID: <87k1oi67gq.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 05/11] migration: implement
 io_set_aio_fd_handler function for RDMA QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <jemmy858585@gmail.com>
Cc: zhang.zhanghailiang@huawei.com, dgilbert@redhat.com, qemu-devel@nongnu.org, Lidong Chen <lidongchen@tencent.com>

Lidong Chen <jemmy858585@gmail.com> wrote:
> From: Lidong Chen <jemmy858585@gmail.com>
>
> if qio_channel_rdma_readv return QIO_CHANNEL_ERR_BLOCK, the destination qemu
> crash.
>
> The backtrace is:
> (gdb) bt
>     #0  0x0000000000000000 in ?? ()
>     #1  0x00000000008db50e in qio_channel_set_aio_fd_handler (ioc=0x38111e0, ctx=0x3726080,
>         io_read=0x8db841 <qio_channel_restart_read>, io_write=0x0, opaque=0x38111e0) at io/channel.c:
>     #2  0x00000000008db952 in qio_channel_set_aio_fd_handlers (ioc=0x38111e0) at io/channel.c:438
>     #3  0x00000000008dbab4 in qio_channel_yield (ioc=0x38111e0, condition=G_IO_IN) at io/channel.c:47
>     #4  0x00000000007a870b in channel_get_buffer (opaque=0x38111e0, buf=0x440c038 "", pos=0, size=327
>         at migration/qemu-file-channel.c:83
>     #5  0x00000000007a70f6 in qemu_fill_buffer (f=0x440c000) at migration/qemu-file.c:299
>     #6  0x00000000007a79d0 in qemu_peek_byte (f=0x440c000, offset=0) at migration/qemu-file.c:562
>     #7  0x00000000007a7a22 in qemu_get_byte (f=0x440c000) at migration/qemu-file.c:575
>     #8  0x00000000007a7c78 in qemu_get_be32 (f=0x440c000) at migration/qemu-file.c:655
>     #9  0x00000000007a0508 in qemu_loadvm_state (f=0x440c000) at migration/savevm.c:2126
>     #10 0x0000000000794141 in process_incoming_migration_co (opaque=0x0) at migration/migration.c:366
>     #11 0x000000000095c598 in coroutine_trampoline (i0=84033984, i1=0) at util/coroutine-ucontext.c:1
>     #12 0x00007f9c0db56d40 in ?? () from /lib64/libc.so.6
>     #13 0x00007f96fe858760 in ?? ()
>     #14 0x0000000000000000 in ?? ()
>
> RDMA QIOChannel not implement io_set_aio_fd_handler. so
> qio_channel_set_aio_fd_handler will access NULL pointer.
>
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
