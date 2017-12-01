Received: from eggs.gnu.org ([2001:4830:134:3::10]:51454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eKrDC-0007Hi-Jq
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eKrD7-0003tg-PO
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:43:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eKrD7-0003tG-FI
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 14:42:57 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB1EeeJw039693
	for <qemu-devel@nongnu.org>; Fri, 1 Dec 2017 09:41:27 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ek7semn7h-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 09:41:27 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 1 Dec 2017 14:41:24 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com
	[9.149.105.58])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id vB1EfMjN26804266
	for <qemu-devel@nongnu.org>; Fri, 1 Dec 2017 14:41:22 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D26E24C046
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 14:36:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A55D44C04A
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 14:36:17 +0000 (GMT)
Received: from oc3836556865.ibm.com (unknown [9.152.224.205])
	by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP
	for <qemu-devel@nongnu.org>; Fri,  1 Dec 2017 14:36:17 +0000 (GMT)
From: Halil Pasic <pasic@linux.vnet.ibm.com>
References: <20171128134648.21530-1-cohuck@redhat.com>
	<6513d1c5-032e-b9d0-3dab-f2d0bd337ae2@linux.vnet.ibm.com>
	<20171128152718.229a20fe.cohuck@redhat.com>
	<bf78fad3-b6b2-bf82-2625-477233adb6cf@linux.vnet.ibm.com>
Date: Fri, 1 Dec 2017 15:41:21 +0100
MIME-Version: 1.0
In-Reply-To: <bf78fad3-b6b2-bf82-2625-477233adb6cf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <389e2efe-cbc5-8a78-e009-cd330d4ede6a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 0/2] s390x: cut down on unattached
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org



On 11/28/2017 04:21 PM, Halil Pasic wrote:
[..]
>>> Otherwise at first glance both patches seem sane.
>>
>> Can I count this as an ack, or do you plan to do more review?
>>
> 
> Yes I was planning to give it another look. And I do already
> have questions. Isn't the QOM composition tree API? I mean
> let's assume the QMP commands working on this tree are not completely
> useless. How is client code (management software) supposed to work,
> assumed it can rely on paths of e.g. properties being stable. Just
> imagine we had this default-cssid property (for the sake of the
> argument, not like we want it) on the css bridge.

Ping! I would like to get this clarified before proceeding with reviewing
this series.

> 
> Now if the composition tree is API then these can only be bug fixes
> (IMHO).
> 
> There are also other oddities I've spotted. My idea was to put
> this composition tree discussion on hold until the vfio-ccw stuff
> is sorted out. I would certainly like to build a better understanding.
> 
> Halil
> 

[..]
