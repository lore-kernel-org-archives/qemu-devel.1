Received: from eggs.gnu.org ([2001:4830:134:3::10]:53763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1defaS-0004up-QE
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:48:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1defaR-0000dW-S1
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 06:48:40 -0400
Date: Mon, 7 Aug 2017 12:48:31 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170807104831.GB6578@localhost.localdomain>
References: <cover.1502075213.git.jcody@redhat.com>
	<403586fbd705655c9e861b9e57648b598b651896.1502075213.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <403586fbd705655c9e861b9e57648b598b651896.1502075213.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] block/vhdx: check for
 offset overflow to bdrv_truncate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, qemu-block@nongnu.org

Am 07.08.2017 um 05:08 hat Jeff Cody geschrieben:
> VHDX uses uint64_t types for most offsets, following the VHDX spec.
> However, bdrv_truncate() takes an int64_t value for the truncating
> offset.  Check for overflow before calling bdrv_truncate().
> 
> N.B.: For a compliant image this is not an issue, as the maximum VHDX
> image size is defined per the spec to be 64TB.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>

Reviewed-by: Kevin Wolf <kwolf@redhat.com>
