Received: from eggs.gnu.org ([2001:4830:134:3::10]:33923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gAbMZ-0006h3-H2
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gAbMY-0006Pk-Qm
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 09:50:51 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181005234023.8104-25-mreitz@redhat.com>
References: <20181005234023.8104-1-mreitz@redhat.com>
	<20181005234023.8104-25-mreitz@redhat.com>
Date: Thu, 11 Oct 2018 15:50:41 +0200
Message-ID: <w51bm80mw26.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 24/31] block: Purify
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

On Sat 06 Oct 2018 01:40:16 AM CEST, Max Reitz wrote:
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
> This completely obsoletes blklogwrite's implementation of
> .bdrv_refresh_filename().
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
