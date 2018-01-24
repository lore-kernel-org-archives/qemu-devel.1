Received: from eggs.gnu.org ([2001:4830:134:3::10]:38825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeRaz-0002De-MK
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eeRau-0002PP-Pf
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:24:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eeRau-0002OT-KD
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:24:28 -0500
Date: Wed, 24 Jan 2018 22:24:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180124222414-mutt-send-email-mst@kernel.org>
References: <1516747387-31760-1-git-send-email-mst@redhat.com>
	<CAFEAcA8UCvw7L55-tw8zacD51zHPa2UeVgxWYgXbMnc3udA3Mw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8UCvw7L55-tw8zacD51zHPa2UeVgxWYgXbMnc3udA3Mw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 0/1] virtio: quick fix
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

On Wed, Jan 24, 2018 at 08:17:08PM +0000, Peter Maydell wrote:
> On 23 January 2018 at 22:44, Michael S. Tsirkin <mst@redhat.com> wrote:
> > This is just a quick bugfix so people can make progress.
> > Will send a pull req with more patches queues later this week.
> >
> > The following changes since commit 52483b067cce4a88ffbf8fbeea26de7549d2ad23:
> >
> >   Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-01-22' into staging (2018-01-23 10:15:09 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 3e59a4745a1668eeec94d142b0f5a7847b866a87:
> >
> >   kvm-all: Partially reverts 4fe6d78b2e to remove the cleanup call (2018-01-24 00:41:50 +0200)
> >
> > ----------------------------------------------------------------
> > virtio: quick fix
> >
> > Fixes a regression in virtio that's causing issues
> > for many people.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > ----------------------------------------------------------------
> > Jose Ricardo Ziviani (1):
> >       kvm-all: Partially reverts 4fe6d78b2e to remove the cleanup call
> >
> >  accel/kvm/kvm-all.c | 4 ----
> >  1 file changed, 4 deletions(-)
> 
> Hi -- this pullreq is superseded by your later one, right?
> 
> thanks
> -- PMM

Exactly, thanks!

-- 
MST
