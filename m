Received: from eggs.gnu.org ([2001:4830:134:3::10]:55108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqkWf-0005OZ-Rg
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqkWf-0002Ud-1c
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:02:57 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:46841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqkWe-0002UQ-SA
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:02:56 -0500
Received: by mail-oi0-x22f.google.com with SMTP id x12so13672072oie.13
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 11:02:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 19:02:35 +0000
Message-ID: <CAFEAcA9KzitEO21Rgh8Azip+gVJjyobzNbk8sHuQf-ngg+Jjxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v9 00/14] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
> This series implements the emulation code for ARM SMMUv3.
>
> SMMUv3 gets instantiated by adding ",iommu=smmuv3" to the virt
> machine option.
>
> VHOST integration will be handled in a separate series. VFIO
> integration is not targeted at the moment. Only stage 1 and
> AArch64 PTW are supported.
>
> Main changes since v8:
> - fix mingw compilation (qemu/log.h)
> - put gpl v2 license on all files to respect initial license
> - change proto of smmu_ptw* to clarify inputs/outputs and
>   prepare for iotlb emulation
> - fix hash table lookup
> - cleanup access type handling during ptw
> - cleanup reset infra (parent_reset)
> - replace some inline functions by macros
> - fix some CMD fields
> - increment cmdq cons only after cmd execution
> - replace some remaining error_report by qemu_log_mask

What state is this series in now? Is it "seems ready to
go, needs review"? Are you hoping it might get in for 2.12,
or targeting 2.13 ?

thanks
-- PMM
