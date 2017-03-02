Received: from eggs.gnu.org ([2001:4830:134:3::10]:49626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjMCW-00081k-Jv
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:35:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjMCV-00060X-Uk
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:35:04 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjMCV-00060I-OM
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 03:35:03 -0500
Received: by mail-wr0-x230.google.com with SMTP id u48so46677786wrc.0
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 00:35:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 08:34:42 +0000
Message-ID: <CAFEAcA9eo4f7pNR0vchTrKrASNcRvgizDEnj7OcirkvKqe_kdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/15] virtio, pc: fixes, features
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

On 2 March 2017 at 06:20, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit 1e0addb682c3c552fd97480037d4f8ff18e2b87e:
>
>   Merge remote-tracking branch 'remotes/sstabellini/tags/xen-20170228-tag' into staging (2017-03-01 20:33:47 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 077dd74239a99f6c1e77c5c1aa24cfc7f58cd20c:
>
>   hw/pxb-pcie: fix PCI Express hotplug support (2017-03-02 07:31:26 +0200)
>
> ----------------------------------------------------------------
> virtio, pc: fixes, features
>
> virtio support for region caches broke a bunch of stuff - fixing most of
> it though it's not ideal.  Still pondering the right way to fix it.
> New: VM gen ID and hotplug for PXB.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

This is now well past the softfreeze deadline; do you have
a justification for putting new features in during freeze?

thanks
-- PMM
