Received: from eggs.gnu.org ([2001:4830:134:3::10]:40724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gVFcx-0003f1-Tg
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:53:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gVFcu-0006Nh-CL
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:53:07 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60374
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gVFct-0006KF-8Y
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:53:03 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wB7Cebui104640
	for <qemu-devel@nongnu.org>; Fri, 7 Dec 2018 07:53:01 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2p7qkb4ngn-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 07:53:01 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 7 Dec 2018 12:53:00 -0000
Date: Fri, 7 Dec 2018 13:52:53 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20181207132946.00df1f5a.cohuck@redhat.com>
References: <20181205145131.28467-1-cohuck@redhat.com>
	<5d274f2c-23a2-0c4f-9f2d-07cbe529c5ac@de.ibm.com>
	<20181207132946.00df1f5a.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20181207135253.10e3e021@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH RFC] vfio-ap: flag as compatible with
 balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 7 Dec 2018 13:29:46 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 7 Dec 2018 13:17:02 +0100
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
> > On 05.12.2018 15:51, Cornelia Huck wrote:
> > > vfio-ap devices do not pin any pages in the host. Therefore, they
> > > are belived to be compatible with memory ballooning.
> > > 
> > > Flag them as compatible, so both vfio-ap and a balloon can be
> > > used simultaneously.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  

With the comment stuff sorted out:
Reviewed-by: Halil Pasic <pasic@linux.ibm.com> 

@Connie: Just had a look at the MAINTAINERS file and hw/vfio/ap.c
is listed under Arch. support S90 with you as a maintainer, and under
vfio-ap with 4 maintainers listed one of them being me. The question
is who is going to post a PULL request for this?

> > 
> > Does it make sense to add cc stable for 3.1?
> 
> Can do that, given that s390x systems really rely on the ballooner in
> general.
> 

I agree with cc stable.

Halil
