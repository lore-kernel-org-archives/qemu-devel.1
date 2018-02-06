Received: from eggs.gnu.org ([2001:4830:134:3::10]:43073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej3qz-0000VQ-34
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ej3qt-00028B-Hh
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:04:09 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180205151835.20812-21-mreitz@redhat.com>
References: <20180205151835.20812-1-mreitz@redhat.com>
	<20180205151835.20812-21-mreitz@redhat.com>
Date: Tue, 06 Feb 2018 15:03:52 +0100
Message-ID: <w511shydxkn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 20/26] block: Generically refresh
 runtime options
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

On Mon 05 Feb 2018 04:18:29 PM CET, Max Reitz wrote:
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

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
