Received: from eggs.gnu.org ([2001:4830:134:3::10]:37981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1df1OJ-0006Kx-A7
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:05:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1df1OI-0003PI-B1
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:05:35 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:32939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1df1OH-0003OV-Sg
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:05:34 -0400
Received: by mail-wr0-x233.google.com with SMTP id v105so11098677wrb.0
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 03:05:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1502142009-9370-1-git-send-email-mst@redhat.com>
References: <1502142009-9370-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Aug 2017 11:05:12 +0100
Message-ID: <CAFEAcA_n5uP+Kw1EPsH+8hoWETd8a_xj1NKKVjjgWWeKkWK7_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] virtio: fix for rc2
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

On 7 August 2017 at 22:40, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit e6a74868d92f858ac33915b6772999d7de2fd288:
>
>   build-sys: add --disable-vhost-user (2017-08-03 15:55:41 +0300)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to e2a7f28693aea7e194ec1435697ec4feb24f8a6f:
>
>   cpu: add APIs to allocate/free CPU environment (2017-08-08 00:31:09 +0300)
>
> ----------------------------------------------------------------
> virtio: fix for rc2
>
> It turns out there's a way to setup SHPC on Q35: just put
> a PCI to PCI bridge behind a DMI to PCI one. Our _OSC is
> thus incorrect.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Applied, thanks.

-- PMM
