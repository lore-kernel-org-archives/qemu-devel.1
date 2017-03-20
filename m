Received: from eggs.gnu.org ([2001:4830:134:3::10]:41961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cq3gV-00040h-M6
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:13:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cq3gQ-0001Ap-Nh
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:13:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cq3gQ-0001AY-I1
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 16:13:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6F163B721
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 20:13:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170317101424.GC2396@work-vm> (David Alan Gilbert's message of
	"Fri, 17 Mar 2017 10:14:24 +0000")
References: <20170315135021.6978-1-quintela@redhat.com>
	<20170315135021.6978-28-quintela@redhat.com>
	<20170317101424.GC2396@work-vm>
Reply-To: quintela@redhat.com
Date: Mon, 20 Mar 2017 21:13:35 +0100
Message-ID: <8737e7aeq8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 27/31] ram: Move last_req_rb to RAMState
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
>> It was on MigrationState when it is only used inside ram.c for
>> postcopy.  Problem is that we need to access it without being able to
>> pass it RAMState directly.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/migration.h | 2 --
>>  migration/migration.c         | 1 -
>>  migration/ram.c               | 6 ++++--
>>  3 files changed, 4 insertions(+), 5 deletions(-)
>> 
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index 84cef4b..e032fb0 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -189,8 +189,6 @@ struct MigrationState
>>      /* Queue of outstanding page requests from the destination */
>>      QemuMutex src_page_req_mutex;
>>      QSIMPLEQ_HEAD(src_page_requests, MigrationSrcPageRequest) src_page_requests;
>> -    /* The RAMBlock used in the last src_page_request */
>> -    RAMBlock *last_req_rb;
>
> Should this be kept together with src_page_req_mutex and src_page_requests?

Yes.

But I still have to use the global variable.

Will do for next version.

Thanks, Juan.
