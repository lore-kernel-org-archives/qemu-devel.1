Received: from eggs.gnu.org ([2001:4830:134:3::10]:57392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyT5w-0001bK-Aa
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 22:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eyT5t-0000Nz-5S
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 22:03:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53650 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eyT5t-0000NZ-0l
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 22:03:13 -0400
Date: Wed, 21 Mar 2018 04:03:00 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180321040251-mutt-send-email-mst@kernel.org>
References: <1521556695-35907-1-git-send-email-mst@redhat.com>
	<152157445744.177.10520299969738107726@71c20359a636>
	<20180321012530.GB12771@lemon.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321012530.GB12771@lemon.usersys.redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, dgilbert@redhat.com, quintela@redhat.com

On Wed, Mar 21, 2018 at 09:25:30AM +0800, Fam Zheng wrote:
> On Tue, 03/20 12:34, no-reply@patchew.org wrote:
> > /tmp/qemu-test/src/migration/postcopy-ram.c:787:41: error: 'struct PostCopyFD' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
> >  int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
> >                                          ^~~~~~~~~~
> > /tmp/qemu-test/src/migration/postcopy-ram.c:787:5: error: no previous prototype for 'postcopy_request_shared_page' [-Werror=missing-prototypes]
> >  int postcopy_request_shared_page(struct PostCopyFD *pcfd, RAMBlock *rb,
> >      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> 
> Is a "#include ..." line missing?
> 
> Fam

This patch isn't against mainline.
