Received: from eggs.gnu.org ([2001:4830:134:3::10]:50604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fksOI-0007pR-VU
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 10:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fksOF-0007WT-0K
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 10:46:19 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <w51muu7uzba.fsf@maestria.local.igalia.com>
References: <20180704145410.794-1-stefanha@redhat.com>
	<w51muu7uzba.fsf@maestria.local.igalia.com>
Date: Wed, 01 Aug 2018 16:45:36 +0200
Message-ID: <w51sh3ycfhr.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] throttle-groups: fix hang when group
 member leaves
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Tue 31 Jul 2018 06:47:53 PM CEST, Alberto Garcia wrote:
> On Wed 04 Jul 2018 04:54:10 PM CEST, Stefan Hajnoczi wrote:
>> Throttle groups consist of members sharing one throttling state
>> (including bps/iops limits).  Round-robin scheduling is used to ensure
>> fairness.  If a group member already has a timer pending then other
>> groups members do not schedule their own timers.  The next group
>> member will have its turn when the existing timer expires.
>>
>> A hang may occur when a group member leaves while it had a timer
>> scheduled.
>
> Ok, I can reproduce this if I run fio with iodepth=1.

I managed to write a test case for this, but unfortunately it seems that
this patch is not enough and it's still possible to hang QEMU 3.0.0-rc2.

I expect to have a fix for tomorrow.

Berto
