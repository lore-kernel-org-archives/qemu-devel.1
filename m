Received: from eggs.gnu.org ([2001:4830:134:3::10]:56949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eb0cV-0005k4-7H
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 03:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eb0cS-00020D-6i
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 03:59:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54586)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eb0cR-0001zW-U5
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 03:59:52 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0F8sEiT041477
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 03:59:50 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fgm3jtdtq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 03:59:50 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 15 Jan 2018 01:59:49 -0700
Date: Mon, 15 Jan 2018 16:59:45 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20180111030421.31418-1-bjsdjshi@linux.vnet.ibm.com>
	<f9224bba-08fb-589e-ed6e-d8e967a8fe67@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9224bba-08fb-589e-ed6e-d8e967a8fe67@linux.vnet.ibm.com>
Message-Id: <20180115085945.GC12499@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] vfio: ccw: basic channel path
 event handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, borntraeger@de.ibm.com, pmorel@linux.vnet.ibm.com

* Halil Pasic <pasic@linux.vnet.ibm.com> [2018-01-12 19:10:20 +0100]:

> 
> 
> On 01/11/2018 04:04 AM, Dong Jia Shi wrote:
> > What are still missing, thus need to be offered in the next version are:
> > - I/O termination and FSM state handling if currently we have I/O on the status
> >   switched path.
> > - Vary on/off event is not sensible to a guest.
> 
> I don't see a doc update. We do have documentation (in
> Documentation/s390/vfio-ccw.txt) in which the uapi interface with the
> regions and their purpose/usage  is at least kind of explained. You are
> changing this interface without updating the doc.
> 
> I would like to see documentation on this because I'm under the
> impression either the design is pretty convoluted or I did not
> get it at all.
Ah, I missed the documentation part. Thanks for pointing out. I will add
it in the next cycle.

-- 
Dong Jia Shi
