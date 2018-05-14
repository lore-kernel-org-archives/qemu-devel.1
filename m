Received: from eggs.gnu.org ([2001:4830:134:3::10]:60459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJpJ-0005mE-V3
	for qemu-devel@nongnu.org; Mon, 14 May 2018 16:12:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fIJpJ-0004k8-0V
	for qemu-devel@nongnu.org; Mon, 14 May 2018 16:12:09 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-11-kwolf@redhat.com>
	<aa4573ab-09a8-6c04-2ccb-b9d90bb1d0ac@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <91f02b4c-930e-e724-dd0e-ac84a8c0d6fc@redhat.com>
Date: Mon, 14 May 2018 16:12:01 -0400
MIME-Version: 1.0
In-Reply-To: <aa4573ab-09a8-6c04-2ccb-b9d90bb1d0ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/42] job: Add JobDriver.job_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org



On 05/11/2018 06:53 PM, Max Reitz wrote:
> On 2018-05-09 18:26, Kevin Wolf wrote:
>> This moves the job_type field from BlockJobDriver to JobDriver.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

>> ---
>>  include/block/blockjob_int.h |  3 ---
>>  include/qemu/job.h           | 11 +++++++++++
>>  block/backup.c               |  2 +-
>>  block/commit.c               |  2 +-
>>  block/mirror.c               |  4 ++--
>>  block/stream.c               |  2 +-
>>  blockjob.c                   | 16 +++++++---------
>>  job.c                        | 10 ++++++++++
>>  8 files changed, 33 insertions(+), 17 deletions(-)
>>
> 
> [...]
> 
>> diff --git a/include/qemu/job.h b/include/qemu/job.h
>> index b4b49f19e1..c87e951c8a 100644
>> --- a/include/qemu/job.h
>> +++ b/include/qemu/job.h
> 
> [...]
> 
>> @@ -57,4 +62,10 @@ struct JobDriver {
>>   */
>>  void *job_create(const char *job_id, const JobDriver *driver, Error **errp);
>>  
>> +/** Returns the JobType of a given Job. */
>> +JobType job_type(Job *job);
>> +
>> +/** Returns the enum string for the JobType of a given Job. */
>> +const char *job_type_str(Job *job);
>> +
> 
> Is there a good reason for these not to take a const Job *?
> 
> Depending on the answer:
> 
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> 
>>  #endif
> 

Max is just very excited to talk about Rust some more, I can tell.
