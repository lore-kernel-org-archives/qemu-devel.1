Received: from eggs.gnu.org ([2001:4830:134:3::10]:49189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gRY1j-0008Ui-BA
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gRY1g-0000tw-6M
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:43:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gRY1g-0000tZ-1T
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 02:43:20 -0500
Date: Tue, 27 Nov 2018 15:43:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181127074309.GE3205@xz-x1>
References: <1542276484-25508-1-git-send-email-wei.w.wang@intel.com>
	<1542276484-25508-5-git-send-email-wei.w.wang@intel.com>
	<20181127060638.GB3205@xz-x1> <5BFCE9B3.4020605@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5BFCE9B3.4020605@intel.com>
Subject: Re: [Qemu-devel] [PATCH v9 4/8] migration: API to clear bits of
 guest free pages from the dirty bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, nilal@redhat.com, riel@redhat.com

On Tue, Nov 27, 2018 at 02:52:35PM +0800, Wei Wang wrote:
> On 11/27/2018 02:06 PM, Peter Xu wrote:
> > On Thu, Nov 15, 2018 at 06:08:00PM +0800, Wei Wang wrote:
> > Again, is it possible to resize during migration?
> > 
> > So I think the check is fine, but uncertain about the comment.
> 
> Yes, resize would not happen with the current implementation.
> But heard it could just be a temporal implementation. Probably
> we could improve the comment like this:
> 
> "
> Though the implementation might not support ram resize currently,
> this could happen in theory with future updates. So the check here
> handles the case that RAMBLOCK is resized after the free page hint is
> reported.
> "

I'm not familiar with that part, but this seems ok to me.

Thanks,

-- 
Peter Xu
