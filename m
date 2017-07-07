Received: from eggs.gnu.org ([2001:4830:134:3::10]:35417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTO6M-0004jq-9H
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTO6L-0004jq-Ga
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:54:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170628120530.31251-1-vsementsov@virtuozzo.com>
	<20170628120530.31251-25-vsementsov@virtuozzo.com>
Date: Fri, 07 Jul 2017 09:54:43 +0200
In-Reply-To: <20170628120530.31251-25-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Wed, 28 Jun 2017 15:05:24 +0300")
Message-ID: <87wp7k65rw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v22 24/30] qmp: add autoload parameter to
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

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Optional. Default is false.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c           | 18 ++++++++++++++++--
>  qapi/block-core.json |  6 +++++-
>  2 files changed, 21 insertions(+), 3 deletions(-)
[...]
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 13f98ec146..5c42cc7790 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1566,11 +1566,15 @@
>  #              Qcow2 disks support persistent bitmaps. Default is false for
>  #              block-dirty-bitmap-add. (Since: 2.10)
>  #
> +# @autoload: the bitmap will be automatically loaded when the image it is stored
> +#            in is opened. This flag may only be specified for persistent
> +#            bitmaps. Default is false for block-dirty-bitmap-add. (Since: 2.10)
> +#

Comments on PATCH 23 apply.

>  # Since: 2.4
>  ##
>  { 'struct': 'BlockDirtyBitmapAdd',
>    'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32',
> -            '*persistent': 'bool' } }
> +            '*persistent': 'bool', '*autoload': 'bool' } }
>  
>  ##
>  # @block-dirty-bitmap-add:
