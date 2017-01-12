Received: from eggs.gnu.org ([2001:4830:134:3::10]:41644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cReHY-0003hM-Ps
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:15:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cReHU-00023I-5j
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:15:04 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:33518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cReHT-00022W-Vf
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 07:15:00 -0500
Received: by mail-wj0-x242.google.com with SMTP id kp2so1679114wjc.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 04:14:59 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1483088160-6714-1-git-send-email-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6f6d7a51-8f43-1465-8a8c-594a24f46034@redhat.com>
Date: Thu, 12 Jan 2017 13:14:57 +0100
MIME-Version: 1.0
In-Reply-To: <1483088160-6714-1-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [kvm-unit-tests PATCH 0/8] VT-d ioapic irq test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: Jan Kiszka <jan.kiszka@web.de>, agordeev@redhat.com, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Andrew Jones <drjones@redhat.com>



On 30/12/2016 09:55, Peter Xu wrote:
> The previous vt-d unittest series only contains the very basic tests.
> Let's enlarge it step by step.
> 
> This series expanded it with IOAPIC irq test.
> 
> Peter Xu (8):
>   pci: introduce pci_intx_line()
>   pci: introduce pci_msi_set_enable()
>   lib/asm-generic: add atomic.h
>   x86: ioapic: generalize trigger mode
>   intel-iommu: add report prefixes
>   intel-iommu: use atomic ops for irte index alloc
>   intel-iommu: allow setup trigger mode for irte
>   intel-iommu: add ioapic irq test
> 
>  lib/asm-generic/atomic.h | 21 ++++++++++++++++++
>  lib/pci.c                | 24 ++++++++++++++++++--
>  lib/pci.h                |  2 ++
>  lib/x86/apic.h           |  6 +++++
>  lib/x86/atomic.h         |  2 ++
>  lib/x86/intel-iommu.c    | 58 +++++++++++++++++++++++++++++++++++++++++++-----
>  lib/x86/intel-iommu.h    |  3 +++
>  x86/intel-iommu.c        | 50 ++++++++++++++++++++++++++++++++++++-----
>  x86/ioapic.c             | 34 +++++++++++++---------------
>  9 files changed, 169 insertions(+), 31 deletions(-)
>  create mode 100644 lib/asm-generic/atomic.h
> 

Queued, thanks.

Paolo
