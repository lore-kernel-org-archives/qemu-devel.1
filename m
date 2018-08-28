Received: from eggs.gnu.org ([2001:4830:134:3::10]:40512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fueJ8-0006JO-Nx
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fueJ7-0008B9-U1
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 09:45:22 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-20-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-20-mreitz@redhat.com>
Date: Tue, 28 Aug 2018 15:45:09 +0200
Message-ID: <w511saisize.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 19/31] block: Use
 bdrv_dirname() for relative filenames
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

On Thu 09 Aug 2018 11:35:16 PM CEST, Max Reitz wrote:
> bdrv_get_full_backing_filename_from_filename() breaks down when it comes
> to JSON filenames. Using bdrv_dirname() as the basis is better because
> since we have BDS, we can descend through the BDS tree to the protocol
> layer, which gives us a greater probability of finding a non-JSON name;
> also, bdrv_dirname() is more correct as it allows block drivers to
> override the generation of that directory name in a protocol-specific
> way.
>
> We still need to keep bdrv_get_full_backing_filename_from_filename(),
> though, because it has valid callers which need it during image creation
> when no BDS is available yet.
>
> This makes a test case in qemu-iotest 110, which was supposed to fail,
> work. That is actually good, but we need to change the reference output
> (and the comment in 110) accordingly.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
