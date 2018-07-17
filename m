Received: from eggs.gnu.org ([2001:4830:134:3::10]:37294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ffNbA-0007zv-Tb
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ffNb5-0000bI-Vm
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:52:52 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47268 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ffNb5-0000aR-Qq
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 06:52:47 -0400
Date: Tue, 17 Jul 2018 12:52:42 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180717105242.yobbkwvgq3kpq33g@kamzik.brq.redhat.com>
References: <20180716151438.9877-1-andre.przywara@arm.com>
	<20180716151438.9877-2-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716151438.9877-2-andre.przywara@arm.com>
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH 1/2] arm64: timer: add TVAL
 accessors
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

On Mon, Jul 16, 2018 at 04:14:37PM +0100, Andre Przywara wrote:
> The ARM arch timer features the CVAL register, which holds an absolute
> value that is compared against the counter value.
> But there is also the TVAL register, which is defined as (CVAL - counter),
> and can be used to program or read relative timeouts.
> 
> Add accessors for the TVAL register, to be able to read and write them
> easily later.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arm/timer.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
