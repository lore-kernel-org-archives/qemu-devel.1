Received: from eggs.gnu.org ([2001:4830:134:3::10]:53925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej4aJ-0005yO-Rw
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej4aJ-0008Q2-6Z
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:50:59 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180205151835.20812-22-mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-22-mreitz@redhat.com>
Date: Tue, 06 Feb 2018 15:50:16 +0100
Message-ID: <w51shaecguv.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 21/26] block: Purify
 .bdrv_refresh_filename()
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

On Mon 05 Feb 2018 04:18:30 PM CET, Max Reitz wrote:
> Currently, BlockDriver.bdrv_refresh_filename() is supposed to both
> refresh the filename (BDS.exact_filename) and set BDS.full_open_options.
> Now that we have generic code in the central bdrv_refresh_filename() for
> creating BDS.full_open_options, we can drop the latter part from all
> BlockDriver.bdrv_refresh_filename() implementations.
>
> This also means that we can drop all of the existing default code for
> this from the global bdrv_refresh_filename() itself.
>
> Furthermore, we now have to call BlockDriver.bdrv_refresh_filename()
> after having set BDS.full_open_options, because the block driver's
> implementation should now be allowed to depend on BDS.full_open_options
> being set correctly.
>
> Finally, with this patch we can drop the @options parameter from
> BlockDriver.bdrv_refresh_filename(); also, add a comment on this
> function's purpose in block/block_int.h while touching its interface.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
