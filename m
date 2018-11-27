Received: from eggs.gnu.org ([2001:4830:134:3::10]:42720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRdTS-0002aO-Hx
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:32:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRdTO-0005G6-Tf
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:32:20 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRdTM-0005Dj-94
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:32:17 -0500
Received: by mail-ot1-x341.google.com with SMTP id a11so20042969otr.10
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 05:32:16 -0800 (PST)
MIME-Version: 1.0
References: <20181126154616.18173-1-eric.auger@redhat.com>
In-Reply-To: <20181126154616.18173-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Nov 2018 13:32:03 +0000
Message-ID: <CAFEAcA9B_jLiHLzJZrKuhT3SfXB+pzj03D=NiVNWqRc+zc=qTA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1] hw/arm/virt-acpi-build: Fix SMMUv3
 ACPI integration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>

On Mon, 26 Nov 2018 at 15:46, Eric Auger <eric.auger@redhat.com> wrote:
>
> The AcpiIortSmmu3 misses 2 32b fields corresponding to the
> proximity domain and the device id mapping index.
>
> Also let's report IO-coherent access is supported for
> translation table walks, descriptor fetches and queues by
> setting the COHACC override flag. Without that, we observe
> wrong command opcodes. The DT description also advertises
> the dma coherency.
>
> Fixes a703b4f6c1ee ("hw/arm/virt-acpi-build: Add smmuv3 node in IORT table")
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reported-by: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>

Hi; it looks (from looking at the code) like this isn't a
regression from 3.0 -- is that right?

I think this fix has missed rc3 (discussion seems to be ongoing
and it needs more time on-list for review), which means it's
likely to miss the 3.1 release. So at the moment I'm expecting
it to go into 4.0. (Maybe if we need an rc4 for some other reason
we might be able to put it in.)

thanks
-- PMM
