Received: from eggs.gnu.org ([2001:4830:134:3::10]:52858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDsXo-00040F-LO
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fDsXk-0005IX-1T
	for qemu-devel@nongnu.org; Wed, 02 May 2018 10:15:44 -0400
References: <20180502140359.18222-1-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c59c9ed2-7964-7433-3fd4-5e55be449da1@redhat.com>
Date: Wed, 2 May 2018 09:15:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180502140359.18222-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] block: Document BDRV_REQ_WRITE_UNCHANGED
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On 05/02/2018 09:03 AM, Max Reitz wrote:
> Add BDRV_REQ_WRITE_UNCHANGED to the list of flags honored during pwrite
> and pwrite_zeroes, and also add a note on when you absolutely need to
> support it.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

Thanks, that helps.

Reviewed-by: Eric Blake <eblake@redhat.com>

> I did not include a note on how this might be useful to protocol
> drivers, because BDRV_REQ_WRITE_UNCHANGED requests will usually not end
> up on the protocol level anyway.
> (I suppose it would be possible in theory if a protocol driver reports a
>   certain range as unallocated and the user installs a copy-on-read
>   driver on top, but I think every protocol driver currently reports
>   everything as allocated.)

It doesn't help that I still haven't revisited an audit of whether all 
the protocol drivers have a sane status return to begin with (fallout 
from Kevin's review of my byte-based block status that landed in 2.12). 
But that doesn't hold up this patch.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
