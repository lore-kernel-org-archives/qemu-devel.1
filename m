Received: from eggs.gnu.org ([2001:4830:134:3::10]:60366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsUCl-0008AP-7K
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dsUCf-0001jQ-Og
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:29:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dsUCf-0001iH-E2
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 09:29:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8EDRjxL084534
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 09:29:12 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cynry4vue-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 09:29:11 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 14 Sep 2017 14:29:08 +0100
References: <1505385363-27717-1-git-send-email-thuth@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 14 Sep 2017 15:29:04 +0200
MIME-Version: 1.0
In-Reply-To: <1505385363-27717-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <7c37fbac-b908-b575-b590-72a4d4e043a1@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] configure: Allow --enable-seccomp on s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eduardo Otubo <otubo@redhat.com>, David Hildenbrand <david@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Christian Ehrhardt <christian.ehrhardt@canonical.com>, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Jason J Herne <jjherne@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>



On 09/14/2017 12:36 PM, Thomas Huth wrote:
> libseccomp supports s390x since version 2.3.0, and I was able to start
> a VM with "-sandbox on" without any obvious problems by using this patch,
> so it should be safe to allow --enable-seccomp on s390x nowadays, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

ack
