Received: from eggs.gnu.org ([2001:4830:134:3::10]:55722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fmygX-0003zU-CU
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fmygU-0007Ti-4Q
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:53:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fmygT-0007TV-VI
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 05:53:46 -0400
Date: Tue, 7 Aug 2018 10:53:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180807095337.GD2556@work-vm>
References: <1533031278-5615-1-git-send-email-wei.w.wang@intel.com>
	<20180807073905.GA7265@xz-mi> <5B69567B.8050309@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B69567B.8050309@intel.com>
Subject: Re: [Qemu-devel] [PATCH v2] bitmap: fix BITMAP_LAST_WORD_MASK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, mst@redhat.com

* Wei Wang (wei.w.wang@intel.com) wrote:
> On 08/07/2018 03:39 PM, Peter Xu wrote:
> > On Tue, Jul 31, 2018 at 06:01:18PM +0800, Wei Wang wrote:
> > > When "nbits = 0", which means no bits to mask, this macro is expected to
> > > return 0, instead of 0xffffffff. This patch changes the macro to return
> > > 0 when there is no bit needs to be masked.
> > > 
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > > CC: Juan Quintela <quintela@redhat.com>
> > > CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > CC: Peter Xu <peterx@redhat.com>
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> > 
> > Is there any existing path that can trigger this nbits==0?
> 
> Not sure about other bitmap APIs which call this macro. But it happens in
> the patches we are working on, which use bitmap_count_one.
> It would be good to have the macro itself handle this corner case, so that
> callers won't need to worry about that.

Given that I see you're having a similar discussion on the kernel list
we should see how that pans out before making qemu changes.

Dave

> Best,
> Wei
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
