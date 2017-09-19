Received: from eggs.gnu.org ([2001:4830:134:3::10]:39658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duCz2-0003n3-Ct
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:30:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1duCyy-00015S-Jn
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 03:30:16 -0400
Date: Tue, 19 Sep 2017 09:29:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170919072956.GB3789@localhost.localdomain>
References: <20170918202529.28379-1-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170918202529.28379-1-el13635@mail.ntua.gr>
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
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>, Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>

Am 18.09.2017 um 22:25 hat Manos Pitsidianakis geschrieben:
> RestartData is the opaque data of the throttle_group_restart_queue_entry
> coroutine. By being stack allocated, it isn't available anymore if
> aio_co_enter schedules the coroutine with a bottom halve and runs after
> throttle_group_restart_queue returns.

Cc: qemu-stable@nongnu.org

(It should be mentioned explicitly in the commit message so you can
filter for it in the commit history. I routinely add this while applying
patches if I'm aware of the qemu-stable CC, but it makes my life easier
if it's already there.)

> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Thanks, applied to the block branch.

Kevin
