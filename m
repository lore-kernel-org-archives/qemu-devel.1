Received: from eggs.gnu.org ([2001:4830:134:3::10]:36707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL2Y7-00069V-Hz
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL2Y4-00017p-Cd
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:17:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dL2Y4-00017e-41
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 03:17:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9DA6C0467C6
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:17:02 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170614063914.GI11751@pxdev.xzpeter.org> (Peter Xu's message of
	"Wed, 14 Jun 2017 14:39:14 +0800")
References: <20170613095251.11493-1-quintela@redhat.com>
	<20170613095251.11493-2-quintela@redhat.com>
	<20170614063914.GI11751@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Wed, 14 Jun 2017 09:16:59 +0200
Message-ID: <87wp8ff384.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] migration: Remove unneeded includes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, lvivier@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Tue, Jun 13, 2017 at 11:52:51AM +0200, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/colo.h  | 3 ---
>>  include/migration/misc.h  | 2 ++
>>  migration/block.c         | 6 ------
>>  migration/colo-failover.c | 2 ++
>>  migration/colo.c          | 2 --
>>  migration/exec.c          | 2 --
>>  migration/fd.c            | 2 --
>>  migration/global_state.c  | 1 -
>>  migration/migration.c     | 6 ------
>>  migration/migration.h     | 2 --
>>  migration/postcopy-ram.c  | 4 +---
>>  migration/qemu-file.c     | 2 --
>>  migration/ram.c           | 4 ----
>>  migration/savevm.c        | 6 ------
>>  14 files changed, 5 insertions(+), 39 deletions(-)
>> 
>> diff --git a/include/migration/colo.h b/include/migration/colo.h
>> index ba0bb6e..be6beba 100644
>> --- a/include/migration/colo.h
>> +++ b/include/migration/colo.h
>> @@ -14,9 +14,6 @@
>>  #define QEMU_COLO_H
>>  
>>  #include "qemu-common.h"
>> -#include "qemu/coroutine_int.h"
>> -#include "qemu/thread.h"
>> -#include "qemu/main-loop.h"
>>  
>>  bool colo_supported(void);
>>  void colo_info_init(void);
>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>> index d5a433a..65c7070 100644
>> --- a/include/migration/misc.h
>> +++ b/include/migration/misc.h
>> @@ -14,6 +14,8 @@
>>  #ifndef MIGRATION_MISC_H
>>  #define MIGRATION_MISC_H
>>  
>> +#include "qemu/notify.h"
>> +
>
> Since we added this new line (I believe it's for Notifier), do we need
> to include "qemu/typedefs.h" as well? Since I see Error and
> MigrationState is used as well.

It compiles, so it should be perfect O:-)

>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>> index c8c4500..922702b 100644
>> --- a/migration/postcopy-ram.c
>> +++ b/migration/postcopy-ram.c
>> @@ -17,14 +17,12 @@
>>   */
>>  
>>  #include "qemu/osdep.h"
>> -
>> -#include "qemu-common.h"
>>  #include "exec/target_page.h"
>>  #include "migration.h"
>>  #include "qemu-file.h"
>> -#include "savevm.h"
>>  #include "postcopy-ram.h"
>>  #include "ram.h"
>> +#include "savevm.h"
>
> Just curious about whether there's any specific reason to move this
> line from above to here?
>
> Besides the nits:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Rebases O:-)


Thanks, Juan.
