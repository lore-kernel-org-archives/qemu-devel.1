Received: from eggs.gnu.org ([2001:4830:134:3::10]:57259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cZLdv-0005QO-QL
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:58:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cZLdr-0005Kl-T8
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:57:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cZLdr-0005KM-NL
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 12:57:55 -0500
References: <32ff6fa9-696a-f4a2-e884-3b22f91506e5@iki.fi>
	<128aeca5-099c-e82b-5cc7-314c899231de@redhat.com>
	<CAKv+Gu-k6ZS=+jd5eQ58_M44gzOCJzQhm212ASVr1espiB167A@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <46bb8ce2-bc2f-fb4b-800d-a180c402082c@redhat.com>
Date: Thu, 2 Feb 2017 18:57:51 +0100
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu-k6ZS=+jd5eQ58_M44gzOCJzQhm212ASVr1espiB167A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] KVM/QEMU on Raspberry Pi 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Pekka Enberg <penberg@iki.fi>, KVM devel mailing list <kvm@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>

On 02/02/17 18:48, Ard Biesheuvel wrote:

>>>  ESR 0x02000000          FAR 0x1DE7EC7EDBADC0DE
>>>
> 
> 
> $ git grep -C5 -ni 0x1DE7EC7EDBADC0DE
> arch/arm64/kvm/sys_regs.h-105-static inline void reset_unknown(struct
> kvm_vcpu *vcpu,
> arch/arm64/kvm/sys_regs.h-106-                           const struct
> sys_reg_desc *r)
> arch/arm64/kvm/sys_regs.h-107-{
> arch/arm64/kvm/sys_regs.h-108-  BUG_ON(!r->reg);
> arch/arm64/kvm/sys_regs.h-109-  BUG_ON(r->reg >= NR_SYS_REGS);
> arch/arm64/kvm/sys_regs.h:110:  vcpu_sys_reg(vcpu, r->reg) =
> 0x1de7ec7edbadc0deULL;
> arch/arm64/kvm/sys_regs.h-111-}
> arch/arm64/kvm/sys_regs.h-112-
> 
> In other words (or rather, in words), KVM is triggering this exception
> in the guest deliberately, which I suspect has something to do with
> the lack of a GIC? Are you using these patches Peter mentions?

"detected bad code". Mind = blown.
