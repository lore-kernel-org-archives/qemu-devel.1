Received: from eggs.gnu.org ([2001:4830:134:3::10]:58703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn3d6-00031n-FE
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:10:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fn3d5-0004SA-MH
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 11:10:36 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180628000745.4477-14-mreitz@redhat.com>
References: <20180628000745.4477-1-mreitz@redhat.com>
	<20180628000745.4477-14-mreitz@redhat.com>
Date: Tue, 07 Aug 2018 17:10:28 +0200
Message-ID: <w51lg9i8b6j.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v9 13/31] block: Fix
 bdrv_find_backing_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Thu 28 Jun 2018 02:07:27 AM CEST, Max Reitz wrote:
> bdrv_find_backing_image() should use bdrv_get_full_backing_filename() or
> bdrv_make_absolute_filename() instead of trying to do what those
> functions do by itself.
>
> path_combine_deprecated() can now be dropped, so let's do that.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
