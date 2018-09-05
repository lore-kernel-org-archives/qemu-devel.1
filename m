Received: from eggs.gnu.org ([2001:4830:134:3::10]:33583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxYhU-0004Yw-Ny
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fxYhT-0005Uj-O8
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:22:32 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-5-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-5-mreitz@redhat.com>
Date: Wed, 05 Sep 2018 16:22:20 +0200
Message-ID: <w5136uot46b.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 04/31] block: Add
 BDS.auto_backing_file
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

On Thu 09 Aug 2018 11:35:01 PM CEST, Max Reitz wrote:
> If the backing file is overridden, this most probably does change the
> guest-visible data of a BDS.  Therefore, we will need to consider this
> in bdrv_refresh_filename().
>
> To see whether it has been overridden, we might want to compare
> bs->backing_file and bs->backing->bs->filename.  However,
> bs->backing_file is changed by bdrv_set_backing_hd() (which is just used
> to change the backing child at runtime, without modifying the image
> header), so bs->backing_file most of the time simply contains a copy of
> bs->backing->bs->filename anyway, so it is useless for such a
> comparison.

What's the point of bs->backing_file then? In what cases is it different
from backing->bs->filename?

Berto
