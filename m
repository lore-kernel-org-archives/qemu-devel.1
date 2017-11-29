Received: from eggs.gnu.org ([2001:4830:134:3::10]:47389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eJxcD-00013g-Gf
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:21:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1eJxcA-0004ni-T0
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:21:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36702
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1eJxcA-0004nF-OS
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 03:21:06 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAT8EWYn066199
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 03:21:03 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ehqt0m5pf-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 29 Nov 2017 03:21:03 -0500
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 29 Nov 2017 03:21:02 -0500
Date: Wed, 29 Nov 2017 16:20:56 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171128130758.67556-1-pasic@linux.vnet.ibm.com>
	<20171129081735.GR5859@bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129081735.GR5859@bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20171129082056.GS5859@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/1] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

* Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-11-29 16:17:35 +0800]:

[...]

> T6. squashing off + explicit given id
>   qemu-system-s390x: vmstate: get_nullptr expected VMS_NULLPTR_MARKER
>   qemu-system-s390x: Failed to load s390_css:css
>   qemu-system-s390x: error while loading state for instance 0x0 of device 's390_css'
>   qemu-system-s390x: load of migration failed: Invalid argument
> [Setting vfio-ccw.devno=non-fe.x.xxxx. (same as T1)
s/T1/T2/

>  Fail due to css mismatch - there is no css 0 in the new vm.]
> 
>   Succeed.
> [Setting vfio-ccw.devno=fe.x.xxxx.]
> 

[...]

-- 
Dong Jia Shi
