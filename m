Received: from eggs.gnu.org ([2001:4830:134:3::10]:52474)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfm3-0000z4-Ai
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fVfm2-0004y7-GA
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:15:59 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fVfm2-0004x1-2w
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 12:15:58 -0400
Received: by mail-oi0-x243.google.com with SMTP id 188-v6so92509oid.12
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 09:15:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1528790908-23441-5-git-send-email-eric.auger@redhat.com>
References: <1528790908-23441-1-git-send-email-eric.auger@redhat.com>
	<1528790908-23441-5-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Jun 2018 17:15:37 +0100
Message-ID: <CAFEAcA-BjCG4s4ddcdvV+2LO_mVhAz2utNoAG9iP61vUF4v4pA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/arm/smmuv3: Add notifications on
 invalidation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, jia.he@hxt-semitech.com, Jia He <hejianet@gmail.com>

On 12 June 2018 at 09:08, Eric Auger <eric.auger@redhat.com> wrote:
> On TLB invalidation commands, let's call registered
> IOMMU notifiers. Those can only be UNMAP notifiers.
> SMMUv3 does not support notification on MAP (VFIO).
>
> This patch allows vhost use case where IOTLB API is notified
> on each guest IOTLB invalidation.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
