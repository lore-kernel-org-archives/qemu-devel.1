Received: from eggs.gnu.org ([2001:4830:134:3::10]:37753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4l2L-0000EN-83
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:53:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e4l2K-00063a-Ex
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:53:17 -0400
Date: Wed, 18 Oct 2017 11:53:10 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171018115310.44eec1ed.cohuck@redhat.com>
In-Reply-To: <20171018082347.GA5150@bjsdjshi@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017171315.7afc5a59.cohuck@redhat.com>
	<4ac6acdd-ccbf-3ff7-b6ec-5bdbc5456665@linux.vnet.ibm.com>
	<20171018082347.GA5150@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/7] improve error handling for IO instr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Wed, 18 Oct 2017 16:23:47 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-17 18:19:20 +0200]:
> 
> [...]
> 
> > >> Testing
> > >> =======
> > >>
> > >> Nothing happened since v2 except for a quick smoke test. Dong Jia gave v2
> > >> a spin with a focus on vfio-ccw. @Dong Jia I would appreciate some proper
> > >> testing, especially regarding the changes in vfio-ccw (patch #3).  
> > > 
> > > Looks sane to me (if needed, I can fix up the minor things I found).
> > > 
> > > In addition to some testing, I'd appreciate some review from others as
> > > well.
> > >   
> > 
> > Of course, I'm fine with the fixes (won't answer individually). I think
> > both Dong Jia and Pierre have already put enough work in this to be credited
> > with a tag, so I really hope they will get around to review this. I would
> > be especially happy with an Tested-by: Dong Jia since this series is quite
> > under-tested, and the changes in vfio-ccw aren't just minor.
> > 
> > Of course I could come up with a test setup myself, but I hope Dong Jia
> > already has one, and he is certainly more involved with vfio-ccw.
> >   
> Using Conny's s390-next branch + this series (#2-#7), I didn't notice
> any obvious problem during my fio test.  So for the vfio-ccw related
> part:
> Tested-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

Thanks!

To which patches may I add the tag? :)
