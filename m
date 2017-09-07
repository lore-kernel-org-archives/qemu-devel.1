Received: from eggs.gnu.org ([2001:4830:134:3::10]:41148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpw6a-0007XI-QT
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpw6W-0006qJ-9y
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:40:24 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:34821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpw6W-0006pu-2w
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 08:40:20 -0400
Received: by mail-wr0-x235.google.com with SMTP id m18so2641615wrm.2
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 05:40:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 13:39:58 +0100
Message-ID: <CAFEAcA-79barRXh-H1g16UgiswsQqtHnYKLv4_Vhp89nNxM2NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 00/20] ARM SMMUv3 Emulation Support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 1 September 2017 at 18:21, Eric Auger <eric.auger@redhat.com> wrote:
> This series implements the emulation code for ARM SMMUv3.
>
> Changes since v6:
> - DPDK testpmd now running on guest with 2 assigned VFs
> - Changed the instantiation method: add the following option to
>   the QEMU command line
>   -device smmuv3 # for virtio/vhost use cases
>   -device smmuv3,caching-mode # for vfio use cases (based on [1])
> - splitted the series into smaller patches to allow the review
> - the VFIO integration based on "tlbi-on-map" smmuv3 driver
>   is isolated from the rest: last 2 patches, not for upstream.
>   This is shipped for testing/bench until a better solution is found.
> - Reworked permission flag checks and event generation

Hi Eric -- I see you've upgraded this from an RFC to a PATCH set.
Do you want the patches reviewed and (eventually) taken into git
now?

thanks
-- PMM
