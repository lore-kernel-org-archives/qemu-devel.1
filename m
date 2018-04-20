Received: from eggs.gnu.org ([2001:4830:134:3::10]:52269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f9Xce-0001UM-Fa
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f9Xcb-0005pD-9f
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:06:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34288 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f9Xcb-0005oW-4k
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 11:06:45 -0400
Date: Fri, 20 Apr 2018 18:06:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180420175948-mutt-send-email-mst@kernel.org>
References: <1524234528-373013-1-git-send-email-mst@redhat.com>
	<CAFEAcA9M5q7Pq-Ooe2h96pW+r+d3m77_oepET8D4JtUUVyqRvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9M5q7Pq-Ooe2h96pW+r+d3m77_oepET8D4JtUUVyqRvQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/1] pc: bugfix
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

On Fri, Apr 20, 2018 at 03:55:31PM +0100, Peter Maydell wrote:
> On 20 April 2018 at 15:29, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit 27e757e29cc79f3f104d2a84d17cdb3b4c11c8ff:
> >
> >   Update version for v2.12.0-rc4 release (2018-04-17 22:26:44 +0100)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to f256f05c94d12eed2c1a0e9b6ed4fb1fb9d8ec72:
> >
> >   intel-iommu: send PSI always when notify_unmap set (2018-04-20 17:26:23 +0300)
> >
> > ----------------------------------------------------------------
> > pc: bugfix
> >
> > Adds missing invalidations in vtd.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Peter Xu (1):
> >       intel-iommu: send PSI always when notify_unmap set
> 
> You really can't send me a pull request at rc4 and expect
> me to apply it without a very clear and detailed rationale
> in the cover letter for why this bug fix justifies having
> to roll an extra rc and delay the release. "bugfix" is
> not sufficient, I'm afraid.
> 
> thanks
> -- PMM

Right, sorry about that.  It fixes a security problem unfortunately.
Would you like me to redo it with a more detailed description?

-- 
MST
