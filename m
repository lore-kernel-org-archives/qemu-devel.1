Received: from eggs.gnu.org ([2001:4830:134:3::10]:41103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erZ2B-0000sj-PZ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 19:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1erZ2B-00065d-1l
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 19:58:51 -0500
Date: Fri, 2 Mar 2018 08:58:26 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180302005826.GI21198@lemon.usersys.redhat.com>
References: <20180228181946.22958-1-stefanha@redhat.com>
	<20180301011517.GH21336@lemon.usersys.redhat.com>
	<20180301145446.GA30789@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301145446.GA30789@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] vl: introduce vm_shutdown()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On Thu, 03/01 14:54, Stefan Hajnoczi wrote:
> On Thu, Mar 01, 2018 at 09:15:17AM +0800, Fam Zheng wrote:
> > On Wed, 02/28 18:19, Stefan Hajnoczi wrote:
> > > v2:
> > >  * Tackle the .ioeventfd_stop() vs vq handler race by removing the ioeventfd
> > >    from a BH in the IOThread [Fam]
> > > 
> > > There are several race conditions in virtio-blk/virtio-scsi dataplane code.
> > > This patch series addresses them, see the commit description for details on the
> > > individual cases.
> > 
> > This doesn't apply to master. Which branch is it based off?
> 
> Sorry, I was going to look up the Based-on: syntax and then forgot.  I'm
> not sure where it's documented, here is a guess at how it works:
> 
> Based-on: "[PATCH v3 0/5] block: fix blk_aio_*() segfault when blk->root == NULL" <20180216165015.30715-1-stefanha@redhat.com>

Sorry for the poor documentation of Patchew, we should improve the situation
soon:

Based-on: <20180216165015.30715-1-stefanha@redhat.com>
([PATCH v3 0/5] block: fix blk_aio_*() segfault when blk->root == NULL)

(Only the "Based-on:" line matters)

Fam
