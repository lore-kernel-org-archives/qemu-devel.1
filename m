Received: from eggs.gnu.org ([2001:4830:134:3::10]:44035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ekC99-0002my-7a
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:07:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ekC96-0007PN-36
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:07:35 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53538 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ekC95-0007Oy-T4
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 12:07:31 -0500
Date: Fri, 9 Feb 2018 19:07:15 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180209190703-mutt-send-email-mst@kernel.org>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
	<CAFEAcA8kvkfoxnQbqZ4Y44uWtbsirCKdmTcnZJzu=ege9YRfTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8kvkfoxnQbqZ4Y44uWtbsirCKdmTcnZJzu=ege9YRfTg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/26] virtio, vhost, pci, pc: features,
 fixes and cleanups
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

On Fri, Feb 09, 2018 at 10:06:42AM +0000, Peter Maydell wrote:
> On 8 February 2018 at 19:08, Michael S. Tsirkin <mst@redhat.com> wrote:
> > The following changes since commit 008a51bbb343972dd8cf09126da8c3b87f4e1c96:
> >
> >   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging (2018-02-08 14:31:51 +0000)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to f4ac9b2e04e8d98854a97bc473353207765aa9e7:
> >
> >   virtio-balloon: include statistics of disk/file caches (2018-02-08 21:06:42 +0200)
> >
> > ----------------------------------------------------------------
> > virtio,vhost,pci,pc: features, fixes and cleanups
> >
> > - a new vhost crypto device
> > - new stats in virtio balloon
> > - virtio eventfd rework for boot speedup
> > - vhost memory rework for boot speedup
> > - fixes and cleanups all over the place
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> 
> Hi. This has some format-string issues:
> 
> /home/peter.maydell/qemu/backends/cryptodev-vhost-user.c: In function
> 'cryptodev_vhost_user_start':
> /home/peter.maydell/qemu/backends/cryptodev-vhost-user.c:112:26:
> error: format '%lu' expects argument of type 'long unsigned int', but
> argument 2 has type 'size_t {aka unsigned int}' [-Werror=format=]
>              error_report("failed to init vhost_crypto for queue %lu", i);
>                           ^
> /home/peter.maydell/qemu/backends/cryptodev-vhost-user.c: In function
> 'cryptodev_vhost_user_init':
> /home/peter.maydell/qemu/backends/cryptodev-vhost-user.c:205:40:
> error: format '%lu' expects argument of type 'long unsigned int', but
> argument 2 has type 'size_t {aka unsigned int}' [-Werror=format=]
>          cc->info_str = g_strdup_printf("cryptodev-vhost-user%lu to %s ",
>                                         ^
> 
> thanks
> -- PMM

Fixed up now, new hash d94c5ae38f25a6e77e07007dcd510b7203a687e8

-- 
MST
