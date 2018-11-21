Received: from eggs.gnu.org ([2001:4830:134:3::10]:52696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPTMp-0003dg-VB
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:20:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPTMo-0006XK-Vk
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 09:20:35 -0500
Date: Wed, 21 Nov 2018 15:20:23 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181121142023.GC4030@linux.fritz.box>
References: <20181121124747.30696-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121124747.30696-1-rjones@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: Fix crash if underlying host
 file or disk returns error.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 21.11.2018 um 13:47 hat Richard W.M. Jones geschrieben:
> Commit 40dce4ee6 "scsi-disk: fix rerror/werror=ignore" introduced a
> bug which causes qemu to crash with the assertion error below if the
> host file or disk returns an error:
> 
>   qemu-system-x86_64: hw/scsi/scsi-bus.c:1374: scsi_req_complete:
>   Assertion `req->status == -1' failed.
> 
> Kevin Wolf suggested this fix:
> 
>   < kwolf> Hm, should the final return false; in that patch
>            actually be a return true?
>   < kwolf> Because I think he didn't intend to change anything
>            except BLOCK_ERROR_ACTION_IGNORE
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1804323

Thanks, applied to the block branch.

Kevin
