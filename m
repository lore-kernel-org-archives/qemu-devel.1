Received: from eggs.gnu.org ([2001:4830:134:3::10]:53821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoVTW-0000T5-Va
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoVTT-0004Wb-5R
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:34:26 -0500
References: <20180215032905.27146-1-eblake@redhat.com>
	<3600bf5d-a91e-337c-57bf-6edf1ee3766e@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <111de9f8-4e88-8f3d-7f43-f1c99d0a6170@redhat.com>
Date: Wed, 21 Feb 2018 08:34:13 -0600
MIME-Version: 1.0
In-Reply-To: <3600bf5d-a91e-337c-57bf-6edf1ee3766e@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] nbd: Honor server's advertised minimum
 block size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 02/16/2018 05:50 AM, Vladimir Sementsov-Ogievskiy wrote:
> 15.02.2018 06:29, Eric Blake wrote:
>> Commit 79ba8c98 (v2.7) changed the setting of request_alignment
>> to occur only during bdrv_refresh_limits(), rather than at at
>> bdrv_open() time; but at the time, NBD was unaffected, because
>> it still used sector-based callbacks, so the block layer
>> defaulted NBD to use 512 request_alignment.
>>

>> Fix these issues by moving the assignment to request_alignment
>> to the right function, and by using a sane default when the
>> server does not advertise a minimum size.
>>
>> CC: qemu-stable@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---

> Reviewed-by: Vladimir Sementsov-Ogievskiy<vsementsov@virtuozzo.com>

Thanks; applied to my NBD queue.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
