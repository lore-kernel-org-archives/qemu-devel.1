Received: from eggs.gnu.org ([2001:4830:134:3::10]:43345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dufDM-0004Kp-5j
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:39:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dufDL-0002o3-Af
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:38:56 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170918202529.28379-1-el13635@mail.ntua.gr>
References: <20170918202529.28379-1-el13635@mail.ntua.gr>
Date: Wed, 20 Sep 2017 11:25:09 +0200
Message-ID: <w51ingd203u.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] block/throttle-groups.c: allocate
 RestartData on the heap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-block <qemu-block@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Mon 18 Sep 2017 10:25:29 PM CEST, Manos Pitsidianakis wrote:
> RestartData is the opaque data of the throttle_group_restart_queue_entry
> coroutine. By being stack allocated, it isn't available anymore if
> aio_co_enter schedules the coroutine with a bottom halve and runs after
> throttle_group_restart_queue returns.
>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
