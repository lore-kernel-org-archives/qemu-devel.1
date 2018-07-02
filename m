Received: from eggs.gnu.org ([2001:4830:134:3::10]:56179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZveh-00006G-MQ
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZved-0004Wm-Pk
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:01:59 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:35664
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1fZved-0004WO-IR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:01:55 -0400
References: <1530270944-11351-1-git-send-email-suzuki.poulose@arm.com>
	<1530270944-11351-7-git-send-email-suzuki.poulose@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <daa9d67d-069a-c413-223f-28444341d99d@arm.com>
Date: Mon, 2 Jul 2018 11:01:51 +0100
MIME-Version: 1.0
In-Reply-To: <1530270944-11351-7-git-send-email-suzuki.poulose@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 06/20] kvm: arm/arm64: Remove spurious
 WARN_ON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, cdall@kernel.org, eric.auger@redhat.com, julien.grall@arm.com, will.deacon@arm.com, catalin.marinas@arm.com, punit.agrawal@arm.com, qemu-devel@nongnu.org

On 29/06/18 12:15, Suzuki K Poulose wrote:
> On a 4-level page table pgd entry can be empty, unlike a 3-level
> page table. Remove the spurious WARN_ON() in stage_get_pud().
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Acked-by: Christoffer Dall <cdall@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  virt/kvm/arm/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 061e6b3..308171c 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -976,7 +976,7 @@ static pud_t *stage2_get_pud(struct kvm *kvm, struct kvm_mmu_memory_cache *cache
>  	pud_t *pud;
>  
>  	pgd = kvm->arch.pgd + stage2_pgd_index(addr);
> -	if (WARN_ON(stage2_pgd_none(*pgd))) {
> +	if (stage2_pgd_none(*pgd)) {
>  		if (!cache)
>  			return NULL;
>  		pud = mmu_memory_cache_alloc(cache);
> 

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
