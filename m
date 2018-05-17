Received: from eggs.gnu.org ([2001:4830:134:3::10]:51241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJKyn-0006px-Dm
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fJKym-0007Cg-NN
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:38:09 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:45116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fJKym-0007CR-IM
	for qemu-devel@nongnu.org; Thu, 17 May 2018 11:38:08 -0400
Received: by mail-ot0-x243.google.com with SMTP id 15-v6so5517870otn.12
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 08:38:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1526493784-25328-1-git-send-email-eric.auger@redhat.com>
References: <1526493784-25328-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 May 2018 16:37:47 +0100
Message-ID: <CAFEAcA_ddWtr_MLXXU8b-=p14f-BaN1UHpXnNJh9cdYQ7KWh+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] ARM SMMUv3: Fix a couple of Coverity
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 16 May 2018 at 19:03, Eric Auger <eric.auger@redhat.com> wrote:
> This series includes 2 patches that fix Coverity issues respectively
> in smmuv3 and smmu-common code.
>
> Eric Auger (2):
>   hw/arm/smmuv3: Fix Coverity issue in smmuv3_record_event
>   hw/arm/smmu-common: Fix coverity issue in get_block_pte_address
>
>  hw/arm/smmu-common.c | 4 ++--
>  hw/arm/smmuv3.c      | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> --



Applied to target-arm.next, thanks.

-- PMM
