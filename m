Received: from eggs.gnu.org ([2001:4830:134:3::10]:59432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d8B76-0001vG-7X
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:48:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1d8B72-0003IP-7N
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:48:04 -0400
Received: from mail.kernel.org ([198.145.29.136]:47706)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1d8B72-0003Hj-1s
	for qemu-devel@nongnu.org; Tue, 09 May 2017 15:48:00 -0400
Date: Tue, 9 May 2017 12:47:54 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <c55f2c76-8c22-4d77-664c-82c07220b8b6@redhat.com>
Message-ID: <alpine.DEB.2.10.1705091247410.24729@sstabellini-ThinkPad-X260>
References: <1494356693-13190-1-git-send-email-sstabellini@kernel.org>
	<7598ea81-5fcb-d806-ce18-a6eb401b5259@redhat.com>
	<c55f2c76-8c22-4d77-664c-82c07220b8b6@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2 1/3] xen/9pfs: fix two resource leaks on
 error paths, discovered by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, qemu-devel@nongnu.org, anthony.perard@citrix.com, xen-devel@lists.xen.org, aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org

On Tue, 9 May 2017, Eric Blake wrote:
> On 05/09/2017 02:20 PM, Eric Blake wrote:
> > On 05/09/2017 02:04 PM, Stefano Stabellini wrote:
> >> CID: 1374836
> >>
> >> Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> >> CC: anthony.perard@citrix.com
> >> CC: groug@kaod.org
> >> CC: aneesh.kumar@linux.vnet.ibm.com
> >> ---
> >>  hw/9pfs/xen-9p-backend.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> > 
> > Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> By the way, you forgot to send a 0/3 cover letter (at least, there was
> no In-Reply-To: header in your 1/3 mail).  That makes it harder to
> automate handling of your series; I was going to reply to the series as
> a whole.
> 
> While it is inconvenient for human readers, it is even worse for some of
> the automated patch tooling we have that expects cover letters for any
> multi-patch series.  More patch submission tips at
> http://wiki.qemu.org/Contribute/SubmitAPatch include how to use 'git
> config' to automate the creation of a cover letter.

Sorry about that, and thanks for the review.
