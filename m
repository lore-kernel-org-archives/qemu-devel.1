Received: from eggs.gnu.org ([2001:4830:134:3::10]:39885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eM7sl-0008S5-FK
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:43:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eM7sg-0001L4-FP
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:43:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52912
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eM7sg-0001Kr-9Q
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 02:43:06 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB57dQ0I058333
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 02:43:05 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2enpk31xb9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 02:43:04 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 02:43:04 -0500
Date: Tue, 5 Dec 2017 15:43:00 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171201143136.62497-1-pasic@linux.vnet.ibm.com>
	<20171201143136.62497-4-pasic@linux.vnet.ibm.com>
	<20171204122859.1a4fcd21.cohuck@redhat.com>
	<1108d0e7-318b-354f-31da-95d5efb8193c@linux.vnet.ibm.com>
	<20171204171124.4d877b22.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171204171124.4d877b22.cohuck@redhat.com>
Message-Id: <20171205074300.GZ5859@bjsdjshi@linux.vnet.ibm.com>
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
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

* Cornelia Huck <cohuck@redhat.com> [2017-12-04 17:11:24 +0100]:

[...]

This one looks good to me too, so:
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

> 
> (...)
> 
> > > Looks sane. We should put a note into the 2.12 changelog as well.
> > >   
> > 
> > I agree. Who would be responsible for updating the changelog. I'm not
> > familiar with that process yet. To be honest, I wouldn't mind having
> > the changelog notice in your writing style. Guess would be better for
> > everyone ;).
> 
> Just a one-liner once we have the 2.12 changelog page.
> 
> > 
> > There are also other things we identified as TODOs:
> > * Updating https://wiki.qemu.org/Features/Channel_I/O_Passthrough
> > (@Dong Jia, could you take this one)
Ok. Will do soon.

> > * In tree and/or on wiki documentation which is up-to-date and
> > more verbose than commit messages are supposed to be (and Dong
> > Jia's write-up could be incorporated to). I see this one as
> > lower prio though. Any volunteers?
> 
> Long-ish things with links etc. should probably go into the wiki.
> 
> Anyway, feel free to go ahead (it's a wiki :) We can always change
> things later on.
> 
Let me update the wiki based on my understanding (and style :) firstly,
then you can login and improve it as you wish.

-- 
Dong Jia Shi
