Received: from eggs.gnu.org ([2001:4830:134:3::10]:46886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e53ti-0001fI-OH
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e53td-0005uj-4n
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:01:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1e53tc-0005tp-Sd
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 02:01:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9J5xZBg070887
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:01:26 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dpnjy29vx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 02:01:26 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 19 Oct 2017 02:01:19 -0400
Date: Thu, 19 Oct 2017 14:01:13 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017171315.7afc5a59.cohuck@redhat.com>
	<4ac6acdd-ccbf-3ff7-b6ec-5bdbc5456665@linux.vnet.ibm.com>
	<20171018082347.GA5150@bjsdjshi@linux.vnet.ibm.com>
	<20171018115310.44eec1ed.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171018115310.44eec1ed.cohuck@redhat.com>
Message-Id: <20171019060113.GA4612@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] improve error handling for IO instr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, Pierre Morel <pmorel@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

* Cornelia Huck <cohuck@redhat.com> [2017-10-18 11:53:10 +0200]:

> On Wed, 18 Oct 2017 16:23:47 +0800
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > * Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-17 18:19:20 +0200]:
> > 
> > [...]
> > 
> > > >> Testing
> > > >> =======
> > > >>
> > > >> Nothing happened since v2 except for a quick smoke test. Dong Jia gave v2
> > > >> a spin with a focus on vfio-ccw. @Dong Jia I would appreciate some proper
> > > >> testing, especially regarding the changes in vfio-ccw (patch #3).  
> > > > 
> > > > Looks sane to me (if needed, I can fix up the minor things I found).
> > > > 
> > > > In addition to some testing, I'd appreciate some review from others as
> > > > well.
> > > >   
> > > 
> > > Of course, I'm fine with the fixes (won't answer individually). I think
> > > both Dong Jia and Pierre have already put enough work in this to be credited
> > > with a tag, so I really hope they will get around to review this. I would
> > > be especially happy with an Tested-by: Dong Jia since this series is quite
> > > under-tested, and the changes in vfio-ccw aren't just minor.
> > > 
> > > Of course I could come up with a test setup myself, but I hope Dong Jia
> > > already has one, and he is certainly more involved with vfio-ccw.
> > >   
> > Using Conny's s390-next branch + this series (#2-#7), I didn't notice
> > any obvious problem during my fio test.  So for the vfio-ccw related
> > part:
> > Tested-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
> Thanks!
> 
> To which patches may I add the tag? :)
> 
The test should cover the vfio-ccw related part in patch #3, I assume.
So add it there?

-- 
Dong Jia Shi
