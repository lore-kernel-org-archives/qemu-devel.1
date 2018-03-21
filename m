Received: from eggs.gnu.org ([2001:4830:134:3::10]:33124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyTOx-0007IE-7y
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 22:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eyTOs-0006Ls-K0
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 22:22:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36340 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eyTOs-0006LW-GC
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 22:22:50 -0400
Date: Wed, 21 Mar 2018 10:22:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180321022234.GB16095@lemon.usersys.redhat.com>
References: <1521556695-35907-1-git-send-email-mst@redhat.com>
	<152157445744.177.10520299969738107726@71c20359a636>
	<20180321012530.GB12771@lemon.usersys.redhat.com>
	<20180321040251-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321040251-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] postcopy-ram: add a stub for
 postcopy_request_shared_page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, dgilbert@redhat.com, quintela@redhat.com

On Wed, 03/21 04:03, Michael S. Tsirkin wrote:
> On Wed, Mar 21, 2018 at 09:25:30AM +0800, Fam Zheng wrote:
> > On Tue, 03/20 12:34, no-reply@patchew.org wrote:
> > > /tmp/qemu-test/src/migration/postcopy-ram.c:787:41: error: 'struct PostCopyFD' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> > >  int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
> > >                                          ^~~~~~~~~~
> > > /tmp/qemu-test/src/migration/postcopy-ram.c:787:5: error: no previous prototype for 'postcopy_request_shared_page' [-Werror=missing-prototypes]
> > >  int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
> > >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > cc1: all warnings being treated as errors
> > 
> > Is a "#include ..." line missing?
> > 
> > Fam
> 
> This patch isn't against mainline.

OK! BTW there is a syntax for patchew to attempt a different base than master:

Based-on: <the-base-series-cover-letter-messge-id>
