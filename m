Received: from eggs.gnu.org ([2001:4830:134:3::10]:52567)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1diFNf-0007BK-9c
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 03:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1diFNe-000534-1u
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 03:38:15 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:12581 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1diFNd-0004zI-Mw
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 03:38:13 -0400
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
	<3f9ef2bf-bd52-b2ef-4051-bea6c06d24ce@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <95284491-a0f3-c2d3-ed79-003f9ff4a047@virtuozzo.com>
Date: Thu, 17 Aug 2017 10:37:59 +0300
MIME-Version: 1.0
In-Reply-To: <3f9ef2bf-bd52-b2ef-4051-bea6c06d24ce@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 00/17] nbd client refactoring and fixing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

17.08.2017 00:21, Eric Blake wrote:
> On 08/04/2017 10:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>> A bit more refactoring and fixing before BLOCK_STATUS series.
>> I've tried to make individual patches simple enough, so there are
>> a lot of them.
> Is your BLOCK_STATUS series something that is in good enough shape to
> post a preliminary version of it (the version you posted back in
> February is now horribly out-of-date, with all the good cleanups you
> have been doing in the meantime).  I want to get a running start at
> reviewing what I can to make sure we get improved NBD functionality into
> 2.11.

Every time I want to produce a new version of BLOCK_STATUS, I stumble on
something and new 10-20 patches refactoring series appears)

>
> Also, please feel free to offer your Reviewed-by on other patches
> (whether NBD-related or not).  Speaking as the NBD maintainer, I welcome
> any help I can get.  And from personal experience, reviews tend to be
> one of the largest bottlenecks in open source software - if you are
> writing patches but not offering reviews, then you are adding to the
> bottleneck so reviewers tend to set your patches aside for when they
> have more time; while if you are actively offering reviews, then it is
> obvious that you care about the project and your patch contributions
> tend to have an easier time getting in.  My personal rule of thumb is to
> try and review at least 2 other patches for every one that I send,
> although that is a rather ambitious goal and there's nothing wrong if
> you can't commit to theh same level of effort.

Thanks, I get the point, I'll try to do better.


>
>> Vladimir Sementsov-Ogievskiy (17):
>>    nbd/client: fix nbd_opt_go
>>    nbd/client: refactor nbd_read_eof
>>    nbd/client: refactor nbd_receive_reply
>>    nbd/client: fix nbd_send_request to return int
>>    block/nbd-client: get rid of ssize_t
>>    block/nbd-client: fix nbd_read_reply_entry
>>    block/nbd-client: refactor request send/receive
>>    block/nbd-client: rename nbd_recv_coroutines_enter_all
>>    block/nbd-client: move nbd_co_receive_reply content into
>>      nbd_co_request
>>    block/nbd-client: move nbd_coroutine_end content into nbd_co_request
>>    block/nbd-client: fix nbd_co_request: set s->reply.handle to 0 on
>>      error
>>    block/nbd-client: refactor nbd_co_request
>>    block/nbd-client: refactor NBDClientSession.recv_coroutine
>>    block/nbd-client: exit reply-reading coroutine on incorrect handle
>>    block/nbd-client: refactor reading reply
>>    block/nbd-client: drop reply field from NBDClientSession
>>    block/nbd-client: always return EIO on and after the first io channel
>>      error
> Of course, parts of this will need rebasing based on what finally landed
> in 2.10, but I can start reviewing what I can for this round.
>

-- 
Best regards,
Vladimir
