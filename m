Received: from eggs.gnu.org ([2001:4830:134:3::10]:34367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRNaR-0003Tg-TJ
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gRNaQ-0006xk-SL
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 15:34:31 -0500
References: <1542912487-279165-1-git-send-email-andrey.shinkevich@virtuozzo.com>
	<1542912487-279165-3-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <fb992d27-3615-61cb-4ffa-37896c7edbad@redhat.com>
Date: Mon, 26 Nov 2018 14:34:20 -0600
MIME-Version: 1.0
In-Reply-To: <1542912487-279165-3-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] The discard flag for block stream
 operation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

On 11/22/18 12:48 PM, Andrey Shinkevich wrote:
> Adding a parameter to QMP block-stream command to allow discarding
> blocks in the backing chain while blocks are being copied to the
> active layer.
> 
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   block/stream.c            | 3 +--
>   blockdev.c                | 8 +++++++-
>   hmp-commands.hx           | 4 ++--
>   hmp.c                     | 4 +++-
>   include/block/block_int.h | 2 +-
>   qapi/block-core.json      | 5 ++++-
>   6 files changed, 18 insertions(+), 8 deletions(-)
> 

> +++ b/qapi/block-core.json
> @@ -2334,6 +2334,9 @@
>   #
>   # @speed:  the maximum speed, in bytes per second
>   #
> +# @discard: true to delete blocks duplicated in old backing files.
> +#           (default: false). Since 3.1.
> +#

This feels like a feature addition and not a bug fix, so not appropriate 
for 3.1-rc3.  The next release will be 4.0, so the "since" line should 
be updated accordingly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
