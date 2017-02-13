Received: from eggs.gnu.org ([2001:4830:134:3::10]:36052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdCII-0002ch-GH
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:47:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdCIF-0003Dn-9c
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:47:34 -0500
Received: from szxga03-in.huawei.com ([119.145.14.66]:2228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cdCIE-0003Cu-MH
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 03:47:31 -0500
References: <1484657864-21708-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170210154435.GF13357@work-vm>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58A17283.5020609@huawei.com>
Date: Mon, 13 Feb 2017 16:46:59 +0800
MIME-Version: 1.0
In-Reply-To: <20170210154435.GF13357@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] COLO: fix some bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, quintela@redhat.com, eddie.dong@intel.com, lizhijian@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com

On 2017/2/10 23:44, Dr. David Alan Gilbert wrote:
> * zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
>> Hi,
>>
>> This series fix three bugs of COLO.
>> patch 1 fix one usage case which users want to change checkpoint-delay
>> with an extream big value set before, the new value may not take effect
>> until finishing a long time of sleep.
>>
>> Patch 2 and 3 are old patches that split from previous version
>> long time ago, and has been reviewed by Dave.
>>
>> I'd like to pick these three patches from the later COLO series,
>> which will include some optimization and integrating with block
>> replication and COLO net proxy.
>>
>> Please review, thanks.
>
> Queued.
> I've added the '(Since 2.9)' that Eric asked for.
>

Thank you very much.
By the way, as we discussed in patch 1, should i add the codes in patch 1
which kick the colo_checkpoint_sem to quick the colo thread exiting ?
In next version ? Or post a new patch ?

Hailiang


> Dave
>
>>
>>
>> zhanghailiang (3):
>>    COLO: fix setting checkpoint-delay not working properly
>>    COLO: Shutdown related socket fd while do failover
>>    COLO: Don't process failover request while loading VM's state
>>
>>   include/migration/colo.h      |   2 +
>>   include/migration/migration.h |   8 ++++
>>   migration/colo.c              | 102 +++++++++++++++++++++++++++++++++++++-----
>>   migration/migration.c         |   3 ++
>>   qapi-schema.json              |   4 +-
>>   5 files changed, 108 insertions(+), 11 deletions(-)
>>
>> --
>> 1.8.3.1
>>
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> .
>
