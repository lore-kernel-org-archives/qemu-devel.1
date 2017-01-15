Received: from eggs.gnu.org ([2001:4830:134:3::10]:52835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cSdfT-0007hZ-At
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 00:47:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cSdfP-0004Hf-Vh
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 00:47:51 -0500
Received: from [59.151.112.132] (port=10268 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <douly.fnst@cn.fujitsu.com>) id 1cSdfP-00047B-K1
	for qemu-devel@nongnu.org; Sun, 15 Jan 2017 00:47:47 -0500
References: <1483513091-30661-1-git-send-email-douly.fnst@cn.fujitsu.com>
	<1483513091-30661-2-git-send-email-douly.fnst@cn.fujitsu.com>
	<5e0a6a79-cb60-b1f0-06ab-2362f63afb78@redhat.com>
From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Message-ID: <f62aad48-31f1-d367-55bd-687b5fe0c881@cn.fujitsu.com>
Date: Sun, 15 Jan 2017 13:47:20 +0800
MIME-Version: 1.0
In-Reply-To: <5e0a6a79-cb60-b1f0-06ab-2362f63afb78@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v3 1/2] block/qapi: reduce the coupling
 between the bdrv_query_stats and bdrv_query_bds_stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, mreitz@redhat.com, famz@redhat.com
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com, fanc.fnst@cn.fujitsu.com

Hi Eric,

At 01/13/2017 11:00 PM, Eric Blake wrote:
> On 01/04/2017 12:58 AM, Dou Liyang wrote:
>> the bdrv_query_stats and bdrv_query_bds_stats functions need to call
>> each other, that increases the coupling. it also makes the program
>> complicated and makes some unnecessary judgements.
>
> s/judgements/judgments/ - although I wonder if 'tests' would be a
> simpler word.
>

Yes, it is.
I will modify it.

>>
>> remove the call from bdrv_query_bds_stats to bdrv_query_stats, just
>> take some recursion to make it clearly.
>>
>> avoid judging whether the blk is NULL during querying the bds stats.
>
> Again, 'testing' might read nicer than 'judging'.

Yes, it is.


Thanks,
	Liyang
