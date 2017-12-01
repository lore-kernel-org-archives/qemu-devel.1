Received: from eggs.gnu.org ([2001:4830:134:3::10]:42738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eKoX4-0001Y5-9m
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eKoX0-0001zn-AP
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:51:22 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52938
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eKoX0-0001z6-56
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:51:18 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB1EYvv8019489
	for <qemu-devel@nongnu.org>; Fri, 1 Dec 2017 09:38:38 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ek7denmcy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Dec 2017 09:38:37 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 1 Dec 2017 14:38:36 -0000
References: <20171128130758.67556-1-pasic@linux.vnet.ibm.com>
	<20171129133733.7fc11968.cohuck@redhat.com>
	<6f7547b8-1346-53ce-3d80-6839c556d724@linux.vnet.ibm.com>
	<20171129182900.409be40f.cohuck@redhat.com>
	<e8d586cf-99bd-3c72-0c39-44408295a744@linux.vnet.ibm.com>
	<20171130143256.2b8d93ba.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 1 Dec 2017 15:38:34 +0100
MIME-Version: 1.0
In-Reply-To: <20171130143256.2b8d93ba.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <94447c83-5ce8-78d5-d4e1-a017efccc297@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 1/1] s390x/css: unrestrict cssids
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Shalini Chellathurai Saroja <shalini@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Boris Fiuczynski <fiuczy@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 11/30/2017 02:32 PM, Cornelia Huck wrote:
> On Thu, 30 Nov 2017 13:32:12 +0100
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> (...)
> 
> Before I spend way too much time on this:
> 
> Is the proposed machine-property interface usable from a libvirt POV?
> IOW, can we go with this now and fix the ugliness later (probably via a
> generic overhaul of the interface)?
> 

I've talked to Boris and Christian yesterday, and we agreed putting
the read only property to the virtual-css-bridge. It's kind of the
'css object' variant all seemed quite happy with, and since the property
is read only, not user creatable is not a problem.

Thus, from our perspective, this question is regarded obsolete at
the moment (this may change, should you turn out to be against having
the property at the virtual-css-bridge).

I've just sent a series named 'unrestrict cssids related patches'.
Could you please have a look?

Regards,
Halil
