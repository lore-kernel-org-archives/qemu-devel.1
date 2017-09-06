Received: from eggs.gnu.org ([2001:4830:134:3::10]:56897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dpRzx-0002SG-NO
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 00:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dpRzt-0000q0-MQ
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 00:31:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46775
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dpRzt-0000nH-GA
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 00:31:29 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v864SgWD091303
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 00:31:27 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ct3hgvj2f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 00:31:27 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 00:31:27 -0400
Date: Wed, 6 Sep 2017 12:31:08 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170830163609.50260-1-pasic@linux.vnet.ibm.com>
	<20170830163609.50260-5-pasic@linux.vnet.ibm.com>
	<20170831115535.1e4201d3.cohuck@redhat.com>
	<7540741b-d230-e7c4-50d3-036f31997c8b@linux.vnet.ibm.com>
	<20170905182546.00457332.cohuck@redhat.com>
	<fe102a7a-e998-8ebe-b94d-e653c4f66c39@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe102a7a-e998-8ebe-b94d-e653c4f66c39@linux.vnet.ibm.com>
Message-Id: <20170906043108.GY31680@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 4/9] s390x: refactor error handling for
 SSCH and RSCH
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-06 00:30:58 +0200]:

[...]

> > 
> >> But I guess, I was afraid of somebody blaming me for this
> >> comment (such TODOs in production code are a bit strange -- what
> >> does it mean: we did not bother to figure it out?).
> > 
> > For one, the TODO is preexisting... and we really should remember to
> > figure out if there's something better rather than just drop the
> > comment.
> > 
> > (And I sure hope nobody is using vfio-ccw in production yet...)
> >
> Since blame says the TODO has been around since 2017-05-17
> let me have a critical look at it.
> 
> At a first glance I would say addressing exception for SSCH
> is not what we want: the only possibility I see for address
> exception for SSCH is due to the ORB address. But if that's
> the case we will never reach the code in question.
Agree.

> So I suppose we can do better.
As the comment said, I'm (still) in the state of 'wondering'.

> 
> Adding Ren. @Ren: Do you agree with my analysis. If you do,
> I could come up with a proposal what to do -- after some reading.
If you have a better idea, and time, why not? ;)

> 
> Regards,
> Halil

-- 
Dong Jia Shi
