Received: from eggs.gnu.org ([209.51.188.92]:34918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1UNc-0004CV-S1
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1UNW-0000cJ-R2
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:06:29 -0500
Date: Wed, 6 Mar 2019 12:05:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190306110559.GF6818@localhost.localdomain>
References: <20190305182908.13557-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305182908.13557-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Wait for qemu to end in 223
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, berto@igalia.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 05.03.2019 um 19:29 hat Eric Blake geschrieben:
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

Makes sense to me. Berto, can you test it?

Kevin
