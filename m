Received: from eggs.gnu.org ([2001:4830:134:3::10]:47182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1flZUy-00082W-KC
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1flZUv-0005Y7-CD
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:48:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57634 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1flZUv-0005X5-5v
	for qemu-devel@nongnu.org; Fri, 03 Aug 2018 08:48:01 -0400
Date: Fri, 3 Aug 2018 14:47:54 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180803124754.44vp6llktrl7h2vv@kamzik.brq.redhat.com>
References: <20180720153942.26821-1-andre.przywara@arm.com>
	<20180720153942.26821-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720153942.26821-2-andre.przywara@arm.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH v2 1/4] mark exit() and
 abort() as non-returning functions
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

On Fri, Jul 20, 2018 at 04:39:39PM +0100, Andre Przywara wrote:
> exit() and abort() are functions that never return, and (at least)
> GCC has an attribute to flag those functions accordingly. This allows
> the compiler to do further optimizations and to omit various warnings
> about uninitialized variables, for instance.
> Since the actual "play-dead" function is in (inline) assembly, the
> compiler does not recognize its fatal nature, so help it with the
> __builtin_unreachable() hint.
> Flag the prototypes of our fatal functions accordingly.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  lib/arm/io.c     | 1 +
>  lib/libcflat.h   | 7 ++++---
>  lib/powerpc/io.c | 1 +
>  lib/x86/io.c     | 1 +
>  4 files changed, 7 insertions(+), 3 deletions(-)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
