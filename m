Received: from eggs.gnu.org ([2001:4830:134:3::10]:59237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6CTp-000318-Fo
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d6CTm-00047p-E4
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:51:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60334)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d6CTm-00047R-7u
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:51:18 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170428165522.GG3276@work-vm> (David Alan Gilbert's message of
	"Fri, 28 Apr 2017 17:55:22 +0100")
References: <20170425103049.4073-1-quintela@redhat.com>
	<20170425103049.4073-3-quintela@redhat.com>
	<20170428165522.GG3276@work-vm>
Reply-To: quintela@redhat.com
Date: Thu, 04 May 2017 10:51:13 +0200
Message-ID: <87vapht37i.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, zhang.zhanghailiang@huawei.com

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We have change in the previous patch to use migration capabilities for
>> it.  Notice that we continue using the old command line flags from
>> migrate command from the time being.  Remove the set_params method as
>> now it is empty.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/migration.h |  3 +--
>>  migration/block.c             | 17 ++---------------
>>  migration/colo.c              |  3 ---
>>  migration/migration.c         |  8 +++++---
>>  migration/savevm.c            |  2 --
>>  5 files changed, 8 insertions(+), 25 deletions(-)
>> 
>> diff --git a/migration/colo.c b/migration/colo.c
>> index c19eb3f..5c6c2f0 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -332,9 +332,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>>          goto out;
>>      }
>>  
>> -    /* Disable block migration */
>> -    s->params.blk = 0;
>> -    s->params.shared = 0;
>
> Hmm you don't seem to have replaced this with anything.
> I think that's a behavioural change; the trick COLO did (I'm not sure if this
> is still the way it works) is that they initiate the first migration
> with block migration enabled so that the two hosts (with non-shared storage)
> get sync'd storage, and then at the completion of that first migration
> they then switch into the checkpointing mode where they're only
> doing updates - that's why it gets switched off at this point
> prior to the 1st checkpoint.


Weird, really.

I did't catch that.

Will investigate.

Thanks.
