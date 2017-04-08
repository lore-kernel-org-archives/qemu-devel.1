Received: from eggs.gnu.org ([2001:4830:134:3::10]:32887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwe5S-0005wg-PC
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwe5P-0000JJ-Lg
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:18:42 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33303)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cwe5P-0000Ix-Fl
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 20:18:39 -0400
Received: by mail-qk0-x244.google.com with SMTP id p22so12164173qka.0
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 17:18:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-3-pbonzini@redhat.com>
	<db112c85-7ea9-509d-dbf7-cebc19623653@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <22fbec98-0eae-bdd1-038b-8910185493c9@amsat.org>
Date: Fri, 7 Apr 2017 21:18:35 -0300
MIME-Version: 1.0
In-Reply-To: <db112c85-7ea9-509d-dbf7-cebc19623653@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/10] blockjob: remove iostatus_reset
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>

On 04/07/2017 08:12 PM, John Snow wrote:
> On 03/23/2017 01:39 PM, Paolo Bonzini wrote:
>> This is unused since commit 66a0fae ("blockjob: Don't touch BDS iostatus",
>> 2016-05-19).
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  blockjob.c                   | 3 ---
>>  include/block/blockjob_int.h | 3 ---
>>  2 files changed, 6 deletions(-)
>>
>> diff --git a/blockjob.c b/blockjob.c
>> index a9fb624..24d1e12 100644
>> --- a/blockjob.c
>> +++ b/blockjob.c
>> @@ -555,9 +555,6 @@ bool block_job_is_cancelled(BlockJob *job)
>>  void block_job_iostatus_reset(BlockJob *job)
>>  {
>>      job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
>> -    if (job->driver->iostatus_reset) {
>> -        job->driver->iostatus_reset(job);
>> -    }
>>  }
>>
>>  static int block_job_finish_sync(BlockJob *job,
>> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
>> index 3f86cc5..bfcc5d1 100644
>> --- a/include/block/blockjob_int.h
>> +++ b/include/block/blockjob_int.h
>> @@ -44,9 +44,6 @@ struct BlockJobDriver {
>>      /** Optional callback for job types that support setting a speed limit */
>>      void (*set_speed)(BlockJob *job, int64_t speed, Error **errp);
>>
>> -    /** Optional callback for job types that need to forward I/O status reset */
>> -    void (*iostatus_reset)(BlockJob *job);
>> -
>>      /** Mandatory: Entrypoint for the Coroutine. */
>>      CoroutineEntry *start;
>>
>>
>
> Good find.
>
> Reviewed-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
