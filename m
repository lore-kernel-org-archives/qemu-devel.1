Received: from eggs.gnu.org ([2001:4830:134:3::10]:33570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1f98In-0007ce-6C
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alifm@linux.ibm.com>) id 1f98Ik-0008TF-2v
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:04:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alifm@linux.ibm.com>) id 1f98Ij-0008Sd-RP
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:04:34 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3JC3wOg024743
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 08:04:32 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hes6qmh2m-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 08:04:29 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <alifm@linux.ibm.com>;
	Thu, 19 Apr 2018 08:03:41 -0400
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<307f8b80-fca2-d55f-6bc6-85b794afa15e@linux.ibm.com>
	<842dc876-dd3e-18d9-bfff-128b357b6281@redhat.com>
From: Farhan Ali <alifm@linux.ibm.com>
Date: Thu, 19 Apr 2018 08:03:37 -0400
MIME-Version: 1.0
In-Reply-To: <842dc876-dd3e-18d9-bfff-128b357b6281@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <a3471bd4-85ff-3677-3cfe-136beefb180d@linux.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.13 0/4]
 pc-bios/s390-ccw: Network boot improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org



On 04/19/2018 01:27 AM, Thomas Huth wrote:
> Ah, that's not a memory leak, though it might look like one if you don't
> know what the vring_send_buf function is doing: vring_send_buf adds a
> buffer to a virtio ring for later use. So the buffer is not unused after
> this function, but gets filled in later by the virtio-net device. Thus
> we must not free the buffer here.
> 
> We could free it in the "uninit" function after shutting down the
> device, but OTOH we are then leaving the firmware code anyway by jumping
> into the OS kernel, so it does not really matter whether we free()ed the
> buffers or not.
> 
>   Thomas

That makes a lot of sense now :) thanks a lot for that explanation and 
sorry for my ignorance.
