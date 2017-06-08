Received: from eggs.gnu.org ([2001:4830:134:3::10]:36369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dIrvu-0000jz-8r
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dIrvt-0000Z4-KY
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 03:32:42 -0400
References: <1496468917-7489-1-git-send-email-sochin.jiang@huawei.com>
	<w51wp8oxh8m.fsf@maestria.local.igalia.com>
From: "sochin.jiang" <sochin.jiang@huawei.com>
Message-ID: <0b817ea2-2b2b-ac19-7c70-c78bb078c607@huawei.com>
Date: Thu, 8 Jun 2017 15:31:10 +0800
MIME-Version: 1.0
In-Reply-To: <w51wp8oxh8m.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] blockjob: cancel blockjobs
 before stopping all iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Cc: lina.lulina@huawei.com, lizhengui@huawei.com, qemu-block@nongnu.org, subo7@huawei.com, eric.fangyi@huawei.com, zhangshuai13@huawei.com, qemu-devel@nongnu.org

 

 Indeed,  thank you for replying and reminding. I'll be more careful next time.


On 2017/6/7 17:46, Alberto Garcia wrote:
> On Sat 03 Jun 2017 07:48:37 AM CEST, sochin.jiang wrote:
>
>> --- a/block.c
>> +++ b/block.c
>> @@ -3084,9 +3084,16 @@ static void bdrv_close(BlockDriverState *bs)
>>      bdrv_drained_end(bs);
>>  }
>>  
>> +void bdrv_cancel_all(void)
>> +{
>> +    if (!block_jobs_is_empty()) {
>> +        block_job_cancel_sync_all();
>> +    }
>> +}
> Why do you need this function at all? block_job_cancel_sync_all() is
> already doing nothing when the block_jobs list is empty.
>
> Berto
>
> .
>
