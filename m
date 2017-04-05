Received: from eggs.gnu.org ([2001:4830:134:3::10]:46149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvlxO-0003D2-PT
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvlxL-0005Fs-Bu
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:30:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cvlxL-0005Eb-4B
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 10:30:43 -0400
Date: Wed, 5 Apr 2017 15:30:38 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170405143037.GC2145@work-vm>
References: <1489850003-5652-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170318151330eucas1p102b9378cc23a399528fa7f2440846650@eucas1p1.samsung.com>
	<1489850003-5652-2-git-send-email-a.perevalov@samsung.com>
	<20170404175737.GL2147@work-vm>
	<36fe247f-4431-4ace-8819-9210512ac43a@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36fe247f-4431-4ace-8819-9210512ac43a@samsung.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] userfault: add pid into uffd_msg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org

* Alexey Perevalov (a.perevalov@samsung.com) wrote:
> On 04/04/2017 08:57 PM, Dr. David Alan Gilbert wrote:
> > * Alexey Perevalov (a.perevalov@samsung.com) wrote:
> > > Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> > > ---
> > >   linux-headers/linux/userfaultfd.h | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/linux-headers/linux/userfaultfd.h b/linux-headers/linux/userfaultfd.h
> > > index 2ed5dc3..7b299a2 100644
> > > --- a/linux-headers/linux/userfaultfd.h
> > > +++ b/linux-headers/linux/userfaultfd.h
> > > @@ -77,6 +77,7 @@ struct uffd_msg {
> > >   		struct {
> > >   			__u64	flags;
> > >   			__u64	address;
> > > +			pid_t   pid;
> > >   		} pagefault;
> > Yes, but we'll just rerun the sync of the headers once your change
> > lands in the kernel.
> Like commit "update Linux headers to 4.6"? But I saw additional commit e.g.
> your.
> Anyway, ok.

Right but mine eventually got dropped when an 'update Linux headers...' patch
caught up.

Dave

> > 
> > Dave
> > 
> > >   		struct {
> > > -- 
> > > 1.8.3.1
> > > 
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> > 
> > 
> 
> 
> -- 
> Best regards,
> Alexey Perevalov
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
