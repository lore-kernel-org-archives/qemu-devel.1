Received: from eggs.gnu.org ([2001:4830:134:3::10]:38358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZyeh-00044t-1T
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:14:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZyeb-000212-Vf
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:14:11 -0400
Received: from foss.arm.com ([217.140.101.70]:39320)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZyeb-00020Q-1k
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:14:05 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-16-git-send-email-suzuki.poulose@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <f7715da8-73ea-28fb-9883-8d0c048e0792@arm.com>
Date: Mon, 2 Jul 2018 14:13:59 +0100
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-16-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/20] kvm: arm/arm64: Allow tuning the
 physical address size for VM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org, Peter Maydel <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

On 29/06/18 12:15, Suzuki K Poulose wrote:
> Allow specifying the physical address size for a new VM via
> the kvm_type argument for KVM_CREATE_VM ioctl. This allows
> us to finalise the stage2 page table format as early as possible
> and hence perform the right checks on the memory slots without
> complication. The size is encoded as Log2(PA_Size) in the bits[7:0]
> of the type field and can encode more information in the future if
> required. The IPA size is still capped at 40bits.

Can't we relax this? There is no technical reason (AFAICS) not to allow
going down to 36bit IPA if the user has requested it.

If we run on a 36bit IPA system, the default would fail. But if the user
specified "please give me a 36bit IPA VM", we could satisfy that
requirement and allow them to run their stupidly small guest!

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
