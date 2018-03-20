Received: from eggs.gnu.org ([2001:4830:134:3::10]:46952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyJOy-0007Wh-GV
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:42:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eyJOx-0004Zv-Mh
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:42:16 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:42298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eyJOx-0004Yb-H2
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 11:42:15 -0400
Received: by mail-ot0-x243.google.com with SMTP id v23-v6so2198264oth.9
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 08:42:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180320170328-mutt-send-email-mst@kernel.org>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
	<CAFEAcA_EbFC2qJvMGKj1gzTBnSgytLaJJfhDcn0FjEsjnvz1Sg@mail.gmail.com>
	<20180320170328-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 15:41:54 +0000
Message-ID: <CAFEAcA8Dxs9u1KyzGmND9H7mPi9+KrBdKzkxTB4+hQYN54JPmg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/50] virtio, vhost, pci, pc: features,
 cleanups
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

On 20 March 2018 at 15:05, Michael S. Tsirkin <mst@redhat.com> wrote:
> I'm curious why does it take that path though.
> Here's the rule
>
> #if defined(__linux__) && defined(__NR_userfaultfd) && defined(CONFIG_EVENTFD)
>
> If it's Linux we'll pick our own copy of the header
> and so __NR_userfaultfd is defined.
>
> CONFIG_EVENTFD is not set?

CONFIG_EVENTFD is set. __NR_userfaultfd is not. It isn't
defined in the system headers, and it's not defined in
our linux-headers/asm-arm64/. Only x86, s390, powerpc
and arm (32-bit) define it. I suspect the build would also
fail on MIPS if I had a mips host in the build set.

thanks
-- PMM
