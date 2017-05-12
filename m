Received: from eggs.gnu.org ([2001:4830:134:3::10]:59576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d8zuk-00050F-Sv
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d8zuh-0007Z5-QM
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:02:42 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3988)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1d8zuh-0007W6-8U
	for qemu-devel@nongnu.org; Thu, 11 May 2017 22:02:39 -0400
References: <20170425103049.4073-1-quintela@redhat.com>
	<20170425103049.4073-3-quintela@redhat.com>
	<20170428165522.GG3276@work-vm>
	<87vapht37i.fsf@secure.mitica> <590AF10B.9020207@huawei.com>
	<87efvvgxpr.fsf@secure.mitica>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <591517AA.9080201@huawei.com>
Date: Fri, 12 May 2017 10:02:18 +0800
MIME-Version: 1.0
In-Reply-To: <87efvvgxpr.fsf@secure.mitica>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: quintela@redhat.com
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

On 2017/5/12 0:33, Juan Quintela wrote:
> Hailiang Zhang <zhang.zhanghailiang@huawei.com> wrote:
>> Hi,
>>
>>>> Hmm you don't seem to have replaced this with anything.
>>>> I think that's a behavioural change; the trick COLO did (I'm not sure if this
>>>> is still the way it works) is that they initiate the first migration
>>>> with block migration enabled so that the two hosts (with non-shared storage)
>>>> get sync'd storage, and then at the completion of that first migration
>>>> they then switch into the checkpointing mode where they're only
>>>> doing updates - that's why it gets switched off at this point
>>>> prior to the 1st checkpoint.
>>> Weird, really.
>>>
>>> I did't catch that.
>>>
>>> Will investigate.
>> Yes, Dave is right, for non-shared disk, we need to enable block
>> migration for first cycle,
>> to sync the disks of two sides. After that, qemu will go into COLO
>> state which we need to
>> disable block migration.
> v2 posted.
>
> My understanding is that it maintains the sematic, please test/comment.

Yes, it is right now, i have reviewed it, thanks.

> Thanks, Juan.
>
> .
>
