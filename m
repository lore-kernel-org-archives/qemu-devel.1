Received: from eggs.gnu.org ([2001:4830:134:3::10]:35870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eHmkD-0003ah-Ro
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eHmk9-00005f-Ba
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:20:25 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eHmk9-0008WQ-2J
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 03:20:21 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAN8Jmfh032364
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 03:20:18 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ednj8pqu9-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 03:20:18 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 23 Nov 2017 01:20:09 -0700
Date: Thu, 23 Nov 2017 16:20:03 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
	<20171108165422.46267-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171108165422.46267-2-pasic@linux.vnet.ibm.com>
Message-Id: <20171123082003.GJ5859@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/3] s390x/ccs: add ccw-testdev
 emulated device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-11-08 17:54:20 +0100]:

Hi Halil,

> Add a fake device meant for testing the correctness of our css emulation.
> 
> What we currently have is writing a Fibonacci sequence of uint32_t to the
> device via ccw write. The write is going to fail if it ain't a Fibonacci
> and indicate a device exception in scsw together with the proper residual
> count. With this we can do basic verification of data integrity.
> 
> Of course lot's of invalid inputs (besides basic data processing) can be
> tested with that as well.
> 
> We also have a no-op mode where the device just tells all-good! This
> could be useful for fuzzing.
> 
> Usage:
> 1) fire up a qemu with something like -device ccw-testdev,devno=fe.0.0001
>    on the command line
> 2) exercise the device from the guest
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
> 
> Introduction
> ------------
> 
> While discussing v1 we (more or less) decided a test device for ccw is a
> good idea. This is an RFC because there are some unresolved technical
> questions I would like to discuss.
> 
Regarding to test coverage, this mainly covers the cds_read. What we
want would be surely more than this. So to extend the coverage, we need
to design more modes (aka, test cases), right?

If nobody disagrees with the basic idea of this series, I can start a
review then. ;)

[...]

-- 
Dong Jia Shi
