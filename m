Received: from eggs.gnu.org ([2001:4830:134:3::10]:58088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2yGI-0003Yc-1P
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2yGE-0002nV-Nq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:04:02 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3525
	helo=dggrg01-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d2yGE-0002jm-4f
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 07:03:58 -0400
References: <1492850128-17472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1492850128-17472-5-git-send-email-zhang.zhanghailiang@huawei.com>
	<87tw5doei8.fsf@secure.mitica>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58FF2CFB.2080606@huawei.com>
Date: Tue, 25 Apr 2017 19:03:23 +0800
MIME-Version: 1.0
In-Reply-To: <87tw5doei8.fsf@secure.mitica>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RESEND v2 04/18] COLO: integrate colo
 compare with colo frame
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, dgilbert@redhat.com, zhangchen.fnst@cn.fujitsu.com, Jason Wang <jasowang@redhat.com>

On 2017/4/25 2:18, Juan Quintela wrote:
> zhanghailiang <zhang.zhanghailiang@huawei.com> wrote:
>> For COLO FT, both the PVM and SVM run at the same time,
>> only sync the state while it needs.
>>
>> So here, let SVM runs while not doing checkpoint, change
>> DEFAULT_MIGRATE_X_CHECKPOINT_DELAY to 200*100.
>>
>> Besides, we forgot to release colo_checkpoint_semd and
>> colo_delay_timer, fix them here.
>>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ....
>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 353f272..2ade2aa 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -70,7 +70,7 @@
>>   /* The delay time (in ms) between two COLO checkpoints
>>    * Note: Please change this default value to 10000 when we support hybrid mode.
>>    */
>> -#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY 200
>> +#define DEFAULT_MIGRATE_X_CHECKPOINT_DELAY (200 * 100)
>>   
>>   static NotifierList migration_state_notifiers =
>>       NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
> 1000 or 200 * 100
>
> Please, fix value or comment?

OK, will fix in next version, thanks.

> Later, Juan.
>
> .
>
