Received: from eggs.gnu.org ([2001:4830:134:3::10]:41807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqNXY-0000mh-Ux
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:02:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqNXY-0002Ul-6b
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:02:36 -0400
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-3-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3cd9b4a9-f5da-75b2-990a-1c296862ced7@redhat.com>
Date: Thu, 16 Aug 2018 14:02:30 -0500
MIME-Version: 1.0
In-Reply-To: <20180809213528.14738-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 02/31] block: Use children list
 in bdrv_refresh_filename
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

On 08/09/2018 04:34 PM, Max Reitz wrote:
> bdrv_refresh_filename() should invoke itself recursively on all
> children, not just on file.
> 
> With that change, we can remove the manual invocations in blkverify,
> quorum, commit, mirror, and blklogwrites.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   block.c              | 9 +++++----
>   block/blklogwrites.c | 3 ---
>   block/blkverify.c    | 3 ---
>   block/commit.c       | 1 -
>   block/mirror.c       | 1 -
>   block/quorum.c       | 1 -
>   6 files changed, 5 insertions(+), 13 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
