Received: from eggs.gnu.org ([2001:4830:134:3::10]:34742)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqKhc-0007dC-Dg
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:56:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqKhb-0007oO-Al
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:56:16 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:36005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqKhb-0007mQ-2W
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 10:56:15 -0400
Received: by mail-wr0-x229.google.com with SMTP id o42so5145172wrb.3
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 07:56:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <0184EA26B2509940AA629AE1405DD7F2015F5973@DGGEMA503-MBX.china.huawei.com>
References: <0184EA26B2509940AA629AE1405DD7F2015F5973@DGGEMA503-MBX.china.huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 15:55:53 +0100
Message-ID: <CAFEAcA-tCv9HAG4JzgHbW9VC77tYYFD=rp=b1BoKN7UayWc0yA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 4/6] target-arm: kvm64: detect guest
 RAS EXTENSION feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Zhaoshenglong <zhaoshenglong@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, kvm-devel <kvm@vger.kernel.org>, "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, Christoffer Dall <christoffer.dall@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>, Tyler Baicar <tbaicar@codeaurora.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ingo Molnar <mingo@kernel.org>, "bp@suse.de" <bp@suse.de>, Shiju Jose <shiju.jose@huawei.com>, "zjzhang@codeaurora.org" <zjzhang@codeaurora.org>, arm-mail-list <linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, John Garry <john.garry@huawei.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, huangdaode <huangdaode@hisilicon.com>, "Wangzhou (B)" <wangzhou1@hisilicon.com>, Huangshaoyu <huangshaoyu@huawei.com>, Wuquanming <wuquanming@huawei.com>, Linuxarm <linuxarm@huawei.com>, "Zhengqiang (turing)" <zhengqiang10@huawei.com>

On 8 September 2017 at 15:26, gengdongjiu <gengdongjiu@huawei.com> wrote:


>> Shouldn't we need to also tell the kernel that we actually want
>> it to expose RAS to the guest? Compare the PMU code in this function,
>> where we set a kvm_init_features bit to do this.

> In the PMU code, it indeed sets a kvm_init_features bit. Here ARM
> James has a concern that we are depend on the host CPU RAS extension,
> He means that if userspace receives the SIGBUS delivered by host
> memory_failure(), user space should record the CPER for guest
> and handling the error regardless whether host CPU supports RAS
> extension. But I think if user space receives the SIGBUS signal,
> that means
> host CPU RAS module detects the error or CPU consumes the poison
> data, thus we should check whether physical CPU support RAS extension.

I don't understand what you have in mind here. If the host does
not support the CPU RAS extension then we should never get a
SIGBUS in the first place.

In any case this doesn't seem relevant to the question of whether it
should be optional to expose the RAS extension to the *guest*.
Even if the host does support RAS, you should be able to run a
VM that knows nothing about RAS.

thanks
-- PMM
