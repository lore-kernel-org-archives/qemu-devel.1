Received: from eggs.gnu.org ([2001:4830:134:3::10]:33163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuDYh-0001lT-W7
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fuDXx-0005ae-CD
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 05:10:57 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180821161857.28402-1-berto@igalia.com>
References: <20180821161857.28402-1-berto@igalia.com>
Date: Mon, 27 Aug 2018 11:10:46 +0200
Message-ID: <w51r2ik2mzt.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] qemu-io: Fix writethrough check in reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue 21 Aug 2018 06:18:57 PM CEST, Alberto Garcia wrote:
> "qemu-io reopen" doesn't allow changing the writethrough setting of
> the cache, but the check is wrong, causing an error even on a simple
> reopen with the default parameters:
>
>    $ qemu-img create -f qcow2 hd.qcow2 1M
>    $ qemu-system-x86_64 -monitor stdio -drive if=virtio,file=hd.qcow2
>    (qemu) qemu-io virtio0 reopen
>    Cannot change cache.writeback: Device attached
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>

This patch is now part of the "Misc reopen-related patches" series:

https://lists.gnu.org/archive/html/qemu-block/2018-08/msg00846.html

Berto
