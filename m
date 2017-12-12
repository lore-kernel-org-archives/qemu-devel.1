Received: from eggs.gnu.org ([2001:4830:134:3::10]:35566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eOlBo-0005cO-Bj
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eOlBi-0005IA-CA
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eOlBi-0005Ga-2Y
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:05:38 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBCE540A062551
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 09:05:32 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eteu65gmm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 09:05:31 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 12 Dec 2017 07:05:29 -0700
Date: Tue, 12 Dec 2017 22:05:24 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-4-pasic@linux.vnet.ibm.com>
	<20171204122859.1a4fcd21.cohuck@redhat.com>
	<1108d0e7-318b-354f-31da-95d5efb8193c@linux.vnet.ibm.com>
	<20171204171124.4d877b22.cohuck@redhat.com>
	<20171205074300.GZ5859@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205074300.GZ5859@bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20171212140523.GA7547@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] s390x: deprecate s390-squash-mcss
 machine prop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-12-05 15:43:00 +0800]:

> * Cornelia Huck <cohuck@redhat.com> [2017-12-04 17:11:24 +0100]:
> 
> [...]
> 
> This one looks good to me too, so:
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> 
> > 
> > (...)
> > 
> > > > Looks sane. We should put a note into the 2.12 changelog as well.
> > > >   
> > > 
> > > I agree. Who would be responsible for updating the changelog. I'm not
> > > familiar with that process yet. To be honest, I wouldn't mind having
> > > the changelog notice in your writing style. Guess would be better for
> > > everyone ;).
> > 
> > Just a one-liner once we have the 2.12 changelog page.
> > 
> > > 
> > > There are also other things we identified as TODOs:
> > > * Updating https://wiki.qemu.org/Features/Channel_I/O_Passthrough
> > > (@Dong Jia, could you take this one)
> Ok. Will do soon.
> 
> > > * In tree and/or on wiki documentation which is up-to-date and
> > > more verbose than commit messages are supposed to be (and Dong
> > > Jia's write-up could be incorporated to). I see this one as
> > > lower prio though. Any volunteers?
> > 
> > Long-ish things with links etc. should probably go into the wiki.
> > 
> > Anyway, feel free to go ahead (it's a wiki :) We can always change
> > things later on.
> > 
> Let me update the wiki based on my understanding (and style :) firstly,
> then you can login and improve it as you wish.
The following wiki is just updated. Please feel free to make additional
correction:
https://wiki.qemu.org/Features/Channel_I/O_Passthrough

BTW, Conny mentioned before that we should also update this one:
https://wiki.qemu.org/Features/LegacyRemoval

Should it be done now?

@Halil, if you would like to do the update operation, I will leave it to
you. If you want to delegate, I can do it.

-- 
Dong Jia Shi
