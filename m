Received: from eggs.gnu.org ([2001:4830:134:3::10]:41050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fkV0O-0005s9-6k
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fkV0J-0008Ob-F5
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 09:48:04 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180704145410.794-1-stefanha@redhat.com>
References: <20180704145410.794-1-stefanha@redhat.com>
Date: Tue, 31 Jul 2018 15:47:20 +0200
Message-ID: <w51r2jjv7o7.fsf@maestria.local.igalia.com>
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
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Wed 04 Jul 2018 04:54:10 PM CEST, Stefan Hajnoczi wrote:
> Throttle groups consist of members sharing one throttling state
> (including bps/iops limits).  Round-robin scheduling is used to ensure
> fairness.  If a group member already has a timer pending then other
> groups members do not schedule their own timers.  The next group
> member will have its turn when the existing timer expires.
>
> A hang may occur when a group member leaves while it had a timer
> scheduled.

I haven't been able to reproduce this. When a member is removed from the
group the pending request queue must already be empty, so does this mean
that there's still a timer when the queue is already empty?

Berto
