Received: from eggs.gnu.org ([2001:4830:134:3::10]:43612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eFK1R-0007fe-KF
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:16:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eFK1N-0000rR-GL
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:16:01 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171116112150.27607-1-stefanha@redhat.com>
References: <20171116112150.27607-1-stefanha@redhat.com>
Date: Thu, 16 Nov 2017 14:15:53 +0100
Message-ID: <w51h8tuqs8m.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.11] throttle-groups: forget timer and
 schedule next TGM on detach
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Manos Pitsidianakis <el13635@mail.ntua.gr>

On Thu 16 Nov 2017 12:21:50 PM CET, Stefan Hajnoczi wrote:
> tg->any_timer_armed[] must be cleared when detaching pending timers from
> the AioContext.  Failure to do so leads to hung I/O because it looks
> like there are still timers pending when in fact they have been removed.
>
> Other ThrottleGroupMembers might have requests pending too so it's
> necessary to schedule the next TGM so it can set a timer.
>
> This patch fixes hung I/O when QEMU is launched with drives that are in
> the same throttling group:
>
>   (guest)$ dd if=/dev/zero of=/dev/vdb oflag=direct bs=512 &
>   (guest)$ dd if=/dev/zero of=/dev/vdc oflag=direct bs=512 &
>   (qemu) stop
>   (qemu) cont
>   ...I/O is stuck...
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
