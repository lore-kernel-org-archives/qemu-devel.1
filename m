Received: from eggs.gnu.org ([2001:4830:134:3::10]:39706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dmKqU-0001ck-BY
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:16:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.vnet.ibm.com>) id 1dmKqP-0000ik-D2
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:16:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45766
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.vnet.ibm.com>)
	id 1dmKqP-0000iY-66
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 10:16:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7SEFLvC065593
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 10:16:48 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2cmjvxrjq1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 10:16:46 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 08:16:03 -0600
References: <cover.1503667215.git.alifm@linux.vnet.ibm.com>
	<3ed8b810b6592daee6a775037ce21f850e40647d.1503667215.git.alifm@linux.vnet.ibm.com>
	<20170825160408.2775c8b5.cohuck@redhat.com>
	<00d41b2b-cf22-c9e2-8d9f-de947f4d3f18@linux.vnet.ibm.com>
	<20170828102214.7aad9112.cohuck@redhat.com>
	<caab4ec1-763a-8dfb-5e88-295a43a41e68@linux.vnet.ibm.com>
	<20170828150653.7cdc8c5a.cohuck@redhat.com>
	<c7e3a1cb-10e6-4c2d-0225-2bcbe9c97de6@linux.vnet.ibm.com>
	<c61c8ee1-3bca-41db-33a7-b65186a80d25@de.ibm.com>
	<b5a9ab05-4e3c-66bc-33ce-d953d7f911e2@linux.vnet.ibm.com>
	<20170828160554.45855dfa.cohuck@redhat.com>
From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 10:15:58 -0400
MIME-Version: 1.0
In-Reply-To: <20170828160554.45855dfa.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <e3f0c9c1-b576-b9bb-66e2-53c2ef94b91b@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] s390-ccw: Fix alignment for CCW1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, pasic@linux.vnet.ibm.com, farman@linux.vnet.ibm.com, walling@linux.vnet.ibm.com



On 08/28/2017 10:05 AM, Cornelia Huck wrote:
>>>> It's the alignment of the CCW which causes the problem.
>>>>
>>>> The exact error message when starting the guest was:
>>>>
>>>> ! No virtio device found !
>>>>
>>>> Since it worked for SCSI and CDL, and failed for LDL disks on that particular system, we are not really sure what caused the failure.
>>>> Debugging it further showed the CCW for LDL disks were not aligned at double word boundary.
> This is really, really odd, as the low-level ccw code is the same for
> any disk type...
>
Exactly!

>>>> Trying the test on a different system with LDL disks worked fine, with the aligned(8) fix.
>>> Do you happen to have an old s390-ccw.img laying around in the test folder? QEMU might pick up
>>> this one (e.g. when calling it without libvirt from the command line).
>>>
>> I explicitly mention the bios to use with '-bios' option and pick up the
>> latest bios. Without the aligned fix I see the error and with the fix it
>> works fine.
> Wait, so the fix fixes it? Or am I confused now?
>

It fixes in my system and one other system we tried on. But fails on a 
system where this issue was first noticed.
