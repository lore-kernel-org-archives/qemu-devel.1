Received: from eggs.gnu.org ([2001:4830:134:3::10]:57294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxXCu-0000ui-Dr
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxXCt-0006QS-LE
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:46:52 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-24-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-24-mreitz@redhat.com>
Date: Wed, 05 Sep 2018 14:46:41 +0200
Message-ID: <w51bm9ct8lq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 23/31] block: Generically
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
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Thu 09 Aug 2018 11:35:20 PM CEST, Max Reitz wrote:
> Instead of having every block driver which implements
> bdrv_refresh_filename() copy all of the strong runtime options over to
> bs->full_open_options, implement this process generically in
> bdrv_refresh_filename().
>
> This patch only adds this new generic implementation, it does not remove
> the old functionality. This is done in a follow-up patch.
>
> With this patch, some superfluous information (that should never have
> been there) may be removed from some JSON filenames, as can be seen in
> the change to iotest 110's reference output.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
