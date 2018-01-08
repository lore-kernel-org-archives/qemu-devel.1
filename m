Received: from eggs.gnu.org ([2001:4830:134:3::10]:45331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eYZia-0000GB-Rn
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:52:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eYZiZ-0005J3-VS
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 10:52:08 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171221142251.18366-10-kwolf@redhat.com>
References: <20171221142251.18366-1-kwolf@redhat.com>
	<20171221142251.18366-10-kwolf@redhat.com>
Date: Mon, 08 Jan 2018 16:41:03 +0100
Message-ID: <w51lgh88ik0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 09/19] block: Nested
 drain_end must still call callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

On Thu 21 Dec 2017 03:22:41 PM CET, Kevin Wolf wrote:
> bdrv_do_drained_begin() restricts the call of parent callbacks and
> aio_disable_external() to the outermost drain section, but the block
> driver callbacks are always called. bdrv_do_drained_end() must match
> this behaviour, otherwise nodes stay drained even if begin/end calls
> were balanced.

Is this patch in the correct place in the series? I was confused becaue
you mention bdrv_do_drained_begin() and bdrv_do_drained_end() that don't
seem to exist yet, I see you add them in a later patch.

Berto
