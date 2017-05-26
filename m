Received: from eggs.gnu.org ([2001:4830:134:3::10]:47402)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dEFMW-0002QV-Nx
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dEFMV-0005yI-QL
	for qemu-devel@nongnu.org; Fri, 26 May 2017 09:33:04 -0400
References: <cover.1495536228.git.berto@igalia.com>
	<142326a3-eaa4-8333-9580-ae0063f8a876@redhat.com>
	<w51shjutjz7.fsf@maestria.local.igalia.com>
	<0e3fc298-d47b-4066-c8c8-02f620c50b89@virtuozzo.com>
	<20170526101727.GF7211@noname.str.redhat.com>
	<cc4efd40-46e8-82c0-10f7-148e84ab477a@virtuozzo.com>
	<w5160gnlq90.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <e636f52f-41c1-4682-e8b9-ea2596ac21b0@virtuozzo.com>
Date: Fri, 26 May 2017 16:32:49 +0300
MIME-Version: 1.0
In-Reply-To: <w5160gnlq90.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Denis V . Lunev" <den@openvz.org>

On 05/26/2017 04:08 PM, Alberto Garcia wrote:
> On Fri 26 May 2017 02:47:55 PM CEST, Anton Nefedov wrote:
>> Tried the another machine; about 10% improvement here
>    [...]
>> [root@localhost ~]# fio --name=randwrite --blocksize=4k
>> --filename=/dev/sdb --rw=randwrite --direct=1 --ioengine=libaio
>> --size=2g --io_size=32m
> 
> In my tests I sometimes detected slight performance decreases in that
> HDD scenario but using 'write' instead of 'randwrite' (and --runtime=60
> instead of --io_size).
> 
> Can you try and see how that works for you?
> 
> Berto
> 

For me it keeps giving pretty much the same result before and after

  write: io=512736KB, bw=8545.4KB/s, iops=2136, runt= 60004msec

/Anton
