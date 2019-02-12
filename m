Received: from eggs.gnu.org ([209.51.188.92]:36626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtSSO-0006M0-DI
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gtSEO-00014U-Hy
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:11:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gtSEH-0000rb-Eh
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 02:11:44 -0500
Date: Tue, 12 Feb 2019 15:11:14 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190212071114.GM1011@xz-x1>
References: <20190204142638.27021-1-mst@redhat.com>
	<CAFEAcA8VGhubZk5HFEjNm5f9xdsgO2RdRR6Vcxzmzzyuj-b5JQ@mail.gmail.com>
	<20190204205105-mutt-send-email-mst@kernel.org>
	<CAFEAcA_m8Ebz8NTKM19FV-APQCOJpXVwyWm48uHRdfdKsHu7Bg@mail.gmail.com>
	<20190205110518-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190205110518-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Feb 05, 2019 at 11:06:42AM -0500, Michael S. Tsirkin wrote:
> On Tue, Feb 05, 2019 at 12:41:55PM +0000, Peter Maydell wrote:
> > On Tue, 5 Feb 2019 at 01:52, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > So I think I fixed the build errors. And who knows maybe
> > > that will fix the runtime ones somehow ..
> > > Could you try pls? Re-pushed to same tag.
> > 
> > these failures still remain:
> > 
> > unused variable for OSX and the BSDs:
> > 
> > tests/vhost-user-test.c:942:17: warning: unused variable 'hugefs'
> > [-Wunused-variable]
> >     const char *hugefs;
> >                 ^
> > 
> > Assertion failure on sparc, s390x and PPC64 hosts:
> > 
> > MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> > QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386
> > QTEST_QEMU_IMG=qemu-img tests/vhost-user-test -m=quick -k --tap <
> > /dev/null | ./scripts/tap-driver.pl --test-name="vhost-user-test"
> > qemu-system-i386: backend does not support LE vnet headers; falling
> > back on userspace virtio
> > qemu-system-i386: backend does not support LE vnet headers; falling
> > back on userspace virtio
> > **
> > ERROR:/home/pm215/qemu/tests/vhost-user-test.c:243:wait_for_fds:
> > assertion failed: (s->fds_num)
> > ERROR - too few tests run (expected 4, got 0)
> > 
> > Given the set of hosts affected this is almost certainly
> > a big-endian-host specific bug.
> > 
> > thanks
> > -- PMM
> 
> You were right.
> 
> OK I reverted the whole part dealing with vhost-user and reposted.

I noticed that the merged pull request could possibly have squashed
the below two patches (in previous pull) into one super patch
(a56de056c91f87e1e):

        i386/kvm: ignore masked irqs when update msi routes
        contrib/vhost-user-blk: fix the compilation issue

Here, the first patch lost its commit message, and the last patch lost
its real author. ;)

Regards,

-- 
Peter Xu
