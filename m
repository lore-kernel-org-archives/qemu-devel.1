Received: from eggs.gnu.org ([209.51.188.92]:40821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggpy3-0004D9-PF
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:54:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggpy3-00020D-0n
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:54:47 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggpy2-0001vx-SQ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 06:54:46 -0500
Received: by mail-ot1-x344.google.com with SMTP id f18so3208312otl.11
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 03:54:45 -0800 (PST)
MIME-Version: 1.0
References: <20190107101041.765-1-eric.auger@redhat.com>
In-Reply-To: <20190107101041.765-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Jan 2019 11:54:34 +0000
Message-ID: <CAFEAcA88LBZWk5G+7M370w-u=SspHnM-nE=piHvCCs-M290tSg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] hw/arm/virt-acpi-build: Set COHACC
 override flag in IORT SMMUv3 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, Andrew Jones <drjones@redhat.com>

On Mon, 7 Jan 2019 at 10:10, Eric Auger <eric.auger@redhat.com> wrote:
>
> Let's report IO-coherent access is supported for translation
> table walks, descriptor fetches and queues by setting the COHACC
> override flag. Without that, we observe wrong command opcodes.
> The DT description also advertises the dma coherency.
>
> Fixes a703b4f6c1ee ("hw/arm/virt-acpi-build: Add smmuv3 node in IORT table")
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> Tested-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>
> ---
> v2 -> v3:
> - added cpu_to_le32
> ---



Applied to target-arm.next, thanks.

-- PMM
