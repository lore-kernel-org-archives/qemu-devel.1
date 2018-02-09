Received: from eggs.gnu.org ([2001:4830:134:3::10]:44515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekAio-0003aE-MS
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ekAin-00073U-Ub
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:36:18 -0500
Date: Fri, 9 Feb 2018 16:36:11 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180209153611.GK3998@localhost.localdomain>
References: <20180207162920.28386-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180207162920.28386-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: early check for
 blockers on drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 07.02.2018 um 17:29 hat Paolo Bonzini geschrieben:
> Even if an op blocker is present for BLOCK_OP_TYPE_MIRROR_SOURCE,
> it is checked a bit late and the result is that the target is
> created even if drive-mirror subsequently fails.  Add an early
> check to avoid this.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, applied to the block branch.

Kevin
