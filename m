Received: from eggs.gnu.org ([2001:4830:134:3::10]:33691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0kuM-0005Yk-7V
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:28:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1f0kuL-0005WR-BM
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 05:28:46 -0400
References: <20180320170521.32152-1-vsementsov@virtuozzo.com>
	<fce080fd-1970-b856-82e0-42c62306da6c@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4add3400-b4d4-4812-72f2-0f184b2f4fd6@virtuozzo.com>
Date: Tue, 27 Mar 2018 12:28:33 +0300
MIME-Version: 1.0
In-Reply-To: <fce080fd-1970-b856-82e0-42c62306da6c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 for 2.12 0/3] fix bitmaps migration
 through shared storage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, den@openvz.org

26.03.2018 21:06, Max Reitz wrote:
> On 2018-03-20 18:05, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> This fixes bitmaps migration through shared storage. Look at 02 for
>> details.
>>
>> The bug introduced in 2.10 with the whole qcow2 bitmaps feature, so
>> qemu-stable in CC. However I doubt that someone really suffered from this.
>>
>> Do we need dirty bitmaps at all in inactive case? - that was a question in v2.
>> And, keeping in mind that we are going to use inactive mode not only for
>> incoming migration, I'm not sure that answer is NO (but, it may be "NO" for
>> 2.10, 2.11), so let's fix it in proposed here manner at least for 2.12.
> For some reason, I can't get 169 to work now at all[1].  What's more,
> whenever I run it, two (on current master, maybe more after this series)
> "cat $TEST_DIR/mig_file" processes stay around.  That doesn't seem right.
>
> However, this series doesn't seem to make it worse[2]...  So I'm keeping
> it.  I suppose it's just some issue with the test.
>
> Max
>
>
> [1] Sometimes there are migration even timeouts, sometimes just VM
> launch timeouts (specifically when VM B is supposed to be re-launched
> just after it has been shut down), and sometimes I get a dirty bitmap
> hash mismatch.
>
>
> [2] The whole timeline was:
>
> - Apply this series, everything seems alright
>
> (a couple of hours later)
> - Test some other things, stumble over 169 once or so
>
> - Focus on 169, fails a bit more often
>
> (today)
> - Can't get it to work at all
>
> - Can't get it to work in any version, neither before nor after this patch
>
> - Lose my sanity
>
> - Write this email
>
> O:-)
>

hmm.. checked on current master (7b93d78a04aa24), tried a lot of times 
in a loop, works for me. How can I help?

-- 
Best regards,
Vladimir
