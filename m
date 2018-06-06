Received: from eggs.gnu.org ([2001:4830:134:3::10]:49984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQcVk-0004A4-Da
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fQcVj-0001Wi-DI
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:46:16 -0400
References: <20180605185905.4583-1-jsnow@redhat.com>
	<20180605185905.4583-3-jsnow@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <83709868-0a34-e810-cfcb-88f99f36087d@redhat.com>
Date: Wed, 6 Jun 2018 13:46:08 -0400
MIME-Version: 1.0
In-Reply-To: <20180605185905.4583-3-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] qapi: add
 x-block-dirty-bitmap-enable/disable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 06/05/2018 02:59 PM, John Snow wrote:
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> [Added x- prefix. --js]
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  blockdev.c           | 42 ++++++++++++++++++++++++++++++++++++++++++
>  qapi/block-core.json | 42 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)
> 

[...]

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 4b1de474a9..c061884a0e 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1808,6 +1808,48 @@
>  { 'command': 'block-dirty-bitmap-clear',
>    'data': 'BlockDirtyBitmap' }
>  
> +##
> +# @x-block-dirty-bitmap-enable:
> +#
> +# Enables a dirty bitmap so that it will begin tracking disk changes.
> +#
> +# Returns: nothing on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found, GenericError with an explanation
> +#
> +# Since: 2.12

Since 3.0

> +#
> +# Example:
> +#
> +# -> { "execute": "x-block-dirty-bitmap-enable",
> +#      "arguments": { "node": "drive0", "name": "bitmap0" } }
> +# <- { "return": {} }
> +#
> +##
> +  { 'command': 'x-block-dirty-bitmap-enable',
> +    'data': 'BlockDirtyBitmap' }
> +
> +##
> +# @x-block-dirty-bitmap-disable:
> +#
> +# Disables a dirty bitmap so that it will stop tracking disk changes.
> +#
> +# Returns: nothing on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found, GenericError with an explanation
> +#
> +# Since: 2.12

Since 3.0

> +#
> +# Example:
> +#
> +# -> { "execute": "x-block-dirty-bitmap-disable",
> +#      "arguments": { "node": "drive0", "name": "bitmap0" } }
> +# <- { "return": {} }
> +#
> +##
> +    { 'command': 'x-block-dirty-bitmap-disable',
> +      'data': 'BlockDirtyBitmap' }
> +
>  ##
>  # @BlockDirtyBitmapSha256:
>  #
> 
