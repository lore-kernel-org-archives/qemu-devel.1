Received: from eggs.gnu.org ([209.51.188.92]:36049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shirley17fei@gmail.com>) id 1gjdAg-0004Zx-E0
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shirley17fei@gmail.com>) id 1gjdAX-0000m6-VU
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:51:18 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
	id 1gjdAL-0000cA-L6
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 23:51:01 -0500
Received: by mail-pg1-x542.google.com with SMTP id j10so2249139pga.1
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 20:51:00 -0800 (PST)
References: <20190113140849.38339-1-lifei1214@126.com>
From: Fei Li <shirley17fei@gmail.com>
Message-ID: <6aa36ba5-1784-b927-b75f-b56ec8d96d4c@gmail.com>
Date: Wed, 16 Jan 2019 12:50:56 +0800
MIME-Version: 1.0
In-Reply-To: <20190113140849.38339-1-lifei1214@126.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/5] fix some segmentation faults
 and migration issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fei Li <lifei1214@126.com>, qemu-devel@nongnu.org

Hi all,

Kindly ping. :)

As my v10 of qemu_thread_create partly rely on this patch series, I'd 
like to know
when will these 5 patches be merged, or I join them with v10 of 
qemu_thread_create
and send together. Could anyone shed light on me? Thanks for the advice 
in advance.


Have a nice day
Fei
在 2019/1/13 下午10:08, Fei Li 写道:
> All these five patches have gotten the Reviewed-by: the first patch
> is to fix one segmentation fault and the other four are to fix some
> migration issues.
>
> To be more detail, they are extracted from previous
> "[PATCH for-4.0 v9 16/16] qemu_thread_create: propagate errors to
> callers to handle.", but actually these five patches are derivative
> and not relevant to the mentioned qemu_thread_create patch series.
> Thus send them separately to make them be merged earlier.
>
> Fei Li (5):
>    Fix segmentation fault when qemu_signal_init fails
>    migration: fix the multifd code when receiving less channels
>    migration: multifd_save_cleanup() can't fail, simplify
>    migration: add more error handling for postcopy_ram_enable_notify
>    migration: unify error handling for process_incoming_migration_co
>
>   migration/channel.c      | 11 ++++++-----
>   migration/migration.c    | 40 +++++++++++++++++++++-------------------
>   migration/migration.h    |  2 +-
>   migration/postcopy-ram.c |  1 +
>   migration/ram.c          | 28 ++++++++++++++++++----------
>   migration/ram.h          |  4 ++--
>   migration/savevm.c       |  1 +
>   util/main-loop.c         |  8 ++++----
>   8 files changed, 54 insertions(+), 41 deletions(-)
>
