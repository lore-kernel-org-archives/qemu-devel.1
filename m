Received: from eggs.gnu.org ([2001:4830:134:3::10]:57702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0jrv-00023f-U4
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:17:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0jrs-0007x1-PW
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:17:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0jrs-0007wS-JC
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 03:17:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 754258FCF8
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 07:17:35 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170418190747.GP2205@work-vm> (David Alan Gilbert's message of
	"Tue, 18 Apr 2017 20:07:50 +0100")
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-11-quintela@redhat.com>
	<20170418190747.GP2205@work-vm>
Reply-To: quintela@redhat.com
Date: Wed, 19 Apr 2017 09:17:32 +0200
Message-ID: <87bmrshnn7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 10/19] migration: Remove use of old
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
Cc: qemu-devel@nongnu.org

"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Juan Quintela (quintela@redhat.com) wrote:
>> We have change in the previous patch to use migration capabilities for
>> it.  Notice that we continue using the old command line flags from
>> migrate command from the time being.  Remove the set_params method as
>> now it is empty.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/migration.h |  2 --
>>  migration/block.c             | 17 ++---------------
>>  migration/colo.c              |  3 ---
>>  migration/migration.c         |  8 +++++---
>>  migration/savevm.c            |  2 --
>>  5 files changed, 7 insertions(+), 25 deletions(-)
>> 
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index 5c78ae1..09d3188 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -41,8 +41,6 @@
>>  extern int only_migratable;
>>  
>>  struct MigrationParams {
>> -    bool blk;
>> -    bool shared;
>>  };
>
> I'm not sure that's portable C - some suggests that empty struct's
> are a GNU addition.
> I suggest either leaving them here, or merging this with the next
> patch.

Added an unused bool.  I think it is clearer in two patches.

Thanks, Juan.
