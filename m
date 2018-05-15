Received: from eggs.gnu.org ([2001:4830:134:3::10]:50082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIWB6-0007ow-Mj
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIWB2-0003YQ-Lr
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:23:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fIWB2-0003YF-Gf
	for qemu-devel@nongnu.org; Tue, 15 May 2018 05:23:24 -0400
Date: Tue, 15 May 2018 11:23:23 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180515092323.yyf4l5qthq6higpn@sirius.home.kraxel.org>
References: <20180507150310.2FEA0381924@moya.office.hostfission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507150310.2FEA0381924@moya.office.hostfission.com>
Subject: Re: [Qemu-devel] [PATCHv3 2/2] ps2: Fix mouse stream corruption due
 to lost data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Geoffrey McRae <geoff@hostfission.com>
Cc: qemu-devel@nongnu.org

On Mon, May 07, 2018 at 11:13:12PM +1000, Geoffrey McRae wrote:
> This fixes an issue by adding bounds checking to multi-byte packets
> where the PS/2 mouse data stream may become corrupted due to data being
> discarded when the PS/2 ringbuffer is full.
> 
> Interrupts for Multi-byte responses are postponed until the final byte
> has been queued.
> 
> These changes fix a bug where windows guests drop the mouse device
> entirely requring the guest to be restarted.

Added to input queue.

thanks,
  Gerd
