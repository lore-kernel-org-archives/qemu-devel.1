Received: from eggs.gnu.org ([2001:4830:134:3::10]:55525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d8r1r-0006XO-5o
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:33:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d8r1o-0006t5-Hk
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:33:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d8r1o-0006st-Bz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 12:33:24 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <590AF10B.9020207@huawei.com> (Hailiang Zhang's message of "Thu,
	4 May 2017 17:14:51 +0800")
References: <20170425103049.4073-1-quintela@redhat.com>
	<20170425103049.4073-3-quintela@redhat.com>
	<20170428165522.GG3276@work-vm> <87vapht37i.fsf@secure.mitica>
	<590AF10B.9020207@huawei.com>
Reply-To: quintela@redhat.com
Date: Thu, 11 May 2017 18:33:20 +0200
Message-ID: <87efvvgxpr.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com

Hailiang Zhang <zhang.zhanghailiang@huawei.com> wrote:
> Hi,
>
>>> Hmm you don't seem to have replaced this with anything.
>>> I think that's a behavioural change; the trick COLO did (I'm not sure if this
>>> is still the way it works) is that they initiate the first migration
>>> with block migration enabled so that the two hosts (with non-shared storage)
>>> get sync'd storage, and then at the completion of that first migration
>>> they then switch into the checkpointing mode where they're only
>>> doing updates - that's why it gets switched off at this point
>>> prior to the 1st checkpoint.
>>
>> Weird, really.
>>
>> I did't catch that.
>>
>> Will investigate.
>
> Yes, Dave is right, for non-shared disk, we need to enable block
> migration for first cycle,
> to sync the disks of two sides. After that, qemu will go into COLO
> state which we need to
> disable block migration.

v2 posted.

My understanding is that it maintains the sematic, please test/comment.

Thanks, Juan.
