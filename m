Received: from eggs.gnu.org ([209.51.188.92]:51039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbiL-0004v1-D3
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEbiK-0004pM-G9
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:34:09 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEbiK-0004oY-52
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:34:08 -0400
Received: by mail-oi1-x241.google.com with SMTP id y84so5248942oia.12
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 08:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190409160219.19026-1-eric.auger@redhat.com>
	<20190410001640.GA25214@xz-x1>
In-Reply-To: <20190410001640.GA25214@xz-x1>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Apr 2019 16:33:55 +0100
Message-ID: <CAFEAcA9LZ21fkGsvw_0+Pro64-JP33qKim8aRNcPnzg9mt16CA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1] hw/arm/smmuv3: Remove
 SMMUNotifierNode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On Wed, 10 Apr 2019 at 01:16, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Apr 09, 2019 at 06:02:19PM +0200, Eric Auger wrote:
> > The SMMUNotifierNode struct is not necessary and brings extra
> > complexity so let's remove it. We now directly track the SMMUDevices
> > which have registered IOMMU MR notifiers.
> >
> > This is inspired from the same transformation on intel-iommu
> > done in commit b4a4ba0d68f50f218ee3957b6638dbee32a5eeef
> > ("intel-iommu: remove IntelIOMMUNotifierNode")
> >
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks; applied to target-arm.next for 4.1.

-- PMM
