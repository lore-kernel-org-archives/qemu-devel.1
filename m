Received: from eggs.gnu.org ([2001:4830:134:3::10]:52784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d94ya-0000Xf-6y
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:27:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d94yZ-0002RS-5o
	for qemu-devel@nongnu.org; Fri, 12 May 2017 03:27:00 -0400
References: <1492005921-15664-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170511191701.GC24584@stefanha-x1.localdomain>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <591563A2.8000504@huawei.com>
Date: Fri, 12 May 2017 15:26:26 +0800
MIME-Version: 1.0
In-Reply-To: <20170511191701.GC24584@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4 0/6] COLO block replication
 supports shared disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: stefanha@redhat.com, qemu-devel@nongnu.org, kwolf@redhat.com, xiecl.fnst@cn.fujitsu.com, qemu-block@nongnu.org, zhangchen.fnst@cn.fujitsu.com, eddie.dong@intel.com, "Dr . David Alan
	Gilbert" <dgilbert@redhat.com>

On 2017/5/12 3:17, Stefan Hajnoczi wrote:
> On Wed, Apr 12, 2017 at 10:05:15PM +0800, zhanghailiang wrote:
>> COLO block replication doesn't support the shared disk case,
>> Here we try to implement it and this is the 4th version.
>>
>> Please review and any commits are welcomed.
>>
>> Cc: Dr. David Alan Gilbert (git) <dgilbert@redhat.com>
>> Cc: eddie.dong@intel.com
> Sorry for the delay.  Feel free to ping me if I don't review within a
> few days when you post a patch.

That is OK. :) , I was doing other things these days, and it is not quite urgent ... thanks.

>> v4:
>> - Add proper comment for primary_disk in patch 2 (Stefan)
>> - Call bdrv_invalidate_cache() while do checkpoint for shared disk in patch 5
>>
>> v3:
>> - Fix some comments from Stefan and Eric
>>
>> v2:
>> - Drop the patch which add a blk_root() helper
>> - Fix some comments from Changlong
>>
>> zhanghailiang (6):
>>    docs/block-replication: Add description for shared-disk case
>>    replication: add shared-disk and shared-disk-id options
>>    replication: Split out backup_do_checkpoint() from
>>      secondary_do_checkpoint()
>>    replication: fix code logic with the new shared_disk option
>>    replication: Implement block replication for shared disk case
>>    nbd/replication: implement .bdrv_get_info() for nbd and replication
>>      driver
>>
>>   block/nbd.c                |  12 +++
>>   block/replication.c        | 198 ++++++++++++++++++++++++++++++++++-----------
>>   docs/block-replication.txt | 139 ++++++++++++++++++++++++++++++-
>>   qapi/block-core.json       |  10 ++-
>>   4 files changed, 306 insertions(+), 53 deletions(-)
>>
>> -- 
>> 1.8.3.1
>>
>>
>>
