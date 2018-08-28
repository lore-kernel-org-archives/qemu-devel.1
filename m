Received: from eggs.gnu.org ([2001:4830:134:3::10]:41445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fud62-0001h0-2f
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:27:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fud61-0007pt-F1
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 08:27:46 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180809213528.14738-3-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
	<20180809213528.14738-3-mreitz@redhat.com>
Date: Tue, 28 Aug 2018 14:27:36 +0200
Message-ID: <w51ftyysmkn.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.1 v10 02/31] block: Use children list
 in bdrv_refresh_filename
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

On Thu 09 Aug 2018 11:34:59 PM CEST, Max Reitz wrote:
> bdrv_refresh_filename() should invoke itself recursively on all
> children, not just on file.
>
> With that change, we can remove the manual invocations in blkverify,
> quorum, commit, mirror, and blklogwrites.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
