Received: from eggs.gnu.org ([2001:4830:134:3::10]:33766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evVyC-0001P2-6h
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evVyB-0001zS-HL
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:31:04 -0400
References: <20180307225732.155835-1-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c9e83e73-4fc9-43b7-2ace-0ffad7492c7e@redhat.com>
Date: Mon, 12 Mar 2018 17:30:40 -0500
MIME-Version: 1.0
In-Reply-To: <20180307225732.155835-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd/server: Honor FUA request on
 NBD_CMD_TRIM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

On 03/07/2018 04:57 PM, Eric Blake wrote:
> The NBD spec states that since trim requests can affect disk contents,
> then they should allow for FUA semantics just like writes for ensuring
> the disk has settled before returning.  As bdrv_[co_]pdiscard() does
> not (yet?) support a flags argument, we can't pass FUA down the block
> layer stack, and must therefore emulate it with a flush at the NBD
> layer.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 

Thanks; queued to my NBD tree.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
