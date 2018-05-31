Received: from eggs.gnu.org ([2001:4830:134:3::10]:42819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOOZf-00050g-2x
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fOOZa-0001SR-38
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:29:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38726 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fOOZZ-0001S5-Ub
	for qemu-devel@nongnu.org; Thu, 31 May 2018 10:29:02 -0400
Date: Thu, 31 May 2018 15:28:56 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180531142856.GA2936@work-vm>
References: <1525918138-6189-1-git-send-email-junyan.he@gmx.com>
	<20180531131858.GL27838@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180531131858.GL27838@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH V5 0/9] nvdimm: guarantee persistence of
 QEMU writes to persistent memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: junyan.he@gmx.com, qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> David Gilbert previously suggested a memory access interface.  I guess
> it would look something like this:
> 
>   typedef struct {
>       void (*memset)(void *s, int c, size_t n);
>       void (*memcpy)(void *dest, const void *src, size_t n);
>   } MemoryOperations;
> 
> That way code doesn't need if (pmem) A else B.  It can just do
> mem_ops->foo().  Have you looked into this idea?

Yep, it really needs to be less invasive in the migration code;
I think a set of ops like that would make it much less painful.

> Also, there was a discussion about leaving the code unchanged but adding
> an nvdimm_flush() call at the very end of migration.  I think someone
> benchmarked it but can't find the email.  Please post a link or
> summarize the results, because that approach would be much less
> invasive.  Thanks!

Dave

> Stefan


--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
