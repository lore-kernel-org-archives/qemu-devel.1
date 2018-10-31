Received: from eggs.gnu.org ([2001:4830:134:3::10]:36001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHu6e-0002fs-G2
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gHu6V-0007Ek-1n
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 13:16:34 -0400
Date: Wed, 31 Oct 2018 18:16:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181031171611.GB4715@localhost.localdomain>
References: <20181019163013.11787-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019163013.11787-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/11] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

Am 19.10.2018 um 18:30 hat Kevin Wolf geschrieben:
> See patch 2 for an explanation of the motivation.
> 
> v4:
> - Split fix for missing rbd_close() into a separate patch [Eric]
> - Added qemu-iotests case
> 
> v3:
> - Clarified QAPI schema documentation that auto-read-only can only
>   degrade read-write to read-only, not the other way round [Eric]
> - Don't refuse to set copy-on-read=on and auto-read-only=on at the same
>   time; only complain when actually trying to degrade to read-only
> - Let bdrv_apply_auto_read_only() return -EACCESS on all errors
> - Fixed file-posix and gluster implementations [Eric, Niels]
> - Added a patch to make auto-read-only=on the default for human user
>   interfaces (-drive/-hda/...)
> 
> v2:
> - Turn bdrv_set_read_only() into bdrv_apply_auto_read_only()
> - Support the option in a lot more block drivers
> 
> Kevin Wolf (11):
>   block: Update flags in bdrv_set_read_only()
>   block: Add auto-read-only option
>   rbd: Close image in qemu_rbd_open() error path
>   block: Require auto-read-only for existing fallbacks
>   nbd: Support auto-read-only option
>   file-posix: Support auto-read-only option
>   curl: Support auto-read-only option
>   gluster: Support auto-read-only option
>   iscsi: Support auto-read-only option
>   block: Make auto-read-only=on default for -drive
>   qemu-iotests: Test auto-read-only with -drive and -blockdev

Applied to the block branch (with the added hunk in patch 2).

Kevin
