Received: from eggs.gnu.org ([2001:4830:134:3::10]:39949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dEEz9-0004zk-Rp
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dEEz6-0005GL-MT
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:08:55 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <cc4efd40-46e8-82c0-10f7-148e84ab477a@virtuozzo.com>
References: <cover.1495536228.git.berto@igalia.com>
	<142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
	<w51shjutjz7.fsf@maestria.local.igalia.com>
	<0e3fc298-d47b-4066-c8c8-02f620c50b89@virtuozzo.com>
	<20170526101727.GF7211@noname.str.redhat.com>
	<cc4efd40-46e8-82c0-10f7-148e84ab477a@virtuozzo.com>
Date: Fri, 26 May 2017 15:08:43 +0200
Message-ID: <w5160gnlq90.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/7] qcow2: Reduce the number of I/O ops
 when doing COW
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anton Nefedov <anton.nefedov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

On Fri 26 May 2017 02:47:55 PM CEST, Anton Nefedov wrote:
> Tried the another machine; about 10% improvement here
  [...]
> [root@localhost ~]# fio --name=randwrite --blocksize=4k
> --filename=/dev/sdb --rw=randwrite --direct=1 --ioengine=libaio
> --size=2g --io_size=32m

In my tests I sometimes detected slight performance decreases in that
HDD scenario but using 'write' instead of 'randwrite' (and --runtime=60
instead of --io_size).

Can you try and see how that works for you?

Berto
