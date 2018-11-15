Received: from eggs.gnu.org ([2001:4830:134:3::10]:38068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNHOy-0004wV-8B
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:09:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNHOv-0007Fk-Bp
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:09:43 -0500
References: <154227257477.21.7282982958373751241@c26723477dc9>
From: Eric Blake <eblake@redhat.com>
Message-ID: <43d5266f-875f-7a8f-eb0f-b2279c17215c@redhat.com>
Date: Thu, 15 Nov 2018 07:09:12 -0600
MIME-Version: 1.0
In-Reply-To: <154227257477.21.7282982958373751241@c26723477dc9>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 00/13] block: byte-based
 blocking read/write
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, kwolf@redhat.com, qemu-block@nongnu.org

On 11/15/18 3:02 AM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> Message-id: 20181115020334.1189829-1-eblake@redhat.com
> Type: series
> Subject: [Qemu-devel] [PATCH v2 for-4.0 00/13] block: byte-based blocking read/write
> 

> /tmp/qemu-test/src/block/qcow2-cluster.c: In function 'qcow2_decompress_cluster':
> /tmp/qemu-test/src/block/qcow2-cluster.c:1630:15: error: implicit declaration of function 'bdrv_read'; did you mean 'bdrv_pread'? [-Werror=implicit-function-declaration]
>           ret = bdrv_read(bs->file, coffset >> 9, s->cluster_data,
>                 ^~~~~~~~~
>                 bdrv_pread
> /tmp/qemu-test/src/block/qcow2-cluster.c:1630:15: error: nested extern declaration of 'bdrv_read' [-Werror=nested-externs]

False positive - for some reason, patchew didn't properly follow my 
Based-on tags that this depends on Kevin's block-next branch:

> Based-on: <20181114210548.1098207-1-eblake@redhat.com>
> [file-posix: Better checks of 64-bit copy_range]
> Based-on: <20181101182738.70462-1-vsementsov@virtuozzo.com>
> [0/7 qcow2 decompress in threads] - more specifically, on Kevin's block-next branch


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
