Received: from eggs.gnu.org ([209.51.188.92]:55372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjmYe-0005vq-Ha
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjmYd-0000hW-J7
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:52:44 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjmYd-0000aT-CP
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:52:43 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so7225406wrx.9
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 06:52:42 -0800 (PST)
References: <20190113140849.38339-1-lifei1214@126.com>
	<6aa36ba5-1784-b927-b75f-b56ec8d96d4c@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <c32370f9-41c0-49a2-920f-e7cc984237cd@redhat.com>
Date: Wed, 16 Jan 2019 15:52:39 +0100
MIME-Version: 1.0
In-Reply-To: <6aa36ba5-1784-b927-b75f-b56ec8d96d4c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Fei Li <shirley17fei@gmail.com>, Fei Li <lifei1214@126.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

On 1/16/19 5:50 AM, Fei Li wrote:
> Hi all,
> 
> Kindly ping. :)
> 
> As my v10 of qemu_thread_create partly rely on this patch series, I'd
> like to know
> when will these 5 patches be merged, or I join them with v10 of
> qemu_thread_create
> and send together. Could anyone shed light on me? Thanks for the advice
> in advance.

This series would get merged quicker if you include the maintainers :)

$ ./scripts/get_maintainer.pl -f migration/*
Juan Quintela <quintela@redhat.com> (maintainer:Migration)
"Dr. David Alan Gilbert" <dgilbert@redhat.com> (maintainer:Migration)

Doing that for you by responding to this mail.

Regards,

Phil.

> 
> 
> Have a nice day
> Fei
> 在 2019/1/13 下午10:08, Fei Li 写道:
>> All these five patches have gotten the Reviewed-by: the first patch
>> is to fix one segmentation fault and the other four are to fix some
>> migration issues.
>>
>> To be more detail, they are extracted from previous
>> "[PATCH for-4.0 v9 16/16] qemu_thread_create: propagate errors to
>> callers to handle.", but actually these five patches are derivative
>> and not relevant to the mentioned qemu_thread_create patch series.
>> Thus send them separately to make them be merged earlier.
>>
>> Fei Li (5):
>>    Fix segmentation fault when qemu_signal_init fails
>>    migration: fix the multifd code when receiving less channels
>>    migration: multifd_save_cleanup() can't fail, simplify
>>    migration: add more error handling for postcopy_ram_enable_notify
>>    migration: unify error handling for process_incoming_migration_co
>>
>>   migration/channel.c      | 11 ++++++-----
>>   migration/migration.c    | 40 +++++++++++++++++++++-------------------
>>   migration/migration.h    |  2 +-
>>   migration/postcopy-ram.c |  1 +
>>   migration/ram.c          | 28 ++++++++++++++++++----------
>>   migration/ram.h          |  4 ++--
>>   migration/savevm.c       |  1 +
>>   util/main-loop.c         |  8 ++++----
>>   8 files changed, 54 insertions(+), 41 deletions(-)
>>
> 
