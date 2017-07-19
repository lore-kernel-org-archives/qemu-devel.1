Received: from eggs.gnu.org ([2001:4830:134:3::10]:45035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dXlP5-0000Jv-BR
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <batmanustc@gmail.com>) id 1dXlP4-0003bq-Hh
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 05:36:23 -0400
MIME-Version: 1.0
From: Sam <batmanustc@gmail.com>
Date: Wed, 19 Jul 2017 17:36:19 +0800
Message-ID: <CAOE=1Z1=g_Yqf40AESGueg9SKU1fiC+H6vKFBHFNMJ9zrbVZjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] [qemu-trace] how to add trace easily?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-discuss@nongnu.org

Hi all,

I'm debugging qemu start up process, I want to add a log in 'io_mem_init'
function in exce.c as bellow:

> static void io_mem_init(void)
> {
>     ADD_LOG_HERE_TO_RECORD_TIME();
>     memory_region_init_io(&io_mem_rom, NULL, &unassigned_mem_ops, NULL,
> NULL, UINT64_MAX);
>     memory_region_init_io(&io_mem_unassigned, NULL, &unassigned_mem_ops,
> NULL,
>                           NULL, UINT64_MAX);
>     memory_region_init_io(&io_mem_notdirty, NULL, &notdirty_mem_ops, NULL,
>                           NULL, UINT64_MAX);
>     memory_region_init_io(&io_mem_watch, NULL, &watch_mem_ops, NULL,
>                           NULL, UINT64_MAX);
>     ADD_LOG_HERE_TO_RECORD_TIME();
> }


I found I could use trace in qemu, but I don't know how to code, so I just
add "io_mem_init" into events file, which could not work.

And I found some one's log is like this:

> jma io_mem_init begin                     -- Tue Jul 18 07:47:59 2017
> jma io_mem_init end                        -- Tue Jul 18 07:47:59 2017
> jma qio_channel_socket_new begin -- Tue Jul 18 07:47:59 2017
> jma qio_channel_socket_new end    -- Tue Jul 18 07:47:59 2017
> jma qio_channel_socket_new begin -- Tue Jul 18 07:48:07 2017
> jma qio_channel_socket_new end    -- Tue Jul 18 07:48:07 2017


I don't know how could he do this easily? So how could I do to log
"ADD_LOG_HERE_TO_RECORD_TIME"? Thank you~
