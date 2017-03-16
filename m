Received: from eggs.gnu.org ([2001:4830:134:3::10]:48507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1coRf3-0007pL-Q9
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1coRey-0001d4-SU
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:25:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40214)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1coRey-0001cW-Jn
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 05:25:28 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2G9KWgI055456
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 05:25:26 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 297cf6kg29-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 05:25:26 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 16 Mar 2017 09:25:21 -0000
Date: Thu, 16 Mar 2017 10:25:16 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170313071652.GD6756@bjsdjshi@linux.vnet.ibm.com>
References: <20170217082939.33208-1-bjsdjshi@linux.vnet.ibm.com>
	<20170309092525.GA10189@bjsdjshi@linux.vnet.ibm.com>
	<20170310114605.1353e810.cornelia.huck@de.ibm.com>
	<20170313071652.GD6756@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170316102516.706fc6d6.cornelia.huck@de.ibm.com>
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

On Mon, 13 Mar 2017 15:16:52 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Beside the fixes for former comments form you and Alex, I will also do
> the following stuff in the next version:
> 1. Remove the "RFC" tag from the mail subject.
> 2. Cc the s390 CIO layer maintainers for patch 1 and 2:
>     Sebastian Ott <sebott@linux.vnet.ibm.com>
>     Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
> 3. For the new created files, update MAINTAINERS by adding:
> S390 VFIO-CCW DRIVER
> M:	Cornelia Huck <cornelia.huck@de.ibm.com>

Please add

M: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

as well :)

> L:	linux-s390@vger.kernel.org
> L:	kvm@vger.kernel.org
> S:	Supported
> F:	drivers/s390/cio/vfio_ccw*
> F:	Documentation/s390/vfio-ccw.txt
> F:	include/uapi/linux/vfio_ccw.h
