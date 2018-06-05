Received: from eggs.gnu.org ([2001:4830:134:3::10]:46659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQD8l-0005Kb-5B
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:40:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fQD8k-0006Az-JA
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:40:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37184 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fQD8k-0006Ap-Ev
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 10:40:50 -0400
Date: Tue, 5 Jun 2018 17:40:46 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180605173952-mutt-send-email-mst@kernel.org>
References: <1524550428-27173-1-git-send-email-wei.w.wang@intel.com>
	<20180601045824.GH14867@xz-mi> <5B10F412.8050900@intel.com>
	<20180601104005.GL14867@xz-mi> <20180601153328.GC2531@work-vm>
	<20180605064240.GA9216@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605064240.GA9216@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v7 0/5] virtio-balloon: free page hint
 reporting support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Wei Wang <wei.w.wang@intel.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, liliang.opensource@gmail.com, pbonzini@redhat.com, nilal@redhat.com

On Tue, Jun 05, 2018 at 02:42:40PM +0800, Peter Xu wrote:
> > I think the answer is no - it doesn't matter; by telling the hypervisor
> > the page is 'free' the kernel gives freedom to the hypervisor to
> > discard the page contents.
> 
> Yeh it seems so.

Well not exactly.  I replied to parent with a clarification.
