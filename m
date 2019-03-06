Received: from eggs.gnu.org ([209.51.188.92]:57449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1WCZ-0000xO-5u
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1WCY-00019E-B2
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:03:15 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190305182908.13557-1-eblake@redhat.com>
References: <20190305182908.13557-1-eblake@redhat.com>
Date: Wed, 06 Mar 2019 14:03:08 +0100
Message-ID: <w51imww5f5f.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] iotests: Wait for qemu to end in 223
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue 05 Mar 2019 07:29:08 PM CET, Eric Blake wrote:
> When iotest 223 was first written, it didn't matter if we waited for
> the qemu process to clean up. But with the introduction of a later
> qemu-nbd process trying to reuse the same file, there is a race where
> even though the asynchronous qemu process has responded to "quit", it
> has not yet had time to unlock the file and exit, resulting in:
>
> -[{ "start": 0, "length": 65536, "depth": 0, "zero": false, "data": false},
> -{ "start": 65536, "length": 2031616, "depth": 0, "zero": false, "data": true},
> -{ "start": 2097152, "length": 2097152, "depth": 0, "zero": false, "data": false}]
> +qemu-nbd: Failed to blk_new_open 'tests/qemu-iotests/scratch/t.qcow2': Failed to get shared "write" lock
> +Is another process using the image [tests/qemu-iotests/scratch/t.qcow2]?
> +qemu-img: Could not open 'driver=nbd,server.type=unix,server.path=tests/qemu-iotests/scratch/qemu-nbd.sock,x-dirty-bitmap=qemu:dirty-bitmap:b': Failed to connect socket tests/qemu-iotests/scratch/qemu-nbd.sock: Connection refused
> +./common.nbd: line 33: kill: (11122) - No such process
>
> Fixes: ddd09448
> Reported-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Tested-by: Alberto Garcia <berto@igalia.com>

Berto
