Received: from eggs.gnu.org ([2001:4830:134:3::10]:32876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb4VV-0003SI-14
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:04:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cb4VU-0007bZ-8q
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 07:04:25 -0500
Date: Tue, 7 Feb 2017 20:04:15 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170207120415.GJ19280@lemon.lan>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
	<20170203154757.36140-16-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203154757.36140-16-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 15/18] qmp: add block-dirty-bitmap-load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

On Fri, 02/03 18:47, Vladimir Sementsov-Ogievskiy wrote:
>  ##
> +# @block-dirty-bitmap-load:
> +#
> +# Load a dirty bitmap from the storage (qcow2 file or nbd export)
> +#
> +# Returns: nothing on success
> +#          If @node is not a valid block device, DeviceNotFound
> +#          If @name is not found, GenericError with an explanation
> +#
> +# Since: vz-7.4

Version number doesn't look very familiar :)

Fam

> +##
> +  { 'command': 'block-dirty-bitmap-load',
> +    'data': 'BlockDirtyBitmap' }
> +
> +##
>  # @BlockDirtyBitmapSha256:
>  #
>  # SHA256 hash of dirty bitmap data
> -- 
> 2.11.0
> 
