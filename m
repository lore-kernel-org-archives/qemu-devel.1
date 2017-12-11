Received: from eggs.gnu.org ([2001:4830:134:3::10]:41816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eOPa8-000573-Nj
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:01:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eOPa5-0005AD-FC
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 10:01:24 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120201004.14999-6-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
	<20171120201004.14999-6-mreitz@redhat.com>
Date: Mon, 11 Dec 2017 16:00:30 +0100
Message-ID: <w51o9n571ip.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 for-2.12 05/25] block: Respect backing
 bs in bdrv_refresh_filename
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

On Mon 20 Nov 2017 09:09:44 PM CET, Max Reitz wrote:
> Basically, bdrv_refresh_filename() should respect all children of a
> BlockDriverState. However, generally those children are driver-specific,
> so this function cannot handle the general case. On the other hand,
> there are only few drivers which use other children than @file and
> @backing (that being vmdk, quorum, and blkverify).
>
> Most block drivers only use @file and/or @backing (if they use any
> children at all). Both can be implemented directly in
> bdrv_refresh_filename.
>
> The user overriding the file's filename is already handled, however, the
> user overriding the backing file is not. If this is done, opening the
> BDS with the plain filename of its file will not be correct, so we may
> not set bs->exact_filename in that case.
>
> iotests 051 and 191 contain test cases for overwriting the backing file,
> and so their output changes with this patch applied (which I consider a
> good thing). Note that in the case of 191, the implicitly opened
> (non-overridden) base file is included in the json:{} filename as well
> -- this will be remedied by a later patch.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
