Received: from eggs.gnu.org ([2001:4830:134:3::10]:47766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIEC6-0007ki-F3
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eIEC5-0008JG-FL
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:39:02 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:35210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eIEC5-0008Iq-82
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:39:01 -0500
Received: by mail-oi0-x242.google.com with SMTP id e142so15103764oih.2
	for <qemu-devel@nongnu.org>; Fri, 24 Nov 2017 05:39:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1511530238-18318-4-git-send-email-eric.auger@redhat.com>
References: <1511530238-18318-1-git-send-email-eric.auger@redhat.com>
	<1511530238-18318-4-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Nov 2017 13:38:39 +0000
Message-ID: <CAFEAcA-ro5AkFt-eAhDX+AhDv5HDs6oezS9UYuT+jsMy5jYMWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] linux-headers: update to pre
 4.15-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, wanghaibin.wang@huawei.com, Vijay Kilari <vijay.kilari@gmail.com>, Andrew Jones <drjones@redhat.com>, Wei Huang <wei@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, wu.wubin@huawei.com

On 24 November 2017 at 13:30, Eric Auger <eric.auger@redhat.com> wrote:
> Update headers against post v4.14 and pre v4.15-rc0.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  include/standard-headers/asm-s390/virtio-ccw.h     |   1 +
>  include/standard-headers/asm-x86/hyperv.h          | 394 +--------------------
>  include/standard-headers/linux/input-event-codes.h |   2 +
>  include/standard-headers/linux/input.h             |   1 +
>  include/standard-headers/linux/pci_regs.h          |  45 ++-
>  linux-headers/asm-arm/kvm.h                        |   8 +
>  linux-headers/asm-arm/kvm_para.h                   |   1 +
>  linux-headers/asm-arm/unistd.h                     |   2 +
>  linux-headers/asm-arm64/kvm.h                      |   8 +
>  linux-headers/asm-arm64/unistd.h                   |   1 +
>  linux-headers/asm-powerpc/epapr_hcalls.h           |   1 +
>  linux-headers/asm-powerpc/kvm.h                    |   1 +
>  linux-headers/asm-powerpc/kvm_para.h               |   1 +
>  linux-headers/asm-powerpc/unistd.h                 |   1 +
>  linux-headers/asm-s390/kvm.h                       |   1 +
>  linux-headers/asm-s390/kvm_para.h                  |   1 +
>  linux-headers/asm-s390/unistd.h                    |   4 +-
>  linux-headers/asm-x86/kvm.h                        |   1 +
>  linux-headers/asm-x86/kvm_para.h                   |   2 +-
>  linux-headers/asm-x86/unistd.h                     |   1 +
>  linux-headers/linux/kvm.h                          |   2 +
>  linux-headers/linux/kvm_para.h                     |   1 +
>  linux-headers/linux/psci.h                         |   1 +
>  linux-headers/linux/userfaultfd.h                  |   1 +
>  linux-headers/linux/vfio.h                         |   1 +
>  linux-headers/linux/vfio_ccw.h                     |   1 +
>  linux-headers/linux/vhost.h                        |   1 +

> --- a/include/standard-headers/asm-x86/hyperv.h
> +++ b/include/standard-headers/asm-x86/hyperv.h
> @@ -1,393 +1 @@
> -#ifndef _ASM_X86_HYPERV_H
> -#define _ASM_X86_HYPERV_H
> -
> -#include "standard-headers/linux/types.h"
> -
> -/*
> - * The below CPUID leaves are present if VersionAndFeatures.HypervisorPresent
> - * is set by CPUID(HvCpuIdFunctionVersionAndFeatures).
> - */
> -#define HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS  0x40000000
> -#define HYPERV_CPUID_INTERFACE                 0x40000001
> -#define HYPERV_CPUID_VERSION                   0x40000002
> -#define HYPERV_CPUID_FEATURES                  0x40000003
> -#define HYPERV_CPUID_ENLIGHTMENT_INFO          0x40000004
> -#define HYPERV_CPUID_IMPLEMENT_LIMITS          0x40000005
> -
> -#define HYPERV_HYPERVISOR_PRESENT_BIT          0x80000000
> -#define HYPERV_CPUID_MIN                       0x40000005
> -#define HYPERV_CPUID_MAX                       0x4000ffff

Did you test building on x86 host? It's hard to see how the
code in QEMU that uses these HYPERV #defines will still compile.

thanks
-- PMM
