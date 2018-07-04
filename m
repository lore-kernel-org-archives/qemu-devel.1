Received: from eggs.gnu.org ([2001:4830:134:3::10]:35738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <will.deacon@arm.com>) id 1faiT0-0003LP-RH
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <will.deacon@arm.com>) id 1faiSv-00036P-RC
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:09:10 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45430
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <will.deacon@arm.com>) id 1faiSv-00035x-JS
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 10:09:05 -0400
Date: Wed, 4 Jul 2018 15:09:43 +0100
From: Will Deacon <will.deacon@arm.com>
Message-ID: <20180704140943.GF4828@arm.com>
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-23-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530270944-11351-23-git-send-email-suzuki.poulose@arm.com>
Subject: Re: [Qemu-devel] [kvmtool test PATCH 22/24] kvmtool: arm64: Add
 support for guest physical address size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, marc.zyngier@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org

On Fri, Jun 29, 2018 at 12:15:42PM +0100, Suzuki K Poulose wrote:
> Add an option to specify the physical address size used by this
> VM.
> 
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arm/aarch64/include/kvm/kvm-config-arch.h | 5 ++++-
>  arm/include/arm-common/kvm-config-arch.h  | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arm/aarch64/include/kvm/kvm-config-arch.h b/arm/aarch64/include/kvm/kvm-config-arch.h
> index 04be43d..dabd22c 100644
> --- a/arm/aarch64/include/kvm/kvm-config-arch.h
> +++ b/arm/aarch64/include/kvm/kvm-config-arch.h
> @@ -8,7 +8,10 @@
>  			"Create PMUv3 device"),				\
>  	OPT_U64('\0', "kaslr-seed", &(cfg)->kaslr_seed,			\
>  			"Specify random seed for Kernel Address Space "	\
> -			"Layout Randomization (KASLR)"),
> +			"Layout Randomization (KASLR)"),		\
> +	OPT_INTEGER('\0', "phys-shift", &(cfg)->phys_shift,		\
> +			"Specify maximum physical address size (not "	\
> +			"the amount of memory)"),

Given that this is a shift value, I think the help message could be more
informative. Something like:

	"Specify maximum number of bits in a guest physical address"

I think I'd actually leave out any mention of memory, because this does
actually have an effect on the amount of addressable memory in a way that I
don't think we want to describe in half of a usage message line :)

Will
