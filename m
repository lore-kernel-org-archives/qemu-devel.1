Received: from eggs.gnu.org ([2001:4830:134:3::10]:34970)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <hch@lst.de>)
	id 1eYYSD-0004pO-Di
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hch@lst.de>) id 1eYYSA-0007eF-Ot
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:31:09 -0500
Received: from verein.lst.de ([213.95.11.211]:33048 helo=newverein.lst.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hch@lst.de>) id 1eYYSA-0007ds-IF
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 09:31:06 -0500
Date: Mon, 8 Jan 2018 15:31:05 +0100
From: Christoph Hellwig <hch@lst.de>
Message-ID: <20180108143105.GC10273@lst.de>
References: <1514940265-18093-1-git-send-email-mjc@sifive.com>
	<1514940265-18093-12-git-send-email-mjc@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1514940265-18093-12-git-send-email-mjc@sifive.com>
Subject: Re: [Qemu-devel] [PATCH v1 11/21] RISC-V HTIF Console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: qemu-devel@nongnu.org, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Sagar Karandikar <sagark@eecs.berkeley.edu>

On Wed, Jan 03, 2018 at 01:44:15PM +1300, Michael Clark wrote:
> HTIF (Host Target Interface) provides console emulation for QEMU. HTIF
> allows identical copies of BBL (Berkeley Boot Loader) and linux to run
> on both Spike and QEMU. BBL provides HTIF console access via the
> SBI (Supervisor Binary Interface) and the linux kernel SBI console.

Do you have a current spec for the SBI?  I haven't been able to find
any current reference since it was removed from the privileged spec.
