Received: from eggs.gnu.org ([209.51.188.92]:41119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gmcO4-0007pH-Mf
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:37:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gmcNr-0000Pj-00
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:37:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54930
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gmcNq-0000Nx-GP
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:37:18 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0OAYYOk024116
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:37:17 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2q79m9xt1r-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 05:37:17 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 24 Jan 2019 10:37:15 -0000
Date: Thu, 24 Jan 2019 11:37:08 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190124110637.2e2e3c4c.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-6-cohuck@redhat.com>
	<20190123165148.55aba88b@oc2783563651>
	<20190124110637.2e2e3c4c.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190124113708.2b024784@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 5/5] vfio-ccw: add handling for async
 channel instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Thu, 24 Jan 2019 11:06:37 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 23 Jan 2019 16:51:48 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon, 21 Jan 2019 12:03:54 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > Add a region to the vfio-ccw device that can be used to submit
> > > asynchronous I/O instructions. ssch continues to be handled by the
> > > existing I/O region; the new region handles hsch and csch.
> > > 
> > > Interrupt status continues to be reported through the same channels
> > > as for ssch.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> > 
> > I had a look, and I don't have any new concerns.(New like not raised
> > before.)
> 
> So, what was raised before that I did not address?
> 

I had the cp->initialized in mind here. My understanding is that this is
the point at which safe accessors are necessary. But I consider that
addressed.

I'm still not a fan of this try_lock() and -EAGAIN in write (and just
lock() in read approach), for the reasons I stated before. But it ain't
a deal-breaker for me. It is just that I don't get the benefit of the
busy looping userspace.

Regards,
Halil
