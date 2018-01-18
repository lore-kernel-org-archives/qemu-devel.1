Received: from eggs.gnu.org ([2001:4830:134:3::10]:42773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ec81q-0000u9-Ds
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:06:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ec81n-000323-AQ
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:06:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51168
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ec81n-00031H-3a
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 06:06:39 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w0IB5OQP000927
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 06:06:38 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fjqx2xwv8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 06:06:30 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Thu, 18 Jan 2018 11:05:45 -0000
References: <20180118085628.40798-1-borntraeger@de.ibm.com>
	<20180118085628.40798-4-borntraeger@de.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Thu, 18 Jan 2018 12:05:40 +0100
MIME-Version: 1.0
In-Reply-To: <20180118085628.40798-4-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0fcbf67e-a728-c3d8-8826-044eedd2c3ed@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/3] s390x/kvm: provide stfle.81
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>



On 01/18/2018 09:56 AM, Christian Borntraeger wrote:
> stfle.81 (ppa15) is a transparent facility that can be passed to the
> guest without the need to implement hypervisor support. As this feature
> can be provided by firmware we add it to all full models.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
