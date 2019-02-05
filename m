Received: from eggs.gnu.org ([209.51.188.92]:55444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqptB-0001fR-IQ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 20:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gqptA-0005HP-JJ
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 20:51:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gqpt9-0005FF-JY
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 20:51:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B4CE3D945
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 01:51:02 +0000 (UTC)
Date: Mon, 4 Feb 2019 20:50:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190204204841-mutt-send-email-mst@kernel.org>
References: <20190204142638.27021-1-mst@redhat.com>
	<CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/25] pci, pc, virtio: fixes, cleanups,
 features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>, cohuck@redhat.com

On Mon, Feb 04, 2019 at 05:59:16PM +0000, Peter Maydell wrote:
> On Mon, 4 Feb 2019 at 14:43, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit b3fc0af1ff5e922d4dd7c875394dbd26dc7313b4:
> >
> >   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-02-01 17:58:27 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 5feab30ea98e30446361d184331b7b5ff94b4116:
> >
> >   contrib/libvhost-user: cleanup casts (2019-02-04 09:23:56 -0500)
> >
> > ----------------------------------------------------------------
> > pci, pc, virtio: fixes, cleanups, features
> >
> > vhost user blk discard/write zeroes features
> > misc cleanups and fixes all over the place
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Hi; I'm afraid this failed build/test on various platforms.
> 


...


> 
> Test failures on sparc host due to an assert:
> 
> ERROR:/home/pm215/qemu/tests/vhost-user-test.c:243:wait_for_fds:
> assertion failed: (s->fds_num)
> Aborted
> 
> and the same on s390x, with a bit more detail:
> 
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
> QTEST_QEMU_IMG=qemu-img tests/vhost-user-test -m=quick -k --tap <
> /dev/null | ./scripts/tap-driver.pl --test-name="vhost-user-test"
> qemu-system-i386: backend does not support LE vnet headers; falling
> back on userspace virtio
> qemu-system-i386: backend does not support LE vnet headers; falling
> back on userspace virtio
> **
> ERROR:/home/linux1/qemu/tests/vhost-user-test.c:243:wait_for_fds:
> assertion failed: (s->fds_num)
> Aborted (core dumped)
> ERROR - too few tests run (expected 4, got 0)
> /home/linux1/qemu/tests/Makefile.include:858: recipe for target
> 'check-qtest-i386' failed


Cornelia do you happen to have a system where you can help
me debug this?

-- 
MST
