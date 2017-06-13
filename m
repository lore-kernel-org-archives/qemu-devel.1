Received: from eggs.gnu.org ([2001:4830:134:3::10]:59421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiZm-0006S0-Bt
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiZh-0005T1-HJ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:57:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39936)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiZh-0005Sx-BY
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:57:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4BBDFC051668
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:57:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170608125937.GC4427@noname.redhat.com> (Kevin Wolf's message
	of "Thu, 8 Jun 2017 14:59:37 +0200")
References: <20170601221552.30628-1-quintela@redhat.com>
	<20170601221552.30628-4-quintela@redhat.com>
	<20170608125937.GC4427@noname.redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 13 Jun 2017 11:57:21 +0200
Message-ID: <871sqoky66.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/5] migration: Create
 load_setup()/cleanup() methods
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

Kevin Wolf <kwolf@redhat.com> wrote:
> Am 02.06.2017 um 00:15 hat Juan Quintela geschrieben:
>> We need to do things at load time.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/register.h |  2 ++
>>  migration/savevm.c           | 31 +++++++++++++++++++++++++++++++
>>  2 files changed, 33 insertions(+)
>> 
>> diff --git a/include/migration/register.h b/include/migration/register.h
>> index 8e37185..0862bb8 100644
>> --- a/include/migration/register.h
>> +++ b/include/migration/register.h
>> @@ -42,6 +42,8 @@ typedef struct SaveVMHandlers {
>>                                uint64_t *non_postcopiable_pending,
>>                                uint64_t *postcopiable_pending);
>>      LoadStateHandler *load_state;
>> +    int (*load_setup)(QEMUFile *f, void *opaque);
>> +    int (*load_cleanup)(void *opaque);
>>  } SaveVMHandlers;
>
> I see that you add code to call load_setup(), but don't you want to call
> load_cleanup() somewhere, too?

Oops, you are right.

I just sent another version of this series.  They are built on top of my
pull request.  And I added the call to load_cleanup.

Thanks for the review, Juan.
