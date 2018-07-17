Received: from eggs.gnu.org ([2001:4830:134:3::10]:37396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ffNbR-00088t-VL
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ffNbN-0000nD-3M
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:53:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59790 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ffNbM-0000mv-Tz
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:53:05 -0400
Date: Tue, 17 Jul 2018 12:53:01 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180717105301.eutivgp2uyuz7ck5@kamzik.brq.redhat.com>
References: <20180716151438.9877-1-andre.przywara@arm.com>
	<20180716151438.9877-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716151438.9877-3-andre.przywara@arm.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH 2/2] arm64: timer: Add TVAL
 timeout IRQ trigger test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org, qemu-devel@nongnu.org

On Mon, Jul 16, 2018 at 04:14:38PM +0100, Andre Przywara wrote:
> So far we were only testing the CVAL register. Add a test which programs
> a (relative) TVAL value to check this functionality as well.
> Also we go into WFI and wait for the interrupt to release us from it.
> The timer tests are run with a 2 second timeout on the host side, so
> that any failure in coming back would be covered.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/timer.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
