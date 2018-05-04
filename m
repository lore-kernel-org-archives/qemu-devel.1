Received: from eggs.gnu.org ([2001:4830:134:3::10]:43793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEdvY-0000P5-F8
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEdvX-0006o4-Og
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:51:24 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:34287)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEdvX-0006ni-IF
	for qemu-devel@nongnu.org; Fri, 04 May 2018 12:51:23 -0400
Received: by mail-oi0-x241.google.com with SMTP id l1-v6so19712882oii.1
	for <qemu-devel@nongnu.org>; Fri, 04 May 2018 09:51:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524665762-31355-1-git-send-email-eric.auger@redhat.com>
References: <1524665762-31355-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 May 2018 17:51:02 +0100
Message-ID: <CAFEAcA9SyY=1eVdXkHpxyES004T5WAx_h9axDSSo-vk440sfiA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v12 00/17] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On 25 April 2018 at 15:15, Eric Auger <eric.auger@redhat.com> wrote:
> This series implements the emulation code for ARM SMMUv3.
>
> SMMUv3 gets instantiated by adding ",iommu=smmuv3" to the virt
> machine option.
>
> Only stage 1 and AArch64 PTW are supported. [1 - 14] bring the core
> emulation code. [15, 16] bring optimizations and 17 brings the vhost
> integration.
>
> Important Note:
> I added the last 3 patches for consistency but I would be happy
> if [1 - 14] could land upstream first, without waiting for the last
> 3 patch additional review cycles.

I have applied 1-14 to target-arm.next; haven't looked at 15-17,
so I suggest you repost those as their own series once 1-14 are
in master.

thanks
-- PMM
