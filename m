Received: from eggs.gnu.org ([2001:4830:134:3::10]:41748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fEG6m-0001eN-3g
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1fEG6h-0006PE-4J
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:25:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37082
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1fEG6g-0006NV-VO
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:25:19 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w43FKvbL117655
	for <qemu-devel@nongnu.org>; Thu, 3 May 2018 11:25:16 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hr3s7v3j1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:25:15 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 3 May 2018 09:25:15 -0600
References: <20180502125221.4877-1-cohuck@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 3 May 2018 11:25:08 -0400
MIME-Version: 1.0
In-Reply-To: <20180502125221.4877-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <cbe7b21c-639c-aa64-4777-03d0aa793ac8@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org



On 05/02/2018 08:52 AM, Cornelia Huck wrote:
> We currently pass an integer as the subcode parameter. However,
> the upper bits of the register containing the subcode need to
> be 0, which is not guaranteed unless we explicitly specify the
> subcode to be an unsigned long value.
> 
> Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag 308/6")
> Cc:qemu-stable@nongnu.org
> Signed-off-by: Cornelia Huck<cohuck@redhat.com>

Sorry for my ignorance, but is there a C standard that says upper bits 
of an int is not guaranteed to be 0?

Thanks
Farhan
