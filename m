Received: from eggs.gnu.org ([2001:4830:134:3::10]:43746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dqG4t-0003XE-LV
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dqG4p-0007up-6Y
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:59:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dqG4o-0007uP-W5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:59:55 -0400
Date: Fri, 8 Sep 2017 11:59:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170908115950.56996cc6.cohuck@redhat.com>
In-Reply-To: <381cb778-5679-634c-9d3d-7276f877da3a@linux.vnet.ibm.com>
References: <20170905182546.00457332.cohuck@redhat.com>
	<fe102a7a-e998-8ebe-b94d-e653c4f66c39@linux.vnet.ibm.com>
	<20170906043108.GY31680@bjsdjshi@linux.vnet.ibm.com>
	<8946b1ec-4d14-c953-deab-aaded7cd2c9d@linux.vnet.ibm.com>
	<20170906162019.45eeec4a.cohuck@redhat.com>
	<cc6eab96-969d-eb66-91b5-cdb965c1bcbb@linux.vnet.ibm.com>
	<20170907085831.GF31680@bjsdjshi@linux.vnet.ibm.com>
	<20170907122400.5b2e3faa.cohuck@redhat.com>
	<27b2addf-0d1c-81d7-1e82-1a8cdac70231@linux.vnet.ibm.com>
	<20170907134134.00f387e8.cohuck@redhat.com>
	<20170908034100.GH31680@bjsdjshi@linux.vnet.ibm.com>
	<381cb778-5679-634c-9d3d-7276f877da3a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Fri, 8 Sep 2017 11:21:57 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> On 09/08/2017 05:41 AM, Dong Jia Shi wrote:
> > Let' me summarize here, in case I misunderstand things. Now we have
> > two ways to choose:
> > 
> > A. Kernel: no change.
> >    Qemu  : handle -EFAULT as option 2 by generating a program check.
> > 
> > B. Kernel: return -EFAULT
> >            +
> >            update the IRB area in the I/O region for option 1 to present
> >            a unit check SCSW (with proper sense byte ECW), and for option
> >            2 to present a program check.
> >    Qemu  : handle -EFAULT according to the information that the IRB area
> >            provided.  
> 
> This is not what I was trying to say. You got my message regarding A, but
> B was supposed to be understood like this.
> 
> Keep the current handling for option 1, that is return -EFAULT. For option
> 2 do what the spec says, execute the program until the bad address and then
> generate a program-check (SCSW) once the bad stuff has it's turn. Thus
> the only change in QEMU would be handling -EFAULT with an unit check (because
> now it's just option 1).

That makes sense to me.
