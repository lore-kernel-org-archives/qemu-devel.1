Received: from eggs.gnu.org ([2001:4830:134:3::10]:50145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFCY1-0008Br-0u
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 02:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFCXz-00069G-WE
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 02:21:40 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:39665)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFCXz-00064y-Bn
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 02:21:39 -0400
Received: by mail-oi1-x232.google.com with SMTP id y81-v6so3138245oia.6
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 23:21:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181023234112.188140-1-mst@redhat.com>
References: <20181023234112.188140-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Oct 2018 07:21:17 +0100
Message-ID: <CAFEAcA_SPT=Ypyep9QgdyjKyFCFTjnH_ZG+99H008HCpnhbFqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/28] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 October 2018 at 00:41, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966ba3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22' into staging (2018-10-23 17:20:23 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 57b279df457c2c4ef66ce9e1b813df35abde69f7:
>
>   vhost-scsi: prevent using uninitialized vqs (2018-10-23 19:29:58 -0400)
>
> ----------------------------------------------------------------
> pci, pc, virtio: fixes, features
>
> AMD IOMMU VAPIC support + fixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

>  dtc                                  |   2 +-

Hi. This pull request seems to include an accidental update
to the dtc submodule. It's in the "intel_iommu: move ce fetching out
when sync shadow" commit, and it's not mentioned in the commit
message, so I am assuming it is unintentional.

Could you fix that and resubmit, please?

thanks
-- PMM
