Received: from eggs.gnu.org ([2001:4830:134:3::10]:33395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cmI43-0002N7-Rl
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cmI3z-0006wF-VJ
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:46:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cmI3z-0006vn-LW
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 05:46:23 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2AAhqeJ027350
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 05:46:21 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2937e712b2-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 05:46:21 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 10 Mar 2017 10:46:18 -0000
Date: Fri, 10 Mar 2017 11:46:05 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170309092525.GA10189@bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
	<20170309092525.GA10189@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170310114605.1353e810.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 00/15] basic vfio-ccw infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

On Thu, 9 Mar 2017 17:25:25 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-02-17 09:29:24 +0100]:
> 
> > vfio-ccw: the basic infrastructure
> > ==================================
> > 
> > Introduction
> > ------------
> > 
> > Here we describe the vfio support for I/O subchannel devices for
> > Linux/s390. Motivation for vfio-ccw is to passthrough subchannels to a
> > virtual machine, while vfio is the means.
> > 
> 
> Ping.
> 
> Any more comment for this version?
> 
> Thanks.
> 
> [...]
> 

I just walked through the patch set again and did not notice anything
else. There's still the area of channel path handling, but I don't see
why it shouldn't be able to fit into the infrastructure you introduce
here. (I'd expect most of the interesting stuff there to be handled in
user space anyway.)

You should update MAINTAINERS, though. I'm not sure the s390 cio folks
are prepared to handle vfio-ccw :) (although I think you should cc:
them on the patches exporting cio interfaces.) It's probably best to
take vfio-ccw through the kvm-s390 tree.
