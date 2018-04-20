Received: from eggs.gnu.org ([2001:4830:134:3::10]:45228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9XS5-0000Z1-OW
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f9XS4-0001Bm-WE
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:55:53 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:40897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f9XS4-0001B3-PZ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 10:55:52 -0400
Received: by mail-ot0-x242.google.com with SMTP id h8-v6so9897081otj.7
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 07:55:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524234528-373013-1-git-send-email-mst@redhat.com>
References: <1524234528-373013-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Apr 2018 15:55:31 +0100
Message-ID: <CAFEAcA9M5q7Pq-Ooe2h96pW+r+d3m77_oepET8D4JtUUVyqRvQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] pc: bugfix
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

On 20 April 2018 at 15:29, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 27e757e29cc79f3f104d2a84d17cdb3b4c11c8ff:
>
>   Update version for v2.12.0-rc4 release (2018-04-17 22:26:44 +0100)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to f256f05c94d12eed2c1a0e9b6ed4fb1fb9d8ec72:
>
>   intel-iommu: send PSI always when notify_unmap set (2018-04-20 17:26:23 +0300)
>
> ----------------------------------------------------------------
> pc: bugfix
>
> Adds missing invalidations in vtd.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Peter Xu (1):
>       intel-iommu: send PSI always when notify_unmap set

You really can't send me a pull request at rc4 and expect
me to apply it without a very clear and detailed rationale
in the cover letter for why this bug fix justifies having
to roll an extra rc and delay the release. "bugfix" is
not sufficient, I'm afraid.

thanks
-- PMM
