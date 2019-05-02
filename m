Received: from eggs.gnu.org ([209.51.188.92]:45904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCqj-0007sv-Aq
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hMCqi-0003t6-DA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 10:38:13 -0400
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
From: Sam <shmuel.eiderman@oracle.com>
In-Reply-To: <3a211c90-f031-07ea-0833-35efcff5f6cb@redhat.com>
Date: Thu, 2 May 2019 17:38:02 +0300
Content-Transfer-Encoding: 7bit
Message-Id: <B7F58E1E-D1FA-40E2-BF86-BE8BAA1A18D7@oracle.com>
References: <20190502085029.30776-1-shmuel.eiderman@oracle.com>
	<20190502135828.42797-1-shmuel.eiderman@oracle.com>
	<3a211c90-f031-07ea-0833-35efcff5f6cb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] qemu-img: rebase: Improve/optimize
 rebase operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, eyal.moscovici@oracle.com, arbel.moshe@oracle.com, liran.alon@oracle.com, sagi.amit@oracle.com, karl.heubaum@oracle.com

I see,

Thanks

> On 2 May 2019, at 17:21, Eric Blake <eblake@redhat.com> wrote:
> 
> On 5/2/19 8:58 AM, Sam Eiderman wrote:
>> This patch series aims to improve the speed of qemu-img rebase.
>> 
>> 1. Mainly by removing unnecessary reads when rebasing on the same
>>   chain.
>> 2. But also by minimizing the number of bdrv_open calls rebase
>>   requires.
>> 
> 
> When sending a v2 series, it's best to do so as a new top-level thread
> rather than in-reply-to the v1 series, as our CI tools are more likely
> to spot it that way.
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 
