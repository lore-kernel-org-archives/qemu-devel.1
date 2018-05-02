Received: from eggs.gnu.org ([2001:4830:134:3::10]:50166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDsL8-0006gr-3l
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDsL4-0006GP-Dg
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:02:38 -0400
References: <1525268093-531-1-git-send-email-ivanren@tencent.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bc77a1b2-27f3-21a0-8d82-b930bdf033a5@redhat.com>
Date: Wed, 2 May 2018 09:02:14 -0500
MIME-Version: 1.0
In-Reply-To: <1525268093-531-1-git-send-email-ivanren@tencent.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] qemu-img: return allocated size for block
 device with qcow2 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ivan Ren <renyime@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

On 05/02/2018 08:34 AM, Ivan Ren wrote:
> qemu-img info with a block device which has a qcow2 format always
> return 0 for disk size, and this can not reflect the qcow2 size
> and the used space of the block device. This patch return the
> allocated size of qcow2 as the disk size.

How does this differ from what qemu can already give you at runtime via 
the wr_highest_offset property in BlockDeviceStats, and related to the 
write_threshold ('block-set-write-threshold command, 
BLOCK_WRITE_THRESHOLD event)?  Is there any code we can reuse, rather 
than writing something from scratch?

> 
> Signed-off-by: Ivan Ren <ivanren@tencent.com>
> ---
>   block/qcow2-bitmap.c |  69 +++++++++++++++++
>   block/qcow2.c        | 212 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   block/qcow2.h        |  42 ++++++++++
>   3 files changed, 323 insertions(+)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
