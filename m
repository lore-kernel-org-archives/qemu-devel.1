Received: from eggs.gnu.org ([2001:4830:134:3::10]:40324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1exte4-0002EM-N3
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 08:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1exte1-0002bV-IV
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 08:12:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53404 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1exte1-0002aZ-E5
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 08:12:05 -0400
Date: Mon, 19 Mar 2018 12:11:47 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180319121147.GC3206@work-vm>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-2-xiaoguangrong@tencent.com>
	<20180315102501.GA3062@work-vm>
	<423c901d-16b6-67fb-262b-3021e30871ec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <423c901d-16b6-67fb-262b-3021e30871ec@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/8] migration: stop compressing page in
 migration thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, quintela@redhat.com, liang.z.li@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

* Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
> 
> Hi David,
> 
> Thanks for your review.
> 
> On 03/15/2018 06:25 PM, Dr. David Alan Gilbert wrote:
> 
> > >   migration/ram.c | 32 ++++++++++++++++----------------
> > 
> > Hi,
> >    Do you have some performance numbers to show this helps?  Were those
> > taken on a normal system or were they taken with one of the compression
> > accelerators (which I think the compression migration was designed for)?
> 
> Yes, i have tested it on my desktop, i7-4790 + 16G, by locally live migrate
> the VM which has 8 vCPUs + 6G memory and the max-bandwidth is limited to 350.
> 
> During the migration, a workload which has 8 threads repeatedly written total
> 6G memory in the VM. Before this patchset, its bandwidth is ~25 mbps, after
> applying, the bandwidth is ~50 mbps.

OK, that's good - worth adding those notes to your cover letter.
I wonder how well it works with compression acceleration hardware; I
can't see anything in this series making it worse.

> BTW, Compression will use almost all valid bandwidth after all of our work
> which i will post it out part by part.

Oh, that will be very nice.

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
