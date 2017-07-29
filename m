Received: from eggs.gnu.org ([2001:4830:134:3::10]:60601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1dbLa6-0005EF-DL
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 02:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1dbLa2-0007f1-HE
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 02:50:34 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1dbLa1-0007UZ-RP
	for qemu-devel@nongnu.org; Sat, 29 Jul 2017 02:50:30 -0400
References: <1501249552-788-1-git-send-email-armbru@redhat.com>
	<1501249552-788-3-git-send-email-armbru@redhat.com>
	<20170728171731.GB3008@work-vm>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <597C2FFE.5020405@huawei.com>
Date: Sat, 29 Jul 2017 14:49:34 +0800
MIME-Version: 1.0
In-Reply-To: <20170728171731.GB3008@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] COLO: Define COLOMode without QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On 2017/7/29 1:17, Dr. David Alan Gilbert wrote:
> * Markus Armbruster (armbru@redhat.com) wrote:
>> COLOMode is defined in the QAPI schema, but not used there.  Of the
>> stuff QAPI generates for it only the typedef is actually used.  Use of
>> QAPI is pointless and only complicates things, so don't.
> Hmm, in one of the old COLO worlds I have, there's code to emit an event
> on exiting from COLO and that event includes the mode it was in.

Yes, we need it in the later series.

> If the intent is to bring that or similar back then it would be worth
> keeping.

Agreed.  ;)

> Dave
>
>> Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>   include/migration/colo.h |  6 ++++++
>>   qapi-schema.json         | 16 ----------------
>>   2 files changed, 6 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/migration/colo.h b/include/migration/colo.h
>> index ff9874e..5d7c500 100644
>> --- a/include/migration/colo.h
>> +++ b/include/migration/colo.h
>> @@ -26,6 +26,12 @@ void migration_incoming_exit_colo(void);
>>   void *colo_process_incoming_thread(void *opaque);
>>   bool migration_incoming_in_colo_state(void);
>>   
>> +typedef enum {
>> +    COLO_MODE_UNKNOWN,
>> +    COLO_MODE_PRIMARY,
>> +    COLO_MODE_SECONDARY,
>> +} COLOMode;
>> +
>>   COLOMode get_colo_mode(void);
>>   
>>   /* failover */
>> diff --git a/qapi-schema.json b/qapi-schema.json
>> index 9b6f6cb..3f0eb05 100644
>> --- a/qapi-schema.json
>> +++ b/qapi-schema.json
>> @@ -1304,22 +1304,6 @@
>>               'vmstate-loaded' ] }
>>   
>>   ##
>> -# @COLOMode:
>> -#
>> -# The colo mode
>> -#
>> -# @unknown: unknown mode
>> -#
>> -# @primary: master side
>> -#
>> -# @secondary: slave side
>> -#
>> -# Since: 2.8
>> -##
>> -{ 'enum': 'COLOMode',
>> -  'data': [ 'unknown', 'primary', 'secondary'] }
>> -
>> -##
>>   # @FailoverStatus:
>>   #
>>   # An enumeration of COLO failover status
>> -- 
>> 2.7.5
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> .
>
