Received: from eggs.gnu.org ([2001:4830:134:3::10]:56172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1flZtJ-0007je-OW
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:13:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1flZtF-0004L8-D1
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:13:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58358 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1flZtF-0004KK-7e
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 09:13:09 -0400
Date: Fri, 3 Aug 2018 15:13:05 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180803131305.rshrvokhexqpwu5y@kamzik.brq.redhat.com>
References: <20180720153942.26821-1-andre.przywara@arm.com>
	<20180720153942.26821-5-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720153942.26821-5-andre.przywara@arm.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v2 4/4] arm/arm64: GICv2:
 add GICD_ITARGETSR testing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, Marc Zyngier <marc.zyngier@arm.com>, Christoffer Dall <christoffer.dall@arm.com>, qemu-devel@nongnu.org, Eric Auger <eric.auger@redhat.com>, kvmarm@lists.cs.columbia.edu

On Fri, Jul 20, 2018 at 04:39:42PM +0100, Andre Przywara wrote:
> Some tests for the ITARGETS registers.
> Bits corresponding to non-existent CPUs must be RAZ/WI.
> These registers must be byte-accessible, also check that accesses beyond
> the implemented IRQ limit are actually read-as-zero/write-ignore.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/gic.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
>  lib/arm/asm/gic.h |  1 +
>  2 files changed, 44 insertions(+)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
