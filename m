Received: from eggs.gnu.org ([2001:4830:134:3::10]:39147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXqRs-0002Fg-5x
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:04:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXqRr-0006wg-6u
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:04:08 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:33956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXqRr-0006wQ-0j
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 12:04:07 -0400
Received: by mail-ot0-x244.google.com with SMTP id i17-v6so8741132otl.1
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 09:04:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529653501-15358-1-git-send-email-eric.auger@redhat.com>
References: <1529653501-15358-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 17:03:45 +0100
Message-ID: <CAFEAcA9CNTF9xsfcKyCpEDX-meb6JyqbicWpZdqGPc8YAU4b8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/4] ARM SMMUv3: IOTLB Emulation and
 VHOST Support
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

On 22 June 2018 at 08:44, Eric Auger <eric.auger@redhat.com> wrote:
> This series brings translation configuration caching and IOTLB
> emulation.  The last patch implements VHOST integration and
> allows to run VSMMUv3 along with VHOST emulated end points.
>
> The first patch fixes the passthrough mode bug reported by Jia.
> It reworks the translate function and this series needed to be
> rebased on it.
>
> Best Regards
>
> Eric
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/v2.12.0-vsmmu-optim-v4
> Previous version at:
> https://github.com/eauger/qemu/tree/v2.12.0-vsmmu-optim-v3
>
> History:
>
> v3 -> v4:
> - (new == IOMMU_NOTIFIER_MAP) replaced by (new & IOMMU_NOTIFIER_MAP)
>   in smmuv3_notify_flag_changed
>
> v2 -> v3:
> - collected Peter's R-b
> - do not use float in trace points anymore
>
> v1 -> v2:
> - addition of the 1st patch (including addr_mask fix)
> - addition of the per device mutex as on intel iommu
>
> v1: [1] v12 last 3 patches resent in this series
> [1] [PATCH v12 00/17] ARM SMMUv3 Emulation Support
> https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg04344.html



Applied to target-arm.next, thanks.

-- PMM
