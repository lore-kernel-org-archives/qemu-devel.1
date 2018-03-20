Received: from eggs.gnu.org ([2001:4830:134:3::10]:52141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyJip-0001Ol-H5
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:02:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyJij-0003Uj-PF
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:02:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36470 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyJij-0003UW-KO
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 12:02:41 -0400
Date: Tue, 20 Mar 2018 18:02:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180320175954-mutt-send-email-mst@kernel.org>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
	<CAFEAcA_EbFC2qJvMGKj1gzTBnSgytLaJJfhDcn0FjEsjnvz1Sg@mail.gmail.com>
	<20180320170328-mutt-send-email-mst@kernel.org>
	<CAFEAcA8Dxs9u1KyzGmND9H7mPi9+KrBdKzkxTB4+hQYN54JPmg@mail.gmail.com>
	<20180320174957-mutt-send-email-mst@kernel.org>
	<CAFEAcA-FzKzh8HVC4oX8=g_gS5WDaf51_nBmNgOqX7HDNk3DqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-FzKzh8HVC4oX8=g_gS5WDaf51_nBmNgOqX7HDNk3DqA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Mar 20, 2018 at 03:54:47PM +0000, Peter Maydell wrote:
> On 20 March 2018 at 15:51, Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Tue, Mar 20, 2018 at 03:41:54PM +0000, Peter Maydell wrote:
> >> CONFIG_EVENTFD is set. __NR_userfaultfd is not. It isn't
> >> defined in the system headers, and it's not defined in
> >> our linux-headers/asm-arm64/. Only x86, s390, powerpc
> >> and arm (32-bit) define it. I suspect the build would also
> >> fail on MIPS if I had a mips host in the build set.
> 
> > Let's update headers for arm and mips then?
> 
> Shouldn't that happen automatically?
> 
> thanks
> -- PMM

And apparently it does for arm:
linux-headers/asm-arm/unistd-common.h has __NR_userfaultfd.

What's the story for arm64 and mips?


-- 
MST
