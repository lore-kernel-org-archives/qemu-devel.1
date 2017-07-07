Received: from eggs.gnu.org ([2001:4830:134:3::10]:35264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTO5g-0004Nx-Tf
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTO5g-0004Xe-5B
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:54:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-24-vsementsov@virtuozzo.com>
Date: Fri, 07 Jul 2017 09:54:00 +0200
In-Reply-To: <20170628120530.31251-24-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Wed, 28 Jun 2017 15:05:23 +0300")
Message-ID: <871sps7kdj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v22 23/30] qmp: add persistent flag to
 block-dirty-bitmap-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, jsnow@redhat.com

QAPI schema review only...  I apologize for its lateness.

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Add optional 'persistent' flag to qmp command block-dirty-bitmap-add.
> Default is false.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index f85c2235c7..13f98ec146 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1561,10 +1561,16 @@
>  # @granularity: the bitmap granularity, default is 64k for
>  #               block-dirty-bitmap-add
>  #
> +# @persistent: the bitmap is persistent, i.e. it will be saved to the
> +#              corresponding block device image file on its close. For now only
> +#              Qcow2 disks support persistent bitmaps. Default is false for
> +#              block-dirty-bitmap-add. (Since: 2.10)

"for block-dirty-bitmap-add" suggests there could be other users, with
different (but unspecified) defaults.  What about replacing the sentence
by "(default: false)"?

Please wrap your comment lines around column 70.

> +#
>  # Since: 2.4
>  ##
>  { 'struct': 'BlockDirtyBitmapAdd',
> -  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32' } }
> +  'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
> +            '*persistent': 'bool' } }
>  
>  ##
>  # @block-dirty-bitmap-add:
