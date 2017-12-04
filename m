Received: from eggs.gnu.org ([2001:4830:134:3::10]:59471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLtyR-0004H0-RK
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:52:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eLtyQ-0004EO-Vg
	for qemu-devel@nongnu.org; Mon, 04 Dec 2017 11:52:07 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-21-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-21-mreitz@redhat.com>
Date: Mon, 04 Dec 2017 17:16:32 +0100
Message-ID: <w51wp2231un.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 20/25] block: Generically
 refresh runtime options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Mon 20 Nov 2017 09:09:59 PM CET, Max Reitz wrote:
> Instead of having every block driver which implements
> bdrv_refresh_filename() copy all of the significant runtime options over
> to bs->full_open_options, implement this process generically in
> bdrv_refresh_filename().
>
> This patch only adds this new generic implementation, it does not remove
> the old functionality. This is done in a follow-up patch.
>
> With this patch, some superfluous information (that should never have
> been there) may be removed from some JSON filenames, as can be seen in
> the change to iotest 110's reference output.  In case of 191, backing
> nodes that have not been overridden are now removed from the filename.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>


> +static const char *const *significant_options(BlockDriverState *bs,
> +                                              const char *const *curopt)
> +{
> +    static const char *const global_options[] = {
> +        "driver", "filename", "base-directory", NULL
> +    };

You forgot to remove "base-directory" here from v6, but else the patch
looks good.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
