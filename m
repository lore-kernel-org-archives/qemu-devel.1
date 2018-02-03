Received: from eggs.gnu.org ([2001:4830:134:3::10]:54615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ei0Nh-0001Vd-QT
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 11:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ei0Ng-00021W-Uy
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 11:09:33 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<20180116125427.18540-4-vsementsov@virtuozzo.com>
Date: Sat, 03 Feb 2018 17:09:17 +0100
In-Reply-To: <20180116125427.18540-4-vsementsov@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Tue, 16 Jan 2018 15:54:24 +0300")
Message-ID: <87fu6if42a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qapi: add
 block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org, jsnow@redhat.com

Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> writes:

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>  blockdev.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 827254db22..b3851ee760 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1672,6 +1672,48 @@
>    'data': 'BlockDirtyBitmap' }
>  
>  ##
> +# @block-dirty-bitmap-enable:
> +#
> +# Enable dirty bitmap, so that it will continue tracking disk changes.
> +#
> +# Returns: nothing on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found, GenericError with an explanation

What do you mean by "with an explanation"?  If it's the error objects
@desc member: that's trivial, any error carries it.

The less error classes other than GenericError are used, the happier I
am...  Do users really need to distinguish between these two errors?

> +#
> +# Since: 2.12
> +#
> +# Example:
> +#
> +# -> { "execute": "block-dirty-bitmap-enable",
> +#      "arguments": { "node": "drive0", "name": "bitmap0" } }
> +# <- { "return": {} }
> +#
> +##
> +  { 'command': 'block-dirty-bitmap-enable',
> +    'data': 'BlockDirtyBitmap' }
> +
> +##
> +# @block-dirty-bitmap-disable:
> +#
> +# Disable dirty bitmap, so that it will stop tracking disk changes.
> +#
> +# Returns: nothing on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found, GenericError with an explanation

Likewise.

> +#
> +# Since: 2.12
> +#
> +# Example:
> +#
> +# -> { "execute": "block-dirty-bitmap-disable",
> +#      "arguments": { "node": "drive0", "name": "bitmap0" } }
> +# <- { "return": {} }
> +#
> +##
> +    { 'command': 'block-dirty-bitmap-disable',
> +      'data': 'BlockDirtyBitmap' }
> +
> +##
>  # @BlockDirtyBitmapSha256:
>  #
>  # SHA256 hash of dirty bitmap data
[...]
