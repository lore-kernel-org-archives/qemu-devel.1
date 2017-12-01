Received: from eggs.gnu.org ([2001:4830:134:3::10]:34311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eKph5-0003XK-RU
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eKph4-0002db-Ve
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:05:47 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eKph4-0002dK-PX
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:05:46 -0500
Received: by mail-ot0-x243.google.com with SMTP id s4so9749603ote.4
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 10:05:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1512148088-28733-1-git-send-email-mst@redhat.com>
References: <1512148088-28733-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Dec 2017 18:05:25 +0000
Message-ID: <CAFEAcA-B7nMNTj6+HOSu=qUzaK3+Me83v_OG04=a2W4MU-KziA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] pc, pci, virtio: fixes for rc3
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

On 1 December 2017 at 17:08, Michael S. Tsirkin <mst@redhat.com> wrote:
> The following changes since commit c11d61271b9e6e7a1f0479ef1ca8fb55fa457a=
62:
>
>   Update version for v2.11.0-rc3 release (2017-11-29 17:59:34 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 75ba2ddb188fa07c3442446766782036e3085cba:
>
>   pc: fix crash on attempted cpu unplug (2017-12-01 19:05:58 +0200)
>
> ----------------------------------------------------------------
> pc, pci, virtio: fixes for rc3
>
> A bunch of fixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

You can't send fixes for rc3 2 days after rc3 has been tagged :-)

> Chao Gao (1):
>       i386/msi: Correct mask of destination ID in MSI address
>
> Greg Kurz (1):
>       vhost: fix error check in vhost_verify_ring_mappings()
>
> Igor Mammedov (1):
>       pc: fix crash on attempted cpu unplug
>
> Marc-Andr=C3=A9 Lureau (1):
>       dump-guest-memory.py: fix No symbol "vmcoreinfo_find"
>
> Maxime Coquelin (2):
>       virtio: Add queue interface to restore avail index from vring used =
index
>       vhost: restore avail index from vring used index on disconnection
>
> Prasad J Pandit (1):
>       virtio: check VirtQueue Vring object is set

Are any of these so important that we would absolutely refuse
to release without the fixes (ie they justify rolling an rc4
that we would otherwise not have needed) ?

thanks
-- PMM
