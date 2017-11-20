Received: from eggs.gnu.org ([2001:4830:134:3::10]:41739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eGnHV-0001t9-Ay
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:42:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eGnHU-0001za-IK
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:42:41 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171120141141.24626-3-kwolf@redhat.com>
References: <20171120141141.24626-1-kwolf@redhat.com>
	<20171120141141.24626-3-kwolf@redhat.com>
Date: Mon, 20 Nov 2017 15:41:59 +0100
Message-ID: <w51k1yl811k.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.11 2/2] block: Don't
 request I/O permission with BDRV_O_NO_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

On Mon 20 Nov 2017 03:11:41 PM CET, Kevin Wolf wrote:
> 'qemu-img info' makes sense even when BLK_PERM_CONSISTENT_READ cannot be
> granted because of a block job in a running qemu process. It already
> sets BDRV_O_NO_IO to indicate that it doesn't access the guest visible
> data at all.
>
> Check the BDRV_O_NO_IO flags in blk_new_open(), so that I/O related
> permissions are not unnecessarily requested and 'qemu-img info' can work
> even if BLK_PERM_CONSISTENT_READ cannot be granted.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
